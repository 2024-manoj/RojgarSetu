<%-- Created by IntelliJ IDEA. User: katwa Date: 5/3/2026 Time: 9:55 AM To
change this template use File | Settings | File Templates. --%> <%@ page
language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Job Seeker Dashboard — RojgarSetu</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
    />

  </head>
  <body>
    <!-- Header -->
    <div class="dashboard-header">
      <div class="logo">
        <h2>Rojgar<span>Setu</span></h2>
      </div>
      <div class="user-info">
        <div class="user-name">
          <i class="fas fa-user-circle"></i>
          <span>John Doe</span>
        </div>
        <a href="#" class="logout-btn" onclick="logout()"
          ><i class="fas fa-sign-out-alt"></i> Logout</a
        >
      </div>
    </div>

    <div class="dashboard-container">
      <!-- Sidebar -->
      <aside class="dashboard-sidebar">
        <ul class="sidebar-menu">
          <li>
            <a href="#" data-section="profile" class="active"
              ><i class="fas fa-user"></i> Profile</a
            >
          </li>
          <li>
            <a href="#" data-section="applications"
              ><i class="fas fa-briefcase"></i> My Applications</a
            >
          </li>
          <li>
            <a href="#" data-section="saved"
              ><i class="fas fa-bookmark"></i> Saved Jobs</a
            >
          </li>
          <li>
            <a href="#" data-section="browse"
              ><i class="fas fa-search"></i> Browse & Apply Jobs</a
            >
          </li>
          <li>
            <a href="#" onclick="logout()"
              ><i class="fas fa-sign-out-alt"></i> Logout</a
            >
          </li>
        </ul>
      </aside>

      <!-- Main Content -->
      <main class="dashboard-main">
        <!-- ===== PROFILE SECTION ===== -->
        <div id="profileSection" class="dashboard-section active">
          <h1 class="section-title">Job Seeker Profile</h1>

          <!-- Profile Card -->
          <div class="card">
            <div class="profile-grid">
              <div class="profile-field">
                <label>Full Name</label>
                <div class="value" id="displayFullName">John Doe</div>
              </div>
              <div class="profile-field">
                <label>Email</label>
                <div class="value" id="displayEmail">john.doe@example.com</div>
              </div>
              <div class="profile-field">
                <label>Phone Number</label>
                <div class="value" id="displayPhone">+977-9876543210</div>
              </div>
              <div class="profile-field">
                <label>Date of Birth</label>
                <div class="value" id="displayDob">1990-01-01</div>
              </div>
              <div class="profile-field">
                <label>Location</label>
                <div class="value" id="displayLocation">
                  Biratnagar, Koshi Province
                </div>
              </div>
              <div class="profile-field">
                <label>Education Level</label>
                <div class="value" id="displayEducation">Bachelor's Degree</div>
              </div>
              <div class="profile-field">
                <label>Skills</label>
                <div class="skills-list" id="displaySkills">
                  <span class="skill-tag">Web Development</span>
                  <span class="skill-tag">UI/UX Design</span>
                  <span class="skill-tag">Project Management</span>
                  <span class="skill-tag">Data Analysis</span>
                </div>
              </div>
            </div>
            <button
              class="btn-primary"
              onclick="toggleEditForm()"
              style="margin-top: 20px"
            >
              <i class="fas fa-edit"></i> Edit Profile
            </button>

            <!-- Edit Profile Form -->
            <div id="editProfileForm" class="edit-form">
              <h3 style="margin-bottom: 15px">Edit Profile</h3>
              <div class="form-group">
                <label>Full Name</label>
                <input type="text" id="editFullName" value="John Doe" />
              </div>
              <div class="form-group">
                <label>Phone Number</label>
                <input type="text" id="editPhone" value="+977-9876543210" />
              </div>
              <div class="form-group">
                <label>Date of Birth</label>
                <input type="date" id="editDob" value="1990-01-01" />
              </div>
              <div class="form-group">
                <label>Location</label>
                <input
                  type="text"
                  id="editLocation"
                  value="Biratnagar, Koshi Province"
                />
              </div>
              <div class="form-group">
                <label>Education Level</label>
                <select id="editEducation">
                  <option>Secondary (SLC/SEE)</option>
                  <option>Higher Secondary (+2)</option>
                  <option selected>Bachelor's Degree</option>
                  <option>Master's Degree</option>
                  <option>PhD/Doctorate</option>
                </select>
              </div>
              <div class="form-group">
                <label>Skills (comma separated)</label>
                <textarea id="editSkills" rows="3">
