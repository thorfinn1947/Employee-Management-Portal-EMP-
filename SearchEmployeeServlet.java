package com.nit.DBSERVLET;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/SearchEmployeeServlet")
public class SearchEmployeeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String empId = request.getParameter("empId");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String loginId = request.getParameter("loginId");
        String dobFrom = request.getParameter("dobFrom");
        String department = request.getParameter("department");

        List<Employee> results = new ArrayList<>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "sahil", "bhai");

            StringBuilder sql = new StringBuilder(
                "SELECT emp_id, first_name, last_name, login_id, TO_CHAR(dob, 'DD-MON-YYYY') AS dob, department, salary FROM employees WHERE 1=1"
            );
            List<Object> params = new ArrayList<>();

            if (empId != null && !empId.isEmpty()) {
                sql.append(" AND LOWER(emp_id) LIKE ?");
                params.add("%" + empId.toLowerCase() + "%");
            }
            if (firstName != null && !firstName.isEmpty()) {
                sql.append(" AND LOWER(first_name) LIKE ?");
                params.add("%" + firstName.toLowerCase() + "%");
            }
            if (lastName != null && !lastName.isEmpty()) {
                sql.append(" AND LOWER(last_name) LIKE ?");
                params.add("%" + lastName.toLowerCase() + "%");
            }
            if (loginId != null && !loginId.isEmpty()) {
                sql.append(" AND LOWER(login_id) LIKE ?");
                params.add("%" + loginId.toLowerCase() + "%");
            }
            if (dobFrom != null && !dobFrom.isEmpty()) {
                sql.append(" AND dob >= TO_DATE(?, 'DD-MON-YYYY')");
                params.add(dobFrom);
            }
            if (department != null && !department.isEmpty()) {
                sql.append(" AND LOWER(department) = ?");
                params.add(department.toLowerCase());
            }

            pstmt = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Employee emp = new Employee(
                        rs.getString("emp_id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("login_id"),
                        null,
                        rs.getString("dob"),
                        rs.getString("department"),
                        rs.getDouble("salary")
                );
                results.add(emp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        request.setAttribute("searchResults", results);
        request.getRequestDispatcher("search.jsp").include(request, response);
    }
}
