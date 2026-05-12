<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Saved Jobs — RojgarSetu</title>
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

    </main>
</div>

<%@ include file="../components/seeker/seekerFooter.jsp" %>

</body>
</html>
