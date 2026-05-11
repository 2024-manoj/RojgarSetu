<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Reports — Admin | RojgarSetu</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/global.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/admin.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>
<body>

<%@ include file="../components/admin/adminNavbar.jsp" %>

<div class="admin-container">
    <%@ include file="../components/admin/adminSidebar.jsp" %>

    <main class="admin-main">
        <div class="page-header">
            <h2><i class="fas fa-chart-line"></i> Reports</h2>
        </div>

        <!-- Stats Cards -->
        <div class="reports-stats">
            <div class="stat-simple">
                <h4>Total Users</h4>
                <div class="number"><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : 0 %></div>
            </div>
            <div class="stat-simple">
                <h4>Seekers</h4>
                <div class="number"><%= request.getAttribute("totalSeekers") != null ? request.getAttribute("totalSeekers") : 0 %></div>
            </div>
            <div class="stat-simple">
                <h4>Employers</h4>
                <div class="number"><%= request.getAttribute("totalEmployers") != null ? request.getAttribute("totalEmployers") : 0 %></div>
            </div>
            <div class="stat-simple">
                <h4>Pending Accounts</h4>
                <div class="number"><%= request.getAttribute("pendingUsers") != null ? request.getAttribute("pendingUsers") : 0 %></div>
            </div>
            <div class="stat-simple">
                <h4>Total Jobs</h4>
                <div class="number"><%= request.getAttribute("totalJobs") != null ? request.getAttribute("totalJobs") : 0 %></div>
            </div>
            <div class="stat-simple">
                <h4>Pending Jobs</h4>
                <div class="number"><%= request.getAttribute("pendingJobs") != null ? request.getAttribute("pendingJobs") : 0 %></div>
            </div>
            <div class="stat-simple">
                <h4>Approved Jobs</h4>
                <div class="number"><%= request.getAttribute("approvedJobs") != null ? request.getAttribute("approvedJobs") : 0 %></div>
            </div>
        </div>

        <!-- Export Section -->
        <div class="export-box">
            <h3><i class="fas fa-download"></i> Export Data</h3>
            <div class="btn-group">
                <form action="<%= request.getContextPath() %>/admin/reports" method="get">
                    <input type="hidden" name="download" value="users"/>
                    <button type="submit" class="btn-csv"><i class="fas fa-file-csv"></i> Users CSV</button>
                </form>
                <form action="<%= request.getContextPath() %>/admin/reports" method="get">
                    <input type="hidden" name="download" value="jobs"/>
                    <button type="submit" class="btn-csv"><i class="fas fa-file-csv"></i> Jobs CSV</button>
                </form>
                <form action="<%= request.getContextPath() %>/admin/reports" method="get">
                    <input type="hidden" name="download" value="employers"/>
                    <button type="submit" class="btn-csv"><i class="fas fa-file-csv"></i> Employers CSV</button>
                </form>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="activity-box">
            <h3><i class="fas fa-history"></i> Recent Activity</h3>
            <div class="activity-item">
                <span><i class="fas fa-briefcase"></i> New Job - Tech Solutions</span>
                <span class="badge-pending">Pending</span>
            </div>
            <div class="activity-item">
                <span><i class="fas fa-user-plus"></i> New Seeker - Rajesh Kumar</span>
                <span class="badge-approved">Approved</span>
            </div>
            <div class="activity-item">
                <span><i class="fas fa-building"></i> Employer Update - Global Innovations</span>
                <span class="badge-approved">Updated</span>
            </div>
        </div>
    </main>
</div>
<%@include file="../components/admin/adminFooter.jsp"%>

</body>
</html>