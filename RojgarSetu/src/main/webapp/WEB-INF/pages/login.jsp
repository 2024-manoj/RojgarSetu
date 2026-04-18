<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Login - RojgarSetu</title>
<%--  <link rel="stylesheet" href="static/style.css">--%>
</head>
<body>
<h2>Login</h2>
<form method="post" action="login">
  <label>Email:</label>
  <input type="email" name="email" required><br>

  <label>Password:</label>
  <input type="password" name="password" required><br>

  <button type="submit">Login</button>
</form>

</body>
</html>
