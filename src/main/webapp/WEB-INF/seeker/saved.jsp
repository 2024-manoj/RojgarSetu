<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.text.SimpleDateFormat" %>
<%
    List<com.demo.models.Job> savedJobs =
        (List<com.demo.models.Job>) request.getAttribute("savedJobs");
    int savedCount = (savedJobs != null) ? savedJobs.size() : 0;
    SimpleDateFormat dateFmt = new SimpleDateFormat("MMM dd, yyyy");

    request.setAttribute("pageTitle", "Saved Jobs");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="../components/seeker/seekerHead.jsp" %>
</head>
<body>

<%@ include file="../components/seeker/seekerLayout.jsp" %>

        <%-- Page Hero --%>
        <div class="saved-hero">
            <div class="saved-hero-bg"></div>
            <div class="saved-hero-content">
                <div class="saved-hero-text">
                    <h2><i class="fa-solid fa-heart"></i> Saved Jobs</h2>
                    <p>Jobs you've bookmarked for later. Apply when you're ready!</p>
                </div>
                <div class="saved-hero-count">
                    <span class="saved-count-num"><%= savedCount %></span>
                    <span class="saved-count-label">Saved</span>
                </div>
            </div>
        </div>

        <%-- Saved Jobs Grid --%>
        <% if (savedJobs != null && !savedJobs.isEmpty()) { %>
        <div class="saved-cards-grid">
            <% for (com.demo.models.Job sJob : savedJobs) {
                String sTitle = sJob.getTitle() != null ? sJob.getTitle() : "—";
                String sCategory = sJob.getCategory() != null ? sJob.getCategory() : "—";
                String sLocation = sJob.getLocationCity() != null ? sJob.getLocationCity() : "—";
                String sSalary = sJob.getSalaryRange() != null ? sJob.getSalaryRange() : "—";
                String sJobType = sJob.getJobType() != null ? sJob.getJobType() : "—";
                String sDeadline = sJob.getDeadline() != null ? dateFmt.format(sJob.getDeadline()) : "—";
                String sDesc = sJob.getDescription() != null ? sJob.getDescription() : "";
                if (sDesc.length() > 100) sDesc = sDesc.substring(0, 100) + "...";

                String sTypeClass = "type-fulltime";
                if ("Part-time".equalsIgnoreCase(sJobType)) sTypeClass = "type-parttime";
                else if ("Contract".equalsIgnoreCase(sJobType)) sTypeClass = "type-contract";
                else if ("Internship".equalsIgnoreCase(sJobType)) sTypeClass = "type-internship";
            %>
            <div class="saved-job-card">
                <div class="saved-card-header">
                    <div class="saved-card-info">
                        <h3><%= sTitle %></h3>
                        <span class="saved-card-category"><%= sCategory %></span>
                    </div>
                    <span class="browse-type-badge <%= sTypeClass %>"><%= sJobType %></span>
                </div>

                <% if (!sDesc.isEmpty()) { %>
                <p class="saved-card-desc"><%= sDesc %></p>
                <% } %>

                <div class="saved-card-meta">
                    <span><i class="fa-solid fa-location-dot"></i> <%= sLocation %></span>
                    <span><i class="fa-solid fa-money-bill-wave"></i> <%= sSalary %></span>
                    <span><i class="fa-solid fa-calendar-check"></i> <%= sDeadline %></span>
                </div>

                <div class="saved-card-actions">
                    <a href="<%= request.getContextPath() %>/seeker?page=browse" class="saved-browse-btn">
                        <i class="fa-solid fa-eye"></i> View & Apply
                    </a>
                    <form method="post" action="<%= request.getContextPath() %>/seeker" style="display:inline;">
                        <input type="hidden" name="action" value="unsaveJob">
                        <input type="hidden" name="jobId" value="<%= sJob.getJobId() %>">
                        <input type="hidden" name="from" value="saved">
                        <button type="submit" class="saved-remove-btn">
                            <i class="fa-solid fa-heart-crack"></i> Remove
                        </button>
                    </form>
                </div>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <%-- Empty State --%>
        <div class="saved-empty-state">
            <div class="saved-empty-icon">
                <i class="fa-regular fa-heart"></i>
            </div>
            <h3>No Saved Jobs Yet</h3>
            <p>Browse jobs and click the <i class="fa-solid fa-heart" style="color:#ef4444;"></i> heart icon to save them here.</p>
            <a href="<%= request.getContextPath() %>/seeker?page=browse" class="saved-browse-link">
                <i class="fa-solid fa-magnifying-glass"></i> Browse Jobs
            </a>
        </div>
        <% } %>

        <%-- Tip card --%>
        <div class="seeker-tip-card" style="margin-top:24px;">
            <div class="seeker-tip-icon">
                <i class="fas fa-lightbulb"></i>
            </div>
            <div class="seeker-tip-content">
                <h4>Pro Tip</h4>
                <p>Save jobs you're interested in while browsing. Come back here to review and apply when you're ready — never miss an opportunity!</p>
            </div>
        </div>

<%@ include file="../components/seeker/seekerLayoutEnd.jsp" %>

</body>
</html>
