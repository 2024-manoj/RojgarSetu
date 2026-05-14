<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    com.demo.models.User eu = (com.demo.models.User) request.getAttribute("employerUser");
    com.demo.models.EmployerProfile ep = (com.demo.models.EmployerProfile) request.getAttribute("employerProfile");
    String dobString = (String) request.getAttribute("dobString");

    String employerDisplayName = "Employer";
    if (eu != null && eu.getFullName() != null && !eu.getFullName().isBlank()) {
        employerDisplayName = eu.getFullName();
    }
    request.setAttribute("pageTitle", "Edit Profile");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="../components/employer/employerHead.jsp" %>
</head>
<body>
<%@ include file="../components/employer/employerLayout.jsp" %>

        <%-- ===== PROFILE HERO ===== --%>
        <div class="employer-profile-hero">
            <div class="employer-hero-bg"></div>
            <div class="employer-hero-content">
                <div class="employer-avatar">
                    <i class="fa-solid fa-building"></i>
                </div>
                <div class="employer-hero-info">
                    <div class="employer-role-badge"><i class="fa-solid fa-briefcase"></i> Employer</div>
                    <h2><%= employerDisplayName %></h2>
                    <p class="employer-email-text">
                        <i class="fa-solid fa-envelope"></i>
                        <%= eu != null && eu.getEmail() != null ? eu.getEmail() : "" %>
                    </p>
                </div>
            </div>
        </div>

        <% if (eu == null) { %>
        <div class="employer-form-card">
            <div class="employer-form-body">
                <p style="color:#9ca3af;">We could not load your account. Please try again.</p>
            </div>
        </div>
        <% } else { %>

        <%-- ===== PERSONAL INFO ===== --%>
        <div class="employer-form-card">
            <div class="employer-form-header">
                <div class="employer-form-header-icon"><i class="fa-solid fa-user"></i></div>
                <div><h3>Personal Information</h3><p>Update your personal details</p></div>
            </div>
            <div class="employer-form-body">
                <form action="<%= request.getContextPath() %>/employer" method="post">
                    <div class="employer-email-readonly">
                        <i class="fa-solid fa-envelope"></i>
                        <span><strong>Email:</strong> <%= eu.getEmail() != null ? eu.getEmail() : "" %></span>
                    </div>
                    <div class="employer-form-grid">
                        <div class="form-group">
                            <label for="fullName"><i class="fa-solid fa-user"></i> Full Name *</label>
                            <input id="fullName" name="fullName" type="text" required value="<%= eu.getFullName() != null ? eu.getFullName() : "" %>"/>
                        </div>
                        <div class="form-group">
                            <label for="phone"><i class="fa-solid fa-phone"></i> Phone</label>
                            <input id="phone" name="phone" type="text" placeholder="Your phone number" value="<%= eu.getPhone() != null ? eu.getPhone() : "" %>"/>
                        </div>
                        <div class="form-group">
                            <label for="location"><i class="fa-solid fa-location-dot"></i> Location</label>
                            <input id="location" name="location" type="text" placeholder="e.g. Kathmandu" value="<%= eu.getLocation() != null ? eu.getLocation() : "" %>"/>
                        </div>
                        <div class="form-group">
                            <label for="dob"><i class="fa-solid fa-calendar"></i> Date of Birth</label>
                            <input id="dob" name="dob" type="date" value="<%= dobString != null ? dobString : "" %>"/>
                        </div>
                    </div>

                    <%-- ===== COMPANY INFO (same form) ===== --%>
                    <div class="employer-section-divider">
                        <div class="employer-form-header-icon"><i class="fa-solid fa-building"></i></div>
                        <div><h3>Company Information</h3><p>Details about your organization</p></div>
                    </div>
                    <div class="employer-form-grid">
                        <div class="form-group">
                            <label for="companyName"><i class="fa-solid fa-building"></i> Company Name</label>
                            <input id="companyName" name="companyName" type="text" placeholder="Your company name" value="<%= ep != null && ep.getCompanyName() != null ? ep.getCompanyName() : "" %>"/>
                        </div>
                        <div class="form-group">
                            <label for="companyCategory"><i class="fa-solid fa-tags"></i> Industry / Category</label>
                            <input id="companyCategory" name="companyCategory" type="text" placeholder="e.g. IT, Finance, Education" value="<%= ep != null && ep.getCompanyCategory() != null ? ep.getCompanyCategory() : "" %>"/>
                        </div>
                        <div class="form-group">
                            <label for="companyCity"><i class="fa-solid fa-city"></i> Company City</label>
                            <input id="companyCity" name="companyCity" type="text" placeholder="e.g. Kathmandu" value="<%= ep != null && ep.getCompanyCity() != null ? ep.getCompanyCity() : "" %>"/>
                        </div>
                        <div class="form-group">
                            <label for="contactPerson"><i class="fa-solid fa-id-badge"></i> Contact Person</label>
                            <input id="contactPerson" name="contactPerson" type="text" placeholder="HR contact name" value="<%= ep != null && ep.getContactPerson() != null ? ep.getContactPerson() : "" %>"/>
                        </div>
                        <div class="form-group full-width">
                            <label for="companyAddress"><i class="fa-solid fa-map-location-dot"></i> Company Address</label>
                            <input id="companyAddress" name="companyAddress" type="text" placeholder="Full company address" value="<%= ep != null && ep.getCompanyAddress() != null ? ep.getCompanyAddress() : "" %>"/>
                        </div>
                        <div class="form-group full-width">
                            <label for="companyDescription"><i class="fa-solid fa-align-left"></i> Company Description</label>
                            <textarea id="companyDescription" name="companyDescription" rows="4" placeholder="Brief description of your company..."><%= ep != null && ep.getCompanyDescription() != null ? ep.getCompanyDescription() : "" %></textarea>
                        </div>
                    </div>

                    <div class="employer-form-actions">
                        <button type="submit" class="employer-save-btn"><i class="fa-solid fa-floppy-disk"></i> Save Profile</button>
                        <button type="reset" class="employer-reset-btn"><i class="fa-solid fa-rotate-left"></i> Reset</button>
                    </div>
                </form>
            </div>
        </div>
        <% } %>

<%@ include file="../components/employer/employerLayoutEnd.jsp" %>
</body>
</html>
