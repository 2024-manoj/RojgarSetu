<%-- Created by IntelliJ IDEA. User: katwa Date: 5/2/2026 Time: 10:58 AM To
change this template use File | Settings | File Templates. --%> <%@ page
language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Jobs — RojgarSetu</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
      rel="stylesheet"
    />

    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
      integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/static/global.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/static/jobs.css"
    />
  </head>
  <body>
    <%@ include file="/WEB-INF/components/Navbar.jsp" %>

    <!-- Jobs Section -->
    <section class="jobs-section">
      <div class="jobs-container">
        <!-- Header -->
        <div class="jobs-header">
          <h1 class="jobs-title">Find Your Dream Job</h1>
          <div class="jobs-divider"></div>
          <p class="jobs-subtitle">
            Browse through thousands of job opportunities across Koshi Province
          </p>
        </div>

        <!-- Search Bar -->
        <div class="search-bar">
          <div class="search-input-wrapper">
            <i class="fas fa-search search-icon"></i>
            <input
              type="text"
              class="search-input"
              placeholder="Search by keyword..."
              id="searchKeyword"
            />
          </div>
          <button class="search-btn" id="searchBtn">
            <i class="fas fa-search"></i> Search
          </button>
        </div>

        <div class="jobs-layout">
          <!-- Sidebar Filters -->
          <aside class="filters-sidebar">
            <!-- Category Filter -->
            <div class="filter-group">
              <h3 class="filter-title"><i class="fas fa-tag"></i> Category</h3>
              <div class="filter-options">
                <label class="filter-checkbox">
                  <input type="checkbox" value="IT" /> IT
                </label>
                <label class="filter-checkbox">
                  <input type="checkbox" value="Marketing" /> Marketing
                </label>
                <label class="filter-checkbox">
                  <input type="checkbox" value="Finance" /> Finance
                </label>
                <label class="filter-checkbox">
                  <input type="checkbox" value="HR" /> HR
                </label>
                <label class="filter-checkbox">
                  <input type="checkbox" value="Sales" /> Sales
                </label>
              </div>
            </div>

            <!-- Location Filter -->
            <div class="filter-group">
              <h3 class="filter-title">
                <i class="fas fa-location-dot"></i> Location
              </h3>
              <div class="filter-options">
                <label class="filter-checkbox">
                  <input type="checkbox" value="Kathmandu" /> Kathmandu
                </label>
                <label class="filter-checkbox">
                  <input type="checkbox" value="Pokhara" /> Pokhara
                </label>
                <label class="filter-checkbox">
                  <input type="checkbox" value="Biratnagar" /> Biratnagar
                </label>
                <label class="filter-checkbox">
                  <input type="checkbox" value="Dharan" /> Dharan
                </label>
                <label class="filter-checkbox">
                  <input type="checkbox" value="Itahari" /> Itahari
                </label>
              </div>
            </div>

            <!-- Salary Range Filter -->
            <div class="filter-group">
              <h3 class="filter-title">
                <i class="fas fa-dollar-sign"></i> Salary Range
              </h3>
              <div class="filter-options">
                <label class="filter-radio">
                  <input type="radio" name="salary" value="below" /> Below $1000
                </label>
                <label class="filter-radio">
                  <input type="radio" name="salary" value="mid" /> $1000 - $2000
                </label>
                <label class="filter-radio">
                  <input type="radio" name="salary" value="above" /> Above $2000
                </label>
              </div>
            </div>

            <!-- Reset Filters -->
            <button class="reset-filters-btn" id="resetFilters">
              <i class="fas fa-undo-alt"></i> Reset Filters
            </button>
          </aside>

          <!-- Job Listings -->
          <main class="job-listings">
            <!-- Results Count -->
            <div class="results-count">
              <p>Showing <span id="jobCount">6</span> jobs</p>
            </div>

            <!-- Job Cards Container -->
            <div class="jobs-grid" id="jobsGrid">
              <!-- Job Card 1 -->
              <div
                class="job-card"
                data-category="IT"
                data-location="Kathmandu"
                data-salary="2000"
              >
                <div class="job-card-header">
                  <h3 class="job-title">Software Engineer</h3>
                  <span class="job-category">IT</span>
                </div>
                <p class="job-company">
                  <i class="fas fa-building"></i> Tech Solutions Inc. -
                  Kathmandu
                </p>
                <p class="job-salary">
                  <i class="fas fa-dollar-sign"></i> $1,500 - $2,500
                </p>
                <button
                  class="apply-btn"
                  onclick="applyJob('Software Engineer', 'Tech Solutions Inc.')"
                >
                  <i class="fas fa-paper-plane"></i> Apply
                </button>
              </div>

              <!-- Job Card 2 -->
              <div
                class="job-card"
                data-category="Marketing"
                data-location="Pokhara"
                data-salary="1400"
              >
                <div class="job-card-header">
                  <h3 class="job-title">Marketing Specialist</h3>
                  <span class="job-category">Marketing</span>
                </div>
                <p class="job-company">
                  <i class="fas fa-building"></i> Global Marketing Co. - Pokhara
                </p>
                <p class="job-salary">
                  <i class="fas fa-dollar-sign"></i> $1,000 - $1,800
                </p>
                <button
                  class="apply-btn"
                  onclick="
                    applyJob('Marketing Specialist', 'Global Marketing Co.')
                  "
                >
                  <i class="fas fa-paper-plane"></i> Apply
                </button>
              </div>

              <!-- Job Card 3 -->
              <div
                class="job-card"
                data-category="Finance"
                data-location="Biratnagar"
                data-salary="1700"
              >
                <div class="job-card-header">
                  <h3 class="job-title">Financial Analyst</h3>
                  <span class="job-category">Finance</span>
                </div>
                <p class="job-company">
                  <i class="fas fa-building"></i> Wealth Management Ltd. -
                  Biratnagar
                </p>
                <p class="job-salary">
                  <i class="fas fa-dollar-sign"></i> $1,200 - $2,200
                </p>
                <button
                  class="apply-btn"
                  onclick="
                    applyJob('Financial Analyst', 'Wealth Management Ltd.')
                  "
                >
                  <i class="fas fa-paper-plane"></i> Apply
                </button>
              </div>

              <!-- Job Card 4 -->
              <div
                class="job-card"
                data-category="IT"
                data-location="Kathmandu"
                data-salary="2500"
              >
                <div class="job-card-header">
                  <h3 class="job-title">Data Scientist</h3>
                  <span class="job-category">IT</span>
                </div>
                <p class="job-company">
                  <i class="fas fa-building"></i> Data Insights Corp. -
                  Kathmandu
                </p>
                <p class="job-salary">
                  <i class="fas fa-dollar-sign"></i> $2,000 - $3,000
                </p>
                <button
                  class="apply-btn"
                  onclick="applyJob('Data Scientist', 'Data Insights Corp.')"
                >
                  <i class="fas fa-paper-plane"></i> Apply
                </button>
              </div>

              <!-- Job Card 5 -->
              <div
                class="job-card"
                data-category="HR"
                data-location="Pokhara"
                data-salary="1650"
              >
                <div class="job-card-header">
                  <h3 class="job-title">HR Manager</h3>
                  <span class="job-category">HR</span>
                </div>
                <p class="job-company">
                  <i class="fas fa-building"></i> People Solutions Inc. -
                  Pokhara
                </p>
                <p class="job-salary">
                  <i class="fas fa-dollar-sign"></i> $1,300 - $2,000
                </p>
                <button
                  class="apply-btn"
                  onclick="applyJob('HR Manager', 'People Solutions Inc.')"
                >
                  <i class="fas fa-paper-plane"></i> Apply
                </button>
              </div>

              <!-- Job Card 6 -->
              <div
                class="job-card"
                data-category="Sales"
                data-location="Biratnagar"
                data-salary="1150"
              >
                <div class="job-card-header">
                  <h3 class="job-title">Sales Executive</h3>
                  <span class="job-category">Sales</span>
                </div>
                <p class="job-company">
                  <i class="fas fa-building"></i> Sales Force Ltd. - Biratnagar
                </p>
                <p class="job-salary">
                  <i class="fas fa-dollar-sign"></i> $800 - $1,500
                </p>
                <button
                  class="apply-btn"
                  onclick="applyJob('Sales Executive', 'Sales Force Ltd.')"
                >
                  <i class="fas fa-paper-plane"></i> Apply
                </button>
              </div>
            </div>

            <!-- Pagination -->
            <div class="pagination">
              <button class="page-btn" id="prevBtn" onclick="prevPage()">
                <i class="fas fa-chevron-left"></i> Previous
              </button>
              <div class="page-numbers" id="pageNumbers">
                <button class="page-num active" onclick="goToPage(1)">1</button>
                <button class="page-num" onclick="goToPage(2)">2</button>
                <button class="page-num" onclick="goToPage(3)">3</button>
              </div>
              <button class="page-btn" id="nextBtn" onclick="nextPage()">
                Next <i class="fas fa-chevron-right"></i>
              </button>
            </div>
          </main>
        </div>
      </div>
    </section>

    <!-- Application Modal -->

    <div class="modal" id="applyModal">
      <div class="modal-content">
        <div class="modal-header">
          <h3>Apply for <span id="modalJobTitle"></span></h3>
          <button class="modal-close" onclick="closeModal()">&times;</button>
        </div>
        <div class="modal-body">
          <p>Company: <strong id="modalCompany"></strong></p>
          <form id="applicationForm">
            <div class="form-group">
              <label><i class="fas fa-user"></i> Full Name</label>
              <input
                type="text"
                class="form-input"
                id="applicantName"
                placeholder="Enter your full name"
                required
              />
            </div>
            <div class="form-group">
              <label><i class="fas fa-envelope"></i> Email</label>
              <input
                type="email"
                class="form-input"
                id="applicantEmail"
                placeholder="Enter your email"
                required
              />
            </div>
            <div class="form-group">
              <label><i class="fas fa-link"></i> Resume/CV Link</label>
              <input
                type="text"
                class="form-input"
                id="resumeLink"
                placeholder="Google Drive / LinkedIn link"
              />
            </div>
            <div class="form-group">
              <label
                ><i class="fas fa-comment"></i> Tell us why you're a good
                fit...</label
              >
              <textarea
                class="form-textarea"
                id="coverLetter"
                rows="4"
                placeholder="Cover Letter"
              ></textarea>
            </div>
            <button type="submit" class="btn-submit">
              <i class="fas fa-paper-plane"></i> Submit Application
            </button>
          </form>
        </div>
      </div>
    </div>

    <%@ include file="/WEB-INF/components/Footer.jsp" %>

    <script>
      // Filtering Logic
      const searchInput = document.getElementById("searchKeyword");
      const searchBtn = document.getElementById("searchBtn");
      const resetBtn = document.getElementById("resetFilters");
      const jobCards = document.querySelectorAll(".job-card");
      const jobCountSpan = document.getElementById("jobCount");

      // Pagination variables
      let currentPage = 1;
      const jobsPerPage = 4;
      let filteredJobs = [...jobCards];

      function filterJobs() {
        const keyword = searchInput.value.toLowerCase();
        const selectedCategories = Array.from(
          document.querySelectorAll(
            '.filter-checkbox input[type="checkbox"]:checked',
          ),
        ).map((cb) => cb.value);
        const selectedLocations = Array.from(
          document.querySelectorAll(
            ".filter-group:nth-child(2) .filter-checkbox input:checked",
          ),
        ).map((cb) => cb.value);
        const selectedSalary = document.querySelector(
          'input[name="salary"]:checked',
        )?.value;

        jobCards.forEach((card) => {
          const title = card
            .querySelector(".job-title")
            .innerText.toLowerCase();
          const category = card.getAttribute("data-category");
          const location = card.getAttribute("data-location");
          const salary = parseInt(card.getAttribute("data-salary"));

          let matchesKeyword = keyword === "" || title.includes(keyword);
          let matchesCategory =
            selectedCategories.length === 0 ||
            selectedCategories.includes(category);
          let matchesLocation =
            selectedLocations.length === 0 ||
            selectedLocations.includes(location);
          let matchesSalary = true;

          if (selectedSalary === "below") matchesSalary = salary < 1000;
          else if (selectedSalary === "mid")
            matchesSalary = salary >= 1000 && salary <= 2000;
          else if (selectedSalary === "above") matchesSalary = salary > 2000;

          if (
            matchesKeyword &&
            matchesCategory &&
            matchesLocation &&
            matchesSalary
          ) {
            card.style.display = "block";
          } else {
            card.style.display = "none";
          }
        });

        updateFilteredJobs();
        updateJobCount();
        resetToPage1();
      }

      function updateFilteredJobs() {
        filteredJobs = Array.from(jobCards).filter(
          (card) => card.style.display !== "none",
        );
        updateJobCount();
        renderPage(currentPage);
      }

      function updateJobCount() {
        const visibleCount = filteredJobs.length;
        jobCountSpan.innerText = visibleCount;
      }

      function renderPage(page) {
        const start = (page - 1) * jobsPerPage;
        const end = start + jobsPerPage;

        jobCards.forEach((card) => (card.style.display = "none"));

        const jobsToShow = filteredJobs.slice(start, end);
        jobsToShow.forEach((job) => (job.style.display = "block"));

        updatePaginationButtons();
      }

      function updatePaginationButtons() {
        const totalPages = Math.ceil(filteredJobs.length / jobsPerPage);
        const pageNumbersDiv = document.getElementById("pageNumbers");
        pageNumbersDiv.innerHTML = "";

        for (let i = 1; i <= totalPages; i++) {
          const btn = document.createElement("button");
          btn.className = "page-num" + (i === currentPage ? " active" : "");
          btn.innerText = i;
          btn.onclick = () => goToPage(i);
          pageNumbersDiv.appendChild(btn);
        }

        document.getElementById("prevBtn").disabled = currentPage === 1;
        document.getElementById("nextBtn").disabled =
          currentPage === totalPages || totalPages === 0;
      }

      function goToPage(page) {
        currentPage = page;
        renderPage(currentPage);
      }

      function prevPage() {
        if (currentPage > 1) {
          currentPage--;
          renderPage(currentPage);
        }
      }

      function nextPage() {
        const totalPages = Math.ceil(filteredJobs.length / jobsPerPage);
        if (currentPage < totalPages) {
          currentPage++;
          renderPage(currentPage);
        }
      }

      function resetToPage1() {
        currentPage = 1;
        renderPage(currentPage);
      }

      function resetFilters() {
        document
          .querySelectorAll(".filter-checkbox input")
          .forEach((cb) => (cb.checked = false));
        document
          .querySelectorAll(".filter-radio input")
          .forEach((radio) => (radio.checked = false));
        searchInput.value = "";
        filterJobs();
      }

      // Application Modal Functions
      function applyJob(jobTitle, company) {
        document.getElementById("modalJobTitle").innerText = jobTitle;
        document.getElementById("modalCompany").innerText = company;
        document.getElementById("applyModal").classList.add("show");
      }

      function closeModal() {
        document.getElementById("applyModal").classList.remove("show");
        document.getElementById("applicationForm").reset();
      }

      document
        .getElementById("applicationForm")
        .addEventListener("submit", function (e) {
          e.preventDefault();
          alert(
            "Application submitted successfully! We will contact you soon.",
          );
          closeModal();
        });

      // Close modal when clicking outside
      window.onclick = function (event) {
        const modal = document.getElementById("applyModal");
        if (event.target === modal) {
          closeModal();
        }
      };

      // Event Listeners
      searchBtn.addEventListener("click", filterJobs);
      resetBtn.addEventListener("click", resetFilters);
      searchInput.addEventListener("keypress", function (e) {
        if (e.key === "Enter") filterJobs();
      });
      document
        .querySelectorAll(".filter-checkbox input, .filter-radio input")
        .forEach((input) => {
          input.addEventListener("change", filterJobs);
        });

      // Initialize
      filterJobs();
    </script>
  </body>
</html>
