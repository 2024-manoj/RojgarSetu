<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.text.SimpleDateFormat" %>
<%
    List<com.demo.models.Application> applications =
        (List<com.demo.models.Application>) request.getAttribute("applications");

    // Date formatter
    SimpleDateFormat dateFmt = new SimpleDateFormat("MMM dd, yyyy");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>My Applications — RojgarSetu</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/global.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/admin.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/seeker.css"/>
</head>
<body>

<%@ include file="../components/seeker/seekerNavbar.jsp" %>

<div class="admin-container">
    <%@ include file="../components/seeker/seekerSidebar.jsp" %>

    <main class="admin-main">

        <%-- Alerts --%>
        <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success">
            <i class="fa-solid fa-circle-check"></i> <%= request.getAttribute("success") %>
        </div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <i class="fa-solid fa-circle-exclamation"></i> <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <%-- Page Header --%>
        <div class="page-header">
            <h2><i class="fa-solid fa-paper-plane"></i> My Applications</h2>
        </div>

        <%-- Applications Table --%>
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
                        <th>Status</th>
                        <th>Applied On</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (applications != null && !applications.isEmpty()) {
                        for (com.demo.models.Application app : applications) {
                            String st = app.getStatus() != null ? app.getStatus() : "";
                            String badgeClass = "status-pending";
                            if ("shortlisted".equalsIgnoreCase(st) || "hired".equalsIgnoreCase(st))
                                badgeClass = "status-approved";
                            else if ("rejected".equalsIgnoreCase(st))
                                badgeClass = "status-rejected";
                    %>
                    <tr>
                        <td><strong>#<%= app.getJobId() %></strong></td>
                        <td>
                            <%
                                String cl = app.getCoverLetter() != null ? app.getCoverLetter() : "";
                                if (cl.length() > 80) cl = cl.substring(0, 80) + "...";
                            %>
                            <%= cl.isEmpty() ? "—" : cl %>
                        </td>
                        <td><span class="status-badge <%= badgeClass %>"><%= st %></span></td>
                        <td><%= app.getAppliedAt() != null ? dateFmt.format(app.getAppliedAt()) : "—" %></td>
                    </tr>
                    <% }
                    } else { %>
                    <tr><td colspan="4">You haven't applied to any jobs yet. <a href="<%= request.getContextPath() %>/seeker?page=browse">Browse jobs</a> to get started!</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>

    </main>
</div>

<%@ include file="../components/seeker/seekerFooter.jsp" %>

</body>
</html>
