<%@ page import="java.sql.*, javax.naming.*, javax.sql.DataSource" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Status</title>
</head>
<body>

<%@ include file="WEB-INF/jspf/header.jspf" %>

<div class="container mt-4">
    <h2>Order Status</h2>

    <%
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        DataSource ds = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Get DataSource from JNDI
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            ds = (DataSource) envCtx.lookup("jdbc/your_database");

            conn = ds.getConnection();

            // Query to fetch order details
            String orderQuery = "SELECT * FROM orders WHERE order_id = ?";
            pstmt = conn.prepareStatement(orderQuery);
            pstmt.setInt(1, orderId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
    %>
    <p><strong>Order ID:</strong> <%= rs.getInt("order_id") %></p>
    <p><strong>Address:</strong> <%= rs.getString("address") %></p>
    <p><strong>Payment Method:</strong> <%= rs.getString("payment_method") %></p>
    <p><strong>Status:</strong> <%= rs.getString("status") %></p>
    <%
            }
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    %>
</div>

<%@ include file="WEB-INF/jspf/footer.jspf" %>

</body>
</html>
