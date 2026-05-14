<%
  String navUri = request.getRequestURI();
  String ctx = request.getContextPath();
  String navPath = navUri != null && navUri.length() >= ctx.length() ? navUri.substring(ctx.length()) : "/";
  boolean homeActive = "/".equals(navPath) || "/home".equals(navPath);
  boolean jobsActive = "/jobs".equals(navPath);
  boolean aboutActive = "/about".equals(navPath);
  boolean contactActive = "/contact".equals(navPath);
%>
<nav>
  <a href="<%= ctx %>/" class="nav-brand">RojgarSetu</a>

  <ul class="nav-links">
    <li>
      <a href="<%= ctx %>/" class="<%= homeActive ? "active" : "" %>">
        <i class="fas fa-house"></i> Home
      </a>
    </li>
    <li>
      <a href="<%= ctx %>/jobs" class="<%= jobsActive ? "active" : "" %>">
        <i class="fas fa-briefcase"></i> Jobs
      </a>
    </li>
    <li>
      <a href="<%= ctx %>/about" class="<%= aboutActive ? "active" : "" %>">
        <i class="fas fa-circle-info"></i> About
      </a>
    </li>
    <li>
      <a href="<%= ctx %>/contact" class="<%= contactActive ? "active" : "" %>">
        <i class="fas fa-envelope"></i> Contact
      </a>
    </li>
  </ul>

  <div class="nav-auth">
    <div class="nav-divider"></div>
    <a href="<%= ctx %>/login" class="btn-login">
      <i class="fas fa-right-to-bracket"></i> Login
    </a>
    <a href="<%= ctx %>/register" class="btn-register">
      <i class="fas fa-user-plus"></i> Register
    </a>
  </div>
</nav>
