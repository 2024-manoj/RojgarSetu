<%--
  Seeker shared alert/flash messages.
  Reads 'success' and 'error' from request attributes (set by SeekerServlet).
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% if (request.getAttribute("success") != null) { %>
<div class="alert alert-success">
    <i class="fa-solid fa-circle-check"></i>
    <%= request.getAttribute("success") %>
</div>
<% } %>
<% if (request.getAttribute("error") != null) { %>
<div class="alert alert-error">
    <i class="fa-solid fa-circle-exclamation"></i>
    <%= request.getAttribute("error") %>
</div>
<% } %>
