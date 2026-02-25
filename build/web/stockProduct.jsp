<%-- 
    Document   : stockProduct
    Created on : 1 Feb 2025, 2:26:28 am
    Author     : sraud
--%>

<%@ page import="java.sql.*, java.util.*, javax.naming.*, javax.sql.DataSource" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Stock Tracking</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link href="css/inventory.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="WEB-INF/jspf/header.jspf" %>

        <div class="container mt-4">
            <h2 class="text-center mb-4">Pharmacist Stock Tracking</h2>
            <div class="row mb-3">
                <div class="col-md-4">
                    <select id="categoryFilter" class="form-select">
                        <option value="all">All Categories</option>
                        <%
                            // Database connection setup
                            DataSource ds = null;
                            Connection conn = null;
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;

                            List<String> categories = new ArrayList<>(); // Declare the list properly
                        
                            try {
                                Context initCtx = new InitialContext();
                                Context envCtx = (Context) initCtx.lookup("java:comp/env");
                                ds = (DataSource) envCtx.lookup("jdbc/hrsr_pharmacy");
                                conn = ds.getConnection();

                                // Fetch categories dynamically
                                String categoryQuery = "SELECT DISTINCT category FROM inventory";
                                pstmt = conn.prepareStatement(categoryQuery);
                                rs = pstmt.executeQuery();

                                while (rs.next()) {
                                    String category = rs.getString("category");
                                    categories.add(category);
                        %>
                        <option value="<%= category %>"><%= category %></option>
                        <%
                    }
                } catch (Exception e) {
                    out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) {}
                    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
                }
                        %>
                    </select>
                </div>
                <div class="col-md-4">
                    <select id="stockFilter" class="form-select">
                        <option value="all">All Stock Levels</option>
                        <option value="low">Low Stock</option>
                        <option value="expired">Expired</option>
                        <option value="expiring-soon">Expiring Soon</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <input type="text" id="search" class="form-control" placeholder="Search items...">
                </div>
            </div>

            <div class="row" id="stock-container">
                <%
                    try {
                        String query = "SELECT item_name, category, stock_quantity, expiration_date FROM inventory";
                        pstmt = conn.prepareStatement(query);
                        rs = pstmt.executeQuery();
                    
                        java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
                        java.sql.Date expiringSoonThreshold = new java.sql.Date(System.currentTimeMillis() + (30L * 24 * 60 * 60 * 1000)); // 30 days ahead

                        while (rs.next()) {
                            int stock = rs.getInt("stock_quantity");
                            java.sql.Date expiration = rs.getDate("expiration_date");
                            String stockClass = "";

                            if (stock <= 10) {
                                stockClass = "low-stock";
                            } else if (stock > 10 && stock <= 50) {
                                stockClass = "medium-stock";
                            } else if (stock > 50) {
                                stockClass = "high-stock";
                            }

                            if (expiration != null && expiration.before(today)) {
                                stockClass = "expired";
                            } else if (expiration != null && expiration.before(expiringSoonThreshold)) {
                                stockClass = "expiring-soon";
                            }
                %>
                <div class="col-md-4 mb-4 inventory-item" data-category="<%= rs.getString("category") %>">
                    <div class="card shadow">
                        <div class="card-body">
                            <h5 class="card-title"><%= rs.getString("item_name") %></h5>
                            <p class="card-text">
                                <strong>Category:</strong> <%= rs.getString("category") %><br>
                                <strong>Stock:</strong> <span class="<%= stockClass %>"><%= stock %></span><br>
                                <strong>Expiration:</strong> <span class="<%= stockClass %>"><%= expiration != null ? expiration : "N/A" %></span>
                            </p>
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
                        try { if (conn != null) conn.close(); } catch (SQLException e) {} // Close connection here
                    }
                %>
            </div>
        </div>

        <%@ include file="WEB-INF/jspf/footer.jspf" %>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                function filterItems() {
                    var searchValue = $("#search").val().toLowerCase();
                    var selectedStock = $("#stockFilter").val();
                    var selectedCategory = $("#categoryFilter").val().toLowerCase();

                    $(".inventory-item").each(function () {
                        var textContent = $(this).text().toLowerCase();
                        var stockClass = $(this).find("span").attr("class");
                        var itemCategory = $(this).data("category").toLowerCase();

                        // Match search query
                        var searchMatch = textContent.indexOf(searchValue) > -1;

                        // Match stock level filter
                        var stockMatch = selectedStock === "all" || stockClass.includes(selectedStock);

                        // Match category filter
                        var categoryMatch = selectedCategory === "all" || itemCategory === selectedCategory;

                        // Show or hide based on all filters
                        if (searchMatch && stockMatch && categoryMatch) {
                            $(this).show();
                        } else {
                            $(this).hide();
                        }
                    });
                }

                // Attach event listeners
                $("#search").on("keyup", filterItems);
                $("#stockFilter").on("change", filterItems);
                $("#categoryFilter").on("change", filterItems);
            });
        </script>
    </body>
</html>

