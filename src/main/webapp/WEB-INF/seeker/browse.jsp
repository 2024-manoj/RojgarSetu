<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.text.SimpleDateFormat" %>
<%
    List<com.demo.models.Job> jobs =
        (List<com.demo.models.Job>) request.getAttribute("jobs");

    SimpleDateFormat dateFmt = new SimpleDateFormat("MMM dd, yyyy");
    int jobCount = (jobs != null) ? jobs.size() : 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Browse Jobs — RojgarSetu</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/global.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/admin.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/seeker.css"/>
</head>
<body>

<%@ include file="../components/seeker/seekerNavbar.jsp" %>

<div class="admin-container">
    <%@ include file="../components/seeker/seekerSidebar.jsp" %>

    <main class="admin-main">

        <%-- Alerts --%>
        <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success">
            <i class="fa-solid fa-circle-check"></i> <%= request.getAttribute("success") %>
        </div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <i class="fa-solid fa-circle-exclamation"></i> <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <%-- Hero Banner --%>
        <div class="browse-hero">
            <div class="browse-hero-bg"></div>
            <div class="browse-hero-content">
                <div class="browse-hero-text">
                    <h2><i class="fa-solid fa-compass"></i> Explore Opportunities</h2>
                    <p>Discover <%= jobCount %> approved job<%= jobCount != 1 ? "s" : "" %> waiting for you. Find the perfect match for your skills.</p>
                </div>
                <div class="browse-hero-stats">
                    <div class="browse-stat-pill">
                        <i class="fa-solid fa-briefcase"></i>
                        <span><strong><%= jobCount %></strong> Jobs</span>
                    </div>
                </div>
            </div>
        </div>

        <%-- Search & Filter Bar --%>
        <div class="browse-toolbar">
            <div class="browse-search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" id="browseSearch" placeholder="Search jobs by title, category, or location..." autocomplete="off"/>
            </div>
            <div class="browse-filter-chips" id="filterChips">
                <button class="filter-chip active" data-filter="all">
                    <i class="fa-solid fa-layer-group"></i> All
                </button>
                <button class="filter-chip" data-filter="Full-time">
                    <i class="fa-solid fa-clock"></i> Full-time
                </button>
                <button class="filter-chip" data-filter="Part-time">
                    <i class="fa-solid fa-hourglass-half"></i> Part-time
                </button>
                <button class="filter-chip" data-filter="Contract">
                    <i class="fa-solid fa-file-signature"></i> Contract
                </button>
                <button class="filter-chip" data-filter="Internship">
                    <i class="fa-solid fa-graduation-cap"></i> Internship
                </button>
            </div>
        </div>

        <%-- Results Count --%>
        <div class="browse-results-info">
            <span id="browseResultCount"><%= jobCount %></span> job<span id="browseResultPlural"><%= jobCount != 1 ? "s" : "" %></span> found
        </div>

        <%-- Job Cards Grid --%>
        <div class="browse-cards-grid" id="browseGrid">
            <% if (jobs != null && !jobs.isEmpty()) {
                String[] gradients = {
                    "linear-gradient(135deg, #0f766e, #134e4a)",
                    "linear-gradient(135deg, #1e40af, #1e3a5f)",
                    "linear-gradient(135deg, #9333ea, #6b21a8)",
                    "linear-gradient(135deg, #c2410c, #9a3412)",
                    "linear-gradient(135deg, #0369a1, #075985)",
                    "linear-gradient(135deg, #15803d, #166534)"
                };
                String[] iconColors = {"#5eead4", "#93c5fd", "#d8b4fe", "#fdba74", "#7dd3fc", "#86efac"};
                int idx = 0;
                for (com.demo.models.Job job : jobs) {
                    String gradient = gradients[idx % gradients.length];
                    String iconColor = iconColors[idx % iconColors.length];
                    idx++;

                    String title = job.getTitle() != null ? job.getTitle() : "—";
                    String category = job.getCategory() != null ? job.getCategory() : "—";
                    String location = job.getLocationCity() != null ? job.getLocationCity() : "—";
                    String jobType = job.getJobType() != null ? job.getJobType() : "—";
                    String salary = job.getSalaryRange() != null ? job.getSalaryRange() : "—";
                    String deadline = job.getDeadline() != null ? dateFmt.format(job.getDeadline()) : "—";
                    String description = job.getDescription() != null ? job.getDescription() : "";
                    if (description.length() > 120) description = description.substring(0, 120) + "...";

                    // Determine job type icon
                    String typeIcon = "fa-solid fa-clock";
                    String typeClass = "type-fulltime";
                    if ("Part-time".equalsIgnoreCase(jobType)) {
                        typeIcon = "fa-solid fa-hourglass-half";
                        typeClass = "type-parttime";
                    } else if ("Contract".equalsIgnoreCase(jobType)) {
                        typeIcon = "fa-solid fa-file-signature";
                        typeClass = "type-contract";
                    } else if ("Internship".equalsIgnoreCase(jobType)) {
                        typeIcon = "fa-solid fa-graduation-cap";
                        typeClass = "type-internship";
                    }
            %>
            <div class="browse-job-card" data-type="<%= jobType %>"
                 data-title="<%= title.toLowerCase() %>"
                 data-category="<%= category.toLowerCase() %>"
                 data-location="<%= location.toLowerCase() %>">

                <%-- Card Header with gradient --%>
                <div class="browse-card-top" style="background: <%= gradient %>;">
                    <div class="browse-card-icon" style="color: <%= iconColor %>;">
                        <i class="fa-solid fa-briefcase"></i>
                    </div>
                    <div class="browse-card-top-info">
                        <h3 class="browse-card-title"><%= title %></h3>
                        <span class="browse-card-category"><%= category %></span>
                    </div>
                    <span class="browse-type-badge <%= typeClass %>">
                        <i class="<%= typeIcon %>"></i> <%= jobType %>
                    </span>
                </div>

                <%-- Card Body --%>
                <div class="browse-card-body">
                    <% if (!description.isEmpty()) { %>
                    <p class="browse-card-desc"><%= description %></p>
                    <% } %>

                    <div class="browse-card-meta">
                        <div class="browse-meta-item">
                            <i class="fa-solid fa-location-dot"></i>
                            <span><%= location %></span>
                        </div>
                        <div class="browse-meta-item">
                            <i class="fa-solid fa-money-bill-wave"></i>
                            <span><%= salary %></span>
                        </div>
                        <div class="browse-meta-item">
                            <i class="fa-solid fa-calendar-check"></i>
                            <span>Deadline: <%= deadline %></span>
                        </div>
                    </div>
                </div>

                <%-- Card Footer --%>
                <div class="browse-card-footer">
                    <div class="browse-posted-info">
                        <i class="fa-regular fa-clock"></i>
                        <% if (job.getPostedAt() != null) { %>
                            Posted <%= dateFmt.format(job.getPostedAt()) %>
                        <% } else { %>
                            Recently posted
                        <% } %>
                    </div>
                    <div class="browse-card-actions">
                        <button type="button" class="browse-detail-btn" onclick="showJobDetail(<%= job.getJobId() %>, this)">
                            <i class="fa-solid fa-eye"></i> View
                        </button>
                        <form action="<%= request.getContextPath() %>/seeker" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="apply"/>
                            <input type="hidden" name="jobId" value="<%= job.getJobId() %>"/>
                            <button type="submit" class="browse-apply-btn">
                                <i class="fa-solid fa-paper-plane"></i> Apply
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            <% }
            } else { %>
            <%-- Empty State --%>
            <div class="browse-empty-state">
                <div class="browse-empty-icon">
                    <i class="fa-solid fa-folder-open"></i>
                </div>
                <h3>No Jobs Available</h3>
                <p>There are no approved jobs at the moment. Please check back later for new opportunities!</p>
            </div>
            <% } %>
        </div>

        <%-- Detail Modal --%>
        <div class="browse-modal-overlay" id="jobDetailModal">
            <div class="browse-modal">
                <div class="browse-modal-header">
                    <h3 id="modalTitle">Job Details</h3>
                    <button class="browse-modal-close" onclick="closeJobModal()">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
                <div class="browse-modal-body" id="modalBody">
                    <!-- Dynamically populated -->
                </div>
            </div>
        </div>

    </main>
