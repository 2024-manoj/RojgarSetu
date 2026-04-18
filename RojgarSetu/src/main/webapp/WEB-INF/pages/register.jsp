<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register - RojgarSetu</title>
<%--    <link rel="stylesheet" href="static/style.css">--%>
</head>
<body>
<h2>Register</h2>
<form method="post" action="register">
    <label>Name:</label>
    <input type="text" name="name" required><br>

    <label>Email:</label>
    <input type="email" name="email" required><br>

    <label>Password:</label>
    <input type="password" name="password" required><br>

    <button type="submit">Register</button>
</form>

</body>
</html>
