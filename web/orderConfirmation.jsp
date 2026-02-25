<%-- 
    Document   : orderConfirmation
    Created on : 3 Feb 2025, 11:52:29 pm
    Author     : sraud
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Confirmation</title>
        <link href="css/orderConfirmation.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <h2 class="text-center mb-4">Order Confirmation</h2>

            <!-- Order Confirmation Message -->
            <div class="confirmation-message">
                <h3>Thank you for your order!</h3>
                <p>Your order has been placed successfully. We are processing it and will notify you once it's shipped.</p>
            </div>

            <!-- Order Details -->
            <div class="order-details">
                <h3>Order Summary</h3>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Item</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Swisse Ultiboost Magnesium</td>
                            <td>RM25.49</td>
                            <td>2</td>
                            <td>RM50.98</td>
                        </tr>
                        <tr>
                            <td>Refresh Eye Drops</td>
                            <td>RM7.99</td>
                            <td>1</td>
                            <td>RM7.99</td>
                        </tr>
                        <tr>
                            <td>Panadol Paracetamol Tablets</td>
                            <td>RM4.99</td>
                            <td>3</td>
                            <td>RM14.97</td>
                        </tr>
                        <tr>
                            <td colspan="3">Total</td>
                            <td>RM73.94</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Navigation Buttons -->
            <div class="navigation-btns">
                <button class="button continue-shopping" onclick="window.location.href = 'inventory.jsp'">Continue Shopping</button>
                <button class="button go-home" onclick="window.location.href = 'index.jsp'">Go to Homepage</button>
            </div>
        </div>
    </body>
</html>

