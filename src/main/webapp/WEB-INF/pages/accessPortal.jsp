<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String selectedJob = request.getParameter("job");
    String selectedDistrict = request.getParameter("district");
    if (selectedJob == null || selectedJob.isBlank()) selectedJob = "your selected job";
    if (selectedDistrict == null || selectedDistrict.isBlank()) selectedDistrict = "Koshi Province";
    String jobLabel = selectedJob.replace("-", " ");
    String districtLabel = selectedDistrict.replace("-", " ");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Access Portal - RojgarSetu</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/global.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/landing.css">
</head>
<body>
<%@ include file="/WEB-INF/components/Navbar.jsp"%>

<main class="portal-page">
    <section class="portal-shell">
        <a class="portal-back" href="<%= request.getContextPath() %>/home">
            <i class="fa-solid fa-arrow-left"></i>
            <span>Back to Home</span>
        </a>

        <div class="portal-heading">
            <span class="portal-kicker"><i class="fa-solid fa-magnifying-glass"></i> Search ready</span>
            <h1>Choose how you want to access RojgarSetu</h1>
            <p>
                Continue to login and open the right dashboard for
                <strong><%= jobLabel %></strong> in <strong><%= districtLabel %></strong>.
            </p>
        </div>

        <div class="portal-cards">
            <a class="portal-card seeker-card" href="<%= request.getContextPath() %>/login?role=seeker">
                <span class="portal-card-icon"><i class="fa-solid fa-user-graduate"></i></span>
                <span class="portal-card-copy">
                    <strong>Seeker Login</strong>
                    <small>Browse jobs, apply, and track your applications.</small>
                </span>
                <i class="fa-solid fa-arrow-right portal-card-arrow"></i>
            </a>

            <a class="portal-card employer-card" href="<%= request.getContextPath() %>/login?role=employer">
                <span class="portal-card-icon"><i class="fa-solid fa-building"></i></span>
                <span class="portal-card-copy">
                    <strong>Employer Login</strong>
                    <small>Post jobs, review applicants, and manage hiring.</small>
                </span>
                <i class="fa-solid fa-arrow-right portal-card-arrow"></i>
            </a>
        </div>

        <div class="portal-access-panel">
            <div>
                <h2>Access Portal</h2>
                <p>Already have an account? Login and continue from your dashboard.</p>
            </div>
            <a class="portal-access-btn" href="<%= request.getContextPath() %>/login">
                <i class="fa-solid fa-right-to-bracket"></i>
                Access Portal
            </a>
        </div>
    </section>
</main>

<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
