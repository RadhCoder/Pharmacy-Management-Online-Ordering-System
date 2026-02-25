<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.hrsr.model.Inventory" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.hrsr.model.User" %>
<%@ page session="true" %>

<% 
    User user = (User) session.getAttribute("user"); // Retrieve user from session
    boolean loggedIn = user != null;
%>

<%
    // Check if inventoryList is null, and call InventoryServlet if needed
    if (request.getAttribute("inventoryList") == null) {
        request.getRequestDispatcher("/inventory").forward(request, response);
        return;
    }
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<head>
    <link href="css/index.css" rel="stylesheet">
    <!-- Add Bootstrap CSS link -->
</head>

<!-- Hero Section -->
<div class="hero-section">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h1 class="display-4 fw-bold mb-4">Your Health Is Our Priority</h1>
                <p class="lead mb-4">Professional healthcare services and quality medical supplies for your well-being.</p>
                <!-- If logged in, show user-specific options -->
                <c:choose>
                    <c:when test="${loggedIn}">
                        <a href="inventory.jsp" class="btn btn-light btn-lg">Shop Now</a>
                    </c:when>
                    <c:otherwise>
                        <a href="login.jsp" class="btn btn-light btn-lg">Login to Shop</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- Quick Info Section -->
<div class="container mt-4">
    <div class="row g-4">
        <div class="col-md-4">
            <div class="quick-info">
                <h5><i class="bi bi-clock"></i> Opening Hours</h5>
                <p class="mb-0">Mon-Sat: 8AM - 9PM</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="quick-info">
                <h5><i class="bi bi-telephone"></i> Contact Us</h5>
                <p class="mb-0">+1 (555) 123-4567</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="quick-info">
                <h5><i class="bi bi-geo-alt"></i> Location</h5>
                <p class="mb-0">123 Health Street</p>
            </div>
        </div>
    </div>
</div>

<!-- Featured Products Carousel -->
<div class="container my-5 featured-products">
    <h2 class="text-center mb-4">Featured Medical Products</h2>

    <div id="productCarousel" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
            <c:forEach var="item" items="${inventoryList}" varStatus="status">
                <c:if test="${status.index % 3 == 0}">
                    <div class="carousel-item ${status.first ? 'active' : ''}">
                        <div class="row justify-content-center">
                        </c:if>

                        <div class="col-md-4">
                            <div class="card product-card">
                                <img src="${item.imagePath}" class="card-img-top" alt="${item.itemName}">
                                <div class="card-body text-center">
                                    <h5 class="card-title">${item.itemName}</h5>
                                    <p class="card-text">RM ${item.price}</p>
                                    <a href="inventory.jsp" class="btn btn-primary">To Know Details</a>
                                </div>
                            </div>
                        </div>

                        <c:if test="${(status.index + 1) % 3 == 0 || status.last}">
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <!-- Carousel Controls -->
        <a class="carousel-control-prev" href="#productCarousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only"></span>
        </a>
        <a class="carousel-control-next" href="#productCarousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only"></span>
        </a>
    </div>
</div>

<!-- Services Section -->
<div class="bg-light py-5">
    <div class="container">
        <h2 class="mb-4">Our Services</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card service-card">
                    <div class="card-body">
                        <h5 class="card-title">Prescription Filling</h5>
                        <p class="card-text">Quick and accurate prescription services with professional consultation.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card service-card">
                    <div class="card-body">
                        <h5 class="card-title">Health Screening</h5>
                        <p class="card-text">Regular health check-ups and screening services available.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card service-card">
                    <div class="card-body">
                        <h5 class="card-title">Vaccination</h5>
                        <p class="card-text">Comprehensive vaccination services for all age groups.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Add Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.10/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>