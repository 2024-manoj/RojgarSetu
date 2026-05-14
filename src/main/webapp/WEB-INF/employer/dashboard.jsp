<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.util.List, java.util.Locale" %>
<%
    com.demo.models.User eu = (com.demo.models.User) request.getAttribute("employerUser");
    com.demo.models.EmployerProfile ep = (com.demo.models.EmployerProfile) request.getAttribute("employerProfile");
    Long totalJobsPosted = (Long) request.getAttribute("totalJobsPosted");
    Long totalApplicants = (Long) request.getAttribute("totalApplicants");
    Long pendingJobs = (Long) request.getAttribute("pendingJobs");
    Long activeJobs = (Long) request.getAttribute("activeJobs");
    List<com.demo.models.Job> recentJobs = (List<com.demo.models.Job>) request.getAttribute("recentJobs");

    String todayDate = new SimpleDateFormat("EEEE, MMMM d, yyyy", Locale.ENGLISH).format(new Date());

    String employerDisplayName = "Employer";
    if (eu != null && eu.getFullName() != null && !eu.getFullName().isBlank()) {
        employerDisplayName = eu.getFullName();
    }

    String companyName = "";
    if (ep != null && ep.getCompanyName() != null && !ep.getCompanyName().isBlank()) {
        companyName = ep.getCompanyName();
    }

    request.setAttribute("pageTitle", "Employer Dashboard");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="../components/employer/employerHead.jsp" %>
</head>
<body>

<%@ include file="../components/employer/employerLayout.jsp" %>

        <%-- ===== WELCOME BANNER ===== --%>
        <div class="employer-welcome-banner">
            <div class="employer-welcome-bg"></div>
            <div class="employer-welcome-content">
                <div class="employer-welcome-text">
                    <h2>
                        <i class="fas fa-building"></i>
                        Welcome, <span><%= companyName.isEmpty() ? employerDisplayName : companyName %></span>
                    </h2>
                    <p>Manage your job postings and find the best talent for your team.</p>
                </div>
                <div class="employer-welcome-date">
                    <i class="fas fa-calendar-day"></i>
                    <span><%= todayDate %></span>
                </div>
            </div>
        </div>

        <%-- ===== STATS GRID ===== --%>
        <div class="stats-grid employer-stats">

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>Total Jobs Posted</h3>
                    <div class="stat-icon blue"><i class="fas fa-clipboard-list"></i></div>
                </div>
                <p class="stat-number"><%= totalJobsPosted != null ? totalJobsPosted : 0 %></p>
                <span class="stat-sub"><i class="fas fa-chart-bar"></i> All time job posts</span>
            </div>

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>Total Applicants</h3>
                    <div class="stat-icon orange"><i class="fas fa-users"></i></div>
                </div>
                <p class="stat-number"><%= totalApplicants != null ? totalApplicants : 0 %></p>
                <span class="stat-sub"><i class="fas fa-user-plus"></i> Across all jobs</span>
            </div>

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>Pending Approval</h3>
                    <div class="stat-icon amber"><i class="fas fa-clock"></i></div>
                </div>
                <p class="stat-number"><%= pendingJobs != null ? pendingJobs : 0 %></p>
                <span class="stat-sub"><i class="fas fa-hourglass-half"></i> Awaiting admin review</span>
            </div>

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>Active Jobs</h3>
                    <div class="stat-icon green"><i class="fas fa-check-circle"></i></div>
                </div>
                <p class="stat-number"><%= activeJobs != null ? activeJobs : 0 %></p>
                <span class="stat-sub"><i class="fas fa-eye"></i> Visible to seekers</span>
            </div>

        </div>

        <%-- ===== RECENT JOB POSTS TABLE ===== --%>
        <div class="section-card">
            <h3 class="section-title">
                <i class="fa-solid fa-clock-rotate-left"></i> Recent Job Posts
            </h3>
            <div class="table-wrapper">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Job Title</th>
                            <th>Category</th>
                            <th>Posted Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (recentJobs != null && !recentJobs.isEmpty()) {
                            SimpleDateFormat dateFmt = new SimpleDateFormat("yyyy-MM-dd");
                            for (com.demo.models.Job job : recentJobs) {
                                String st = job.getStatus() != null ? job.getStatus() : "";
                                String badgeClass = "status-pending";
                                if ("approved".equalsIgnoreCase(st)) badgeClass = "status-approved";
                                else if ("rejected".equalsIgnoreCase(st)) badgeClass = "status-rejected";
                        %>
                        <tr>
                            <td><strong><%= job.getTitle() != null ? job.getTitle() : "—" %></strong></td>
                            <td><%= job.getCategory() != null ? job.getCategory() : "—" %></td>
                            <td><%= job.getPostedAt() != null ? dateFmt.format(job.getPostedAt()) : "—" %></td>
                            <td><span class="status-badge <%= badgeClass %>"><%= st %></span></td>
                            <td>
                                <a href="<%= request.getContextPath() %>/employer?page=postjob&editId=<%= job.getJobId() %>"
                                   class="muted-btn"><i class="fa-solid fa-pen"></i> Edit</a>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="5">No jobs posted yet. <a href="<%= request.getContextPath() %>/employer?page=postjob">Post your first job!</a></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

<%@ include file="../components/employer/employerLayoutEnd.jsp" %>

</body>
</html>
