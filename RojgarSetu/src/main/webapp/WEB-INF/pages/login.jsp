<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - RojgarSetu</title>
  <!-- External stylesheet -->
</head>
<body>
<%@ include file="/WEB-INF/components/Navbar.jsp" %>
<div class="login-container">
  <div class="logo">
    <h1>🔐 Login</h1>
    <p>Welcome back! Please login to your account</p>
  </div>

  <form action="login" method="POST">
    <div class="form-group">
      <label for="username">Username</label>
      <input type="text"  required placeholder="Enter your username">
    </div>

    <div class="form-group">
      <label for="password">Password</label>
      <input type="password" required placeholder="Enter your password">
    </div>

    <button type="submit" class="btn-login">Login</button>
  </form>

  <div class="register-link">
    Don't have an account? <a href="register.jsp">Register here</a>
  </div>

  <div class="back-home">
    <a href="index.jsp">← Back to Home</a>
  </div>
</div>
</body>
</html>
