<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    com.demo.models.Job editJob = (com.demo.models.Job) request.getAttribute("editJob");
    boolean isEditing = editJob != null;

    String formTitle = isEditing ? "Edit Job Post" : "Post a New Job";
    String formAction = isEditing ? "updatejob" : "postjob";

    request.setAttribute("pageTitle", formTitle);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="../components/employer/employerHead.jsp" %>
</head>
<body>

<%@ include file="../components/employer/employerLayout.jsp" %>

        <%-- ===== PAGE HEADER ===== --%>
        <div class="page-header">
            <h2><i class="fa-solid fa-<%= isEditing ? "pen-to-square" : "plus-circle" %>"></i> <%= formTitle %></h2>
        </div>

        <%-- ===== POST JOB FORM ===== --%>
        <div class="employer-form-card">

            <div class="employer-form-header">
                <div class="employer-form-header-icon">
                    <i class="fa-solid fa-<%= isEditing ? "pen-to-square" : "briefcase" %>"></i>
                </div>
                <div>
                    <h3><%= formTitle %></h3>
                    <p><%= isEditing ? "Update the details of your job listing" : "Fill in the details to create a new job listing" %></p>
                </div>
            </div>

            <div class="employer-form-body">
                <form action="<%= request.getContextPath() %>/employer" method="post">
                    <input type="hidden" name="action" value="<%= formAction %>"/>
                    <% if (isEditing) { %>
                    <input type="hidden" name="jobId" value="<%= editJob.getJobId() %>"/>
                    <% } %>

                    <div class="employer-form-grid">

                        <div class="form-group">
                            <label for="title">
                                <i class="fa-solid fa-heading"></i> Job Title *
                            </label>
                            <input id="title" name="title" type="text" required
                                   placeholder="e.g. Software Engineer"
                                   value="<%= isEditing && editJob.getTitle() != null ? editJob.getTitle() : "" %>"/>
                        </div>

                        <div class="form-group">
                            <label for="category">
                                <i class="fa-solid fa-tags"></i> Category
                            </label>
                            <input id="category" name="category" type="text"
                                   placeholder="e.g. IT, Marketing, Design"
                                   value="<%= isEditing && editJob.getCategory() != null ? editJob.getCategory() : "" %>"/>
                        </div>

                        <div class="form-group">
                            <label for="locationCity">
                                <i class="fa-solid fa-location-dot"></i> Location / City
                            </label>
                            <input id="locationCity" name="locationCity" type="text"
                                   placeholder="e.g. Kathmandu"
                                   value="<%= isEditing && editJob.getLocationCity() != null ? editJob.getLocationCity() : "" %>"/>
                        </div>

                        <div class="form-group">
                            <label for="salaryRange">
                                <i class="fa-solid fa-money-bill-wave"></i> Salary Range
                            </label>
                            <input id="salaryRange" name="salaryRange" type="text"
                                   placeholder="e.g. NPR 30,000 - 50,000"
                                   value="<%= isEditing && editJob.getSalaryRange() != null ? editJob.getSalaryRange() : "" %>"/>
                        </div>

                        <div class="form-group">
                            <label for="jobType">
                                <i class="fa-solid fa-clock"></i> Job Type
                            </label>
                            <select id="jobType" name="jobType" class="employer-select">
                                <option value="Full-time" <%= isEditing && "Full-time".equals(editJob.getJobType()) ? "selected" : "" %>>Full-time</option>
                                <option value="Part-time" <%= isEditing && "Part-time".equals(editJob.getJobType()) ? "selected" : "" %>>Part-time</option>
                                <option value="Contract" <%= isEditing && "Contract".equals(editJob.getJobType()) ? "selected" : "" %>>Contract</option>
                                <option value="Internship" <%= isEditing && "Internship".equals(editJob.getJobType()) ? "selected" : "" %>>Internship</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="deadline">
                                <i class="fa-solid fa-calendar-xmark"></i> Application Deadline
                            </label>
                            <input id="deadline" name="deadline" type="date"
                                   value="<%= isEditing && editJob.getDeadline() != null ? editJob.getDeadline().toString() : "" %>"/>
                        </div>

                        <div class="form-group full-width">
                            <label for="description">
                                <i class="fa-solid fa-align-left"></i> Job Description
                            </label>
                            <textarea id="description" name="description" rows="5"
                                      placeholder="Describe the role, responsibilities, requirements..."><%= isEditing && editJob.getDescription() != null ? editJob.getDescription() : "" %></textarea>
                        </div>

                    </div>

                    <div class="employer-form-actions">
                        <button type="submit" class="employer-save-btn">
                            <i class="fa-solid fa-<%= isEditing ? "floppy-disk" : "paper-plane" %>"></i>
                            <%= isEditing ? "Update Job" : "Post Job" %>
                        </button>
                        <button type="reset" class="employer-reset-btn">
                            <i class="fa-solid fa-rotate-left"></i> Reset
                        </button>
                    </div>

                </form>
            </div>

        </div>

<%@ include file="../components/employer/employerLayoutEnd.jsp" %>

</body>
</html>
