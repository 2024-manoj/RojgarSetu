<%--
  Employer shared page layout wrapper — opens the admin-container + sidebar structure.
  Use employerLayoutEnd.jsp to close it.
  
  Usage in page JSP:
    <%@ include file="../components/employer/employerLayout.jsp" %>
       ... page content here (inside <main class="admin-main">) ...
    <%@ include file="../components/employer/employerLayoutEnd.jsp" %>
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="employerNavbar.jsp" %>

<div class="admin-container">
    <%@ include file="employerSidebar.jsp" %>
    <main class="admin-main">
        <%@ include file="employerAlerts.jsp" %>
