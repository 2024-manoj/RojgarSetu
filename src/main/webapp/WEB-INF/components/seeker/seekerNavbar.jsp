<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<header class="admin-header-bar">
    <div class="logo">
        <h2>Rojgar<span>Setu</span> <span style="font-weight:400;font-size:0.85rem;opacity:0.9">Seeker</span></h2>
    </div>
    <div class="header-right">
        <div class="admin-name">
            <i class="fa-solid fa-user"></i>
            <span>
                <%= request.getAttribute("seekerUser") != null
                        ? ((com.demo.models.User) request.getAttribute("seekerUser")).getFullName()
                        : "Seeker" %>
            </span>
        </div>
        <a class="logout-btn" href="<%= request.getContextPath() %>/logout">
            <i class="fa-solid fa-right-from-bracket"></i> Logout
        </a>
    </div>
</header>
