<%--
  Seeker top bar (fixed header) — teal / emerald theme.
  No JavaScript — pure HTML.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String seekerHeaderName = "Guest User";
    com.demo.models.User navUser = (com.demo.models.User) session.getAttribute("user");
    if (navUser != null && navUser.getFullName() != null) {
        seekerHeaderName = navUser.getFullName();
    }
%>
<header class="seeker-header-bar">

    <div class="logo">
        <h2>Rojgar<span>Setu</span></h2>
    </div>

    <div class="header-right">

        <!-- Quick action links (no JS) -->
        <div class="header-actions">
            <a href="<%= request.getContextPath() %>/seeker?page=browse"
               class="header-icon-btn" title="Browse Jobs">
                <i class="fa-solid fa-magnifying-glass"></i>
            </a>
        </div>

        <!-- User badge -->
        <div class="seeker-name">
            <i class="fa-solid fa-user-circle"></i>
            <span><%= seekerHeaderName %></span>
        </div>

        <!-- Logout -->
        <a class="logout-btn" href="javascript:void(0)" onclick="openLogoutModal()">
            <i class="fa-solid fa-right-from-bracket"></i>
            <span>Logout</span>
        </a>

    </div>

</header>
