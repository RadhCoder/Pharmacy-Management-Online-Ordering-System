<%-- 
    Document   : login
    Created on : 30 Jan 2025, 8:06:26 pm
    Author     : Ratna Dewi
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - HRSR Pharmacy</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <!-- Custom CSS -->
        <link href="css/login.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <!-- Include Header Fragment -->
        <%@ include file="WEB-INF/jspf/header.jspf" %>

        <div class="container">
            <div class="login-container">
                <h2 class="login-title">Welcome Back</h2>

                <!-- Error Message -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger" role="alert">
                        <i class="bi bi-exclamation-circle me-2"></i>
                        ${errorMessage}
                    </div>
                </c:if>

                <form action="login" method="post" class="needs-validation" novalidate>
                    <!-- Email Field -->
                    <div class="form-floating mb-3">
                        <input type="email" 
                               class="form-control" 
                               id="email" 
                               name="email" 
                               placeholder="name@example.com"
                               required>
                        <label for="email">Email address</label>
                        <div class="invalid-feedback">
                            Please enter a valid email address.
                        </div>
                    </div>

                    <!-- Password Field -->
                    <div class="form-floating mb-3">
                        <input type="password" 
                               class="form-control" 
                               id="password" 
                               name="password" 
                               placeholder="Password"
                               required>
                        <label for="password">Password</label>
                        <div class="invalid-feedback">
                            Please enter your password.
                        </div>
                    </div>

                    <!-- Remember Me and Forgot Password -->
                    <div class="password-options">
                        <div class="form-check remember-me">
                            <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe">
                            <label class="form-check-label" for="rememberMe">
                                Remember me
                            </label>
                        </div>
                    </div>

                    <!-- Login Button -->
                    <button type="submit" class="btn btn-primary btn-login">
                        <i class="bi bi-box-arrow-in-right me-2"></i>
                        Login
                    </button>
                </form>

            </div>
        </div>

        <!-- Include Footer Fragment -->
        <%@ include file="WEB-INF/jspf/footer.jspf" %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Form Validation Script -->
        <script>
            (function () {
                'use strict'

                // Fetch all forms that need validation
                var forms = document.querySelectorAll('.needs-validation')

                // Loop over them and prevent submission
                Array.prototype.slice.call(forms)
                        .forEach(function (form) {
                            form.addEventListener('submit', function (event) {
                                if (!form.checkValidity()) {
                                    event.preventDefault()
                                    event.stopPropagation()
                                }
                                form.classList.add('was-validated')
                            }, false)
                        })
            })()
        </script>
    </body>
</html>