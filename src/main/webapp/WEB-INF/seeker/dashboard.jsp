<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.util.Locale" %>
<%
    com.demo.models.User su = (com.demo.models.User) request.getAttribute("seekerUser");
    Long openJobs = (Long) request.getAttribute("openJobsCount");
    Long appCount = (Long) request.getAttribute("applicationCount");

    String todayDate = new SimpleDateFormat("EEEE, MMMM d, yyyy", Locale.ENGLISH).format(new Date());

    String seekerDisplayName = "Seeker";
    if (su != null && su.getFullName() != null && !su.getFullName().isBlank()) {
        seekerDisplayName = su.getFullName();
    }

    request.setAttribute("pageTitle", "Seeker Dashboard");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="../components/seeker/seekerHead.jsp" %>
</head>
<body>

<%@ include file="../components/seeker/seekerLayout.jsp" %>

        <%-- ===== WELCOME BANNER ===== --%>
        <div class="seeker-welcome-banner">
            <div class="seeker-welcome-bg"></div>
            <div class="seeker-welcome-content">
                <div class="seeker-welcome-text">
                    <h2>
                        <i class="fas fa-hand-sparkles"></i>
                        Welcome back, <span><%= seekerDisplayName %></span>
                    </h2>
                    <p>Keep your profile updated to get the best job recommendations.</p>
                </div>
                <div class="seeker-welcome-date">
                    <i class="fas fa-calendar-day"></i>
                    <span><%= todayDate %></span>
                </div>
            </div>
        </div>

        <%-- ===== STATS GRID ===== --%>
        <div class="stats-grid seeker-stats">

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>Account Status</h3>
                    <div class="stat-icon teal"><i class="fas fa-shield-halved"></i></div>
                </div>
                <p class="stat-number" style="font-size:1.3rem;">
                    <%= su != null && su.getStatus() != null ? su.getStatus() : "—" %>
                </p>
                <span class="stat-sub"><i class="fas fa-info-circle"></i> Your current account status</span>
            </div>

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>Open Approved Jobs</h3>
                    <div class="stat-icon orange"><i class="fas fa-briefcase"></i></div>
                </div>
                <p class="stat-number"><%= openJobs != null ? openJobs : 0 %></p>
                <span class="stat-sub"><i class="fas fa-arrow-trend-up"></i> Available for applications</span>
            </div>

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>My Applications</h3>
                    <div class="stat-icon green"><i class="fas fa-paper-plane"></i></div>
                </div>
                <p class="stat-number"><%= appCount != null ? appCount : 0 %></p>
                <span class="stat-sub"><i class="fas fa-check-circle"></i> Jobs you applied to</span>
            </div>

        </div>

        <%-- ===== TIP CARD ===== --%>
        <div class="seeker-tip-card">
            <div class="seeker-tip-icon">
                <i class="fas fa-lightbulb"></i>
            </div>
            <div class="seeker-tip-content">
                <h4>Quick Tip</h4>
                <p>
                    Complete your profile to stand out to employers.
                    Add your skills, education, and upload your resume.
                    Use <a href="<%= request.getContextPath() %>/seeker?page=browse">Browse Jobs</a> to find the best opportunities.
                </p>
            </div>
        </div>

<%@ include file="../components/seeker/seekerLayoutEnd.jsp" %>

</body>
</html>
