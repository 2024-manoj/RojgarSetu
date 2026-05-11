<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String uri = request.getRequestURI();
%>
<aside class="admin-sidebar">
    <ul class="sidebar-menu">
        <li>
            <a href="<%= request.getContextPath() %>/seeker" class="<%= uri.endsWith("/seeker") ? "active" : "" %>">
                <i class="fa-solid fa-gauge"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/home">
                <i class="fa-solid fa-briefcase"></i>
                <span>Browse jobs</span>
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
