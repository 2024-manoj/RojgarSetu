<%--
  Browse Jobs — Single Job Card component.
  Expects these variables to be set before including:
    - cardJob (com.demo.models.Job)
    - cardIdx (int) - index for gradient cycling
    - cardDateFmt (SimpleDateFormat)
  All logic handled via scriptlet — no JavaScript.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Gradient palette for card headers
    String[] cardGradients = {
        "linear-gradient(135deg, #0f766e, #134e4a)",
        "linear-gradient(135deg, #1e40af, #1e3a5f)",
        "linear-gradient(135deg, #9333ea, #6b21a8)",
        "linear-gradient(135deg, #c2410c, #9a3412)",
        "linear-gradient(135deg, #0369a1, #075985)",
        "linear-gradient(135deg, #15803d, #166534)"
    };
    String[] cardIconColors = {"#5eead4", "#93c5fd", "#d8b4fe", "#fdba74", "#7dd3fc", "#86efac"};

    com.demo.models.Job cardJob = (com.demo.models.Job) request.getAttribute("cardJob");
    int cardIdx = (Integer) request.getAttribute("cardIdx");
    java.text.SimpleDateFormat cardDateFmt = (java.text.SimpleDateFormat) request.getAttribute("cardDateFmt");

    String cGradient = cardGradients[cardIdx % cardGradients.length];
    String cIconColor = cardIconColors[cardIdx % cardIconColors.length];

    String cTitle = cardJob.getTitle() != null ? cardJob.getTitle() : "—";
    String cCategory = cardJob.getCategory() != null ? cardJob.getCategory() : "—";
    String cLocation = cardJob.getLocationCity() != null ? cardJob.getLocationCity() : "—";
    String cJobType = cardJob.getJobType() != null ? cardJob.getJobType() : "—";
    String cSalary = cardJob.getSalaryRange() != null ? cardJob.getSalaryRange() : "—";
    String cDeadline = cardJob.getDeadline() != null ? cardDateFmt.format(cardJob.getDeadline()) : "—";
    String cDescription = cardJob.getDescription() != null ? cardJob.getDescription() : "";
    if (cDescription.length() > 120) cDescription = cDescription.substring(0, 120) + "...";
    String cTitleAttr = cTitle.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;");

    // Job type styling
    String cTypeIcon = "fa-solid fa-clock";
    String cTypeClass = "type-fulltime";
    if ("Part-time".equalsIgnoreCase(cJobType)) {
        cTypeIcon = "fa-solid fa-hourglass-half"; cTypeClass = "type-parttime";
    } else if ("Contract".equalsIgnoreCase(cJobType)) {
        cTypeIcon = "fa-solid fa-file-signature"; cTypeClass = "type-contract";
    } else if ("Internship".equalsIgnoreCase(cJobType)) {
        cTypeIcon = "fa-solid fa-graduation-cap"; cTypeClass = "type-internship";
    }
%>
<div class="browse-job-card" data-type="<%= cJobType %>"
     data-title="<%= cTitle.toLowerCase() %>"
     data-category="<%= cCategory.toLowerCase() %>"
     data-location="<%= cLocation.toLowerCase() %>">

    <%-- Card Header --%>
    <div class="browse-card-top" style="background: <%= cGradient %>;">
        <div class="browse-card-icon" style="color: <%= cIconColor %>;">
            <i class="fa-solid fa-briefcase"></i>
        </div>
        <div class="browse-card-top-info">
            <h3 class="browse-card-title"><%= cTitle %></h3>
            <span class="browse-card-category"><%= cCategory %></span>
        </div>
        <span class="browse-type-badge <%= cTypeClass %>">
            <i class="<%= cTypeIcon %>"></i> <%= cJobType %>
        </span>
    </div>

    <%-- Card Body --%>
    <div class="browse-card-body">
        <% if (!cDescription.isEmpty()) { %>
        <p class="browse-card-desc"><%= cDescription %></p>
        <% } %>

        <div class="browse-card-meta">
            <div class="browse-meta-item">
                <i class="fa-solid fa-location-dot"></i>
                <span><%= cLocation %></span>
            </div>
            <div class="browse-meta-item">
                <i class="fa-solid fa-money-bill-wave"></i>
                <span><%= cSalary %></span>
            </div>
            <div class="browse-meta-item">
                <i class="fa-solid fa-calendar-check"></i>
                <span>Deadline: <%= cDeadline %></span>
            </div>
        </div>
    </div>

    <%-- Card Footer --%>
    <div class="browse-card-footer">
        <div class="browse-posted-info">
            <i class="fa-regular fa-clock"></i>
            <% if (cardJob.getPostedAt() != null) { %>
                Posted <%= cardDateFmt.format(cardJob.getPostedAt()) %>
            <% } else { %>
                Recently posted
            <% } %>
        </div>
        <div class="browse-card-actions">
            <button type="button" class="browse-detail-btn" onclick="showJobDetail(<%= cardJob.getJobId() %>)">
                <i class="fa-solid fa-eye"></i> View
            </button>
            <button type="button" class="browse-apply-btn"
                    data-job-id="<%= cardJob.getJobId() %>"
                    data-job-title="<%= cTitleAttr %>"
                    onclick="showApplyModal(this)">
                <i class="fa-solid fa-paper-plane"></i> Apply
            </button>
        </div>
    </div>
</div>
