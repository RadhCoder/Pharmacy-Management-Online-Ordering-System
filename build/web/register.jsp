<%-- 
    Document   : register
    Created on : 30 Jan 2025, 6:12:39 pm
    Author     : Ratna Dewi
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - HRSR Pharmacy</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/register.css" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Include Header Fragment -->
    <%@ include file="WEB-INF/jspf/header.jspf" %>

    <div class="container">
        <div class="register-container">
            <h2 class="register-title">Create an Account</h2>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <i class="bi bi-exclamation-circle"></i>
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="register" method="POST" class="needs-validation" novalidate>
                <!-- Full Name Field -->
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="fullName" name="full_name" 
                           placeholder="Enter your full name" required>
                    <label for="fullName">Full Name</label>
                    <div class="invalid-feedback">
                        Please enter your full name.
                    </div>
                </div>

                <!-- Email Field -->
                <div class="form-floating mb-3">
                    <input type="email" class="form-control" id="email" name="email" 
                           placeholder="name@example.com" required>
                    <label for="email">Email address</label>
                    <div class="invalid-feedback">
                        Please enter a valid email address.
                    </div>
                </div>

                <!-- Password Field -->
                <div class="form-floating mb-3">
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="Password" required minlength="6">
                    <label for="password">Password</label>
                    <div class="invalid-feedback">
                        Password must be at least 6 characters long.
                    </div>
                </div>

                <!-- Role Selection -->
                <div class="form-floating mb-4">
                    <select class="form-select" id="role" name="role" required>
                        <option value="customer">Customer</option>
                        <option value="admin">Admin</option>
                    </select>
                    <label for="role">Select Role</label>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary btn-register">
                    Create Account
                </button>
            </form>

            <!-- Login Link -->
            <div class="login-link">
                Already have an account? <a href="login.jsp">Login here</a>
            </div>
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