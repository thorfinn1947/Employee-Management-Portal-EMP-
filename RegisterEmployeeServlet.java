package com.nit.DBSERVLET;

import java.io.*;
import java.sql.*;
import java.util.Random;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@MultipartConfig(maxFileSize = 1024 * 1024)
@WebServlet("/AddEmployeeServlet")
public class RegisterEmployeeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String middleName = request.getParameter("middleName");
        String lastName = request.getParameter("lastName");
        String dobStr = request.getParameter("dob");
        String department = request.getParameter("department");
        String salary = request.getParameter("salary");
        String permanentAddress = request.getParameter("permanentAddress");
        String currentAddress = request.getParameter("currentAddress");
        String password = request.getParameter("password"); // Get password
        Part idProof = request.getPart("idProof");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            java.sql.Date dob = java.sql.Date.valueOf(dobStr);

            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "sahil", "bhai");

            String empId = null;
            while (true) {
                empId = "EMP" + (10000 + new Random().nextInt(90000));
                pstmt = conn.prepareStatement("SELECT COUNT(*) FROM employees WHERE emp_id = ?");
                pstmt.setString(1, empId);
                rs = pstmt.executeQuery();
                if (rs.next() && rs.getInt(1) == 0) break;
                rs.close();
                pstmt.close();
            }

            String loginId = (firstName.charAt(0) + lastName).toLowerCase();

            pstmt = conn.prepareStatement("SELECT emp_id FROM employees WHERE login_id = ?");
            pstmt.setString(1, loginId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("message", "User with Login ID '" + loginId + "' already registered. Please login.");
                request.setAttribute("messageType", "error");
                RequestDispatcher rd = request.getRequestDispatcher("LoginProject.jsp");
                rd.forward(request, response);

                rs.close();
                pstmt.close();
                conn.close();
                return;
            }
            rs.close();
            pstmt.close();

            // Ensure unique loginId if collision happens
            Random random = new Random();
            while (true) {
                pstmt = conn.prepareStatement("SELECT COUNT(*) FROM employees WHERE login_id = ?");
                pstmt.setString(1, loginId);
                rs = pstmt.executeQuery();
                rs.next();
                if (rs.getInt(1) == 0) {
                    rs.close();
                    pstmt.close();
                    break;
                }
                rs.close();
                pstmt.close();

                loginId = (firstName.charAt(0) + lastName + String.format("%03d", random.nextInt(1000))).toLowerCase();
            }

            InputStream inputStream = idProof.getInputStream();

            String insertSql = "INSERT INTO employees (emp_id, first_name, middle_name, last_name, login_id, password, dob, department, salary, permanent_address, current_address, id_proof) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            pstmt = conn.prepareStatement(insertSql);
            pstmt.setString(1, empId);
            pstmt.setString(2, firstName);
            pstmt.setString(3, middleName);
            pstmt.setString(4, lastName);
            pstmt.setString(5, loginId);
            pstmt.setString(6, password); // insert password
            pstmt.setDate(7, dob);
            pstmt.setString(8, department);
            pstmt.setDouble(9, Double.parseDouble(salary));
            pstmt.setString(10, permanentAddress);
            pstmt.setString(11, currentAddress);
            pstmt.setBlob(12, inputStream);

            int inserted = pstmt.executeUpdate();

            if (inserted > 0) {
                request.setAttribute("message", "Employee registered successfully! ID: " + empId);
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Employee registration failed.");
                request.setAttribute("messageType", "error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        RequestDispatcher rd = request.getRequestDispatcher("addEmployee.jsp");
        rd.forward(request, response);
    }
}
