<%--
  Created by IntelliJ IDEA.
  User: katwa
  Date: 5/11/2026
  Time: 10:02 AM
  To change this template use File | Settings | File Templates.
--%>

<%
    String uri = request.getRequestURI();
%>
<aside class="admin-sidebar">

    <ul class="sidebar-menu">

        <li>
            <a href="<%=request.getContextPath()%>/admin/dashboard" class="<%= uri.endsWith("/admin/dashboard") ? "active" : "" %>">
                <i class="fa-solid fa-gauge"></i>
                <span>Dashboard</span>
            </a>
        </li>

        <li>
            <a href="<%=request.getContextPath()%>/admin/seekers" class="<%= uri.endsWith("/admin/seekers") ? "active" : "" %>">
                <i class="fa-solid fa-user-group"></i>
                <span>Seekers</span>
            </a>
        </li>

        <li>
            <a href="<%=request.getContextPath()%>/admin/employers" class="<%= uri.endsWith("/admin/employers") ? "active" : "" %>">
                <i class="fa-solid fa-building"></i>
                <span>Employers</span>
            </a>
        </li>

        <li>
            <a href="<%=request.getContextPath()%>/admin/jobs" class="<%= uri.endsWith("/admin/jobs") ? "active" : "" %>">
                <i class="fa-solid fa-briefcase"></i>
                <span>Jobs</span>
            </a>
        </li>

        <li>
            <a href="<%=request.getContextPath()%>/admin/reports" class="<%= uri.endsWith("/admin/reports") ? "active" : "" %>">
                <i class="fa-solid fa-chart-column"></i>
                <span>Reports</span>
            </a>
        </li>

        <li>
            <a href="<%=request.getContextPath()%>/admin/profile" class="<%= uri.endsWith("/admin/profile") ? "active" : "" %>">
                <i class="fa-solid fa-id-card"></i>
                <span>Profile</span>
            </a>
        </li>

    </ul>

</aside>