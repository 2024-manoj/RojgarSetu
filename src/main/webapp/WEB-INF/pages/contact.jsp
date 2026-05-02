<%--
  Created by IntelliJ IDEA.
  User: katwa
  Date: 5/2/2026
  Time: 10:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Contact Us — RojgarSetu</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/contact.css">
</head>
<body>

<%@ include file="/WEB-INF/components/Navbar.jsp" %>

<!-- Contact Section -->
<section class="contact-section">
  <div class="contact-container">

    <!-- Header -->
    <div class="contact-header">
      <h1 class="contact-title">Contact Us</h1>
      <div class="contact-divider"></div>
      <p class="contact-subtitle">We'd love to hear from you. Send us a message and we'll respond as soon as possible.</p>
    </div>

    <div class="contact-wrapper">
      <!-- Contact Form -->
      <div class="contact-form-container">
        <form action="${pageContext.request.contextPath}/ContactServlet" method="post" class="contact-form">

          <div class="form-row">
            <div class="form-group">
              <label for="name" class="form-label">
                <i class="fas fa-user"></i> Name
              </label>
              <input type="text" id="name" name="name" class="form-input" placeholder="Your Name" required>
            </div>

            <div class="form-group">
              <label for="email" class="form-label">
                <i class="fas fa-envelope"></i> Email
              </label>
              <input type="email" id="email" name="email" class="form-input" placeholder="Your Email" required>
            </div>
          </div>

          <div class="form-group">
            <label for="subject" class="form-label">
              <i class="fas fa-tag"></i> Subject
            </label>
            <input type="text" id="subject" name="subject" class="form-input" placeholder="Subject of your message" required>
          </div>

          <div class="form-group">
            <label for="message" class="form-label">
              <i class="fas fa-comment"></i> Message
            </label>
            <textarea id="message" name="message" class="form-textarea" placeholder="Your Message" rows="5" required></textarea>
          </div>

          <!-- Success/Error Messages -->
          <% String success = (String) request.getAttribute("success"); %>
          <% if (success != null) { %>
          <div class="alert-success">
            <i class="fas fa-circle-check"></i> <%= success %>
          </div>
          <% } %>

          <% String error = (String) request.getAttribute("error"); %>
          <% if (error != null) { %>
          <div class="alert-error">
            <i class="fas fa-circle-exclamation"></i> <%= error %>
          </div>
          <% } %>

          <button type="submit" class="btn-submit">
            <i class="fas fa-paper-plane"></i> Submit
          </button>
        </form>
      </div>

      <!-- Office Info -->
      <div class="office-info">
        <h3 class="office-title">Our Office</h3>

        <div class="info-item">
          <div class="info-icon">
            <i class="fas fa-location-dot"></i>
          </div>
          <div class="info-text">
            <h4>Address:</h4>
            <p>Koshi Province, Nepal</p>
          </div>
        </div>

        <div class="info-item">
          <div class="info-icon">
            <i class="fas fa-phone-alt"></i>
          </div>
          <div class="info-text">
            <h4>Phone:</h4>
            <p>+977-1234567890</p>
          </div>
        </div>

        <div class="info-item">
          <div class="info-icon">
            <i class="fas fa-envelope"></i>
          </div>
          <div class="info-text">
            <h4>Email:</h4>
            <p><a href="mailto:example@rojgarsetu.com">example@rojgarsetu.com</a></p>
          </div>
        </div>

        <!-- Social Links -->
        <div class="social-links">
          <h4>Follow Us</h4>
          <div class="social-icons">
            <a href="#"><i class="fab fa-facebook-f"></i></a>
            <a href="#"><i class="fab fa-twitter"></i></a>
            <a href="#"><i class="fab fa-linkedin-in"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
          </div>
        </div>
      </div>
    </div>

    <!-- Map Section (Optional) -->
    <div class="map-section">
      <iframe
              src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3533.123456789!2d87.283333!3d26.816667!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39ef6c7a7a7a7a7a%3A0x4f4f4f4f4f4f4f4f!2sBhanu%20Chowk%2C%20Dharan!5e0!3m2!1sen!2snp!4v1700000000000!5m2!1sen!2snp"
              width="100%"
              height="300"
              style="border:0; border-radius: 12px;"
              allowfullscreen=""
              loading="lazy"
              referrerpolicy="no-referrer-when-downgrade">
      </iframe>
    </div>

    <!-- Contact Footer Bar -->
    <div class="contact-footer-bar">
      <p>
        <i class="fas fa-envelope"></i> katwalmanoj67@gmail.com &nbsp;&nbsp;|&nbsp;&nbsp;
        <i class="fas fa-phone-alt"></i> +977 9804064003
      </p>
    </div>

  </div>
</section>

<%@ include file="/WEB-INF/components/Footer.jsp" %>



</body>
</html>
