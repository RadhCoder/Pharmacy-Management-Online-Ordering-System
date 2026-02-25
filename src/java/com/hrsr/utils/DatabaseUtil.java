/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hrsr.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/hrsr_pharmacy";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "";

    // Method to get a connection
    public static Connection getConnection() throws SQLException {
        try {
            // Load the MySQL JDBC driver (optional, for older JDBC versions)
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Return the connection to the database
            return DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("Database driver not found.", e);
        }
    }
}
