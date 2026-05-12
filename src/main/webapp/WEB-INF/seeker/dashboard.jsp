<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.util.Locale" %>
<%
    com.demo.models.User su = (com.demo.models.User) request.getAttribute("seekerUser");
    com.demo.models.SeekerProfile sp = (com.demo.models.SeekerProfile) request.getAttribute("seekerProfile");
    Long openJobs = (Long) request.getAttribute("openJobsCount");
    Long appCount = (Long) request.getAttribute("applicationCount");
    String dobString = (String) request.getAttribute("dobString");

    // Format today's date in Java (no JS needed)
    String todayDate = new SimpleDateFormat("EEEE, MMMM d, yyyy", Locale.ENGLISH).format(new Date());

    // Seeker name for display
    String seekerDisplayName = "Seeker";
    if (su != null && su.getFullName() != null && !su.getFullName().isBlank()) {
        seekerDisplayName = su.getFullName();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Seeker Dashboard — RojgarSetu</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/global.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/admin.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/seeker.css"/>
</head>
<body>

<%-- ===== HEADER ===== --%>
<%@ include file="../components/seeker/seekerNavbar.jsp" %>

<div class="admin-container">

    <%-- ===== SIDEBAR ===== --%>
    <%@ include file="../components/seeker/seekerSidebar.jsp" %>

    <main class="admin-main">

        <%-- ===== ALERTS ===== --%>
        <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success">
            <i class="fa-solid fa-circle-check"></i>
            <%= request.getAttribute("success") %>
        </div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <i class="fa-solid fa-circle-exclamation"></i>
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <%-- ===== WELCOME BANNER ===== --%>
        <div class="seeker-welcome-banner">
            <div class="seeker-welcome-bg"></div>
            <div class="seeker-welcome-content">
                <div class="seeker-welcome-text">
                    <h2>
                        <i class="fas fa-hand-sparkles"></i>
                        Welcome back, <span><%= seekerDisplayName %></span>
                    </h2>
                    <p>Keep your profile updated to get the best job recommendations.</p>
                </div>
                <div class="seeker-welcome-date">
                    <i class="fas fa-calendar-day"></i>
                    <span><%= todayDate %></span>
                </div>
            </div>
        </div>

        <%-- ===== STATS GRID ===== --%>
        <div class="stats-grid seeker-stats">

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>Account Status</h3>
                    <div class="stat-icon teal"><i class="fas fa-shield-halved"></i></div>
                </div>
                <p class="stat-number" style="font-size:1.3rem;">
                    <%= su != null && su.getStatus() != null ? su.getStatus() : "—" %>
                </p>
                <span class="stat-sub"><i class="fas fa-info-circle"></i> Your current account status</span>
            </div>

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>Open Approved Jobs</h3>
                    <div class="stat-icon orange"><i class="fas fa-briefcase"></i></div>
                </div>
                <p class="stat-number"><%= openJobs != null ? openJobs : 0 %></p>
                <span class="stat-sub"><i class="fas fa-arrow-trend-up"></i> Available for applications</span>
            </div>

            <div class="stat-card">
                <div class="stat-card-top">
                    <h3>My Applications</h3>
                    <div class="stat-icon green"><i class="fas fa-paper-plane"></i></div>
                </div>
                <p class="stat-number"><%= appCount != null ? appCount : 0 %></p>
                <span class="stat-sub"><i class="fas fa-check-circle"></i> Jobs you applied to</span>
            </div>

        </div>

        <%-- ===== TIP CARD ===== --%>
        <div class="seeker-tip-card">
            <div class="seeker-tip-icon">
                <i class="fas fa-lightbulb"></i>
            </div>
            <div class="seeker-tip-content">
                <h4>Quick Tip</h4>
                <p>
                    Complete your profile to stand out to employers.
                    Add your skills, education, and upload your resume.
                    Use <a href="<%= request.getContextPath() %>/seeker?page=browse">Browse Jobs</a> to find the best opportunities.
                </p>
            </div>
        </div>

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

    </main>

</div>

<%-- ===== FOOTER ===== --%>
<%@ include file="../components/seeker/seekerFooter.jsp" %>

</body>
</html>
