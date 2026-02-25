<%@ page import="java.sql.*, javax.naming.*, javax.sql.DataSource" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Checkout</title>
        <link href="css/checkout.css" rel="stylesheet">
    </head>
    <body>

        <%@ include file="WEB-INF/jspf/header.jspf" %>

        <div class="container">
            <h2 class="text-center mb-4">Checkout</h2>

            <!-- Billing Information -->
            <div class="billing-info">
                <h3>Billing Information</h3>
                <form>
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" class="form-control" placeholder="Enter your name" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" class="form-control" placeholder="Enter your email" required>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" id="address" class="form-control" placeholder="Enter your address" required>
                    </div>
                    <div class="form-group">
                        <label for="city">City</label>
                        <input type="text" id="city" class="form-control" placeholder="Enter your city" required>
                    </div>
                    <div class="form-group">
                        <label for="zip">Zip Code</label>
                        <input type="text" id="zip" class="form-control" placeholder="Enter your zip code" required>
                    </div>
                </form>
            </div>

            <!-- Payment Method -->
            <div class="payment-method">
                <h3>Payment Method</h3>
                <label for="payment-method">Choose a payment method:</label>
                <select id="payment-method" class="form-select">
                    <option value="credit-card">Credit Card</option>
                    <option value="paypal">Online Banking</option>
                    <option value="bank-transfer">Paypal</option>
                </select>
            </div>

            <!-- Order Summary -->
            <div class="order-summary">
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

            <!-- Checkout Button -->
            <div class="checkout-btn">
                <button class="button confirm-button" onclick="confirmOrder()">Confirm Order</button>
            </div>
        </div>

        <script>
            function confirmOrder() {
                alert("Your order has been placed successfully!");
                window.location.href = 'orderConfirmation.jsp'; // Redirect to confirmation page
            }
        </script>

        <%@ include file="WEB-INF/jspf/footer.jspf" %>

    </body>
</html>
