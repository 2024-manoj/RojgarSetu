<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/global.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/admin.css"/>
</head>
<body>

<%@ include file="../components/admin/adminNavbar.jsp" %>

<div class="admin-container">

    <%@ include file="../components/admin/adminSidebar.jsp" %>

    <main class="admin-main">

        <!-- ===== WELCOME BANNER ===== -->
        <div class="welcome-banner">
            <div class="welcome-banner-bg"></div>
            <div class="welcome-banner-content">
                <div class="welcome-text">
                    <h2><i class="fas fa-hand-sparkles"></i> Welcome back, <span><%= session.getAttribute("adminName") != null ? session.getAttribute("adminName") : "Admin" %></span></h2>
                    <p>Here's what's happening with your platform today.</p>
                </div>
                <div class="welcome-date">
                    <i class="fas fa-calendar-day"></i>
                    <span id="currentDate"></span>
                </div>
            </div>
        </div>

        <!-- ===== STATS GRID ===== -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>Total Users</h3>
                    <div class="stat-icon blue"><i class="fas fa-users"></i></div>
                </div>
                <p class="stat-number">
                    <%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : 0 %>
                </p>
                <span class="stat-sub"><i class="fas fa-user-group"></i> Seekers: <%= request.getAttribute("totalSeekers") != null ? request.getAttribute("totalSeekers") : 0 %></span>
            </div>

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>Total Employers</h3>
                    <div class="stat-icon orange"><i class="fas fa-building"></i></div>
                </div>
                <p class="stat-number">
                    <%= request.getAttribute("totalEmployers") != null ? request.getAttribute("totalEmployers") : 0 %>
                </p>
                <span class="stat-sub"><i class="fas fa-clock"></i> Pending: <%= request.getAttribute("pendingUsers") != null ? request.getAttribute("pendingUsers") : 0 %></span>
            </div>

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>Total Jobs</h3>
                    <div class="stat-icon green"><i class="fas fa-briefcase"></i></div>
                </div>
                <p class="stat-number">
                    <%= request.getAttribute("totalJobs") != null ? request.getAttribute("totalJobs") : 0 %>
                </p>
                <span class="stat-sub"><i class="fas fa-check-circle"></i> Approved: <%= request.getAttribute("approvedJobs") != null ? request.getAttribute("approvedJobs") : 0 %></span>
            </div>

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>Pending Jobs</h3>
                    <div class="stat-icon red"><i class="fas fa-hourglass-half"></i></div>
                </div>
                <p class="stat-number">
                    <%= request.getAttribute("pendingApprovals") != null ? request.getAttribute("pendingApprovals") : 0 %>
                </p>
                <span class="stat-sub"><i class="fas fa-exclamation-triangle"></i> Needs attention</span>
            </div>
        </div>

        <!-- ===== QUICK ACTIONS ===== -->
        <div class="quick-actions">
            <a href="<%=request.getContextPath()%>/admin/seekers" class="quick-action-card">
                <div class="qa-icon blue"><i class="fas fa-user-group"></i></div>
                <div class="qa-text">
                    <h4>Manage Seekers</h4>
                    <p>View & approve seekers</p>
                </div>
                <i class="fas fa-arrow-right qa-arrow"></i>
            </a>
            <a href="<%=request.getContextPath()%>/admin/employers" class="quick-action-card">
                <div class="qa-icon orange"><i class="fas fa-building"></i></div>
                <div class="qa-text">
                    <h4>Manage Employers</h4>
                    <p>Review employer accounts</p>
                </div>
                <i class="fas fa-arrow-right qa-arrow"></i>
            </a>
            <a href="<%=request.getContextPath()%>/admin/jobs" class="quick-action-card">
                <div class="qa-icon green"><i class="fas fa-briefcase"></i></div>
                <div class="qa-text">
                    <h4>Manage Jobs</h4>
                    <p>Approve or reject jobs</p>
                </div>
                <i class="fas fa-arrow-right qa-arrow"></i>
            </a>
            <a href="<%=request.getContextPath()%>/admin/reports" class="quick-action-card">
                <div class="qa-icon purple"><i class="fas fa-chart-column"></i></div>
                <div class="qa-text">
                    <h4>View Reports</h4>
                    <p>Export data & analytics</p>
                </div>
                <i class="fas fa-arrow-right qa-arrow"></i>
            </a>
        </div>

        <!-- ===== TWO COLUMN: PENDING JOBS + RECENT USERS ===== -->
        <div class="dashboard-grid">

            <!-- PENDING JOBS TABLE -->
            <div class="section-card">
                <h3 class="section-title">
                    <i class="fas fa-clock"></i> Pending Job Approvals
                </h3>
                <div class="table-wrapper">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Job Title</th>
                            <th>Employer</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            java.util.List<com.demo.models.Job> jobs =
                                    (java.util.List<com.demo.models.Job>) request.getAttribute("jobs");
                            if (jobs != null && !jobs.isEmpty()) {
                                for (com.demo.models.Job job : jobs) {
                        %>
                        <tr>
                            <td><%= job.getJobId() %></td>
                            <td><%= job.getTitle() %></td>
                            <td><%= job.getEmployerId() %></td>
                            <td><span class="status-badge status-pending"><%= job.getStatus() %></span></td>
                            <td class="action-cell">
                                <form action="<%=request.getContextPath()%>/admin/jobs" method="post" style="display:inline;">
                                    <input type="hidden" name="from" value="dashboard"/>
                                    <input type="hidden" name="action" value="approve"/>
                                    <input type="hidden" name="jobId" value="<%= job.getJobId() %>"/>
                                    <button type="submit" class="approve-btn"><i class="fas fa-check"></i> Approve</button>
                                </form>
                                <form action="<%=request.getContextPath()%>/admin/jobs" method="post" style="display:inline;margin-left:6px;">
                                    <input type="hidden" name="from" value="dashboard"/>
                                    <input type="hidden" name="action" value="reject"/>
                                    <input type="hidden" name="jobId" value="<%= job.getJobId() %>"/>
                                    <button type="submit" class="delete-btn"><i class="fas fa-xmark"></i> Reject</button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr><td colspan="5">No pending jobs right now. You're all caught up! 🎉</td></tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- RECENT USERS -->
            <div class="section-card">
                <h3 class="section-title">
                    <i class="fas fa-user-plus"></i> Recent Registrations
                </h3>
                <div class="table-wrapper">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Role</th>
                            <th>Status</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            java.util.List<com.demo.models.User> recentUsers =
                                    (java.util.List<com.demo.models.User>) request.getAttribute("recentUsers");
                            if (recentUsers != null && !recentUsers.isEmpty()) {
                                for (com.demo.models.User u : recentUsers) {
                                    String st = u.getStatus() != null ? u.getStatus() : "";
                                    String badgeClass = "status-pending";
                                    if ("APPROVED".equalsIgnoreCase(st)) badgeClass = "status-approved";
                                    else if ("REJECTED".equalsIgnoreCase(st)) badgeClass = "status-rejected";
                        %>
                        <tr>
                            <td>
                                <div class="user-cell">
                                    <div class="user-cell-avatar"><i class="fas fa-user"></i></div>
                                    <div>
                                        <strong><%= u.getFullName() != null ? u.getFullName() : "" %></strong>
                                        <small><%= u.getEmail() != null ? u.getEmail() : "" %></small>
                                    </div>
                                </div>
                            </td>
                            <td><span class="role-badge role-<%= u.getRole() != null ? u.getRole().toLowerCase() : "" %>"><%= u.getRole() %></span></td>
                            <td><span class="status-badge <%= badgeClass %>"><%= st %></span></td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr><td colspan="3">No users registered yet.</td></tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>

    </main>

</div>
<%@include file="../components/admin/adminFooter.jsp"%>

<script>
    // Display current date
    const dateEl = document.getElementById('currentDate');
    if (dateEl) {
        const now = new Date();
        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        dateEl.textContent = now.toLocaleDateString('en-US', options);
    }
</script>

</body>
</html>