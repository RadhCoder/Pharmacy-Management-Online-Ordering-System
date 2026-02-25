<%-- 
    Document   : add_to_cart.jsp
    Created on : 3 Feb 2025, 10:30:10 pm
    Author     : sraud
--%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.DataSource" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer userId = (Integer) session.getAttribute("user_id");

    if (userId == null) {
        out.println("<p style='color: red;'>Error: User not logged in.</p>");
        return;
    } else {
        out.println("<p>User ID: " + userId + "</p>");
    }

    String itemIdStr = request.getParameter("item_id");
    String quantityStr = request.getParameter("quantity");

    if (itemIdStr == null || quantityStr == null) {
        out.println("<p style='color: red;'>Error: Missing item_id or quantity.</p>");
        return;
    } else {
        out.println("<p>Item ID: " + itemIdStr + ", Quantity: " + quantityStr + "</p>");
    }

    int itemId = Integer.parseInt(itemIdStr);
    int quantity = Integer.parseInt(quantityStr);

    DataSource ds = null;
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        ds = (DataSource) envCtx.lookup("jdbc/hrsr_pharmacy");
        conn = ds.getConnection();

        String insertQuery = "INSERT INTO cart (user_id, item_id, quantity) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(insertQuery);
        pstmt.setInt(1, userId);
        pstmt.setInt(2, itemId);
        pstmt.setInt(3, quantity);

        int rowsInserted = pstmt.executeUpdate();
        out.println("<p>Rows inserted: " + rowsInserted + "</p>");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>