<%--
  Browse Jobs — Search & Filter Toolbar component.
  Filter chips for job types. Search uses minimal JS (kept for client-side UX).
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
