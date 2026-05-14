<%--
  Employer top bar (fixed header) — Navy Blue + Gold theme.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String employerHeaderName = "Employer";
    com.demo.models.User navUser = (com.demo.models.User) session.getAttribute("user");
    if (navUser != null && navUser.getFullName() != null) {
        employerHeaderName = navUser.getFullName();
    }

    // Try to get company name
    String companyDisplay = "";
    com.demo.models.EmployerProfile navProfile = null;
    try {
        java.sql.Connection navConn = com.demo.utils.DBConnection.getConnection();
        com.demo.dao.EmployerDao navDao = new com.demo.dao.EmployerDao(navConn);
        navProfile = navDao.getEmployerProfile(navUser != null ? navUser.getId() : 0);
        if (navProfile != null && navProfile.getCompanyName() != null && !navProfile.getCompanyName().isBlank()) {
            companyDisplay = navProfile.getCompanyName();
        }
        navConn.close();
    } catch (Exception ignored) {}
%>
<header class="employer-header-bar">

    <div class="logo">
        <h2>Rojgar<span>Setu</span></h2>
    </div>

    <div class="header-right">

        <!-- Company badge -->
        <% if (!companyDisplay.isEmpty()) { %>
        <div class="employer-company-badge">
            <i class="fa-solid fa-building"></i>
            <span><%= companyDisplay %></span>
        </div>
        <% } %>

        <!-- User badge -->
        <div class="employer-name">
            <i class="fa-solid fa-user-tie"></i>
            <span><%= employerHeaderName %></span>
        </div>

        <!-- Logout -->
        <a class="logout-btn" href="javascript:void(0)" onclick="openLogoutModal()">
            <i class="fa-solid fa-right-from-bracket"></i>
            <span>Logout</span>
        </a>

    </div>

</header>
