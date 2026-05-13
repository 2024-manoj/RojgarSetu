<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setAttribute("pageTitle", "Saved Jobs");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="../components/seeker/seekerHead.jsp" %>
</head>
<body>

<%@ include file="../components/seeker/seekerLayout.jsp" %>

        <%-- Page Header --%>
        <div class="page-header">
            <h2><i class="fa-solid fa-bookmark"></i> Saved Jobs</h2>
        </div>

        <%-- Empty state --%>
        <div class="section-card">
            <h3 class="section-title">
                <i class="fa-solid fa-heart"></i> Your Saved Jobs
            </h3>
            <div class="table-wrapper">
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>Job Title</th>
                        <th>Company</th>
                        <th>Location</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td colspan="4">
                            No saved jobs yet. Browse jobs and save the ones you like!
                            <br/>
                            <a href="<%= request.getContextPath() %>/seeker?page=browse"
                               style="color:#0f766e;font-weight:600;text-decoration:none;">
                                Browse Jobs →
                            </a>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <%-- Info tip --%>
        <div class="seeker-tip-card">
            <div class="seeker-tip-icon">
                <i class="fas fa-info-circle"></i>
            </div>
            <div class="seeker-tip-content">
                <h4>Coming Soon</h4>
                <p>The save jobs feature is coming soon. You'll be able to bookmark jobs and apply later.</p>
            </div>
        </div>

<%@ include file="../components/seeker/seekerLayoutEnd.jsp" %>

</body>
</html>
