<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    com.demo.models.User su = (com.demo.models.User) request.getAttribute("seekerUser");
    com.demo.models.SeekerProfile sp = (com.demo.models.SeekerProfile) request.getAttribute("seekerProfile");
    String dobString = (String) request.getAttribute("dobString");

    String seekerDisplayName = "Seeker";
    if (su != null && su.getFullName() != null && !su.getFullName().isBlank()) {
        seekerDisplayName = su.getFullName();
    }

    request.setAttribute("pageTitle", "Edit Profile");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="../components/seeker/seekerHead.jsp" %>
</head>
<body>

<%@ include file="../components/seeker/seekerLayout.jsp" %>

        <%-- ===== PROFILE HERO ===== --%>
        <div class="seeker-profile-hero">
            <div class="seeker-hero-bg"></div>
            <div class="seeker-hero-content">
                <div class="seeker-avatar">
                    <i class="fa-solid fa-user"></i>
                </div>
                <div class="seeker-hero-info">
                    <div class="seeker-role-badge">
                        <i class="fa-solid fa-magnifying-glass"></i> Job Seeker
                    </div>
                    <h2><%= seekerDisplayName %></h2>
                    <p class="seeker-email-text">
                        <i class="fa-solid fa-envelope"></i>
                        <%= su != null && su.getEmail() != null ? su.getEmail() : "" %>
                    </p>
                </div>
            </div>
        </div>

        <%-- ===== EDIT PROFILE FORM ===== --%>
        <div class="seeker-form-card">

            <div class="seeker-form-header">
                <div class="seeker-form-header-icon">
                    <i class="fa-solid fa-user-pen"></i>
                </div>
                <div>
                    <h3>Edit Profile</h3>
                    <p>Keep only the details employers need to review you</p>
                </div>
            </div>

            <% if (su == null) { %>
            <div class="seeker-form-body">
                <p style="color:#9ca3af;">We could not load your account. Please try again.</p>
            </div>
            <% } else { %>
            <div class="seeker-form-body">
                <form action="<%= request.getContextPath() %>/seeker" method="post" enctype="multipart/form-data">

                    <%-- Email (read-only) --%>
                    <div class="seeker-email-readonly">
                        <i class="fa-solid fa-envelope"></i>
                        <span><strong>Email:</strong> <%= su.getEmail() != null ? su.getEmail() : "" %></span>
                    </div>

                    <%-- Two-column grid --%>
                    <div class="seeker-form-grid">

                        <div class="form-group">
                            <label for="fullName">
                                <i class="fa-solid fa-user"></i> Full Name
                            </label>
                            <input id="fullName" name="fullName" type="text" required
                                   value="<%= su.getFullName() != null ? su.getFullName() : "" %>"/>
                        </div>

                        <div class="form-group">
                            <label for="phone">
                                <i class="fa-solid fa-phone"></i> Phone
                            </label>
                            <input id="phone" name="phone" type="text"
                                   placeholder="Your phone number"
                                   value="<%= su.getPhone() != null ? su.getPhone() : "" %>"/>
                        </div>

                        <div class="form-group">
                            <label for="location">
                                <i class="fa-solid fa-location-dot"></i> Location
                            </label>
                            <input id="location" name="location" type="text"
                                   placeholder="e.g. Kathmandu"
                                   value="<%= su.getLocation() != null ? su.getLocation() : "" %>"/>
                        </div>

                        <div class="form-group">
                            <label for="education">
                                <i class="fa-solid fa-graduation-cap"></i> Education
                            </label>
                            <input id="education" name="education" type="text"
                                   placeholder="e.g. BSc CSIT"
                                   value="<%= sp != null && sp.getEducation() != null ? sp.getEducation() : "" %>"/>
                        </div>

                        <div class="form-group">
                            <label for="experienceYear">
                                <i class="fa-solid fa-chart-line"></i> Experience (years)
                            </label>
                            <input id="experienceYear" name="experienceYear" type="number" min="0" step="1"
                                   value="<%= sp != null ? sp.getExperienceYear() : 0 %>"/>
                        </div>

                        <div class="form-group full-width">
                            <label for="skills">
                                <i class="fa-solid fa-code"></i> Skills
                            </label>
                            <input id="skills" name="skills" type="text"
                                   placeholder="e.g. Java, HTML, CSS, JavaScript"
                                   value="<%= sp != null && sp.getSkills() != null ? sp.getSkills() : "" %>"/>
                        </div>

                        <div class="form-group full-width">
                            <label for="resumeFile">
                                <i class="fa-solid fa-file-pdf"></i> Upload Resume (PDF)
                            </label>
                            <input id="resumeFile" name="resumeFile" type="file" accept="application/pdf,.pdf"/>
                            <% if (sp != null && sp.getResumePath() != null && !sp.getResumePath().isBlank()) { %>
                                <div class="seeker-upload-note resume-file-info">
                                    <i class="fa-solid fa-file-pdf" style="color:#ef4444;"></i>
                                    Current resume saved.
                                    <div class="resume-actions" style="margin-top:6px;">
                                        <a class="resume-view-btn" href="<%= request.getContextPath() %>/resume?file=<%= sp.getResumePath() %>" target="_blank">
                                            <i class="fa-solid fa-eye"></i> View PDF
                                        </a>
                                        <a class="resume-download-btn" href="<%= request.getContextPath() %>/resume?file=<%= sp.getResumePath() %>&download=true">
                                            <i class="fa-solid fa-download"></i> Download
                                        </a>
                                    </div>
                                </div>
                            <% } else { %>
                                <p class="seeker-upload-note">Choose a PDF from your computer. Maximum size: 5 MB.</p>
                            <% } %>
                        </div>

                    </div>

                    <%-- Buttons --%>
                    <div class="seeker-form-actions">
                        <button type="submit" class="seeker-save-btn">
                            <i class="fa-solid fa-floppy-disk"></i> Save Profile
                        </button>
                        <button type="reset" class="seeker-reset-btn">
                            <i class="fa-solid fa-rotate-left"></i> Reset
                        </button>
                    </div>

                </form>
            </div>
            <% } %>

        </div>

<%@ include file="../components/seeker/seekerLayoutEnd.jsp" %>

</body>
</html>
