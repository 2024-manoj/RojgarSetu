<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    com.demo.models.User adminUser = (com.demo.models.User) request.getAttribute("adminUser");
    String dobString = (String) request.getAttribute("dobString");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Admin Profile — RojgarSetu</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
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
            <h2><i class="fas fa-user-cog"></i> Admin Profile</h2>
        </div>

        <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %>
        </div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <% if (adminUser == null) { %>
        <div class="profile-card">
            <p>Profile could not be loaded.</p>
        </div>
        <% } else { %>

        <!-- ===== PROFILE HERO BANNER ===== -->
        <div class="profile-hero">
            <div class="profile-hero-bg"></div>
            <div class="profile-hero-content">
                <div class="profile-avatar-lg">
                    <i class="fas fa-user-shield"></i>
                </div>
                <div class="profile-hero-info">
                    <h2><%= adminUser.getFullName() != null ? adminUser.getFullName() : "Admin" %></h2>
                    <span class="profile-role-badge"><i class="fas fa-shield-halved"></i> Administrator</span>
                    <p class="profile-email-text"><i class="fas fa-envelope"></i> <%= adminUser.getEmail() != null ? adminUser.getEmail() : "" %></p>
                </div>
                <div class="profile-hero-actions">
                    <button class="btn-edit-profile" onclick="toggleEdit()">
                        <i class="fas fa-pen-to-square"></i> Edit Profile
                    </button>
                </div>
            </div>
        </div>

        <!-- ===== TWO COLUMN LAYOUT ===== -->
        <div class="profile-grid">

            <!-- LEFT: Personal Info -->
            <div class="profile-card" id="profileView">
                <div class="profile-card-header">
                    <div class="profile-card-icon blue">
                        <i class="fas fa-id-card"></i>
                    </div>
                    <h3>Personal Information</h3>
                </div>

                <div class="profile-info-grid">
                    <div class="profile-info-item">
                        <div class="profile-info-icon"><i class="fas fa-user"></i></div>
                        <div>
                            <span class="profile-info-label">Full Name</span>
                            <span class="profile-info-value"><%= adminUser.getFullName() != null ? adminUser.getFullName() : "Not set" %></span>
                        </div>
                    </div>

                    <div class="profile-info-item">
                        <div class="profile-info-icon"><i class="fas fa-envelope"></i></div>
                        <div>
                            <span class="profile-info-label">Email Address</span>
                            <span class="profile-info-value"><%= adminUser.getEmail() != null ? adminUser.getEmail() : "Not set" %></span>
                        </div>
                    </div>

                    <div class="profile-info-item">
                        <div class="profile-info-icon"><i class="fas fa-phone"></i></div>
                        <div>
                            <span class="profile-info-label">Phone Number</span>
                            <span class="profile-info-value"><%= adminUser.getPhone() != null ? adminUser.getPhone() : "Not set" %></span>
                        </div>
                    </div>

                    <div class="profile-info-item">
                        <div class="profile-info-icon"><i class="fas fa-map-marker-alt"></i></div>
                        <div>
                            <span class="profile-info-label">Location</span>
                            <span class="profile-info-value"><%= adminUser.getLocation() != null ? adminUser.getLocation() : "Not set" %></span>
                        </div>
                    </div>

                    <div class="profile-info-item">
                        <div class="profile-info-icon"><i class="fas fa-cake-candles"></i></div>
                        <div>
                            <span class="profile-info-label">Date of Birth</span>
                            <span class="profile-info-value"><%= dobString != null ? dobString : "Not set" %></span>
                        </div>
                    </div>

                    <div class="profile-info-item">
                        <div class="profile-info-icon"><i class="fas fa-calendar-check"></i></div>
                        <div>
                            <span class="profile-info-label">Member Since</span>
                            <span class="profile-info-value"><%= adminUser.getCreatedAt() != null ? adminUser.getCreatedAt() : "Not set" %></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- LEFT: Edit Form (hidden by default) -->
            <div class="profile-card" id="editForm" style="display:none;">
                <div class="profile-card-header">
                    <div class="profile-card-icon orange">
                        <i class="fas fa-pen-to-square"></i>
                    </div>
                    <h3>Edit Profile</h3>
                </div>

                <form action="<%= request.getContextPath() %>/admin/profile" method="post" class="profile-edit-form">
                    <div class="form-row">
                        <div class="form-group">
                            <label><i class="fas fa-user"></i> Full Name</label>
                            <input type="text" name="fullName" value="<%= adminUser.getFullName() != null ? adminUser.getFullName() : "" %>" required placeholder="Enter full name">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-phone"></i> Phone</label>
                            <input type="text" name="phone" value="<%= adminUser.getPhone() != null ? adminUser.getPhone() : "" %>" placeholder="Enter phone number">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label><i class="fas fa-map-marker-alt"></i> Location</label>
                            <input type="text" name="location" value="<%= adminUser.getLocation() != null ? adminUser.getLocation() : "" %>" placeholder="Enter location">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-cake-candles"></i> Date of Birth</label>
                            <input type="date" name="dob" value="<%= dobString != null ? dobString : "" %>">
                        </div>
                    </div>
                    <div class="form-btn-group">
                        <button type="submit" class="btn-save"><i class="fas fa-save"></i> Save Changes</button>
                        <button type="button" class="btn-cancel" onclick="toggleEdit()"><i class="fas fa-xmark"></i> Cancel</button>
                    </div>
                </form>
            </div>

            <!-- RIGHT: Change Password -->
            <div class="profile-card">
                <div class="profile-card-header">
                    <div class="profile-card-icon green">
                        <i class="fas fa-shield-halved"></i>
                    </div>
                    <h3>Security Settings</h3>
                </div>

                <p class="profile-card-desc">
                    Update your password regularly to keep your account secure.
                </p>

                <form action="<%= request.getContextPath() %>/admin/change-password" method="post" class="profile-edit-form">
                    <div class="form-group">
                        <label><i class="fas fa-lock"></i> Current Password</label>
                        <div class="input-icon-wrap">
                            <input type="password" name="currentPassword" placeholder="Enter current password" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-key"></i> New Password</label>
                        <div class="input-icon-wrap">
                            <input type="password" name="newPassword" placeholder="Enter new password" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-key"></i> Confirm Password</label>
                        <div class="input-icon-wrap">
                            <input type="password" name="confirmPassword" placeholder="Confirm new password" required>
                        </div>
                    </div>
                    <button type="submit" class="btn-save"><i class="fas fa-shield-halved"></i> Update Password</button>
                </form>
            </div>

        </div>

        <% } %>

    </main>
</div>
<%@include file="../components/admin/adminFooter.jsp"%>

<script>
    function toggleEdit() {
        const editForm = document.getElementById('editForm');
        const profileView = document.getElementById('profileView');

        if (editForm.style.display === 'none' || editForm.style.display === '') {
            editForm.style.display = 'block';
            editForm.style.animation = 'fadeIn 0.3s ease';
            profileView.style.display = 'none';
        } else {
            editForm.style.display = 'none';
            profileView.style.display = 'block';
            profileView.style.animation = 'fadeIn 0.3s ease';
        }
    }
</script>

</body>
</html>