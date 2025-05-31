package com.nit.DBSERVLET;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String loginId = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "sahil", "bhai");

            pstmt = conn.prepareStatement("SELECT * FROM employees WHERE LOGIN_ID = ? AND PASSWORD = ?");
            pstmt.setString(1, loginId);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                 HttpSession session = request.getSession();
                session.setAttribute("user", loginId);
                response.sendRedirect("search.jsp");
            } else {
              
                request.setAttribute("errorMessage", "Invalid username or password.");
                RequestDispatcher rd = request.getRequestDispatcher("LoginProject.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Server error: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("LoginProject.jsp");
            rd.forward(request, response);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
