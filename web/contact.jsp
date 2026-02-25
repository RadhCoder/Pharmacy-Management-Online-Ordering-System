<%-- 
    Document   : contact
    Created on : 1 Feb 2025, 1:43:37 am
    Author     : sraud
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Contact Us</title>
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <link href="css/contact.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="WEB-INF/jspf/header.jspf" %>
        <div class="container my-5">
            <h1 class="text-center mb-5">Visit Us</h1>
            <p>Visit us at our location below:</p>
            <div>
                <iframe src="https://maps.co/embed/679d090d5fb9e452808802suvfff698" allowfullscreen></iframe>
            </div>
        </div>
        <%@ include file="WEB-INF/jspf/footer.jspf" %>

    </body>
</html>

