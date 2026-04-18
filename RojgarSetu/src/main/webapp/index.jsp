<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>RojgarSetu</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet" href="static/style.css">

</head>
<body>
    <%@include file="WEB-INF/components/Navbar.jsp"%>

    <section class="hero">
        <div class="hero-inner">
            <h1>Find Your Dream Job in <span style="color: var(--primary);">Koshi Province</span></h1>
            <p>Connecting local talent with the best employers across Nepal. Simple, professional, and effective.</p>

            <div class="search-bar">
                <input type="text" placeholder="Search title or keyword">
                <input type="text" placeholder="Location">
                <button class="btn-register">Search Job</button>
            </div>
        </div>
    </section>

    <footer class="footer">
        <div class="footer-inner">
            <p>© 2023 RojgarSetu Koshi Province. All rights reserved.</p>
            <div class="footer-links">
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
            </div>
        </div>
    </footer>








</body>
</html>