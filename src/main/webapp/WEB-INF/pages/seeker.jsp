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
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Poppins", sans-serif;
      }

      :root {
        --primary-blue: #1a3c6e;
        --accent-orange: #f4a623;
        --neutral-grey: #76777b;
        --soft-bg: #f2f2f2;
        --main-bg: #e9e9eb;
        --white: #ffffff;
        --radius: 12px;
      }

      body {
        background-color: var(--main-bg);
      }

      /* Header */
      .dashboard-header {
        background-color: var(--primary-blue);
        color: white;
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      }

      .logo h2 {
        font-size: 1.3rem;
      }

      .logo span {
        color: var(--accent-orange);
      }

      .user-info {
        display: flex;
        align-items: center;
        gap: 20px;
      }

      .user-name {
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .logout-btn {
        background-color: rgba(255, 255, 255, 0.2);
        color: white;
        padding: 8px 16px;
        border-radius: 8px;
        text-decoration: none;
        font-size: 0.85rem;
        transition: background-color 0.2s;
      }

      .logout-btn:hover {
        background-color: rgba(255, 255, 255, 0.3);
      }

      /* Container */
      .dashboard-container {
        display: flex;
        margin-top: 70px;
        min-height: calc(100vh - 70px);
      }

      /* Sidebar */
      .dashboard-sidebar {
        width: 260px;
        background-color: var(--white);
        border-right: 1px solid #e0e0e0;
        position: fixed;
        height: calc(100vh - 70px);
        overflow-y: auto;
        box-shadow: 2px 0 8px rgba(0, 0, 0, 0.05);
      }

      .sidebar-menu {
        list-style: none;
        padding: 20px 0;
      }

      .sidebar-menu li {
        margin: 5px 0;
      }

      .sidebar-menu a {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 24px;
        color: #555;
        text-decoration: none;
        font-size: 0.9rem;
        font-weight: 500;
        transition: all 0.2s;
        border-left: 3px solid transparent;
      }

      .sidebar-menu a:hover {
        background-color: var(--soft-bg);
        color: var(--primary-blue);
      }

      .sidebar-menu a.active {
        background-color: rgba(26, 60, 110, 0.08);
        color: var(--primary-blue);
        border-left-color: var(--primary-blue);
      }

      .sidebar-menu i {
        width: 20px;
      }

      /* Main Content */
      .dashboard-main {
        margin-left: 260px;
        flex: 1;
        padding: 30px;
      }

      /* Sections */
      .dashboard-section {
        display: none;
        animation: fadeIn 0.3s ease;
      }

      .dashboard-section.active {
        display: block;
      }

      @keyframes fadeIn {
        from {
          opacity: 0;
          transform: translateY(10px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      .section-title {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--primary-blue);
        margin-bottom: 25px;
      }

      /* Cards */
      .card {
        background-color: var(--white);
        border-radius: var(--radius);
        padding: 25px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        margin-bottom: 25px;
      }

      .profile-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
      }

      .profile-field {
        margin-bottom: 15px;
      }

      .profile-field label {
        font-size: 0.8rem;
        color: var(--neutral-grey);
        display: block;
        margin-bottom: 5px;
      }

      .profile-field .value {
        font-size: 1rem;
        font-weight: 500;
        color: #333;
      }

      .skills-list {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        margin-top: 5px;
      }

      .skill-tag {
        background-color: var(--soft-bg);
        color: var(--primary-blue);
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 0.8rem;
      }

      /* Edit Profile Form */
      .edit-form {
        display: none;
        margin-top: 20px;
        padding-top: 20px;
        border-top: 1px solid #e0e0e0;
      }

      .edit-form.show {
        display: block;
      }

      .form-group {
        margin-bottom: 15px;
      }

      .form-group label {
        display: block;
        font-size: 0.85rem;
        font-weight: 500;
        margin-bottom: 5px;
        color: #333;
      }

      .form-group input,
      .form-group select,
      .form-group textarea {
        width: 100%;
        padding: 10px 12px;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 0.9rem;
        outline: none;
        transition: border-color 0.2s;
      }

      .form-group input:focus,
      .form-group select:focus,
      .form-group textarea:focus {
        border-color: var(--primary-blue);
      }

      .btn-primary {
        background-color: var(--primary-blue);
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.2s;
      }

      .btn-primary:hover {
        background-color: #0f2a4d;
      }

      .btn-secondary {
        background-color: var(--soft-bg);
        color: #333;
        border: none;
        padding: 10px 20px;
        border-radius: 8px;
        font-weight: 500;
        cursor: pointer;
        margin-left: 10px;
      }

      /* Password Change */
      .password-card {
        background-color: var(--white);
        border-radius: var(--radius);
        padding: 25px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
      }

      .password-card h3 {
        font-size: 1.2rem;
        margin-bottom: 20px;
        color: var(--primary-blue);
      }

      /* Tables */
      .table-wrapper {
        overflow-x: auto;
      }

      .data-table {
        width: 100%;
        border-collapse: collapse;
      }

      .data-table th,
      .data-table td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #e8e8e8;
      }

      .data-table th {
        background-color: #f8f8f8;
        font-weight: 600;
        color: #555;
      }

      .data-table tr:hover {
        background-color: #fafafa;
      }

      /* Status Badges */
      .status-badge {
        display: inline-block;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: 600;
      }

      .status-pending {
        background-color: #fff3cd;
        color: #856404;
      }

      .status-accepted {
        background-color: #d4edda;
        color: #155724;
      }

      .status-rejected {
        background-color: #f8d7da;
        color: #721c24;
      }

      /* Job Cards for Saved Jobs */
      .saved-jobs-grid {
        display: flex;
        flex-direction: column;
        gap: 15px;
      }

      .job-card {
        background-color: var(--white);
        border-radius: var(--radius);
        padding: 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
      }

      .job-info h4 {
        font-size: 1.1rem;
        font-weight: 600;
        color: #333;
        margin-bottom: 5px;
      }

      .job-info p {
        font-size: 0.85rem;
        color: var(--neutral-grey);
        margin: 3px 0;
      }

      .job-category {
        display: inline-block;
        background-color: var(--soft-bg);
        color: var(--primary-blue);
        padding: 2px 10px;
        border-radius: 15px;
        font-size: 0.75rem;
        margin-top: 5px;
      }

      .job-actions {
        display: flex;
        gap: 10px;
      }

      .btn-remove {
        background-color: #f8d7da;
        color: #721c24;
        border: none;
        padding: 8px 16px;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 500;
      }

      .btn-apply {
        background-color: var(--primary-blue);
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 500;
      }

      /* Pagination */
      .pagination {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-top: 25px;
      }

      .page-btn {
        background-color: var(--white);
        border: 1px solid #ddd;
        padding: 8px 15px;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.2s;
      }

      .page-btn.active {
        background-color: var(--primary-blue);
        color: white;
        border-color: var(--primary-blue);
      }

      .page-btn:hover:not(.active) {
        border-color: var(--primary-blue);
        color: var(--primary-blue);
      }

      /* Alert */
      .alert {
        position: fixed;
        top: 80px;
        right: 20px;
        padding: 15px 20px;
        border-radius: 8px;
        color: white;
        z-index: 2000;
        animation: slideIn 0.3s ease;
      }

      .alert-success {
        background-color: #16a34a;
      }

      .alert-error {
        background-color: #dc2626;
      }

      @keyframes slideIn {
        from {
          right: -300px;
          opacity: 0;
        }
        to {
          right: 20px;
          opacity: 1;
        }
      }

      /* Modal */
      .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 2000;
        align-items: center;
        justify-content: center;
      }

      .modal.show {
        display: flex;
      }

      .modal-content {
        background-color: white;
        border-radius: 12px;
        width: 90%;
        max-width: 400px;
        padding: 25px;
        text-align: center;
      }

      /* Responsive */
      @media (max-width: 768px) {
        .dashboard-sidebar {
          width: 200px;
        }
        .dashboard-main {
          margin-left: 200px;
        }
        .profile-grid {
          grid-template-columns: 1fr;
        }
        .job-card {
          flex-direction: column;
          text-align: center;
          gap: 15px;
        }
      }

      @media (max-width: 576px) {
        .dashboard-sidebar {
          display: none;
        }
        .dashboard-main {
          margin-left: 0;
        }
      }
    </style>
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
