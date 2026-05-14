<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.text.SimpleDateFormat" %>
<%
  List<com.demo.models.Job> jobs = (List<com.demo.models.Job>) request.getAttribute("jobs");
  String keyword = (String) request.getAttribute("keyword");
  String district = (String) request.getAttribute("district");
  String[] selectedCategories = (String[]) request.getAttribute("selectedCategories");
  String[] selectedLocations = (String[]) request.getAttribute("selectedLocations");
  SimpleDateFormat dateFmt = new SimpleDateFormat("MMM dd, yyyy");

  if (keyword == null) keyword = "";
  if (district == null) district = "";

  java.util.function.Predicate<String> categoryChecked = value -> {
    if (selectedCategories == null) return false;
    for (String item : selectedCategories) {
      if (value.equalsIgnoreCase(item)) return true;
    }
    return false;
  };
  java.util.function.Predicate<String> locationChecked = value -> {
    if (selectedLocations == null) return false;
    for (String item : selectedLocations) {
      if (value.equalsIgnoreCase(item)) return true;
    }
    return false;
  };
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Jobs - RojgarSetu</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
      integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/global.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/jobs.css" />
  </head>
  <body>
    <%@ include file="/WEB-INF/components/Navbar.jsp" %>

    <section class="jobs-section">
      <div class="jobs-container">
        <div class="jobs-header">
          <h1 class="jobs-title">Find Your Dream Job</h1>
          <div class="jobs-divider"></div>
          <p class="jobs-subtitle">
            Browse approved opportunities across Koshi Province
          </p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
          <div class="jobs-alert"><i class="fas fa-circle-exclamation"></i> <%= request.getAttribute("error") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/jobs" method="get" class="search-bar">
          <div class="search-input-wrapper">
            <i class="fas fa-search search-icon"></i>
            <input
              type="text"
              class="search-input"
              placeholder="Search by title, category, or keyword"
              name="keyword"
              value="<%= keyword %>"
            />
          </div>
          <select class="jobs-district-select" name="district">
            <option value="">All Districts</option>
            <option value="sunsari" <%= "sunsari".equalsIgnoreCase(district) ? "selected" : "" %>>Sunsari</option>
            <option value="morang" <%= "morang".equalsIgnoreCase(district) ? "selected" : "" %>>Morang</option>
            <option value="jhapa" <%= "jhapa".equalsIgnoreCase(district) ? "selected" : "" %>>Jhapa</option>
            <option value="ilam" <%= "ilam".equalsIgnoreCase(district) ? "selected" : "" %>>Ilam</option>
            <option value="dhankuta" <%= "dhankuta".equalsIgnoreCase(district) ? "selected" : "" %>>Dhankuta</option>
            <option value="udayapur" <%= "udayapur".equalsIgnoreCase(district) ? "selected" : "" %>>Udayapur</option>
          </select>
          <button class="search-btn" type="submit">
            <i class="fas fa-search"></i> Search
          </button>
        </form>

        <div class="jobs-layout">
          <aside class="filters-sidebar">
            <form action="${pageContext.request.contextPath}/jobs" method="get">
              <input type="hidden" name="keyword" value="<%= keyword %>" />
              <input type="hidden" name="district" value="<%= district %>" />

              <div class="filter-group">
                <h3 class="filter-title"><i class="fas fa-tag"></i> Category</h3>
                <div class="filter-options">
                  <label class="filter-checkbox"><input type="checkbox" name="category" value="IT" <%= categoryChecked.test("IT") ? "checked" : "" %> /> IT</label>
                  <label class="filter-checkbox"><input type="checkbox" name="category" value="Marketing" <%= categoryChecked.test("Marketing") ? "checked" : "" %> /> Marketing</label>
                  <label class="filter-checkbox"><input type="checkbox" name="category" value="Finance" <%= categoryChecked.test("Finance") ? "checked" : "" %> /> Finance</label>
                  <label class="filter-checkbox"><input type="checkbox" name="category" value="HR" <%= categoryChecked.test("HR") ? "checked" : "" %> /> HR</label>
                  <label class="filter-checkbox"><input type="checkbox" name="category" value="Sales" <%= categoryChecked.test("Sales") ? "checked" : "" %> /> Sales</label>
                </div>
              </div>

              <div class="filter-group">
                <h3 class="filter-title"><i class="fas fa-location-dot"></i> Location</h3>
                <div class="filter-options">
                  <label class="filter-checkbox"><input type="checkbox" name="location" value="Biratnagar" <%= locationChecked.test("Biratnagar") ? "checked" : "" %> /> Biratnagar</label>
                  <label class="filter-checkbox"><input type="checkbox" name="location" value="Dharan" <%= locationChecked.test("Dharan") ? "checked" : "" %> /> Dharan</label>
                  <label class="filter-checkbox"><input type="checkbox" name="location" value="Itahari" <%= locationChecked.test("Itahari") ? "checked" : "" %> /> Itahari</label>
                  <label class="filter-checkbox"><input type="checkbox" name="location" value="Damak" <%= locationChecked.test("Damak") ? "checked" : "" %> /> Damak</label>
                  <label class="filter-checkbox"><input type="checkbox" name="location" value="Birtamod" <%= locationChecked.test("Birtamod") ? "checked" : "" %> /> Birtamod</label>
                </div>
              </div>

              <button class="search-btn filter-submit-btn" type="submit">
                <i class="fas fa-filter"></i> Apply Filters
              </button>
              <a class="reset-filters-btn" href="${pageContext.request.contextPath}/jobs">
                <i class="fas fa-undo-alt"></i> Reset Filters
              </a>
            </form>
          </aside>

          <main class="job-listings">
            <div class="results-count">
              <p>Showing <span><%= jobs != null ? jobs.size() : 0 %></span> jobs</p>
            </div>

            <div class="jobs-grid">
              <% if (jobs != null && !jobs.isEmpty()) {
                for (com.demo.models.Job job : jobs) {
                  String title = job.getTitle() != null ? job.getTitle() : "Untitled Job";
                  String category = job.getCategory() != null ? job.getCategory() : "General";
                  String location = job.getLocationCity() != null ? job.getLocationCity() : "Koshi Province";
                  String salary = job.getSalaryRange() != null && !job.getSalaryRange().isBlank() ? job.getSalaryRange() : "Not disclosed";
                  String jobType = job.getJobType() != null ? job.getJobType() : "Full-time";
                  String deadline = job.getDeadline() != null ? dateFmt.format(job.getDeadline()) : "Open";
                  String desc = job.getDescription() != null ? job.getDescription() : "";
                  if (desc.length() > 150) desc = desc.substring(0, 150) + "...";
              %>
              <article class="job-card">
                <div class="job-card-header">
                  <div>
                    <h3 class="job-title"><%= title %></h3>
                    <p class="job-company"><i class="fas fa-location-dot"></i> <%= location %></p>
                  </div>
                  <span class="job-category"><%= category %></span>
                </div>
                <% if (!desc.isBlank()) { %>
                  <p class="job-description"><%= desc %></p>
                <% } %>
                <div class="job-meta-row">
                  <span><i class="fas fa-briefcase"></i> <%= jobType %></span>
                  <span><i class="fas fa-money-bill-wave"></i> <%= salary %></span>
                  <span><i class="fas fa-calendar-check"></i> <%= deadline %></span>
                </div>
                <button class="apply-btn" onclick="applyJob()">
                  <i class="fas fa-paper-plane"></i> Apply
                </button>
              </article>
              <% } } else { %>
              <div class="jobs-empty-state">
                <i class="fas fa-folder-open"></i>
                <h3>No matching jobs found</h3>
                <p>Try changing the keyword, district, or filters.</p>
                <a href="${pageContext.request.contextPath}/jobs">View all jobs</a>
              </div>
              <% } %>
            </div>
          </main>
        </div>
      </div>
    </section>

    <%@ include file="/WEB-INF/components/Footer.jsp" %>

    <script>
      function applyJob() {
        window.location.href = "${pageContext.request.contextPath}/login?role=seeker&next=browse";
      }
    </script>
  </body>
</html>
