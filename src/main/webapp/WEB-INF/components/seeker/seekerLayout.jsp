<%--
  Seeker shared page layout wrapper — opens the admin-container + sidebar structure.
  Use seekerLayoutEnd.jsp to close it.
  
  Usage in page JSP:
    <%@ include file="../components/seeker/seekerLayout.jsp" %>
       ... page content here (inside <main class="admin-main">) ...
    <%@ include file="../components/seeker/seekerLayoutEnd.jsp" %>
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="seekerNavbar.jsp" %>

<div class="admin-container">
    <%@ include file="seekerSidebar.jsp" %>
    <main class="admin-main">
        <%@ include file="seekerAlerts.jsp" %>
