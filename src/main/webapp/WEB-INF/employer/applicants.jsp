<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.text.SimpleDateFormat" %>
<%
    List<com.demo.models.Application> applications =
        (List<com.demo.models.Application>) request.getAttribute("applications");
    SimpleDateFormat dateFmt = new SimpleDateFormat("MMM dd, yyyy");
    request.setAttribute("pageTitle", "View Applicants");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="../components/employer/employerHead.jsp" %>
</head>
<body>
<%@ include file="../components/employer/employerLayout.jsp" %>

        <div class="page-header">
            <h2><i class="fa-solid fa-users"></i> View Applicants</h2>
        </div>

        <div class="section-card">
            <h3 class="section-title"><i class="fa-solid fa-user-check"></i> All Applications
                <span class="section-count"><%= applications != null ? applications.size() : 0 %> applicants</span>
            </h3>
            <div class="table-wrapper">
                <table class="data-table">
                    <thead><tr>
                        <th>#</th><th>Applicant</th><th>Email</th><th>Job Title</th><th>Applied On</th><th>Status</th><th>Actions</th>
                    </tr></thead>
                    <tbody>
                        <% if (applications != null && !applications.isEmpty()) {
                            for (com.demo.models.Application app : applications) {
                                String st = app.getStatus() != null ? app.getStatus() : "";
                                String badgeClass = "status-pending";
                                if ("shortlisted".equalsIgnoreCase(st) || "hired".equalsIgnoreCase(st)) badgeClass = "status-approved";
                                else if ("rejected".equalsIgnoreCase(st)) badgeClass = "status-rejected";
                        %>
                        <tr>
                            <td><strong>#<%= app.getId() %></strong></td>
                            <td><div class="applicant-info"><i class="fa-solid fa-user-circle applicant-avatar"></i><strong><%= app.getSeekerName() != null ? app.getSeekerName() : "—" %></strong></div></td>
                            <td><%= app.getSeekerEmail() != null ? app.getSeekerEmail() : "—" %></td>
                            <td><%= app.getJobTitle() != null ? app.getJobTitle() : "—" %></td>
                            <td><%= app.getAppliedAt() != null ? dateFmt.format(app.getAppliedAt()) : "—" %></td>
                            <td><span class="status-badge <%= badgeClass %>"><%= st %></span></td>
                            <td class="action-cell">
                                <% if ("pending".equalsIgnoreCase(st)) { %>
                                <form method="post" action="<%= request.getContextPath() %>/employer" style="display:inline;">
                                    <input type="hidden" name="action" value="updateapplication"/>
                                    <input type="hidden" name="appId" value="<%= app.getId() %>"/>
                                    <input type="hidden" name="status" value="shortlisted"/>
                                    <button type="submit" class="approve-btn"><i class="fa-solid fa-check"></i> Shortlist</button>
                                </form>
                                <form method="post" action="<%= request.getContextPath() %>/employer" style="display:inline;">
                                    <input type="hidden" name="action" value="updateapplication"/>
                                    <input type="hidden" name="appId" value="<%= app.getId() %>"/>
                                    <input type="hidden" name="status" value="rejected"/>
                                    <button type="submit" class="delete-btn"><i class="fa-solid fa-xmark"></i> Reject</button>
                                </form>
                                <% } else if ("shortlisted".equalsIgnoreCase(st)) { %>
                                <form method="post" action="<%= request.getContextPath() %>/employer" style="display:inline;">
                                    <input type="hidden" name="action" value="updateapplication"/>
                                    <input type="hidden" name="appId" value="<%= app.getId() %>"/>
                                    <input type="hidden" name="status" value="hired"/>
                                    <button type="submit" class="approve-btn"><i class="fa-solid fa-handshake"></i> Hire</button>
                                </form>
                                <% } else { %>
                                <span class="muted-btn" style="cursor:default;opacity:0.6;"><i class="fa-solid fa-lock"></i> Final</span>
                                <% } %>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr><td colspan="7">No applications received yet. Post more jobs to attract talent!</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

<%@ include file="../components/employer/employerLayoutEnd.jsp" %>
</body>
</html>
