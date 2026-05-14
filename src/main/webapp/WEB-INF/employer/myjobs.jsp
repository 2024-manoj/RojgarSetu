<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.text.SimpleDateFormat" %>
<%
    List<com.demo.models.Job> myJobs = (List<com.demo.models.Job>) request.getAttribute("myJobs");
    SimpleDateFormat dateFmt = new SimpleDateFormat("MMM dd, yyyy");

    request.setAttribute("pageTitle", "My Job Posts");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="../components/employer/employerHead.jsp" %>
</head>
<body>

<%@ include file="../components/employer/employerLayout.jsp" %>

        <%-- Page Header --%>
        <div class="page-header">
            <h2><i class="fa-solid fa-briefcase"></i> My Job Posts</h2>
            <a href="<%= request.getContextPath() %>/employer?page=postjob" class="employer-action-btn">
                <i class="fa-solid fa-plus"></i> Post New Job
            </a>
        </div>

        <%-- Jobs Table --%>
        <div class="section-card">
            <h3 class="section-title">
                <i class="fa-solid fa-list-check"></i> All Job Listings
                <span class="section-count"><%= myJobs != null ? myJobs.size() : 0 %> jobs</span>
            </h3>
            <div class="table-wrapper">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Job Title</th>
                            <th>Category</th>
                            <th>Location</th>
                            <th>Type</th>
                            <th>Posted</th>
                            <th>Deadline</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (myJobs != null && !myJobs.isEmpty()) {
                            for (com.demo.models.Job job : myJobs) {
                                String st = job.getStatus() != null ? job.getStatus() : "";
                                String badgeClass = "status-pending";
                                if ("approved".equalsIgnoreCase(st)) badgeClass = "status-approved";
                                else if ("rejected".equalsIgnoreCase(st)) badgeClass = "status-rejected";
                        %>
                        <tr>
                            <td><strong>#<%= job.getJobId() %></strong></td>
                            <td><strong><%= job.getTitle() != null ? job.getTitle() : "—" %></strong></td>
                            <td><%= job.getCategory() != null ? job.getCategory() : "—" %></td>
                            <td><%= job.getLocationCity() != null ? job.getLocationCity() : "—" %></td>
                            <td><span class="job-type-badge"><%= job.getJobType() != null ? job.getJobType() : "—" %></span></td>
                            <td><%= job.getPostedAt() != null ? dateFmt.format(job.getPostedAt()) : "—" %></td>
                            <td><%= job.getDeadline() != null ? dateFmt.format(job.getDeadline()) : "—" %></td>
                            <td><span class="status-badge <%= badgeClass %>"><%= st %></span></td>
                            <td class="action-cell">
                                <a href="<%= request.getContextPath() %>/employer?page=postjob&editId=<%= job.getJobId() %>"
                                   class="muted-btn"><i class="fa-solid fa-pen"></i></a>
                                <form method="post" action="<%= request.getContextPath() %>/employer" style="display:inline;">
                                    <input type="hidden" name="action" value="deletejob"/>
                                    <input type="hidden" name="jobId" value="<%= job.getJobId() %>"/>
                                    <button type="submit" class="delete-btn"
                                            onclick="return confirm('Are you sure you want to delete this job?')">
                                        <i class="fa-solid fa-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="9">You haven't posted any jobs yet.
                                <a href="<%= request.getContextPath() %>/employer?page=postjob">Post your first job!</a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

<%@ include file="../components/employer/employerLayoutEnd.jsp" %>

</body>
</html>
