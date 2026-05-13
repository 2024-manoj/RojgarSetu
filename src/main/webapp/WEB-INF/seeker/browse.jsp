<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.text.SimpleDateFormat" %>
<%
    List<com.demo.models.Job> jobs =
        (List<com.demo.models.Job>) request.getAttribute("jobs");

    SimpleDateFormat dateFmt = new SimpleDateFormat("MMM dd, yyyy");
    int jobCount = (jobs != null) ? jobs.size() : 0;

    request.setAttribute("pageTitle", "Browse Jobs");
    request.setAttribute("jobCount", jobCount);
    request.setAttribute("cardDateFmt", dateFmt);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="../components/seeker/seekerHead.jsp" %>
</head>
<body>

<%@ include file="../components/seeker/seekerLayout.jsp" %>

        <%-- Hero Banner --%>
        <%@ include file="../components/seeker/browseHero.jsp" %>

        <%-- Search & Filter Toolbar --%>
        <%@ include file="../components/seeker/browseToolbar.jsp" %>

        <%-- Results Count --%>
        <div class="browse-results-info">
            <span id="browseResultCount"><%= jobCount %></span> job<span id="browseResultPlural"><%= jobCount != 1 ? "s" : "" %></span> found
        </div>

        <%-- Job Cards Grid --%>
        <div class="browse-cards-grid" id="browseGrid">
            <% if (jobs != null && !jobs.isEmpty()) {
                int idx = 0;
                for (com.demo.models.Job job : jobs) {
                    request.setAttribute("cardJob", job);
                    request.setAttribute("cardIdx", idx);
                    idx++;
            %>
                    <%@ include file="../components/seeker/browseJobCard.jsp" %>
            <%  }
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

        <%-- Job Detail Modal (server-side rendered) --%>
        <%@ include file="../components/seeker/browseJobModal.jsp" %>

<%@ include file="../components/seeker/seekerLayoutEnd.jsp" %>

<%-- Minimal JS: client-side search & filter only (cannot be done server-side without page reload) --%>
<script>
    (function() {
        var searchInput = document.getElementById('browseSearch');
        var filterChips = document.querySelectorAll('.filter-chip');
        var cards = document.querySelectorAll('.browse-job-card');
        var resultCount = document.getElementById('browseResultCount');
        var resultPlural = document.getElementById('browseResultPlural');
        var activeFilter = 'all';

        function applyFilters() {
            var keyword = searchInput.value.toLowerCase().trim();
            var visible = 0;

            for (var i = 0; i < cards.length; i++) {
                var card = cards[i];
                var type = card.getAttribute('data-type');
                var title = card.getAttribute('data-title');
                var category = card.getAttribute('data-category');
                var location = card.getAttribute('data-location');

                var matchesFilter = activeFilter === 'all' || type === activeFilter;
                var matchesSearch = !keyword ||
                    title.indexOf(keyword) !== -1 ||
                    category.indexOf(keyword) !== -1 ||
                    location.indexOf(keyword) !== -1;

                if (matchesFilter && matchesSearch) {
                    card.style.display = '';
                    visible++;
                } else {
                    card.style.display = 'none';
                }
            }

            resultCount.textContent = visible;
            resultPlural.textContent = visible !== 1 ? 's' : '';
        }

        for (var i = 0; i < filterChips.length; i++) {
            filterChips[i].addEventListener('click', function() {
                for (var j = 0; j < filterChips.length; j++) {
                    filterChips[j].classList.remove('active');
                }
                this.classList.add('active');
                activeFilter = this.getAttribute('data-filter');
                applyFilters();
            });
        }

        searchInput.addEventListener('input', applyFilters);
    })();
</script>

</body>
</html>
