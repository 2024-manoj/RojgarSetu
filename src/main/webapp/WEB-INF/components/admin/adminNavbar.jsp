<%--
  Top bar for admin area (fixed header).
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<header class="admin-header-bar">
    <div class="logo">
        <h2>Rojgar<span>Setu</span> <span style="font-weight:400;font-size:0.85rem;opacity:0.9">Admin</span></h2>
    </div>
    <div class="header-right">
        <div class="admin-name">
            <i class="fa-solid fa-user-shield"></i>
            <span><%= session.getAttribute("adminName") != null ? session.getAttribute("adminName") : "Admin" %></span>
        </div>
        <a class="logout-btn" href="<%= request.getContextPath() %>/logout">
            <i class="fa-solid fa-right-from-bracket"></i> Logout
        </a>
    </div>
</header>
