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
                    <p>Update your personal information and job preferences</p>
                </div>
            </div>

            <% if (su == null) { %>
            <div class="seeker-form-body">
                <p style="color:#9ca3af;">We could not load your account. Please try again.</p>
            </div>
            <% } else { %>
            <div class="seeker-form-body">
                <form action="<%= request.getContextPath() %>/seeker" method="post">

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
                            <label for="dob">
                                <i class="fa-solid fa-calendar"></i> Date of Birth
                            </label>
                            <input id="dob" name="dob" type="date"
                                   value="<%= dobString != null ? dobString : "" %>"/>
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

                        <div class="form-group">
                            <label for="addressCity">
                                <i class="fa-solid fa-city"></i> City (profile)
                            </label>
                            <input id="addressCity" name="addressCity" type="text"
                                   placeholder="Current city"
                                   value="<%= sp != null && sp.getAddressCity() != null ? sp.getAddressCity() : "" %>"/>
                        </div>

                        <div class="form-group">
                            <label for="resumePath">
                                <i class="fa-solid fa-file-lines"></i> Resume Path / URL
                            </label>
                            <input id="resumePath" name="resumePath" type="text"
                                   placeholder="/uploads/resume.pdf or https://..."
                                   value="<%= sp != null && sp.getResumePath() != null ? sp.getResumePath() : "" %>"/>
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
