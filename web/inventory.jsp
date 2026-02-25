<%-- 
    Document   : inventory
    Created on : 31 Jan 2025, 12:41:36 pm
    Author     : sraud
--%>

<%@ page import="java.sql.*, javax.naming.*, javax.sql.DataSource, java.util.Set, java.util.HashSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Retrieve the user object and loggedIn status from the session
    Object user = session.getAttribute("user");
    Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");

    // Handle case where user is null (not logged in)
    if (user == null) {
        loggedIn = false; // Set loggedIn to false if user is null
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pharmacy Inventory</title>
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <link href="css/inventory.css" rel="stylesheet">

    </head>
    <body>

        <%@ include file="WEB-INF/jspf/header.jspf" %>

        <div class="container mt-4">
            <h2 class="text-center mb-4">Pharmacy Inventory</h2>

            <div class="row mb-3">
                <!-- Category Filter -->
                <div class="col-md-4">
                    <select id="categoryFilter" class="form-select">
                        <option value="all">All Categories</option>
                        <%
                            DataSource ds = null;
                            Connection conn = null;
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;
                            Set<String> categories = new HashSet<>(); // To store unique categories

                            try {
                                // Get DataSource from JNDI
                                Context initCtx = new InitialContext();
                                Context envCtx = (Context) initCtx.lookup("java:comp/env");
                                ds = (DataSource) envCtx.lookup("jdbc/hrsr_pharmacy"); // Use your JNDI name

                                // Get a connection from the pool
                                conn = ds.getConnection();

                                // Query to fetch unique categories
                                String categoryQuery = "SELECT DISTINCT category FROM inventory";
                                pstmt = conn.prepareStatement(categoryQuery);
                                rs = pstmt.executeQuery();

                                while (rs.next()) {
                                    categories.add(rs.getString("category"));
                                }
                        
                                for (String category : categories) {
                        %>
                        <option value="<%= category %>"><%= category %></option>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                            } finally {
                                try { if (rs != null) rs.close(); } catch (SQLException e) {}
                                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
                                try { if (conn != null) conn.close(); } catch (SQLException e) {} // Return connection to pool
                            }
                        %>
                    </select>
                </div>

                <!-- Search Bar -->
                <div class="col-md-6">
                    <input type="text" id="search" class="form-control" placeholder="Search for medicines...">
                </div>
            </div>
                    
            <!-- Inventory Display -->
            <div class="row" id="inventory-container">
                <%
                    try {
                        // Get a new connection for fetching inventory
                        conn = ds.getConnection();

                        // Query to fetch inventory
                        String query = "SELECT item_id, item_name, category, description, price, stock_quantity, expiration_date, image_path FROM inventory";
                        pstmt = conn.prepareStatement(query);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                %>
                <div class="col-md-4 mb-4 inventory-item" data-category="<%= rs.getString("category") %>">
                    <div class="card shadow">
                        <% if (rs.getString("image_path") != null && !rs.getString("image_path").isEmpty()) { %>
                        <img src="<%= rs.getString("image_path") %>" class="card-img-top" alt="Item Image">
                        <% } else { %>
                        <img src="https://via.placeholder.com/150" class="card-img-top" alt="No Image Available">
                        <% } %>
                        <div class="card-body">
                            <h5 class="card-title"><%= rs.getString("item_name") %></h5>
                            <p class="card-text">
                                <strong>Category:</strong> <%= rs.getString("category") %><br>
                                <strong>Price:</strong> RM <%= rs.getBigDecimal("price") %><br>
                                <strong>Expiration:</strong> <%= rs.getDate("expiration_date") != null ? rs.getDate("expiration_date") : "N/A" %><br>
                                <i class="bi bi-info-circle"></i> <%= rs.getString("description") %> 
                            </p>
                            <!-- Form for Add to Cart -->
                        <% if (loggedIn) { %>
                            <form action="cart" method="POST">
                                <input type="hidden" name="itemId" value="<%= rs.getLong("item_id") %>">  <!-- Fix: Match Servlet's itemId -->
                                <input type="number" name="quantity" value="1" min="1" class="form-control mb-2" required>  <!-- Keep Quantity -->
                                <button type="submit" class="btn btn-primary">Add to Cart</button>
                            </form>
                        <% } else { %>
                            <p class="text-danger">Please <a href="login.jsp">log in</a> to add items to the cart.</p>
                        <% } %>
                        </div>
                    </div>
                </div>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException e) {}
                        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
                        try { if (conn != null) conn.close(); } catch (SQLException e) {} // Return connection to pool
                    }
                %>
            </div>
        </div>
        <%@ include file="WEB-INF/jspf/footer.jspf" %>

        <!-- Bootstrap JS & jQuery for Search & Filtering -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                // Search Functionality
                $("#search").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $(".inventory-item").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                    });
                });

                // Category Filter
                $("#categoryFilter").on("change", function () {
                    var selectedCategory = $(this).val().toLowerCase();

                    $(".inventory-item").each(function () {
                        var itemCategory = $(this).data("category").toLowerCase();

                        if (selectedCategory === "all" || itemCategory === selectedCategory) {
                            $(this).show();
                        } else {
                            $(this).hide();
                        }
                    });
                });
            });
        </script>

    </body>
</html>
