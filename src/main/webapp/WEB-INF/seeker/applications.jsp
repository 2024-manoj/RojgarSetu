<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.text.SimpleDateFormat" %>
<%
    List<com.demo.models.Application> applications =
        (List<com.demo.models.Application>) request.getAttribute("applications");

    SimpleDateFormat dateFmt = new SimpleDateFormat("MMM dd, yyyy");
    request.setAttribute("pageTitle", "My Applications");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="../components/seeker/seekerHead.jsp" %>
</head>
<body>

<%@ include file="../components/seeker/seekerLayout.jsp" %>

        <div class="page-header">
            <h2><i class="fa-solid fa-paper-plane"></i> My Applications</h2>
        </div>

        <div class="section-card">
            <h3 class="section-title">
                <i class="fa-solid fa-list-check"></i> Application History
            </h3>
            <div class="table-wrapper">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Job ID</th>
                            <th>Cover Letter</th>
                            <th>Resume</th>
                            <th>Status</th>
                            <th>Applied On</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (applications != null && !applications.isEmpty()) {
                            for (com.demo.models.Application app : applications) {
                                String st = app.getStatus() != null ? app.getStatus() : "";
                                String badgeClass = "status-pending";
                                if ("shortlisted".equalsIgnoreCase(st) || "hired".equalsIgnoreCase(st)) badgeClass = "status-approved";
                                else if ("rejected".equalsIgnoreCase(st)) badgeClass = "status-rejected";
                                String cl = app.getCoverLetter() != null ? app.getCoverLetter() : "";
                                if (cl.length() > 80) cl = cl.substring(0, 80) + "...";
                        %>
                        <tr>
                            <td><strong>#<%= app.getJobId() %></strong></td>
                            <td><%= cl.isEmpty() ? "-" : cl %></td>
                            <td>
                                <% if (app.getResumePath() != null && !app.getResumePath().isBlank()) { %>
                                    <div class="resume-actions">
                                        <a class="resume-view-btn" href="<%= request.getContextPath() %>/resume?file=<%= app.getResumePath() %>" target="_blank" title="View PDF">
                                            <i class="fa-solid fa-eye"></i> View
                                        </a>
                                        <a class="resume-download-btn" href="<%= request.getContextPath() %>/resume?file=<%= app.getResumePath() %>&download=true" title="Download PDF">
                                            <i class="fa-solid fa-download"></i>
                                        </a>
                                    </div>
                                <% } else { %>
                                    <span class="no-resume">—</span>
                                <% } %>
                            </td>
                            <td><span class="status-badge <%= badgeClass %>"><%= st %></span></td>
                            <td><%= app.getAppliedAt() != null ? dateFmt.format(app.getAppliedAt()) : "-" %></td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="5">You haven't applied to any jobs yet.
                                <a href="<%= request.getContextPath() %>/seeker?page=browse">Browse jobs</a> to get started!
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

<%@ include file="../components/seeker/seekerLayoutEnd.jsp" %>

</body>
</html>
