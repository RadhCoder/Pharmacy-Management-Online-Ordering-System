/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hrsr.servlets;

import com.hrsr.model.User;
import com.hrsr.services.UserService; // Import the service class
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    // Use the regular service class instead of EJB
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to register.jsp when visiting /register
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (fullName == null || email == null || password == null || role == null) {
            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Create user object and set properties
        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password); // This will be hashed in UserService
        user.setRole(User.Role.valueOf(role));

        // Call the service method to register the user
        boolean success = userService.registerUser(user);

        if (success) {
            // Redirect to login page after successful registration
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
