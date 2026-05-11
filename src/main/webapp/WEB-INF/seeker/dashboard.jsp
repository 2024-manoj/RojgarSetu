<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    com.demo.models.User su = (com.demo.models.User) request.getAttribute("seekerUser");
    com.demo.models.SeekerProfile sp = (com.demo.models.SeekerProfile) request.getAttribute("seekerProfile");
    Long openJobs = (Long) request.getAttribute("openJobsCount");
    String dobString = (String) request.getAttribute("dobString");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Seeker dashboard — RojgarSetu</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/global.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/admin.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>
<body>

<%@ include file="../components/seeker/seekerNavbar.jsp" %>

<div class="admin-container">

    <%@ include file="../components/seeker/seekerSidebar.jsp" %>

    <main class="admin-main">

        <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success"><%= request.getAttribute("success") %></div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <div class="stats-grid">
            <div class="stat-card">
                <h3>Account status</h3>
                <p class="stat-number" style="font-size:1.2rem;">
                    <%= su != null && su.getStatus() != null ? su.getStatus() : "—" %>
                </p>
            </div>
            <div class="stat-card">
                <h3>Open approved jobs</h3>
                <p class="stat-number"><%= openJobs != null ? openJobs : 0 %></p>
            </div>
        </div>

        <div class="section-card">
            <h3 class="section-title">Welcome back</h3>
            <p style="color:#555;line-height:1.6;">
                Update your profile below. Use <strong>Browse jobs</strong> in the sidebar for public pages.
            </p>
        </div>

        <div class="section-card">
            <h3 class="section-title">Edit profile</h3>
            <% if (su == null) { %>
            <p>We could not load your account.</p>
            <% } else { %>
            <form action="<%= request.getContextPath() %>/seeker" method="post" class="profile-form">

                <p class="profile-email">
                    <strong>Email</strong> (read-only): <%= su.getEmail() != null ? su.getEmail() : "" %>
                </p>

                <div class="form-group">
                    <label for="fullName">Full name</label>
                    <input id="fullName" name="fullName" type="text" required
                           value="<%= su.getFullName() != null ? su.getFullName() : "" %>"/>
                </div>

                <div class="form-group">
                    <label for="phone">Phone</label>
                    <input id="phone" name="phone" type="text"
                           value="<%= su.getPhone() != null ? su.getPhone() : "" %>"/>
                </div>

                <div class="form-group">
                    <label for="location">Location</label>
                    <input id="location" name="location" type="text"
                           value="<%= su.getLocation() != null ? su.getLocation() : "" %>"/>
                </div>

                <div class="form-group">
                    <label for="dob">Date of birth</label>
                    <input id="dob" name="dob" type="date"
                           value="<%= dobString != null ? dobString : "" %>"/>
                </div>

                <div class="form-group">
                    <label for="education">Education</label>
                    <input id="education" name="education" type="text"
                           placeholder="e.g. BSc CSIT"
                           value="<%= sp != null && sp.getEducation() != null ? sp.getEducation() : "" %>"/>
                </div>

                <div class="form-group">
                    <label for="skills">Skills</label>
                    <input id="skills" name="skills" type="text"
                           placeholder="Comma-separated or short list"
                           value="<%= sp != null && sp.getSkills() != null ? sp.getSkills() : "" %>"/>
                </div>

                <div class="form-group">
                    <label for="addressCity">City (profile)</label>
                    <input id="addressCity" name="addressCity" type="text"
                           placeholder="Current city"
                           value="<%= sp != null && sp.getAddressCity() != null ? sp.getAddressCity() : "" %>"/>
                </div>

                <div class="form-group">
                    <label for="experienceYear">Experience (years)</label>
                    <input id="experienceYear" name="experienceYear" type="number" min="0" step="1"
                           value="<%= sp != null ? sp.getExperienceYear() : 0 %>"/>
                </div>

                <div class="form-group">
                    <label for="resumePath">Resume path or URL</label>
                    <input id="resumePath" name="resumePath" type="text"
                           placeholder="/uploads/resume.pdf or https://..."
                           value="<%= sp != null && sp.getResumePath() != null ? sp.getResumePath() : "" %>"/>
                </div>

                <div class="form-actions">
                    <button type="submit" class="approve-btn">Save profile</button>
                </div>
            </form>
            <% } %>
        </div>

    </main>

</div>

</body>
</html>
