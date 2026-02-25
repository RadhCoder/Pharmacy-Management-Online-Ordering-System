package com.hrsr.servlets;

import com.hrsr.model.Inventory;
import com.hrsr.utils.DatabaseUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            // Use DatabaseUtil to get the connection
            conn = DatabaseUtil.getConnection();
            
            // Query to fetch inventory items
            String query = "SELECT * FROM inventory LIMIT 4";  // Limit to 4 featured items
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);
            
            // Create a list to store the inventory items
            List<Inventory> inventoryList = new ArrayList<>();
            
            while (rs.next()) {
                Inventory item = new Inventory();
                item.setId(rs.getLong("id"));
                item.setItemName(rs.getString("item_name"));
                item.setImagePath(rs.getString("image_path"));
                item.setPrice(rs.getDouble("price"));
                inventoryList.add(item);
            }
            
            // Pass the inventoryList to the JSP
            request.setAttribute("inventoryList", inventoryList);
            
            // Forward the request to the JSP page
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
