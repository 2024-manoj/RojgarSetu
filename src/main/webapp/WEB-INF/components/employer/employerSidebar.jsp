<%--
  Employer sidebar — Navy Blue theme with section labels.
  Active state uses ?page= parameter. No JavaScript.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String currentPage = request.getParameter("page");
    if (currentPage == null) currentPage = "";

    boolean isDashboard = currentPage.isEmpty();
%>
<aside class="employer-sidebar">

    <ul class="sidebar-menu">

        <!-- Section: Main -->
        <li class="sidebar-section-label">Main</li>

        <li>
            <a href="<%= request.getContextPath() %>/employer"
               class="<%= isDashboard ? "active" : "" %>">
                <i class="fa-solid fa-gauge"></i>
                <span>Dashboard</span>
            </a>
        </li>

        <div class="sidebar-divider"></div>

        <!-- Section: Job Management -->
        <li class="sidebar-section-label">Jobs</li>

        <li>
            <a href="<%= request.getContextPath() %>/employer?page=postjob"
               class="<%= "postjob".equals(currentPage) ? "active" : "" %>">
                <i class="fa-solid fa-plus-circle"></i>
                <span>Post a Job</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/employer?page=myjobs"
               class="<%= "myjobs".equals(currentPage) ? "active" : "" %>">
                <i class="fa-solid fa-briefcase"></i>
                <span>My Job Posts</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/employer?page=applicants"
               class="<%= "applicants".equals(currentPage) ? "active" : "" %>">
                <i class="fa-solid fa-users"></i>
                <span>View Applicants</span>
            </a>
        </li>

        <div class="sidebar-divider"></div>

        <!-- Section: Account -->
        <li class="sidebar-section-label">Account</li>

        <li>
            <a href="<%= request.getContextPath() %>/employer?page=profile"
               class="<%= "profile".equals(currentPage) ? "active" : "" %>">
                <i class="fa-solid fa-user-pen"></i>
                <span>Profile</span>
            </a>
        </li>

        <li>
            <a href="javascript:void(0)" onclick="openLogoutModal()">
                <i class="fa-solid fa-right-from-bracket"></i>
                <span>Logout</span>
            </a>
        </li>

    </ul>

</aside>
