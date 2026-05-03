<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Register — RojgarSetu</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/global.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/register.css">
</head>
<body>

<%@ include file="/WEB-INF/components/Navbar.jsp" %>

<!-- Register Section -->
<section class="auth-section">
    <div class="auth-card">

        <!-- Header -->
        <div class="auth-header">
            <div class="auth-logo-icon">
                <i class="fas fa-user-plus"></i>
            </div>
            <h1 class="auth-title">Create an Account</h1>
            <p class="auth-subtitle">Join the bridge to opportunities in Koshi Province.</p>
        </div>

        <!-- Role Selection - Radio Buttons -->
        <div class="role-radios">
            <label class="role-radio">
                <input type="radio" name="role" value="seeker" checked onchange="toggleRoleFields()">
                <span class="role-radio-custom"></span>
                <i class="fas fa-user"></i> I'm a Job Seeker
            </label>
            <label class="role-radio">
                <input type="radio" name="role" value="employer" onchange="toggleRoleFields()">
                <span class="role-radio-custom"></span>
                <i class="fas fa-building"></i> I'm an Employer
            </label>
        </div>

        <!-- Error/Success Messages -->
        <%
            String error = (String) request.getAttribute("error");
            String errorParam = request.getParameter("error");
            if (errorParam != null) {
                if ("2".equals(errorParam)) {
                    error = "An error occurred during registration. Please try again.";
                }
            }
        %>
        <% if (error != null) { %>
        <div class="auth-alert error"><i class="fas fa-circle-exclamation"></i> <%= error %></div>
        <% } %>
        <% String success = (String) request.getAttribute("success"); %>
        <% if (success != null) { %>
        <div class="auth-alert success"><i class="fas fa-circle-check"></i> <%= success %></div>
        <% } %>

        <!-- Register Form -->
        <form action="${pageContext.request.contextPath}/register" method="post" class="auth-form">

            <!-- Hidden role field for servlet -->
            <input type="hidden" name="role" id="roleField" value="seeker">

            <!-- Full Name -->
            <div class="form-group">
                <label class="form-label"><i class="fas fa-user"></i> Full Name</label>
                <input type="text" name="fullName" class="form-input" placeholder="e.g. Rajesh Kumar" required>
            </div>

            <!-- Email -->
            <div class="form-group">
                <label class="form-label"><i class="fas fa-envelope"></i> Email Address</label>
                <input type="email" name="email" class="form-input" placeholder="name@example.com" required>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label class="form-label"><i class="fas fa-lock"></i> Password</label>
                <div class="input-password-wrapper">
                    <input type="password" name="password" id="password" class="form-input" placeholder="*********" required>
                    <button type="button" class="toggle-password" onclick="togglePassword('password', 'eyeIcon')">
                        <i class="fas fa-eye" id="eyeIcon"></i>
                    </button>
                </div>
            </div>

            <!-- ===== JOB SEEKER FIELDS ===== -->
            <div id="seekerFields">
                <!-- City -->
                <div class="form-group">
                    <label class="form-label"><i class="fas fa-location-dot"></i> City (Koshi Province)</label>
                    <select name="city" class="form-input">
                        <option value="">Select City</option>
                        <option value="Biratnagar">Biratnagar</option>
                        <option value="Dharan">Dharan</option>
                        <option value="Itahari">Itahari</option>
                        <option value="Damak">Damak</option>
                        <option value="Birtamode">Birtamode</option>
                        <option value="Urlabari">Urlabari</option>
                        <option value="Rangeli">Rangeli</option>
                    </select>
                </div>

                <!-- Education -->
                <div class="form-group">
                    <label class="form-label"><i class="fas fa-graduation-cap"></i> Education</label>
                    <select name="education" class="form-input">
                        <option value="">Select Education</option>
                        <option value="Secondary (SLC/SEE)">Secondary (SLC/SEE)</option>
                        <option value="Higher Secondary (+2)">Higher Secondary (+2)</option>
                        <option value="Bachelor's Degree">Bachelor's Degree</option>
                        <option value="Master's Degree">Master's Degree</option>
                        <option value="PhD/Doctorate">PhD/Doctorate</option>
                        <option value="Diploma/Certificate">Diploma/Certificate</option>
                    </select>
                </div>


            </div>

            <!-- ===== EMPLOYER FIELDS (Hidden by default) ===== -->
            <div id="employerFields" style="display: none;">
                <div class="form-group">
                    <label class="form-label"><i class="fas fa-building"></i> Company Name</label>
                    <input type="text" name="companyName" class="form-input"
                           placeholder="e.g. Tech Solutions Pvt. Ltd.">
                </div>
                <div class="form-group">
                    <label class="form-label"><i class="fas fa-briefcase"></i> Industry Type</label>
                    <select name="industry" class="form-input">
                        <option value="">Select Industry</option>
                        <option value="Technology">Technology</option>
                        <option value="Banking & Finance">Banking & Finance</option>
                        <option value="Agriculture">Agriculture</option>
                        <option value="Education">Education</option>
                        <option value="Healthcare">Healthcare</option>
                        <option value="Manufacturing">Manufacturing</option>
                        <option value="Tourism">Tourism</option>
                    </select>
                </div>
            </div>

            <!-- Register Button -->
            <button type="submit" class="btn-submit" id="registerBtn">
                <i class="fas fa-user-plus"></i> Register
            </button>

        </form>

        <!-- Divider -->
        <div class="auth-divider"><span>or</span></div>

        <!-- Login Link -->
        <p class="auth-switch">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Login <i class="fas fa-arrow-right"></i></a>
        </p>

    </div>
</section>

<%@ include file="/WEB-INF/components/Footer.jsp"%>

<script>
    function toggleRoleFields() {
        const roleRadios = document.querySelectorAll('input[name="role"]');
        let selectedRole = "seeker";

        for (let radio of roleRadios) {
            if (radio.checked) {
                selectedRole = radio.value;
                break;
            }
        }

        const seekerFields = document.getElementById('seekerFields');
        const employerFields = document.getElementById('employerFields');
        const registerBtn = document.getElementById('registerBtn');
        const roleField = document.getElementById('roleField');

        roleField.value = selectedRole;

        if (selectedRole === 'seeker') {
            seekerFields.style.display = 'block';
            employerFields.style.display = 'none';
            registerBtn.innerHTML = '<i class="fas fa-user-plus"></i> Register as Seeker';

            // Make seeker fields required
            document.querySelectorAll('#seekerFields select, #seekerFields input').forEach(field => {
                field.required = true;
            });
            document.querySelectorAll('#employerFields select, #employerFields input').forEach(field => {
                field.required = false;
            });
        } else {
            seekerFields.style.display = 'none';
            employerFields.style.display = 'block';
            registerBtn.innerHTML = '<i class="fas fa-building"></i> Register as Employer';

            // Make employer fields required
            document.querySelectorAll('#employerFields select, #employerFields input').forEach(field => {
                field.required = true;
            });
            document.querySelectorAll('#seekerFields select, #seekerFields input').forEach(field => {
                field.required = false;
            });
        }
    }



    // Toggle password visibility
    function togglePassword(inputId, iconId) {
        const input = document.getElementById(inputId);
        const icon = document.getElementById(iconId);
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    }


</script>
</body>
</html>
