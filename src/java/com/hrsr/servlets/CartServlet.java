package com.hrsr.servlets;

import com.hrsr.model.Cart;
import com.hrsr.model.CartItem;
import com.hrsr.model.Inventory;
import com.hrsr.utils.DatabaseUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        Integer userId = (Integer) session.getAttribute("user_id");
        if (userId != null) {
            try (Connection conn = DatabaseUtil.getConnection()) {
                String query = "SELECT cart.item_id, cart.quantity, inventory.item_name, inventory.price " +
                               "FROM cart JOIN inventory ON cart.item_id = inventory.item_id " +
                               "WHERE cart.user_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setInt(1, userId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            CartItem item = new CartItem(
                                    rs.getLong("item_id"),
                                    rs.getString("item_name"),
                                    rs.getDouble("price"),
                                    rs.getInt("quantity")
                            );
                            cart.addItem(item);
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error retrieving cart items.");
            }
        }

        request.setAttribute("cart", cart);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        Integer userId = (Integer) session.getAttribute("user_id");
        if (userId != null) {
            String itemId = request.getParameter("itemId");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Inventory inventory = null;
            try (Connection conn = DatabaseUtil.getConnection()) {
                String query = "SELECT item_name, price FROM inventory WHERE item_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setLong(1, Long.parseLong(itemId));
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            inventory = new Inventory();
                            inventory.setId(Long.parseLong(itemId));
                            inventory.setItemName(rs.getString("item_name"));
                            inventory.setPrice(rs.getDouble("price"));
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error retrieving item details.");
                request.getRequestDispatcher("/cart.jsp").forward(request, response);
                return;
            }

            if (inventory != null) {
                CartItem item = new CartItem(inventory.getId(), inventory.getItemName(), inventory.getPrice(), quantity);
                cart.addItem(item);

                try (Connection conn = DatabaseUtil.getConnection()) {
                    String query = "INSERT INTO cart (user_id, item_id, quantity) VALUES (?, ?, ?) " +
                                   "ON DUPLICATE KEY UPDATE quantity = quantity + ?";
                    try (PreparedStatement stmt = conn.prepareStatement(query)) {
                        stmt.setInt(1, userId);
                        stmt.setLong(2, inventory.getId());
                        stmt.setInt(3, quantity);
                        stmt.setInt(4, quantity);
                        stmt.executeUpdate();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    request.setAttribute("errorMessage", "Error adding item to cart.");
                    request.getRequestDispatcher("/cart.jsp").forward(request, response);
                    return;
                }
            }
        }

        response.sendRedirect("/cart.jsp");
    }
}
