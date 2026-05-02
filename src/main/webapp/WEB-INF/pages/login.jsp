<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Login — RojgarSetu</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/global.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/login.css">


</head>
<body>

<%@include file="/WEB-INF/components/Navbar.jsp"%>

<!-- Login Section -->
<section class="auth-section">
    <div class="auth-card">

        <!-- Card Header -->
        <div class="auth-header">
            <div class="auth-logo-icon">
                <i class="fas fa-briefcase"></i>
            </div>
            <h1 class="auth-title">Welcome Back</h1>
            <p class="auth-subtitle">Login to your RojgarSetu account</p>
        </div>

        <!-- Error Message -->
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
        <div class="auth-alert error">
            <i class="fas fa-circle-exclamation"></i> <%= error %>
        </div>
        <% } %>

        <!-- Success Message -->
        <% String success = (String) request.getAttribute("success"); %>
        <% if (success != null) { %>
        <div class="auth-alert success">
            <i class="fas fa-circle-check"></i> <%= success %>
        </div>
        <% } %>

        <!-- Login Form -->
        <form action="${pageContext.request.contextPath}/LoginServlet" method="post" class="auth-form">

            <!-- Email -->
            <div class="form-group">
                <label for="email" class="form-label">
                    <i class="fas fa-envelope"></i> Email Address
                </label>
                <input
                        type="email"
                        id="email"
                        name="email"
                        class="form-input"
                        placeholder="Enter your email"
                        required
                        autocomplete="email"
                />
            </div>

            <!-- Password -->
            <div class="form-group">
                <div class="label-row">
                    <label for="password" class="form-label">
                        <i class="fas fa-lock"></i> Password
                    </label>
                    <a href="${pageContext.request.contextPath}/forgot-password" class="forgot-link">Forgot password?</a>
                </div>
                <div class="input-password-wrapper">
                    <input
                            type="password"
                            id="password"
                            name="password"
                            class="form-input"
                            placeholder="Enter your password"
                            required
                            autocomplete="current-password"
                    />
                    <button type="button" class="toggle-password" onclick="togglePassword()">
                        <i class="fas fa-eye" id="eyeIcon"></i>
                    </button>
                </div>
            </div>

            <!-- Remember Me -->
            <div class="form-check">
                <input type="checkbox" id="rememberMe" name="rememberMe" class="check-input" />
                <label for="rememberMe" class="check-label">Remember me for 30 days</label>
            </div>

            <!-- Submit -->
            <button type="submit" class="btn-submit">
                <i class="fas fa-right-to-bracket"></i> Login
            </button>

        </form>

        <!-- Divider -->
        <div class="auth-divider"><span>or</span></div>

        <!-- Register Link -->
        <p class="auth-switch">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register">Create one for free <i class="fas fa-arrow-right"></i></a>
        </p>

    </div>
</section>

<%@ include file="/WEB-INF/components/Footer.jsp" %>

<script>
    function togglePassword() {
        const input = document.getElementById('password');
        const icon = document.getElementById('eyeIcon');
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.replace('fa-eye', 'fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.replace('fa-eye-slash', 'fa-eye');
        }
    }
</script>

</body>
</html>