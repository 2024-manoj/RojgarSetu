<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Jobs — Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
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
            <h2><i class="fa-solid fa-briefcase"></i> Manage Jobs</h2>
        </div>

        <div class="section-card">

            <h3 class="section-title">All jobs</h3>

            <div class="table-wrapper">

                <table class="data-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Employer ID</th>
                        <th>Category</th>
                        <th>City</th>
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
                                String st = job.getStatus() != null ? job.getStatus() : "";
                                String badgeClass = "status-pending";
                                if ("approved".equalsIgnoreCase(st)) badgeClass = "status-approved";
                                else if ("rejected".equalsIgnoreCase(st)) badgeClass = "status-rejected";
                    %>
                    <tr>
                        <td><%= job.getJobId() %></td>
                        <td><%= job.getTitle() != null ? job.getTitle() : "" %></td>
                        <td><%= job.getEmployerId() %></td>
                        <td><%= job.getCategory() != null ? job.getCategory() : "" %></td>
                        <td><%= job.getLocationCity() != null ? job.getLocationCity() : "" %></td>
                        <td><span class="status-badge <%= badgeClass %>"><%= st %></span></td>
                        <td class="action-cell">
                            <% if ("pending".equalsIgnoreCase(st)) { %>
                            <form action="<%= request.getContextPath() %>/admin/jobs" method="post" style="display:inline;">
                                <input type="hidden" name="from" value="jobs"/>
                                <input type="hidden" name="action" value="approve"/>
                                <input type="hidden" name="jobId" value="<%= job.getJobId() %>"/>
                                <button type="submit" class="approve-btn">Approve</button>
                            </form>
                            <form action="<%= request.getContextPath() %>/admin/jobs" method="post" style="display:inline;margin-left:4px;">
                                <input type="hidden" name="from" value="jobs"/>
                                <input type="hidden" name="action" value="reject"/>
                                <input type="hidden" name="jobId" value="<%= job.getJobId() %>"/>
                                <button type="submit" class="muted-btn">Reject</button>
                            </form>
                            <% } %>
                            <form action="<%= request.getContextPath() %>/admin/jobs" method="post" style="display:inline;margin-left:4px;"
                                  onsubmit="return confirm('Delete this job?');">
                                <input type="hidden" name="from" value="jobs"/>
                                <input type="hidden" name="action" value="delete"/>
                                <input type="hidden" name="jobId" value="<%= job.getJobId() %>"/>
                                <button type="submit" class="delete-btn">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7">No jobs found.</td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>

            </div>

        </div>

    </main>

</div>
<%@include file="../components/admin/adminFooter.jsp"%>

</body>
</html>
