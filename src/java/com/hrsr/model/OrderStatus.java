/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hrsr.model;

/**
 *
 * @author PC
 */

import java.util.HashMap;
import java.util.Map;

public class OrderStatus {
    private static Map<Long, Order> orders = new HashMap<>();

    public static void createOrder(Order order) {
        orders.put(order.getOrderId(), order);
    }

    public static Order getOrderStatus(long orderId) {
        return orders.get(orderId);
    }

    public static void updateOrderStatus(long orderId, String newStatus) {
        Order order = orders.get(orderId);
        if (order != null) {
            order.updateStatus(newStatus);
        }
    }
}