Web Development, UI/UX Design, Project Management, Data Analysis</textarea
                >
              </div>
              <button class="btn-primary" onclick="saveProfile()">
                Save Changes
              </button>
              <button class="btn-secondary" onclick="toggleEditForm()">
                Cancel
              </button>
            </div>
          </div>

          <!-- Change Password Card -->
          <div class="password-card">
            <h3><i class="fas fa-key"></i> Change Password</h3>
            <div class="form-group">
              <label>Current Password</label>
              <input
                type="password"
                id="currentPassword"
                placeholder="Enter current password"
              />
            </div>
            <div class="form-group">
              <label>New Password</label>
              <input
                type="password"
                id="newPassword"
                placeholder="Enter new password"
              />
            </div>
            <div class="form-group">
              <label>Confirm New Password</label>
              <input
                type="password"
                id="confirmPassword"
                placeholder="Confirm new password"
              />
            </div>
            <button class="btn-primary" onclick="changePassword()">
              Change Password
            </button>
          </div>
        </div>

        <!-- ===== MY APPLICATIONS SECTION ===== -->
        <div id="applicationsSection" class="dashboard-section">
          <h1 class="section-title">My Applications</h1>
          <div class="card">
            <div class="table-wrapper">
              <table class="data-table">
                <thead>
                  <tr>
                    <th>Job Title</th>
                    <th>Company</th>
                    <th>Applied Date</th>
                    <th>Status</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody id="applicationsTable">
                  <tr>
                    <td>Frontend Developer</td>
                    <td>Tech Solutions Inc.</td>
                    <td>2023-10-26</td>
                    <td>
                      <span class="status-badge status-pending">Pending</span>
                    </td>
                    <td>
                      <button
                        class="btn-primary"
                        style="padding: 5px 12px; font-size: 0.8rem"
                        onclick="viewApplication('Frontend Developer')"
                      >
                        View
                      </button>
                    </td>
                  </tr>
                  <tr>
                    <td>UI/UX Designer</td>
                    <td>Creative Agency</td>
                    <td>2023-10-20</td>
                    <td>
                      <span class="status-badge status-accepted">Accepted</span>
                    </td>
                    <td>
                      <button
                        class="btn-primary"
                        style="padding: 5px 12px; font-size: 0.8rem"
                        onclick="viewApplication('UI/UX Designer')"
                      >
                        View
                      </button>
                    </td>
                  </tr>
                  <tr>
                    <td>Backend Engineer</td>
                    <td>Global Innovations</td>
                    <td>2023-10-15</td>
                    <td>
                      <span class="status-badge status-rejected">Rejected</span>
                    </td>
                    <td>
                      <button
                        class="btn-primary"
                        style="padding: 5px 12px; font-size: 0.8rem"
                        onclick="viewApplication('Backend Engineer')"
                      >
                        View
                      </button>
                    </td>
                  </tr>
                  <tr>
                    <td>Data Scientist</td>
                    <td>Data Insights Ltd.</td>
                    <td>2023-10-10</td>
                    <td>
                      <span class="status-badge status-pending">Pending</span>
                    </td>
                    <td>
                      <button
                        class="btn-primary"
                        style="padding: 5px 12px; font-size: 0.8rem"
                        onclick="viewApplication('Data Scientist')"
                      >
                        View
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>

            <!-- Pagination -->
            <div class="pagination">
              <button class="page-btn" onclick="prevPage('applications')">
                Previous
              </button>
              <button class="page-btn active">1</button>
              <button class="page-btn" onclick="changePage(2)">2</button>
              <button class="page-btn" onclick="changePage(3)">3</button>
              <button class="page-btn" onclick="nextPage('applications')">
                Next
              </button>
            </div>
          </div>
        </div>

        <!-- ===== SAVED JOBS SECTION ===== -->
        <div id="savedSection" class="dashboard-section">
          <h1 class="section-title">Saved Jobs</h1>
          <div class="saved-jobs-grid" id="savedJobsGrid">
            <!-- Job Card 1 -->
            <div class="job-card">
              <div class="job-info">
                <h4>Software Engineer</h4>
                <p>Tech Solutions Inc. - Kathmandu</p>
                <p>Salary: $1,500 - $2,500</p>
                <span class="job-category">IT</span>
              </div>
              <div class="job-actions">
                <button class="btn-remove" onclick="removeSavedJob(this)">
                  <i class="fas fa-trash"></i> Remove
                </button>
                <button
                  class="btn-apply"
                  onclick="applyNow('Software Engineer')"
                >
                  <i class="fas fa-paper-plane"></i> Apply
                </button>
              </div>
            </div>
            <!-- Job Card 2 -->
            <div class="job-card">
              <div class="job-info">
                <h4>Marketing Specialist</h4>
                <p>Global Marketing Co. - Pokhara</p>
                <p>Salary: $1,000 - $1,800</p>
                <span class="job-category">Marketing</span>
              </div>
              <div class="job-actions">
                <button class="btn-remove" onclick="removeSavedJob(this)">
                  <i class="fas fa-trash"></i> Remove
                </button>
                <button
                  class="btn-apply"
                  onclick="applyNow('Marketing Specialist')"
                >
                  <i class="fas fa-paper-plane"></i> Apply
                </button>
              </div>
            </div>
            <!-- Job Card 3 -->
            <div class="job-card">
              <div class="job-info">
                <h4>Financial Analyst</h4>
                <p>Wealth Management Ltd. - Biratnagar</p>
                <p>Salary: $1,200 - $2,200</p>
                <span class="job-category">Finance</span>
              </div>
              <div class="job-actions">
                <button class="btn-remove" onclick="removeSavedJob(this)">
                  <i class="fas fa-trash"></i> Remove
                </button>
                <button
                  class="btn-apply"
                  onclick="applyNow('Financial Analyst')"
                >
                  <i class="fas fa-paper-plane"></i> Apply
                </button>
              </div>
            </div>
            <!-- Job Card 4 -->
            <div class="job-card">
              <div class="job-info">
                <h4>Data Scientist</h4>
                <p>Data Insights Corp. - Kathmandu</p>
                <p>Salary: $2,000 - $3,000</p>
                <span class="job-category">IT</span>
              </div>
              <div class="job-actions">
                <button class="btn-remove" onclick="removeSavedJob(this)">
                  <i class="fas fa-trash"></i> Remove
                </button>
                <button class="btn-apply" onclick="applyNow('Data Scientist')">
                  <i class="fas fa-paper-plane"></i> Apply
                </button>
              </div>
            </div>
          </div>

          <!-- Pagination for Saved Jobs -->
          <div class="pagination">
            <button class="page-btn" onclick="prevPage('saved')">
              Previous
            </button>
            <button class="page-btn active">1</button>
            <button class="page-btn" onclick="changePage(2)">2</button>
            <button class="page-btn" onclick="nextPage('saved')">Next</button>
          </div>
        </div>

        <!-- ===== BROWSE & APPLY JOBS SECTION ===== -->
        <div id="browseSection" class="dashboard-section">
          <h1 class="section-title">Browse & Apply Jobs</h1>

          <!-- Search Bar -->
          <div class="card">
            <div style="display: flex; gap: 10px; flex-wrap: wrap">
              <input
                type="text"
                id="searchKeyword"
                placeholder="Search by keyword..."
                style="
                  flex: 1;
                  padding: 12px;
                  border: 1px solid #ddd;
                  border-radius: 8px;
                "
              />
              <select
                id="categoryFilter"
                style="
                  padding: 12px;
                  border: 1px solid #ddd;
                  border-radius: 8px;
                "
              >
                <option value="">All Categories</option>
                <option>IT</option>
                <option>Marketing</option>
                <option>Finance</option>
                <option>HR</option>
                <option>Sales</option>
              </select>
              <button class="btn-primary" onclick="searchJobs()">
                <i class="fas fa-search"></i> Search
              </button>
            </div>
          </div>

          <!-- Job Listings -->
          <div class="saved-jobs-grid" id="browseJobsGrid">
            <div class="job-card">
              <div class="job-info">
                <h4>Frontend Developer</h4>
                <p>Tech Solutions Inc. - Kathmandu</p>
                <p>Salary: $1,200 - $2,000</p>
                <span class="job-category">IT</span>
              </div>
              <div class="job-actions">
                <button class="btn-remove" onclick="saveJob(this)">
                  <i class="fas fa-bookmark"></i> Save
                </button>
                <button
                  class="btn-apply"
                  onclick="applyNow('Frontend Developer')"
                >
                  <i class="fas fa-paper-plane"></i> Apply
                </button>
              </div>
            </div>
            <div class="job-card">
              <div class="job-info">
                <h4>HR Manager</h4>
                <p>People Solutions Inc. - Pokhara</p>
                <p>Salary: $1,300 - $2,000</p>
                <span class="job-category">HR</span>
              </div>
              <div class="job-actions">
                <button class="btn-remove" onclick="saveJob(this)">
                  <i class="fas fa-bookmark"></i> Save
                </button>
                <button class="btn-apply" onclick="applyNow('HR Manager')">
                  <i class="fas fa-paper-plane"></i> Apply
                </button>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>

    <!-- Modal -->
    <div id="applyModal" class="modal">
      <div class="modal-content">
        <h3>Apply for <span id="modalJobTitle"></span></h3>
        <div class="form-group" style="margin-top: 15px">
          <label>Cover Letter</label>
          <textarea
            rows="4"
            id="coverLetter"
            placeholder="Tell us why you're a good fit..."
            style="
              width: 100%;
              padding: 10px;
              border-radius: 8px;
              border: 1px solid #ddd;
            "
          ></textarea>
        </div>
        <div style="margin-top: 20px">
          <button class="btn-primary" onclick="submitApplication()">
            Submit Application
          </button>
          <button class="btn-secondary" onclick="closeModal()">Cancel</button>
        </div>
      </div>
    </div>

    <script>
      // ===== SECTION SWITCHING =====
      document.querySelectorAll(".sidebar-menu a").forEach((link) => {
        link.addEventListener("click", function (e) {
          const sectionName = this.getAttribute("data-section");
          if (sectionName) {
            e.preventDefault();
            document
              .querySelectorAll(".sidebar-menu a")
              .forEach((a) => a.classList.remove("active"));
            this.classList.add("active");
            document
              .querySelectorAll(".dashboard-section")
              .forEach((section) => section.classList.remove("active"));
            document
              .getElementById(sectionName + "Section")
              .classList.add("active");
          }
        });
      });

      // ===== PROFILE FUNCTIONS =====
      function toggleEditForm() {
        const form = document.getElementById("editProfileForm");
        form.classList.toggle("show");
      }

      function saveProfile() {
        document.getElementById("displayFullName").innerText =
          document.getElementById("editFullName").value;
        document.getElementById("displayPhone").innerText =
          document.getElementById("editPhone").value;
        document.getElementById("displayDob").innerText =
          document.getElementById("editDob").value;
        document.getElementById("displayLocation").innerText =
          document.getElementById("editLocation").value;
        document.getElementById("displayEducation").innerText =
          document.getElementById("editEducation").value;

        const skills = document.getElementById("editSkills").value.split(",");
        const skillsHtml = skills
          .map((s) => `<span class="skill-tag">${s.trim()}</span>`)
          .join("");
        document.getElementById("displaySkills").innerHTML = skillsHtml;

        toggleEditForm();
        showAlert("Profile updated successfully!", "success");
      }

      function changePassword() {
        const current = document.getElementById("currentPassword").value;
        const newPass = document.getElementById("newPassword").value;
        const confirm = document.getElementById("confirmPassword").value;

        if (!current || !newPass || !confirm) {
          showAlert("Please fill all password fields!", "error");
          return;
        }

        if (newPass !== confirm) {
          showAlert("New password and confirm password do not match!", "error");
          return;
        }

        if (newPass.length < 6) {
          showAlert("Password must be at least 6 characters!", "error");
          return;
        }

        showAlert("Password changed successfully!", "success");
        document.getElementById("currentPassword").value = "";
        document.getElementById("newPassword").value = "";
        document.getElementById("confirmPassword").value = "";
      }

      // ===== APPLICATIONS FUNCTIONS =====
      function viewApplication(jobTitle) {
        showAlert(`Viewing application for: ${jobTitle}`, "success");
      }

      // ===== SAVED JOBS FUNCTIONS =====
      function removeSavedJob(button) {
        if (confirm("Remove this job from saved list?")) {
          button.closest(".job-card").remove();
          showAlert("Job removed from saved list!", "success");
        }
      }

      function saveJob(button) {
        showAlert("Job saved successfully!", "success");
        button.innerHTML = '<i class="fas fa-check"></i> Saved';
        button.disabled = true;
      }

      // ===== APPLY FUNCTIONS =====
      let currentJob = "";

      function applyNow(jobTitle) {
        currentJob = jobTitle;
        document.getElementById("modalJobTitle").innerText = jobTitle;
        document.getElementById("applyModal").classList.add("show");
      }

      function submitApplication() {
        const coverLetter = document.getElementById("coverLetter").value;
        if (!coverLetter) {
          showAlert("Please write a cover letter!", "error");
          return;
        }
        showAlert(`Application submitted for ${currentJob}!`, "success");
        closeModal();
        document.getElementById("coverLetter").value = "";
      }

      function closeModal() {
        document.getElementById("applyModal").classList.remove("show");
      }

      // ===== SEARCH JOBS =====
      function searchJobs() {
        const keyword = document.getElementById("searchKeyword").value;
        const category = document.getElementById("categoryFilter").value;
        showAlert(
          `Searching for: ${keyword} in ${category || "all categories"}`,
          "success",
        );
      }

      // ===== PAGINATION =====
      function prevPage(section) {
        showAlert("Previous page", "success");
      }

      function nextPage(section) {
        showAlert("Next page", "success");
      }

      function changePage(page) {
        showAlert(`Page ${page}`, "success");
      }

      // ===== ALERT FUNCTION (FIXED) =====
      function showAlert(message, type) {
        const alert = document.createElement("div");
        alert.className = `alert alert-${type}`;
        // Fixed: Calculate icon name outside template literal to avoid EL parsing
        const icon = type === "success" ? "check-circle" : "exclamation-circle";
        alert.innerHTML = `<i class="fas fa-${icon}"></i> ${message}`;
        document.body.appendChild(alert);

        setTimeout(() => {
          alert.remove();
        }, 3000);
      }

      // ===== LOGOUT =====
      function logout() {
        if (confirm("Are you sure you want to logout?")) {
          window.location.href = "${pageContext.request.contextPath}/login";
        }
      }

      // Close modal on outside click
      window.onclick = function (event) {
        const modal = document.getElementById("applyModal");
        if (event.target === modal) {
          closeModal();
        }
      };
    </script>
  </body>
</html>
