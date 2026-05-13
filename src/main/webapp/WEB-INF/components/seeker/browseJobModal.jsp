<%--
  Browse Jobs — Job Detail Modal (server-side rendered).
  Each job's full details are pre-rendered in hidden divs via scriptlets.
  Modal display toggled with minimal JS (no DOM scraping needed).
  
  Expects 'jobs' list to be available in request scope.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.text.SimpleDateFormat" %>
<%
    List<com.demo.models.Job> modalJobs =
        (List<com.demo.models.Job>) request.getAttribute("jobs");
    SimpleDateFormat modalDateFmt = new SimpleDateFormat("MMM dd, yyyy");
%>

<%-- Pre-rendered hidden detail blocks for each job --%>
<% if (modalJobs != null) {
    for (com.demo.models.Job mj : modalJobs) {
        String mTitle = mj.getTitle() != null ? mj.getTitle() : "—";
        String mCategory = mj.getCategory() != null ? mj.getCategory() : "—";
        String mLocation = mj.getLocationCity() != null ? mj.getLocationCity() : "—";
        String mJobType = mj.getJobType() != null ? mj.getJobType() : "—";
        String mSalary = mj.getSalaryRange() != null ? mj.getSalaryRange() : "—";
        String mDeadline = mj.getDeadline() != null ? modalDateFmt.format(mj.getDeadline()) : "—";
        String mDesc = mj.getDescription() != null ? mj.getDescription() : "No description provided.";
        String mPosted = mj.getPostedAt() != null ? modalDateFmt.format(mj.getPostedAt()) : "Recently posted";

        // Job type badge class
        String mTypeClass = "type-fulltime";
        String mTypeIcon = "fa-solid fa-clock";
        if ("Part-time".equalsIgnoreCase(mJobType)) {
            mTypeClass = "type-parttime"; mTypeIcon = "fa-solid fa-hourglass-half";
        } else if ("Contract".equalsIgnoreCase(mJobType)) {
            mTypeClass = "type-contract"; mTypeIcon = "fa-solid fa-file-signature";
        } else if ("Internship".equalsIgnoreCase(mJobType)) {
            mTypeClass = "type-internship"; mTypeIcon = "fa-solid fa-graduation-cap";
        }
%>
<div id="jobDetail_<%= mj.getJobId() %>" class="job-detail-data" style="display:none;">
    <div class="modal-detail-section">
        <div class="modal-detail-title-row">
            <h2><%= mTitle %></h2>
            <span class="browse-type-badge <%= mTypeClass %>">
                <i class="<%= mTypeIcon %>"></i> <%= mJobType %>
            </span>
        </div>
        <span class="modal-category-badge"><i class="fa-solid fa-tag"></i> <%= mCategory %></span>
    </div>

    <div class="modal-detail-section">
        <h4><i class="fa-solid fa-align-left"></i> Description</h4>
        <p><%= mDesc %></p>
    </div>

    <div class="modal-detail-grid">
        <div class="modal-info-card">
            <i class="fa-solid fa-location-dot"></i>
            <span>Location</span>
            <strong><%= mLocation %></strong>
        </div>
        <div class="modal-info-card">
            <i class="fa-solid fa-money-bill-wave"></i>
            <span>Salary</span>
            <strong><%= mSalary %></strong>
        </div>
        <div class="modal-info-card">
            <i class="fa-solid fa-calendar-check"></i>
            <span>Deadline</span>
            <strong><%= mDeadline %></strong>
        </div>
    </div>

    <div class="modal-detail-footer">
        <span class="modal-posted"><i class="fa-regular fa-clock"></i> Posted <%= mPosted %></span>
    </div>
</div>
<% }
} %>

<%-- The actual modal shell --%>
<div class="browse-modal-overlay" id="jobDetailModal">
    <div class="browse-modal">
        <div class="browse-modal-header">
            <h3 id="modalTitle">Job Details</h3>
            <button class="browse-modal-close" onclick="closeJobModal()">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>
        <div class="browse-modal-body" id="modalBody">
            <%-- Populated from pre-rendered hidden blocks --%>
        </div>
    </div>
</div>

<script>
    /* Minimal JS — only for showing/hiding the modal.
       All job details are pre-rendered server-side via scriptlets. */
    function showJobDetail(jobId) {
        var src = document.getElementById('jobDetail_' + jobId);
        if (!src) return;
        document.getElementById('modalBody').innerHTML = src.innerHTML;
        document.getElementById('jobDetailModal').classList.add('show');
        document.body.style.overflow = 'hidden';
    }
    function closeJobModal() {
        document.getElementById('jobDetailModal').classList.remove('show');
        document.body.style.overflow = '';
    }
    document.getElementById('jobDetailModal').addEventListener('click', function(e) {
        if (e.target === this) closeJobModal();
    });
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') closeJobModal();
    });
</script>
