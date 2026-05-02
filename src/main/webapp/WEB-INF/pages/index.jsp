<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: katwa
  Date: 5/1/2026
  Time: 7:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home Page</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/global.css">
</head>
<body >
<%@ include file="/WEB-INF/components/Navbar.jsp"%>
<!-- Hero Section -->


<section class="hero">
    <div class="hero-content">
        <h1 class="hero-title">
            Find Your Dream Job in <span class="hero-highlight">Koshi Province</span>
        </h1>
        <p class="hero-subtitle">
            Connecting local talent with the best employers across Nepal. Simple, professional, and effective.
        </p>

        <!-- Search Bar -->
        <div class="hero-search">
            <div class="search-input-wrapper">
                <i class="fas fa-magnifying-glass search-icon"></i>
                <input type="text" class="search-input" placeholder="Search job title or keyword" />
            </div>

            <div class="search-select-wrapper">
                <i class="fas fa-location-dot select-icon"></i>
                <select class="search-select">
                    <option value="">All Districts</option>
                    <option value="sunsari">Sunsari</option>
                    <option value="morang">Morang</option>
                    <option value="jhapa">Jhapa</option>
                    <option value="ilam">Ilam</option>
                    <option value="taplejung">Taplejung</option>
                    <option value="panchthar">Panchthar</option>
                    <option value="terhathum">Terhathum</option>
                    <option value="dhankuta">Dhankuta</option>
                    <option value="bhojpur">Bhojpur</option>
                    <option value="solukhumbu">Solukhumbu</option>
                    <option value="okhaldhunga">Okhaldhunga</option>
                    <option value="khotang">Khotang</option>
                    <option value="udayapur">Udayapur</option>
                    <option value="saptari">Saptari</option>
                </select>
            </div>

            <button class="search-btn">
                <i class="fas fa-search"></i> Search Jobs
            </button>
        </div>

        <!-- Quick Stats -->
        <div class="hero-stats">
            <div class="stat-item">
                <i class="fas fa-briefcase"></i>
                <span><strong>500+</strong> Active Jobs</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
                <i class="fas fa-building"></i>
                <span><strong>120+</strong> Companies</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
                <i class="fas fa-users"></i>
                <span><strong>3000+</strong> Job Seekers</span>
            </div>
        </div>
    </div>
</section>

<section class="how-it-works">
    <div class="hiw-container">

        <div class="hiw-header">
            <h2 class="hiw-title">Bridging the Gap: <span class="hiw-title-bold">How It Works</span></h2>
            <p class="hiw-subtitle">Simple steps to connect job seekers with the best employers across Koshi Province.</p>
        </div>

        <div class="hiw-columns">

            <!-- Job Seekers Column -->
            <div class="hiw-column">
                <div class="hiw-col-header seeker">
                    <i class="fas fa-person-walking"></i>
                    <h3>For Job Seekers</h3>
                </div>

                <div class="hiw-step">
                    <div class="step-number seeker-num">1</div>
                    <div class="step-body">
                        <h4>Create Your Profile</h4>
                        <p>Build a professional digital resume that showcases your local skills and experience.</p>
                    </div>
                </div>

                <div class="hiw-step">
                    <div class="step-number seeker-num">2</div>
                    <div class="step-body">
                        <h4>Find Local Matches</h4>
                        <p>Browse thousands of jobs filtered by your city in Koshi Province and your industry.</p>
                    </div>
                </div>

                <div class="hiw-step">
                    <div class="step-number seeker-num">3</div>
                    <div class="step-body">
                        <h4>Apply with Ease</h4>
                        <p>Submit your application instantly and track your status from your dashboard.</p>
                    </div>
                </div>
            </div>

            <!-- Divider -->
            <div class="hiw-col-divider"></div>

            <!-- Employers Column -->
            <div class="hiw-column">
                <div class="hiw-col-header employer">
                    <i class="fas fa-building"></i>
                    <h3>For Employers</h3>
                </div>

                <div class="hiw-step">
                    <div class="step-number employer-num">1</div>
                    <div class="step-body">
                        <h4>Post a Requirement</h4>
                        <p>List your job openings with specific local requirements and salary ranges.</p>
                    </div>
                </div>

                <div class="hiw-step">
                    <div class="step-number employer-num">2</div>
                    <div class="step-body">
                        <h4>Review Candidates</h4>
                        <p>Access our database of skilled locals and filter by experience and location.</p>
                    </div>
                </div>

                <div class="hiw-step">
                    <div class="step-number employer-num">3</div>
                    <div class="step-body">
                        <h4>Hire the Best</h4>
                        <p>Message candidates directly and manage your recruitment pipeline efficiently.</p>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

<%@ include file="/WEB-INF/components/Footer.jsp"%>

</body>
</html>