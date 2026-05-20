package com.demo.controller;

import com.demo.filter.EmployerAuth;
import com.demo.dao.ApplicationDao;
import com.demo.dao.EmployerDao;
import com.demo.dao.JobDao;
import com.demo.dao.StatsDao;
import com.demo.dao.UserDao;
import com.demo.models.Application;
import com.demo.models.EmployerProfile;
import com.demo.models.Job;
import com.demo.models.User;
import com.demo.utils.DBConnection;
import com.demo.utils.SessionUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Servlet that handles all Employer dashboard operations.
 * Routes GET requests to dashboard, post-job, my-jobs, applicants,
 * and profile pages. Processes POST actions for job CRUD,
 * application status updates, and profile management.
 *
 * @author Manoj Katuwal
 */
@WebServlet("/employer")
public class EmployerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!EmployerAuth.requireEmployer(req, resp))
            return;

        Integer userId = SessionUtils.requireUserId(req, resp);
        if (userId == null) return;

        SessionUtils.consumeFlash(req, "employerFlashSuccess", "employerFlashError");

        String page = req.getParameter("page");
        if (page == null)
            page = "";

        switch (page) {
            case "postjob":
                handlePostJobPage(req, resp, userId);
                break;
            case "myjobs":
                handleMyJobsPage(req, resp, userId);
                break;
            case "applicants":
                handleApplicantsPage(req, resp, userId);
                break;
            case "profile":
                handleProfilePage(req, resp, userId);
                break;
            default:
                handleDashboardPage(req, resp, userId);
                break;
        }
    }

    private void handleDashboardPage(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            UserDao userDao = new UserDao(conn);
            EmployerDao employerDao = new EmployerDao(conn);
            JobDao jobDao = new JobDao(conn);
            StatsDao statsDao = new StatsDao(conn);
            ApplicationDao appDao = new ApplicationDao(conn);

            req.setAttribute("employerUser", userDao.getUserById(userId));
            req.setAttribute("employerProfile", employerDao.getEmployerProfile(userId));
            req.setAttribute("totalJobsPosted", statsDao.getJobCountByEmployer(userId));
            req.setAttribute("totalApplicants", appDao.getApplicationCountByEmployer(userId));
            req.setAttribute("pendingJobs", statsDao.getPendingJobCountByEmployer(userId));
            req.setAttribute("activeJobs", statsDao.getActiveJobCountByEmployer(userId));
            req.setAttribute("recentJobs", jobDao.getRecentJobsByEmployer(userId, 5));
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("totalJobsPosted", 0L);
            req.setAttribute("totalApplicants", 0L);
            req.setAttribute("pendingJobs", 0L);
            req.setAttribute("activeJobs", 0L);
            req.setAttribute("error", "Could not load employer dashboard.");
        }
        req.getRequestDispatcher("/WEB-INF/employer/dashboard.jsp").forward(req, resp);
    }

    private void handlePostJobPage(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws ServletException, IOException {
        String editId = req.getParameter("editId");
        if (editId != null && !editId.isBlank()) {
            try (Connection conn = DBConnection.getConnection()) {
                JobDao jobDao = new JobDao(conn);
                Job job = jobDao.getJobById(Integer.parseInt(editId.trim()));
                if (job != null && job.getEmployerId() == userId)
                    req.setAttribute("editJob", job);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        req.getRequestDispatcher("/WEB-INF/employer/postjob.jsp").forward(req, resp);
    }

    private void handleMyJobsPage(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            JobDao jobDao = new JobDao(conn);
            req.setAttribute("myJobs", jobDao.getJobsByEmployer(userId));
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Could not load your jobs.");
        }
        req.getRequestDispatcher("/WEB-INF/employer/myjobs.jsp").forward(req, resp);
    }

    private void handleApplicantsPage(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            ApplicationDao appDao = new ApplicationDao(conn);
            req.setAttribute("applications", appDao.getApplicationsForEmployer(userId));
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Could not load applicants.");
        }
        req.getRequestDispatcher("/WEB-INF/employer/applicants.jsp").forward(req, resp);
    }

    private void handleProfilePage(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            UserDao userDao = new UserDao(conn);
            EmployerDao employerDao = new EmployerDao(conn);

            User employerUser = userDao.getUserById(userId);
            req.setAttribute("employerUser", employerUser);
            req.setAttribute("employerProfile", employerDao.getEmployerProfile(userId));
            if (employerUser != null && employerUser.getDob() != null) {
                req.setAttribute("dobString", new SimpleDateFormat("yyyy-MM-dd").format(employerUser.getDob()));
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Could not load profile.");
        }
        req.getRequestDispatcher("/WEB-INF/employer/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        if (!EmployerAuth.requireEmployer(req, resp))
            return;
        Integer userId = SessionUtils.requireUserId(req, resp);
        if (userId == null) return;

        String action = req.getParameter("action");
        if ("postjob".equals(action)) {
            handlePostJob(req, resp, userId);
            return;
        }
        if ("updatejob".equals(action)) {
            handleUpdateJob(req, resp, userId);
            return;
        }
        if ("deletejob".equals(action)) {
            handleDeleteJob(req, resp, userId);
            return;
        }
        if ("updateapplication".equals(action)) {
            handleUpdateApplication(req, resp, userId);
            return;
        }
        handleProfileUpdate(req, resp, userId);
    }

    private void handlePostJob(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws IOException {
        String title = req.getParameter("title");
        if (title == null || title.isBlank()) {
            SessionUtils.setFlashError(req, "employerFlashError", "Job title is required.");
            resp.sendRedirect(req.getContextPath() + "/employer?page=postjob");
            return;
        }
        try (Connection conn = DBConnection.getConnection()) {
            JobDao jobDao = new JobDao(conn);
            Job job = new Job();
            job.setEmployerId(userId);
            job.setTitle(title.trim());
            job.setDescription(param(req, "description"));
            job.setCategory(param(req, "category"));
            job.setLocationCity(param(req, "locationCity"));
            job.setSalaryRange(param(req, "salaryRange"));
            job.setJobType(paramOr(req, "jobType", "Full-time"));
            job.setDeadline(parseDate(req.getParameter("deadline"), 30));
            if (jobDao.createJob(job)) {
                SessionUtils.setFlashSuccess(req, "employerFlashSuccess",
                        "Job posted successfully! It will be visible after admin approval.");
            } else {
                SessionUtils.setFlashError(req, "employerFlashError", "Could not post the job. Try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            SessionUtils.setFlashError(req, "employerFlashError", "Error posting job.");
        }
        resp.sendRedirect(req.getContextPath() + "/employer?page=myjobs");
    }

    private void handleUpdateJob(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws IOException {
        String jobIdStr = req.getParameter("jobId");
        if (jobIdStr == null || jobIdStr.isBlank()) {
            SessionUtils.setFlashError(req, "employerFlashError", "Invalid job.");
            resp.sendRedirect(req.getContextPath() + "/employer?page=myjobs");
            return;
        }
        try (Connection conn = DBConnection.getConnection()) {
            JobDao jobDao = new JobDao(conn);
            Job job = new Job();
            job.setJobId(Integer.parseInt(jobIdStr.trim()));
            job.setEmployerId(userId);
            job.setTitle(param(req, "title"));
            job.setDescription(param(req, "description"));
            job.setCategory(param(req, "category"));
            job.setLocationCity(param(req, "locationCity"));
            job.setSalaryRange(param(req, "salaryRange"));
            job.setJobType(paramOr(req, "jobType", "Full-time"));
            String dl = req.getParameter("deadline");
            if (dl != null && !dl.isBlank()) {
                try {
                    job.setDeadline(java.sql.Date.valueOf(dl.trim()));
                } catch (Exception ignored) {
                }
            }
            if (jobDao.updateJob(job)) {
                SessionUtils.setFlashSuccess(req, "employerFlashSuccess", "Job updated successfully!");
            } else {
                SessionUtils.setFlashError(req, "employerFlashError", "Could not update the job.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            SessionUtils.setFlashError(req, "employerFlashError", "Error updating job.");
        }
        resp.sendRedirect(req.getContextPath() + "/employer?page=myjobs");
    }

    private void handleDeleteJob(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws IOException {
        String jobIdStr = req.getParameter("jobId");
        if (jobIdStr == null || jobIdStr.isBlank()) {
            SessionUtils.setFlashError(req, "employerFlashError", "Invalid job.");
            resp.sendRedirect(req.getContextPath() + "/employer?page=myjobs");
            return;
        }
        try (Connection conn = DBConnection.getConnection()) {
            JobDao jobDao = new JobDao(conn);
            if (jobDao.deleteJobByEmployer(Integer.parseInt(jobIdStr.trim()), userId)) {
                SessionUtils.setFlashSuccess(req, "employerFlashSuccess", "Job deleted successfully.");
            } else {
                SessionUtils.setFlashError(req, "employerFlashError", "Could not delete job.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            SessionUtils.setFlashError(req, "employerFlashError", "Error deleting job.");
        }
        resp.sendRedirect(req.getContextPath() + "/employer?page=myjobs");
    }

    private void handleUpdateApplication(HttpServletRequest req, HttpServletResponse resp,
            int userId) throws IOException {
        String appIdStr = req.getParameter("appId");
        String status = req.getParameter("status");
        if (appIdStr == null || appIdStr.isBlank() || status == null || status.isBlank()) {
            SessionUtils.setFlashError(req, "employerFlashError", "Invalid request.");
            resp.sendRedirect(req.getContextPath() + "/employer?page=applicants");
            return;
        }
        try (Connection conn = DBConnection.getConnection()) {
            ApplicationDao appDao = new ApplicationDao(conn);
            if (appDao.updateApplicationStatus(Integer.parseInt(appIdStr.trim()), status.trim(), userId)) {
                SessionUtils.setFlashSuccess(req, "employerFlashSuccess", "Application status updated.");
            } else {
                SessionUtils.setFlashError(req, "employerFlashError", "Could not update application.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            SessionUtils.setFlashError(req, "employerFlashError", "Error updating application.");
        }
        resp.sendRedirect(req.getContextPath() + "/employer?page=applicants");
    }

    private void handleProfileUpdate(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws IOException {
        String fullName = req.getParameter("fullName");
        if (fullName == null || fullName.isBlank()) {
            SessionUtils.setFlashError(req, "employerFlashError", "Full name is required.");
            resp.sendRedirect(req.getContextPath() + "/employer?page=profile");
            return;
        }
        User user = new User();
        user.setId(userId);
        user.setFullName(fullName.trim());
        user.setPhone(param(req, "phone"));
        user.setLocation(param(req, "location"));
        String dobStr = req.getParameter("dob");
        if (dobStr != null && !dobStr.isBlank()) {
            try {
                user.setDob(new SimpleDateFormat("yyyy-MM-dd").parse(dobStr));
            } catch (Exception ignored) {
            }
        }

        try (Connection conn = DBConnection.getConnection()) {
            UserDao userDao = new UserDao(conn);
            EmployerDao employerDao = new EmployerDao(conn);

            if (!userDao.updateUserProfile(user)) {
                SessionUtils.setFlashError(req, "employerFlashError", "Could not update account profile.");
                resp.sendRedirect(req.getContextPath() + "/employer?page=profile");
                return;
            }
            if (!employerDao.insertEmployerProfileIfMissing(userId)) {
                SessionUtils.setFlashError(req, "employerFlashError", "Could not prepare employer profile.");
                resp.sendRedirect(req.getContextPath() + "/employer?page=profile");
                return;
            }
            EmployerProfile profile = employerDao.getEmployerProfile(userId);
            if (profile == null) {
                SessionUtils.setFlashError(req, "employerFlashError", "Employer profile not found.");
                resp.sendRedirect(req.getContextPath() + "/employer?page=profile");
                return;
            }
            profile.setUserId(userId);
            profile.setCompanyName(param(req, "companyName"));
            profile.setCompanyAddress(param(req, "companyAddress"));
            profile.setCompanyCategory(param(req, "companyCategory"));
            profile.setCompanyCity(param(req, "companyCity"));
            profile.setCompanyDescription(param(req, "companyDescription"));
            profile.setContactPerson(param(req, "contactPerson"));

            if (employerDao.updateEmployerProfile(profile)) {
                User refreshed = userDao.getUserById(userId);
                if (refreshed != null)
                    SessionUtils.updateSessionUser(req, refreshed);
                SessionUtils.setFlashSuccess(req, "employerFlashSuccess", "Profile saved.");
            } else {
                SessionUtils.setFlashError(req, "employerFlashError", "Could not update employer details.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            SessionUtils.setFlashError(req, "employerFlashError", "An error occurred while saving.");
        }
        resp.sendRedirect(req.getContextPath() + "/employer?page=profile");
    }

    private String param(HttpServletRequest req, String name) {
        String v = req.getParameter(name);
        return v != null ? v.trim() : "";
    }

    private String paramOr(HttpServletRequest req, String name, String def) {
        String v = req.getParameter(name);
        return v != null && !v.isBlank() ? v.trim() : def;
    }

    private java.sql.Date parseDate(String s, int defaultDays) {
        if (s != null && !s.isBlank()) {
            try {
                return java.sql.Date.valueOf(s.trim());
            } catch (Exception ignored) {
            }
        }
        return new java.sql.Date(System.currentTimeMillis() + (long) defaultDays * 24 * 60 * 60 * 1000);
    }
}
