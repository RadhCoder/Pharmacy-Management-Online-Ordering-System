/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.hrsr.servlets;

import com.hrsr.model.Inventory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import jakarta.servlet.http.HttpSession;

@WebServlet("/inventory")
public class InventoryServlet extends HttpServlet {

    private DataSource dataSource;

    @Override
    public void init() throws ServletException {
        try {
            InitialContext ctx = new InitialContext();
            dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/hrsr_pharmacy");
        } catch (NamingException e) {
            throw new ServletException("Database connection problem", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Inventory> inventoryList = new ArrayList<>();
        String sql = "SELECT item_id, item_name, image_path, price FROM inventory";

        try (Connection conn = dataSource.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Inventory item = new Inventory();
                item.setId(rs.getLong("item_id"));
                item.setItemName(rs.getString("item_name"));
                item.setImagePath(rs.getString("image_path"));
                item.setPrice(rs.getBigDecimal("price").doubleValue());
                inventoryList.add(item);
            }

            System.out.println("✅ Inventory List Size: " + inventoryList.size()); // Debugging

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Store the list in the request and forward to index.jsp
        request.setAttribute("inventoryList", inventoryList);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    
     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Ensure user is logged in before adding to cart
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id"); // Check if user is logged in
        
        if (userId == null) {
            // Redirect to login page if user is not logged in
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        // Retrieve data from form submission
        int itemId = Integer.parseInt(request.getParameter("item_id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        BigDecimal totalPrice = new BigDecimal(request.getParameter("total_price"));

        // Add the item to the cart
        String sql = "INSERT INTO cart (user_id, item_id, quantity, total_price) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = dataSource.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, itemId);
            stmt.setInt(3, quantity);
            stmt.setBigDecimal(4, totalPrice);
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("✅ Item added to cart successfully.");
            } else {
                System.out.println("❌ Failed to add item to cart.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
