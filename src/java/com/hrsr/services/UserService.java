package com.hrsr.services;

import com.hrsr.model.User;
import com.hrsr.utils.DatabaseUtil;
import java.sql.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class UserService {

    // Simulate user registration logic (now with actual database insertion)
    public boolean registerUser(User user) {
        // Hash the password with SHA-256
        String hashedPassword = hashPassword(user.getPassword());
        user.setPassword(hashedPassword);
        
        // Save the user to the database
        try (Connection conn = DatabaseUtil.getConnection()) {
            // Prepare the SQL insert statement
            String sql = "INSERT INTO users (full_name, email, password, role) VALUES (?, ?, ?, ?)";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, user.getFullName());
                stmt.setString(2, user.getEmail());
                stmt.setString(3, user.getPassword());  // Store the hashed password
                stmt.setString(4, user.getRole().name()); // Store the role as a string

                // Execute the insert
                int rowsAffected = stmt.executeUpdate();
                
                return rowsAffected > 0; // If rows are affected, registration was successful
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false if there is a database error
        }
    }

    // Hash the password using SHA-256
    public String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = digest.digest(password.getBytes());
            return Base64.getEncoder().encodeToString(hashedBytes);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null; // Return null if there is an error with hashing
        }
    }
}
