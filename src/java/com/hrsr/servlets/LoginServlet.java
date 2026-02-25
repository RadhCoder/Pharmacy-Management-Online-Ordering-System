package com.hrsr.servlets;

import com.hrsr.model.User;
import com.hrsr.services.UserService; // Import the service for password hashing
import com.hrsr.utils.DatabaseUtil;  // Import DatabaseUtil
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    // UserService to hash password
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if the user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect("index.jsp"); // Redirect if already logged in
            return;
        }

        // Forward to login page
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Hash the entered password
        String hashedPassword = userService.hashPassword(password);

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Use DatabaseUtil to get the connection
            conn = DatabaseUtil.getConnection();

            // Query to check if the user exists
            String query = "SELECT * FROM users WHERE email = ? AND password = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, hashedPassword);  // Compare hashed password

            rs = stmt.executeQuery();

            if (rs.next()) {
                // User found, create User object and session
                User user = new User();
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(User.Role.valueOf(rs.getString("role")));

                // Store user details in session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);  // Store User object in session
                session.setAttribute("loggedIn", true); // Set loggedIn attribute
                session.setAttribute("user_id", user.getUser_id());

                System.out.println("Session ID: " + session.getId());

                // Redirect based on role
                if (user.getRole() == User.Role.admin) {
                    response.sendRedirect(request.getContextPath() + "/stockProduct.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                }
            } else {
                // Invalid credentials, show error message
                request.setAttribute("errorMessage", "Invalid email or password.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