</div>

<%@ include file="../components/seeker/seekerFooter.jsp" %>

<script>
    // ===== Search & Filter Logic =====
    const searchInput = document.getElementById('browseSearch');
    const filterChips = document.querySelectorAll('.filter-chip');
    const cards = document.querySelectorAll('.browse-job-card');
    const resultCount = document.getElementById('browseResultCount');
    const resultPlural = document.getElementById('browseResultPlural');
    let activeFilter = 'all';

    function applyFilters() {
        const keyword = searchInput.value.toLowerCase().trim();
        let visible = 0;

        cards.forEach(card => {
            const type = card.getAttribute('data-type');
            const title = card.getAttribute('data-title');
            const category = card.getAttribute('data-category');
            const location = card.getAttribute('data-location');

            const matchesFilter = activeFilter === 'all' || type === activeFilter;
            const matchesSearch = !keyword ||
                title.includes(keyword) ||
                category.includes(keyword) ||
                location.includes(keyword);

            if (matchesFilter && matchesSearch) {
                card.style.display = '';
                card.style.animation = 'cardFadeIn 0.3s ease forwards';
                visible++;
            } else {
                card.style.display = 'none';
            }
        });

        resultCount.textContent = visible;
        resultPlural.textContent = visible !== 1 ? 's' : '';
    }

    filterChips.forEach(chip => {
        chip.addEventListener('click', function() {
            filterChips.forEach(c => c.classList.remove('active'));
            this.classList.add('active');
            activeFilter = this.getAttribute('data-filter');
            applyFilters();
        });
    });

    searchInput.addEventListener('input', applyFilters);

    // ===== Detail Modal =====
    function showJobDetail(jobId, btn) {
        const card = btn.closest('.browse-job-card');
        const title = card.querySelector('.browse-card-title').textContent;
        const category = card.querySelector('.browse-card-category').textContent;
        const desc = card.querySelector('.browse-card-desc');
        const metas = card.querySelectorAll('.browse-meta-item span');
        const posted = card.querySelector('.browse-posted-info').textContent.trim();
        const typeBadge = card.querySelector('.browse-type-badge');

        let html = '<div class="modal-detail-section">';
        html += '<div class="modal-detail-title-row">';
        html += '<h2>' + title + '</h2>';
        html += '<span class="modal-type-badge">' + typeBadge.innerHTML + '</span>';
        html += '</div>';
        html += '<span class="modal-category-badge"><i class="fa-solid fa-tag"></i> ' + category + '</span>';
        html += '</div>';

        if (desc) {
            html += '<div class="modal-detail-section">';
            html += '<h4><i class="fa-solid fa-align-left"></i> Description</h4>';
            html += '<p>' + desc.textContent + '</p>';
            html += '</div>';
        }

        html += '<div class="modal-detail-grid">';
        if (metas.length > 0) {
            html += '<div class="modal-info-card"><i class="fa-solid fa-location-dot"></i><span>Location</span><strong>' + metas[0].textContent + '</strong></div>';
        }
        if (metas.length > 1) {
            html += '<div class="modal-info-card"><i class="fa-solid fa-money-bill-wave"></i><span>Salary</span><strong>' + metas[1].textContent + '</strong></div>';
        }
        if (metas.length > 2) {
            html += '<div class="modal-info-card"><i class="fa-solid fa-calendar-check"></i><span>Deadline</span><strong>' + metas[2].textContent.replace("Deadline: ", "") + '</strong></div>';
        }
        html += '</div>';

        html += '<div class="modal-detail-footer">';
        html += '<span class="modal-posted"><i class="fa-regular fa-clock"></i> ' + posted + '</span>';
        html += '</div>';

        document.getElementById('modalTitle').textContent = title;
        document.getElementById('modalBody').innerHTML = html;
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

</body>
</html>
