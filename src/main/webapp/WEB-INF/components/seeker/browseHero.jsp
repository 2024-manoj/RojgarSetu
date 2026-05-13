<%--
  Browse Jobs — Hero Banner component.
  Expects 'jobCount' (int) set before including.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="browse-hero">
    <div class="browse-hero-bg"></div>
    <div class="browse-hero-content">
        <div class="browse-hero-text">
            <h2><i class="fa-solid fa-compass"></i> Explore Opportunities</h2>
            <p>Discover <%= request.getAttribute("jobCount") %> approved job<%= ((int)request.getAttribute("jobCount")) != 1 ? "s" : "" %> waiting for you. Find the perfect match for your skills.</p>
        </div>
        <div class="browse-hero-stats">
            <div class="browse-stat-pill">
                <i class="fa-solid fa-briefcase"></i>
                <span><strong><%= request.getAttribute("jobCount") %></strong> Jobs</span>
            </div>
        </div>
    </div>
</div>
