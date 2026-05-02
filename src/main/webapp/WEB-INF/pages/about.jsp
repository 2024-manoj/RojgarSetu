<%--
  Created by IntelliJ IDEA.
  User: katwa
  Date: 5/1/2026
  Time: 10:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>About — RojgarSetu</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/global.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/static/about.css">
</head>
<body>

<%@ include file="/WEB-INF/components/Navbar.jsp" %>

<!-- About Section -->
<section class="about-section">
    <div class="about-container">

        <!-- Header -->
        <div class="about-header">
            <h1 class="about-title">About <span class="about-highlight">RojgarSetu</span></h1>
            <div class="about-divider"></div>
        </div>

        <!-- Main Description -->
        <div class="about-content">
            <p class="about-description">
                RojgarSetu is a dedicated local job portal system for Koshi Province, Nepal, connecting job seekers with employers.
                Our mission is to bridge the gap between talent and opportunity, fostering economic growth and reducing unemployment
                in the region. We strive to provide a user-friendly platform that simplifies the job search and hiring process for everyone.
            </p>
            <p class="about-description">
                Our platform caters to three distinct user roles: <strong>Job Seekers</strong> looking for their next career move,
                <strong>Employers</strong> seeking qualified candidates, and <strong>Administrators</strong> managing the system to ensure
                smooth operations. We believe in transparency, efficiency, and creating a positive impact on the local community.
            </p>
        </div>

        <!-- Mission & Vision -->
        <div class="mission-vision">
            <div class="mission-card">
                <div class="card-icon">
                    <i class="fas fa-bullseye"></i>
                </div>
                <h3>Our Mission</h3>
                <p>To empower individuals in Koshi Province by providing accessible job opportunities and to support local businesses in finding the right talent, thereby contributing to the region's prosperity.</p>
            </div>
            <div class="vision-card">
                <div class="card-icon">
                    <i class="fas fa-eye"></i>
                </div>
                <h3>Our Vision</h3>
                <p>To be the leading and most trusted job portal in Koshi Province, recognized for our commitment to connecting communities with sustainable employment and fostering a vibrant local economy.</p>
            </div>
        </div>

        <!-- Meet Our Team - 5 Members with Images -->
        <div class="team-section">
            <h2 class="section-title">Meet Our Team</h2>
            <div class="team-grid">

                <!-- Team Member 1 -->
                <div class="team-card">
                    <div class="team-image">
                        <img src="${pageContext.request.contextPath}/assets/team/img.png" alt="Aayush Chaudhari" onerror="this.src='https://ui-avatars.com/api/?name=Jane+Doe&background=1A3C6E&color=fff&size=120'">
                    </div>
                    <h4>Aayush Chaudhari</h4>
                    <p class="team-role">Founder & CEO</p>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-github"></i></a>
                    </div>
                </div>

                <!-- Team Member 2 -->
                <div class="team-card">
                    <div class="team-image">
                        <img src="${pageContext.request.contextPath}/assets/team/img.png" alt="Manoj Katuwal" onerror="this.src='https://ui-avatars.com/api/?name=John+Smith&background=1A3C6E&color=fff&size=120'">
                    </div>
                    <h4>Manoj Katuwal</h4>
                    <p class="team-role">Head of Operations</p>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-github"></i></a>
                    </div>
                </div>

                <!-- Team Member 3 -->
                <div class="team-card">
                    <div class="team-image">
                        <img src="${pageContext.request.contextPath}/assets/team/img.png" alt="Kristina Gurung" >
                    </div>
                    <h4>Kristina Gurung </h4>
                    <p class="team-role">Lead Developer</p>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-github"></i></a>
                    </div>
                </div>

                <!-- Team Member 4 -->
                <div class="team-card">
                    <div class="team-image">
                        <img src="${pageContext.request.contextPath}/assets/team/img.png" alt="Khusi Limbu" onerror="this.src='https://ui-avatars.com/api/?name=Michael+Brown&background=1A3C6E&color=fff&size=120'">
                    </div>
                    <h4>Khusi Limbu</h4>
                    <p class="team-role">HR Specialist</p>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-github"></i></a>
                    </div>
                </div>

                <!-- Team Member 5 -->
                <div class="team-card">
                    <div class="team-image">
                        <img src="${pageContext.request.contextPath}/assets/team/img.png" alt="Biman Limbu" onerror="this.src='https://ui-avatars.com/api/?name=Sarah+Lee&background=1A3C6E&color=fff&size=120'">
                    </div>
                    <h4>Biman Limbu</h4>
                    <p class="team-role">Customer Success Lead</p>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-github"></i></a>
                    </div>
                </div>

            </div>
        </div>

        <!-- Impact Stats -->
        <div class="impact-section">
            <h2 class="section-title">Our Impact in Numbers</h2>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-number">5000+</div>
                    <div class="stat-label">Total Jobs</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">750+</div>
                    <div class="stat-label">Total Employers</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">15000+</div>
                    <div class="stat-label">Total Job Seekers</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">2000+</div>
                    <div class="stat-label">Jobs Filled</div>
                </div>
            </div>
        </div>

        <!-- Contact Info -->
        <div class="contact-info">
            <p>
                <i class="fas fa-envelope"></i>
                <a href="https://github.com/2024-manoj">katwalmanoj67@gmail.com</a>
            </p>
            <p>
                <i class="fas fa-phone-alt"></i>
                <span>+977-9804064003</span>
            </p>
        </div>

    </div>
</section>

<%@ include file="/WEB-INF/components/Footer.jsp" %>

</body>
</html>