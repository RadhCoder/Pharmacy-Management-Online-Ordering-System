<%@ page import="java.sql.*, javax.naming.*, javax.sql.DataSource" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    DataSource ds = null;
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Get DataSource from JNDI
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        ds = (DataSource) envCtx.lookup("jdbc/hrsr_pharmacy");

        conn = ds.getConnection();

        // Insert order details
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("payment");
        int userId = (Integer) session.getAttribute("user_id");

        String orderQuery = "INSERT INTO orders (user_id, address, payment_method, status) VALUES (?, ?, ?, 'Processing')";
        pstmt = conn.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS);
        pstmt.setInt(1, userId);
        pstmt.setString(2, address);
        pstmt.setString(3, paymentMethod);
        pstmt.executeUpdate();

        // Get the generated order ID
        rs = pstmt.getGeneratedKeys();
        rs.next();
        int orderId = rs.getInt(1);

        // Process cart items and link to order
        String cartQuery = "SELECT cart.item_id, cart.quantity FROM cart WHERE cart.user_id = ?";
        pstmt = conn.prepareStatement(cartQuery);
        pstmt.setInt(1, userId);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            String orderItemQuery = "INSERT INTO order_items (order_id, item_id, quantity) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(orderItemQuery);
            pstmt.setInt(1, orderId);
            pstmt.setInt(2, rs.getInt("item_id"));
            pstmt.setInt(3, rs.getInt("quantity"));
            pstmt.executeUpdate();
        }

        // Clear the user's cart
        String clearCartQuery = "DELETE FROM cart WHERE user_id = ?";
        pstmt = conn.prepareStatement(clearCartQuery);
        pstmt.setInt(1, userId);
        pstmt.executeUpdate();

        // Redirect to the order status page
        response.sendRedirect("orderStatus.jsp?orderId=" + orderId);
    } catch (Exception e) {
        out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) {}
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
        try { if (conn != null) conn.close(); } catch (SQLException e) {}
    }
%>
