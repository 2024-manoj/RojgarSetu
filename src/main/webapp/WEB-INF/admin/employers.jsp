<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Manage Employers — Admin</title>
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
            <h2><i class="fa-solid fa-building"></i> Manage Employers</h2>
        </div>

        <div class="section-card">

            <h3 class="section-title">Manage employers</h3>

            <div class="table-wrapper">

                <table class="data-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Location</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        java.util.List<com.demo.models.User> employers =
                                (java.util.List<com.demo.models.User>) request.getAttribute("employers");
                        if (employers != null && !employers.isEmpty()) {
                            for (com.demo.models.User u : employers) {
                                String st = u.getStatus() != null ? u.getStatus() : "";
                                String badgeClass = "status-pending";
                                if ("APPROVED".equalsIgnoreCase(st)) badgeClass = "status-approved";
                                else if ("REJECTED".equalsIgnoreCase(st)) badgeClass = "status-rejected";
                    %>
                    <tr>
                        <td><%= u.getId() %></td>
                        <td><%= u.getFullName() != null ? u.getFullName() : "" %></td>
                        <td><%= u.getEmail() != null ? u.getEmail() : "" %></td>
                        <td><%= u.getLocation() != null ? u.getLocation() : "" %></td>
                        <td><span class="status-badge <%= badgeClass %>"><%= st %></span></td>
                        <td class="action-cell">
                            <% if ("PENDING".equalsIgnoreCase(st)) { %>
                            <form action="<%= request.getContextPath() %>/admin/employers" method="post" style="display:inline;">
                                <input type="hidden" name="userId" value="<%= u.getId() %>"/>
                                <input type="hidden" name="action" value="approve"/>
                                <button type="submit" class="approve-btn">Approve</button>
                            </form>
                            <form action="<%= request.getContextPath() %>/admin/employers" method="post" style="display:inline;margin-left:4px;">
                                <input type="hidden" name="userId" value="<%= u.getId() %>"/>
                                <input type="hidden" name="action" value="reject"/>
                                <button type="submit" class="muted-btn">Reject</button>
                            </form>
                            <% } %>
                            <form action="<%= request.getContextPath() %>/admin/employers" method="post" style="display:inline;margin-left:4px;"
                                  onsubmit="return confirm('Delete this user?');">
                                <input type="hidden" name="userId" value="<%= u.getId() %>"/>
                                <input type="hidden" name="action" value="delete"/>
                                <button type="submit" class="delete-btn">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6">No employers found.</td>
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
