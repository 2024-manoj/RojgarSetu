<nav>
    <a href="${pageContext.request.contextPath}/" class="nav-brand">RojgarSetu</a>

    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/" class="active">
            <i class="fas fa-house"></i> Home
        </a></li>
        <li><a href="${pageContext.request.contextPath}/jobs">
            <i class="fas fa-briefcase"></i> Jobs
        </a></li>
        <li><a href="${pageContext.request.contextPath}/about">
            <i class="fas fa-circle-info"></i> About
        </a></li>
        <li><a href="${pageContext.request.contextPath}/contact">
            <i class="fas fa-envelope"></i> Contact
        </a></li>
    </ul>

    <div class="nav-auth">
        <div class="nav-divider"></div>
        <a href="${pageContext.request.contextPath}/login" class="btn-login">
            <i class="fas fa-right-to-bracket"></i> Login
        </a>
        <a href="${pageContext.request.contextPath}/register" class="btn-register">
            <i class="fas fa-user-plus"></i> Register
        </a>
    </div>
</nav>