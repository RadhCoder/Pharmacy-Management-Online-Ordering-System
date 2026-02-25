<%@ page import="java.sql.*, javax.naming.*, javax.sql.DataSource" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cart</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                padding: 20px;
            }
            .cart-container {
                max-width: 600px;
                margin: auto;
                border: 1px solid #ddd;
                padding: 15px;
                border-radius: 5px;
                box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
                text-align: center;
            }
            .cart-item {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 10px;
                border-bottom: 1px solid #ddd;
            }
            .cart-item img {
                width: 50px;
                height: 50px;
                margin-right: 10px;
            }
            .cart-item-details {
                flex-grow: 1;
                text-align: left;
            }
            .cart-item span {
                display: block;
            }
            .total {
                font-weight: bold;
                text-align: right;
                margin-top: 15px;
            }
            .buttons {
                margin-top: 20px;
            }
            .button {
                padding: 10px 20px;
                margin: 5px;
                border: none;
                cursor: pointer;
                font-size: 16px;
                border-radius: 5px;
            }
            .yes-button {
                background-color: green;
                color: white;
            }
            .no-button {
                background-color: red;
                color: white;
            }
        </style>
    </head>
    <body>

        <%@ include file="WEB-INF/jspf/header.jspf" %>

    <body>
        <div class="cart-container">
            <h2>Shopping Cart</h2>
            <div class="cart-item">
                <img src="images/02swisse.jpg" alt="Product 1">
                <div class="cart-item-details">
                    <span>Item Name: Swisse Ultiboost Magnesium</span>
                    <span>Quantity: 2</span>
                    <span>Price: RM50.98</span>
                </div>
            </div>
            <div class="cart-item">
                <img src="images/26refreshEyeDrops.jpg" alt="Product 2">
                <div class="cart-item-details">
                    <span>Item Name: Refresh Eye Drops</span>
                    <span>Quantity: 1</span>
                    <span>Price: RM 7.99</span>
                </div>
            </div>
            <div class="cart-item">
                <img src="images/16panadolParacetamol.jpg" alt="Product 3">
                <div class="cart-item-details">
                    <span>Item Name: Panadol Paracetamol Tablets</span>
                    <span>Quantity: 3</span>
                    <span>Price: RM14.97</span>
                </div>
            </div>
            <div class="total">
                Total Price: RM 73.94
            </div>
            <div class="buttons">
                <button class="button yes-button" onclick="window.location.href = 'checkout.jsp'">Yes, Proceed to Checkout</button>
                <button class="button no-button" onclick="window.location.href = 'inventory.jsp'">No, Continue Shopping</button>

            </div>
        </div>
        <script>
            function proceedToCheckout() {
                alert('Proceeding to checkout...');
                setTimeout(() => {
                    window.location.href = 'checkout.jsp';
                }, 1000);
            }

            function continueShopping() {
                alert('Returning to shopping...');
                setTimeout(() => {
                    window.location.href = 'shop.jsp';
                }, 1000);
            }
        </script>
    </body>


    <%@ include file="WEB-INF/jspf/footer.jspf" %>

</body>
</html>
