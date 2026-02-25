/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hrsr.servlets;

/**
 *
 * @author PC
 */
import com.hrsr.model.Cart;
import com.hrsr.model.CartItem;
import com.hrsr.model.Order;
import com.hrsr.model.OrderStatus;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            // Redirect to cart if it's empty
            response.sendRedirect("/cart");
            return;
        }

        double totalAmount = cart.getTotal();
        request.setAttribute("totalAmount", totalAmount);
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            // Redirect to cart if it's empty
            response.sendRedirect("/cart");
            return;
        }

        // Here you would typically get userId from session after login
         Long userId = (Long) session.getAttribute("userId"); // Assuming userId is stored in session

        if (userId == null) {
            response.sendRedirect("/login"); // Redirect to login if user is not logged in
            return;
        }
        double totalAmount = cart.getTotal();
        
        // Create an order and save it
        Order order = new Order(System.currentTimeMillis(), userId, cart.getItems(), totalAmount);

        // Save the order using OrderStatus (example method)
        OrderStatus.createOrder(order);

        // Clear the cart after order placement
        cart.clearCart();

        // Redirect to order status page
        response.sendRedirect("/order-status?orderId=" + order.getOrderId());
    }
}
