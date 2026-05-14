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
    SimpleDateFormat dateFmt = new SimpleDateFormat("MMM dd, yyyy");

    String employerDisplayName = "Employer";
    if (eu != null && eu.getFullName() != null && !eu.getFullName().isBlank()) {
        employerDisplayName = eu.getFullName();
    }

    String companyName = "";
    if (ep != null && ep.getCompanyName() != null && !ep.getCompanyName().isBlank()) {
        companyName = ep.getCompanyName();
    }

    long jobsCount = totalJobsPosted != null ? totalJobsPosted : 0;
    long applicantsCount = totalApplicants != null ? totalApplicants : 0;
    long pendingCount = pendingJobs != null ? pendingJobs : 0;
    long activeCount = activeJobs != null ? activeJobs : 0;
    long inactiveCount = Math.max(0, jobsCount - activeCount - pendingCount);

    String dashboardFocusIcon = "fa-circle-check";
    String dashboardFocusTitle = "Workspace looks healthy";
    String dashboardFocusText = "Keep your open roles fresh and review applicants regularly.";
    if (jobsCount == 0) {
        dashboardFocusIcon = "fa-briefcase";
        dashboardFocusTitle = "Post your first job";
        dashboardFocusText = "Create a job post so seekers can discover your company.";
    } else if (pendingCount > 0) {
        dashboardFocusIcon = "fa-hourglass-half";
        dashboardFocusTitle = pendingCount + " job" + (pendingCount == 1 ? "" : "s") + " awaiting approval";
        dashboardFocusText = "These posts will become visible after admin review.";
    } else if (applicantsCount > 0) {
        dashboardFocusIcon = "fa-user-check";
        dashboardFocusTitle = "Review new applicants";
        dashboardFocusText = "Shortlist, reject, or hire candidates from the applicants page.";
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
                    <p>Track posts, approvals, and applicants from one focused workspace.</p>
                </div>
                <div class="employer-welcome-side">
                    <div class="employer-welcome-date">
                        <i class="fas fa-calendar-day"></i>
                        <span><%= todayDate %></span>
                    </div>
                    <div class="employer-welcome-actions">
                        <a class="employer-hero-btn primary" href="<%= request.getContextPath() %>/employer?page=postjob">
                            <i class="fa-solid fa-plus"></i>
                            <span>Post Job</span>
                        </a>
                        <a class="employer-hero-btn secondary" href="<%= request.getContextPath() %>/employer?page=applicants">
                            <i class="fa-solid fa-users"></i>
                            <span>Applicants</span>
                        </a>
                    </div>
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
                <p class="stat-number"><%= jobsCount %></p>
                <span class="stat-sub"><i class="fas fa-chart-bar"></i> All time job posts</span>
            </div>

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>Total Applicants</h3>
                    <div class="stat-icon orange"><i class="fas fa-users"></i></div>
                </div>
                <p class="stat-number"><%= applicantsCount %></p>
                <span class="stat-sub"><i class="fas fa-user-plus"></i> Across all jobs</span>
            </div>

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>Pending Approval</h3>
                    <div class="stat-icon amber"><i class="fas fa-clock"></i></div>
                </div>
                <p class="stat-number"><%= pendingCount %></p>
                <span class="stat-sub"><i class="fas fa-hourglass-half"></i> Awaiting admin review</span>
            </div>

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>Active Jobs</h3>
                    <div class="stat-icon green"><i class="fas fa-check-circle"></i></div>
                </div>
                <p class="stat-number"><%= activeCount %></p>
                <span class="stat-sub"><i class="fas fa-eye"></i> Visible to seekers</span>
            </div>

        </div>

        <%-- ===== QUICK WORKSPACE ===== --%>
        <div class="employer-dashboard-grid">
            <div class="employer-focus-card">
                <div class="employer-focus-icon">
                    <i class="fa-solid <%= dashboardFocusIcon %>"></i>
                </div>
                <div class="employer-focus-copy">
                    <span class="employer-eyebrow">Needs attention</span>
                    <h3><%= dashboardFocusTitle %></h3>
                    <p><%= dashboardFocusText %></p>
                </div>
                <a class="employer-focus-action" href="<%= jobsCount == 0 ? request.getContextPath() + "/employer?page=postjob" : request.getContextPath() + "/employer?page=myjobs" %>">
                    <span><%= jobsCount == 0 ? "Create post" : "View jobs" %></span>
                    <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>

            <div class="employer-health-card">
                <h3><i class="fa-solid fa-chart-simple"></i> Job pipeline</h3>
                <div class="pipeline-list">
                    <div class="pipeline-row">
                        <span><i class="fa-solid fa-circle-check approved-dot"></i> Active</span>
                        <strong><%= activeCount %></strong>
                    </div>
                    <div class="pipeline-row">
                        <span><i class="fa-solid fa-clock pending-dot"></i> Pending</span>
                        <strong><%= pendingCount %></strong>
                    </div>
                    <div class="pipeline-row">
                        <span><i class="fa-solid fa-circle-minus muted-dot"></i> Other</span>
                        <strong><%= inactiveCount %></strong>
                    </div>
                </div>
            </div>
        </div>

        <%-- ===== QUICK ACTIONS ===== --%>
        <div class="employer-quick-actions">
            <a href="<%= request.getContextPath() %>/employer?page=postjob" class="employer-quick-card">
                <span class="employer-quick-icon blue"><i class="fa-solid fa-plus"></i></span>
                <span>
                    <strong>Post a job</strong>
                    <small>Create a new vacancy</small>
                </span>
                <i class="fa-solid fa-chevron-right"></i>
            </a>
            <a href="<%= request.getContextPath() %>/employer?page=myjobs" class="employer-quick-card">
                <span class="employer-quick-icon amber"><i class="fa-solid fa-briefcase"></i></span>
                <span>
                    <strong>Manage jobs</strong>
                    <small>Edit, check status</small>
                </span>
                <i class="fa-solid fa-chevron-right"></i>
            </a>
            <a href="<%= request.getContextPath() %>/employer?page=applicants" class="employer-quick-card">
                <span class="employer-quick-icon green"><i class="fa-solid fa-user-check"></i></span>
                <span>
                    <strong>Review applicants</strong>
                    <small>Shortlist or hire</small>
                </span>
                <i class="fa-solid fa-chevron-right"></i>
            </a>
        </div>

        <%-- ===== RECENT JOB POSTS TABLE ===== --%>
        <div class="section-card">
            <div class="section-title employer-section-title">
                <span><i class="fa-solid fa-clock-rotate-left"></i> Recent Job Posts</span>
                <a href="<%= request.getContextPath() %>/employer?page=myjobs">View all</a>
            </div>
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
                            for (com.demo.models.Job job : recentJobs) {
                                String st = job.getStatus() != null ? job.getStatus() : "";
                                String badgeClass = "status-pending";
                                if ("approved".equalsIgnoreCase(st)) badgeClass = "status-approved";
                                else if ("rejected".equalsIgnoreCase(st)) badgeClass = "status-rejected";
                        %>
                        <tr>
                            <td>
                                <div class="employer-job-cell">
                                    <span class="employer-job-icon"><i class="fa-solid fa-briefcase"></i></span>
                                    <strong><%= job.getTitle() != null ? job.getTitle() : "-" %></strong>
                                </div>
                            </td>
                            <td><%= job.getCategory() != null ? job.getCategory() : "-" %></td>
                            <td><%= job.getPostedAt() != null ? dateFmt.format(job.getPostedAt()) : "-" %></td>
                            <td><span class="status-badge <%= badgeClass %>"><%= st %></span></td>
                            <td>
                                <a href="<%= request.getContextPath() %>/employer?page=postjob&editId=<%= job.getJobId() %>"
                                   class="muted-btn"><i class="fa-solid fa-pen"></i> Edit</a>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="5">
                                <div class="employer-empty-state">
                                    <span><i class="fa-solid fa-briefcase"></i></span>
                                    <strong>No jobs posted yet</strong>
                                    <p>Create your first listing and start receiving applicants.</p>
                                    <a href="<%= request.getContextPath() %>/employer?page=postjob">Post your first job</a>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

<%@ include file="../components/employer/employerLayoutEnd.jsp" %>

</body>
</html>
