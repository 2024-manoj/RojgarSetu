<%--
  Seeker sidebar — teal / emerald theme with section labels.
  Active state uses ?page= parameter. No JavaScript.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String currentPage = request.getParameter("page");
    if (currentPage == null) currentPage = "";

    // Helper: if page param is empty we are on the dashboard
    boolean isDashboard = currentPage.isEmpty();
%>
<aside class="seeker-sidebar">

    <ul class="sidebar-menu">

        <!-- Section: Main -->
        <li class="sidebar-section-label">Main</li>

        <li>
            <a href="<%= request.getContextPath() %>/seeker"
               class="<%= isDashboard ? "active" : "" %>">
                <i class="fa-solid fa-gauge"></i>
                <span>Dashboard</span>
            </a>
        </li>

        <div class="sidebar-divider"></div>

        <!-- Section: Job Search -->
        <li class="sidebar-section-label">Job Search</li>

        <li>
            <a href="<%= request.getContextPath() %>/seeker?page=browse"
               class="<%= "browse".equals(currentPage) ? "active" : "" %>">
                <i class="fa-solid fa-magnifying-glass"></i>
                <span>Browse Jobs</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/seeker?page=applications"
               class="<%= "applications".equals(currentPage) ? "active" : "" %>">
                <i class="fa-solid fa-paper-plane"></i>
                <span>My Applications</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/seeker?page=saved"
               class="<%= "saved".equals(currentPage) ? "active" : "" %>">
                <i class="fa-solid fa-bookmark"></i>
                <span>Saved Jobs</span>
            </a>
        </li>

        <div class="sidebar-divider"></div>

        <!-- Section: Account -->
        <li class="sidebar-section-label">Account</li>

        <li>
            <a href="<%= request.getContextPath() %>/seeker"
               class="">
                <i class="fa-solid fa-user-pen"></i>
                <span>Edit Profile</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/logout">
                <i class="fa-solid fa-right-from-bracket"></i>
                <span>Logout</span>
            </a>
        </li>

    </ul>

</aside>