<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Dashboard — RojgarSetu</title>
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
      .admin-header-bar {
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
        margin: 0;
      }

      .logo span {
        color: var(--accent-orange);
      }

      .header-right {
        display: flex;
        align-items: center;
        gap: 20px;
      }

      .admin-name {
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

      /* ===== CONTAINER ===== */
      .admin-container {
        display: flex;
        margin-top: 70px;
        min-height: calc(100vh - 70px);
      }

      /* ===== SIDEBAR STYLES ===== */
      .admin-sidebar {
        width: 260px;
        background-color: var(--white);
        border-right: 1px solid #e0e0e0;
        padding: 20px 0;
        position: fixed;
        height: calc(100vh - 70px);
        overflow-y: auto;
        box-shadow: 2px 0 8px rgba(0, 0, 0, 0.05);
      }

      .sidebar-menu {
        list-style: none;
        padding: 0;
        margin: 0;
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
        transition: all 0.2s ease;
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
        font-size: 1rem;
      }

      /* ===== MAIN CONTENT ===== */
      .admin-main {
        margin-left: 260px;
        flex: 1;
        padding: 30px;
      }

      /* ===== STATS CARDS ===== */
      .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
      }

      .stat-card {
        background-color: var(--white);
        padding: 25px;
        border-radius: var(--radius);
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        border-left: 4px solid var(--primary-blue);
        transition: transform 0.2s;
      }

      .stat-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
      }

      .stat-card h3 {
        font-size: 0.85rem;
        font-weight: 500;
        color: var(--neutral-grey);
        margin: 0 0 10px 0;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      .stat-card .stat-number {
        font-size: 2.2rem;
        font-weight: 700;
        color: var(--primary-blue);
        margin: 0;
      }

      /* ===== SECTION STYLES ===== */
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

      .section-card {
        background-color: var(--white);
        border-radius: var(--radius);
        padding: 25px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        margin-bottom: 30px;
      }

      .section-title {
        font-size: 1.2rem;
        font-weight: 600;
        color: var(--primary-blue);
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
      }

      /* ===== TABLES ===== */
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
        font-size: 0.85rem;
      }

      .data-table td {
        font-size: 0.85rem;
        color: #444;
      }

      .data-table tr:hover {
        background-color: #fafafa;
      }

      /* ===== STATUS BADGES ===== */
      .status-badge {
        display: inline-block;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 0.7rem;
        font-weight: 600;
      }

      .status-pending {
        background-color: #fff3cd;
        color: #856404;
      }

      .status-active,
      .status-approved {
        background-color: #d4edda;
        color: #155724;
      }

      .status-rejected {
        background-color: #f8d7da;
        color: #721c24;
      }

      /* ===== ACTION BUTTONS ===== */
      .action-btn-sm {
        background: none;
        border: none;
        cursor: pointer;
        padding: 6px;
        border-radius: 6px;
        margin: 0 3px;
        font-size: 0.9rem;
        transition: all 0.2s;
      }

      .action-view {
        color: var(--primary-blue);
      }
      .action-edit {
        color: var(--accent-orange);
      }
      .action-delete {
        color: #dc2626;
      }
      .action-approve {
        color: #16a34a;
      }
      .action-reject {
        color: #dc2626;
      }

      .action-btn-sm:hover {
        background-color: var(--soft-bg);
      }

      /* ===== QUICK ACTIONS ===== */
      .actions-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
      }

      .action-btn {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        padding: 14px;
        background: linear-gradient(135deg, var(--primary-blue), #0f2a4d);
        color: white;
        text-decoration: none;
        border-radius: 10px;
        font-weight: 600;
        font-size: 0.9rem;
        transition: transform 0.2s;
        border: none;
        cursor: pointer;
      }

      .action-btn:hover {
        transform: translateY(-2px);
      }

      /* ===== CATEGORIES LIST ===== */
      .categories-list {
        display: flex;
        flex-direction: column;
        gap: 10px;
      }

      .category-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 15px;
        background-color: var(--soft-bg);
        border-radius: 10px;
      }

      .category-item span i {
        color: var(--primary-blue);
        margin-right: 10px;
      }

      .add-category {
        margin-top: 15px;
        display: flex;
        gap: 10px;
      }

      .add-category input {
        flex: 1;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 8px;
        outline: none;
      }

      .add-category button {
        padding: 10px 20px;
        background-color: var(--primary-blue);
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
      }

      /* ===== PROFILE CARD ===== */
      .profile-card {
        text-align: center;
        padding: 30px;
      }

      .profile-avatar {
        width: 100px;
        height: 100px;
        background-color: rgba(26, 60, 110, 0.1);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 20px;
      }

      .profile-avatar i {
        font-size: 3rem;
        color: var(--primary-blue);
      }

      .profile-info p {
        margin: 10px 0;
      }

      /* ===== MODAL ===== */
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
        max-width: 500px;
        padding: 25px;
      }

      .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
      }

      .modal-close {
        background: none;
        border: none;
        font-size: 1.5rem;
        cursor: pointer;
      }

      /* ===== RESPONSIVE ===== */
      @media (max-width: 768px) {
        .admin-sidebar {
          width: 200px;
        }
        .admin-main {
          margin-left: 200px;
        }
        .stats-grid {
          grid-template-columns: repeat(2, 1fr);
        }
      }

      @media (max-width: 576px) {
        .admin-sidebar {
          display: none;
        }
        .admin-main {
          margin-left: 0;
        }
      }
    </style>
  </head>
  <body>
    <!-- Header Bar -->
    <div class="admin-header-bar">
      <div class="logo">
        <h2>Rojgar<span>Setu</span></h2>
      </div>
      <div class="header-right">
        <div class="admin-name">
          <i class="fas fa-user-shield"></i>
          <span>Admin</span>
        </div>
        <a href="logout" class="logout-btn"
          ><i class="fas fa-sign-out-alt"></i> Logout</a
        >
      </div>
    </div>

    <div class="admin-container">
      <!-- Sidebar -->
      <aside class="admin-sidebar">
        <ul class="sidebar-menu">
          <li>
            <a href="#" data-section="dashboard" class="active"
              ><i class="fas fa-chart-line"></i> Dashboard</a
            >
          </li>
          <li>
            <a href="#" data-section="seekers"
              ><i class="fas fa-users"></i> Manage Job Seekers</a
            >
          </li>
          <li>
            <a href="#" data-section="employers"
              ><i class="fas fa-building"></i> Manage Employers</a
            >
          </li>
          <li>
            <a href="#" data-section="jobs"
              ><i class="fas fa-briefcase"></i> Manage Job Posts</a
            >
          </li>
          <li>
            <a href="#" data-section="categories"
              ><i class="fas fa-list"></i> Manage Job Categories</a
            >
          </li>
          <li>
            <a href="#" data-section="reports"
              ><i class="fas fa-file-csv"></i> Reports</a
            >
          </li>
          <li>
            <a href="#" data-section="profile"
              ><i class="fas fa-user-cog"></i> Admin Profile</a
            >
          </li>
        </ul>
      </aside>

      <!-- Main Content -->
      <main class="admin-main">
        <!-- ===== DASHBOARD SECTION ===== -->
        <div id="dashboardSection" class="dashboard-section active">
          <div class="stats-grid">
            <div class="stat-card">
              <h3>Total Users</h3>
              <p class="stat-number" id="totalUsers">1,234</p>
            </div>
            <div class="stat-card">
              <h3>Total Employers</h3>
              <p class="stat-number" id="totalEmployers">567</p>
            </div>
            <div class="stat-card">
              <h3>Total Jobs</h3>
              <p class="stat-number" id="totalJobs">890</p>
            </div>
            <div class="stat-card">
              <h3>Pending Approvals</h3>
              <p class="stat-number" id="pendingApprovals">12</p>
            </div>
          </div>

          <div class="section-card">
            <h3 class="section-title">
              <i class="fas fa-history"></i> Recent Activity
            </h3>
            <div class="table-wrapper">
              <table class="data-table">
                <thead>
                  <tr>
                    <th>Activity</th>
                    <th>User</th>
                    <th>Date</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody id="recentActivityTable">
                  <tr>
                    <td><i class="fas fa-briefcase"></i> New Job Post</td>
                    <td>Tech Solutions Inc.</td>
                    <td>2023-10-26</td>
                    <td>
                      <span class="status-badge status-pending">Pending</span>
                    </td>
                  </tr>
                  <tr>
                    <td><i class="fas fa-user-plus"></i> New Registration</td>
                    <td>John Doe</td>
                    <td>2023-10-25</td>
                    <td>
                      <span class="status-badge status-active">Active</span>
                    </td>
                  </tr>
                  <tr>
                    <td><i class="fas fa-edit"></i> Profile Update</td>
                    <td>Global Innovations</td>
                    <td>2023-10-24</td>
                    <td>
                      <span class="status-badge status-approved">Approved</span>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <div class="section-card">
            <h3 class="section-title">
              <i class="fas fa-bolt"></i> Quick Actions
            </h3>
            <div class="actions-grid">
              <button
                class="action-btn"
                onclick="showAlert('Approving pending jobs...')"
              >
                <i class="fas fa-check-circle"></i> Approve Pending Jobs
              </button>
              <button
                class="action-btn"
                onclick="showAlert('Viewing all users...')"
              >
                <i class="fas fa-users"></i> View All Users
              </button>
              <button
                class="action-btn"
                onclick="showAlert('Generating report...')"
              >
                <i class="fas fa-file-export"></i> Generate Report
              </button>
            </div>
          </div>
        </div>

        <!-- ===== MANAGE JOB SEEKERS SECTION ===== -->
        <div id="seekersSection" class="dashboard-section">
          <div class="section-card">
            <h3 class="section-title">
              <i class="fas fa-users"></i> Manage Job Seekers
            </h3>
            <div class="table-wrapper">
              <table class="data-table">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Location</th>
                    <th>Status</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody id="seekersTable">
                  <tr>
                    <td>1</td>
                    <td>Rajesh Kumar</td>
                    <td>rajesh@email.com</td>
                    <td>Biratnagar</td>
                    <td>
                      <span class="status-badge status-active">Active</span>
                    </td>
                    <td>
                      <button
                        class="action-btn-sm action-view"
                        onclick="viewItem('Seeker', 'Rajesh Kumar')"
                      >
                        <i class="fas fa-eye"></i></button
                      ><button
                        class="action-btn-sm action-edit"
                        onclick="editItem('Seeker', 'Rajesh Kumar')"
                      >
                        <i class="fas fa-edit"></i></button
                      ><button
                        class="action-btn-sm action-delete"
                        onclick="deleteItem('Seeker', 'Rajesh Kumar')"
                      >
                        <i class="fas fa-trash"></i>
                      </button>
                    </td>
                  </tr>
                  <tr>
                    <td>2</td>
                    <td>Sita Sharma</td>
                    <td>sita@email.com</td>
                    <td>Dharan</td>
                    <td>
                      <span class="status-badge status-active">Active</span>
                    </td>
                    <td>
                      <button
                        class="action-btn-sm action-view"
                        onclick="viewItem('Seeker', 'Sita Sharma')"
                      >
                        <i class="fas fa-eye"></i></button
                      ><button
                        class="action-btn-sm action-edit"
                        onclick="editItem('Seeker', 'Sita Sharma')"
                      >
                        <i class="fas fa-edit"></i></button
                      ><button
                        class="action-btn-sm action-delete"
                        onclick="deleteItem('Seeker', 'Sita Sharma')"
                      >
                        <i class="fas fa-trash"></i>
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <!-- ===== MANAGE EMPLOYERS SECTION ===== -->
        <div id="employersSection" class="dashboard-section">
          <div class="section-card">
            <h3 class="section-title">
              <i class="fas fa-building"></i> Manage Employers
            </h3>
            <div class="table-wrapper">
              <table class="data-table">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Company</th>
                    <th>Email</th>
                    <th>Location</th>
                    <th>Status</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody id="employersTable">
                  <tr>
                    <td>1</td>
                    <td>Tech Solutions Inc.</td>
                    <td>contact@tech.com</td>
                    <td>Kathmandu</td>
                    <td>
                      <span class="status-badge status-approved">Approved</span>
                    </td>
                    <td>
                      <button
                        class="action-btn-sm action-view"
                        onclick="viewItem('Employer', 'Tech Solutions')"
                      >
                        <i class="fas fa-eye"></i></button
                      ><button
                        class="action-btn-sm action-edit"
                        onclick="editItem('Employer', 'Tech Solutions')"
                      >
                        <i class="fas fa-edit"></i></button
                      ><button
                        class="action-btn-sm action-delete"
                        onclick="deleteItem('Employer', 'Tech Solutions')"
                      >
                        <i class="fas fa-trash"></i>
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <!-- ===== MANAGE JOBS SECTION ===== -->
        <div id="jobsSection" class="dashboard-section">
          <div class="section-card">
            <h3 class="section-title">
              <i class="fas fa-briefcase"></i> Manage Job Posts
            </h3>
            <div class="table-wrapper">
              <table class="data-table">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Company</th>
                    <th>Location</th>
                    <th>Status</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody id="jobsTable">
                  <tr>
                    <td>1</td>
                    <td>Software Engineer</td>
                    <td>Tech Solutions</td>
                    <td>Kathmandu</td>
                    <td>
                      <span class="status-badge status-pending">Pending</span>
                    </td>
                    <td>
                      <button
                        class="action-btn-sm action-approve"
                        onclick="approveJob(this)"
                      >
                        <i class="fas fa-check-circle"></i></button
                      ><button
                        class="action-btn-sm action-reject"
                        onclick="rejectJob(this)"
                      >
                        <i class="fas fa-times-circle"></i>
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <!-- ===== MANAGE CATEGORIES SECTION ===== -->
        <div id="categoriesSection" class="dashboard-section">
          <div class="section-card">
            <h3 class="section-title">
              <i class="fas fa-list"></i> Manage Job Categories
            </h3>
            <div class="categories-list" id="categoriesList">
              <div class="category-item">
                <span><i class="fas fa-code"></i> IT</span
                ><button
                  class="action-btn-sm action-delete"
                  onclick="deleteCategory(this)"
                >
                  <i class="fas fa-trash"></i>
                </button>
              </div>
              <div class="category-item">
                <span><i class="fas fa-chart-line"></i> Marketing</span
                ><button
                  class="action-btn-sm action-delete"
                  onclick="deleteCategory(this)"
                >
                  <i class="fas fa-trash"></i>
                </button>
              </div>
              <div class="category-item">
                <span><i class="fas fa-chart-pie"></i> Finance</span
                ><button
                  class="action-btn-sm action-delete"
                  onclick="deleteCategory(this)"
                >
                  <i class="fas fa-trash"></i>
                </button>
              </div>
              <div class="category-item">
                <span><i class="fas fa-users"></i> HR</span
                ><button
                  class="action-btn-sm action-delete"
                  onclick="deleteCategory(this)"
                >
                  <i class="fas fa-trash"></i>
                </button>
              </div>
              <div class="category-item">
                <span><i class="fas fa-chart-simple"></i> Sales</span
                ><button
                  class="action-btn-sm action-delete"
                  onclick="deleteCategory(this)"
                >
                  <i class="fas fa-trash"></i>
                </button>
              </div>
            </div>
            <div class="add-category">
              <input
                type="text"
                id="newCategoryName"
                placeholder="Enter new category name"
              />
              <button onclick="addCategory()">
                <i class="fas fa-plus"></i> Add Category
              </button>
            </div>
          </div>
        </div>

        <!-- ===== REPORTS SECTION ===== -->
        <div id="reportsSection" class="dashboard-section">
          <div class="section-card">
            <h3 class="section-title">
              <i class="fas fa-file-csv"></i> Reports
            </h3>
            <div class="actions-grid">
              <button class="action-btn" onclick="downloadReport('users')">
                <i class="fas fa-file-pdf"></i> Users Report
              </button>
              <button class="action-btn" onclick="downloadReport('jobs')">
                <i class="fas fa-file-excel"></i> Jobs Report
              </button>
              <button
                class="action-btn"
                onclick="downloadReport('applications')"
              >
                <i class="fas fa-chart-bar"></i> Applications Report
              </button>
            </div>
          </div>
        </div>

        <!-- ===== ADMIN PROFILE SECTION ===== -->
        <div id="profileSection" class="dashboard-section">
          <div class="section-card profile-card">
            <div class="profile-avatar">
              <i class="fas fa-user-shield"></i>
            </div>
            <div class="profile-info">
              <p><strong>Full Name:</strong> Admin User</p>
              <p><strong>Email:</strong> admin@rojgarsetu.com</p>
              <p><strong>Role:</strong> Administrator</p>
              <p><strong>Member Since:</strong> 2024-01-01</p>
            </div>
            <button
              class="action-btn"
              style="margin-top: 20px"
              onclick="editProfile()"
            >
              <i class="fas fa-edit"></i> Edit Profile
            </button>
          </div>
        </div>
      </main>
    </div>

    <!-- Modal -->
    <div id="alertModal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3>Alert</h3>
          <button class="modal-close" onclick="closeModal()">&times;</button>
        </div>
        <div class="modal-body">
          <p id="modalMessage"></p>
        </div>
        <div style="margin-top: 20px; text-align: right">
          <button
            class="action-btn"
            style="padding: 8px 20px"
            onclick="closeModal()"
          >
            OK
          </button>
        </div>
      </div>
    </div>

    <script>
      // ===== SECTION SWITCHING =====
      document.querySelectorAll(".sidebar-menu a").forEach((link) => {
        link.addEventListener("click", function (e) {
          e.preventDefault();

          // Remove active class from all links and sections
          document
            .querySelectorAll(".sidebar-menu a")
            .forEach((a) => a.classList.remove("active"));
          document
            .querySelectorAll(".dashboard-section")
            .forEach((section) => section.classList.remove("active"));

          // Add active class to clicked link
          this.classList.add("active");

          // Show corresponding section
          const sectionName = this.getAttribute("data-section");
          document
            .getElementById(sectionName + "Section")
            .classList.add("active");
        });
      });

      // ===== ALERT MODAL =====
      function showAlert(message) {
        document.getElementById("modalMessage").innerText = message;
        document.getElementById("alertModal").classList.add("show");
      }

      function closeModal() {
        document.getElementById("alertModal").classList.remove("show");
      }

      // Close modal when clicking outside
      window.onclick = function (event) {
        const modal = document.getElementById("alertModal");
        if (event.target === modal) {
          closeModal();
        }
      };

      // ===== CRUD FUNCTIONS =====
      function viewItem(type, name) {
        showAlert("Viewing " + type + ": " + name);
      }

      function editItem(type, name) {
        showAlert("Edit " + type + ": " + name);
      }

      function deleteItem(type, name) {
        if (
          confirm("Are you sure you want to delete " + type + ": " + name + "?")
        ) {
          showAlert(type + " deleted successfully!");
        }
      }

      function approveJob(button) {
        if (confirm("Approve this job posting?")) {
          const row = button.closest("tr");
          const statusCell = row.querySelector("td:nth-child(5)");
          statusCell.innerHTML =
            '<span class="status-badge status-approved">Approved</span>';
          showAlert("Job approved successfully!");
        }
      }

      function rejectJob(button) {
        if (confirm("Reject this job posting?")) {
          const row = button.closest("tr");
          const statusCell = row.querySelector("td:nth-child(5)");
          statusCell.innerHTML =
            '<span class="status-badge status-rejected">Rejected</span>';
          showAlert("Job rejected!");
        }
      }

      // ===== CATEGORY MANAGEMENT =====
      function addCategory() {
        const input = document.getElementById("newCategoryName");
        const categoryName = input.value.trim();

        if (categoryName === "") {
          showAlert("Please enter a category name!");
          return;
        }

        const categoriesList = document.getElementById("categoriesList");
        const newCategory = document.createElement("div");
        newCategory.className = "category-item";
        newCategory.innerHTML = `
                <span><i class="fas fa-tag"></i> ${categoryName}</span>
                <button class="action-btn-sm action-delete" onclick="deleteCategory(this)"><i class="fas fa-trash"></i></button>
            `;

        categoriesList.appendChild(newCategory);
        input.value = "";
        showAlert('Category "' + categoryName + '" added successfully!');
      }

      function deleteCategory(button) {
        if (confirm("Are you sure you want to delete this category?")) {
          button.closest(".category-item").remove();
          showAlert("Category deleted successfully!");
        }
      }

      // ===== REPORT DOWNLOAD =====
      function downloadReport(type) {
        let message = "";
        switch (type) {
          case "users":
            message = "Downloading Users Report...";
            break;
          case "jobs":
            message = "Downloading Jobs Report...";
            break;
          case "applications":
            message = "Downloading Applications Report...";
            break;
        }
        showAlert(message);

        // Simulate download after 1 second
        setTimeout(() => {
          showAlert("Report downloaded successfully!");
        }, 1000);
      }

      // ===== PROFILE EDIT =====
      function editProfile() {
        showAlert("Edit profile functionality coming soon!");
      }

      // ===== STATS UPDATE (Simulation) =====
      function updateStats() {
        // You can fetch real stats from server here
        console.log("Stats updated");
      }

      // Load stats on page load
      document.addEventListener("DOMContentLoaded", function () {
        updateStats();
      });
    </script>
  </body>
</html>
