package com.demo.controller;

import com.demo.filter.SeekerAuth;
import com.demo.dao.ApplicationDao;
import com.demo.dao.JobDao;
import com.demo.models.Job;
import com.demo.dao.SeekerDao;
import com.demo.dao.StatsDao;
import com.demo.dao.UserDao;
import com.demo.models.Application;
import com.demo.models.Job;
import com.demo.models.SeekerProfile;
import com.demo.models.User;
import com.demo.utils.DBConnection;
import com.demo.utils.SessionUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Set;
import java.util.UUID;

/**
 * Servlet that handles all Seeker dashboard operations.
 * Routes GET requests to dashboard, profile, applications, saved jobs,
 * and browse pages. Processes POST actions for job applications,
 * save/unsave toggles, and profile updates with resume upload.
 *
 * @author Manoj Katuwal
 */
@WebServlet("/seeker")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 8 * 1024 * 1024)
public class SeekerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!SeekerAuth.requireSeeker(req, resp)) {
            return;
        }

        Integer userId = SessionUtils.requireUserId(req, resp);
        if (userId == null) return;

        SessionUtils.consumeFlash(req, "seekerFlashSuccess", "seekerFlashError");

        String page = req.getParameter("page");
        if (page == null)
            page = "";

        switch (page) {
            case "profile":
                handleProfilePage(req, resp, userId);
                break;
            case "applications":
                handleApplicationsPage(req, resp, userId);
                break;
            case "saved":
                handleSavedPage(req, resp, userId);
                break;
            case "browse":
                handleBrowsePage(req, resp, userId);
                break;
            default:
                handleDashboardPage(req, resp, userId);
                break;
        }
    }

    /** Dashboard page — profile + stats */
    private void handleDashboardPage(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            UserDao userDao = new UserDao(conn);
            SeekerDao seekerDao = new SeekerDao(conn);
            StatsDao statsDao = new StatsDao(conn);
            ApplicationDao appDao = new ApplicationDao(conn);

            User seekerUser = userDao.getUserById(userId);
            SeekerProfile seekerProfile = seekerDao.getSeekerProfile(userId);

            req.setAttribute("seekerUser", seekerUser);
            req.setAttribute("seekerProfile", seekerProfile);
            req.setAttribute("openJobsCount", statsDao.getApprovedJobCount());

            req.setAttribute("applicationCount", appDao.getApplicationCountBySeeker(userId));

            req.setAttribute("savedJobsCount", seekerDao.getSavedJobCount(userId));

            if (seekerUser != null && seekerUser.getDob() != null) {
                req.setAttribute("dobString", new SimpleDateFormat("yyyy-MM-dd").format(seekerUser.getDob()));
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("openJobsCount", 0L);
            req.setAttribute("applicationCount", 0L);
            req.setAttribute("error", "Could not load seeker dashboard.");
        }

        req.getRequestDispatcher("/WEB-INF/seeker/dashboard.jsp").forward(req, resp);
    }

    /** Edit Profile page — shows profile form only */
    private void handleProfilePage(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            UserDao userDao = new UserDao(conn);
            SeekerDao seekerDao = new SeekerDao(conn);

            User seekerUser = userDao.getUserById(userId);
            SeekerProfile seekerProfile = seekerDao.getSeekerProfile(userId);

            req.setAttribute("seekerUser", seekerUser);
            req.setAttribute("seekerProfile", seekerProfile);

            if (seekerUser != null && seekerUser.getDob() != null) {
                req.setAttribute("dobString", new SimpleDateFormat("yyyy-MM-dd").format(seekerUser.getDob()));
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Could not load profile.");
        }

        req.getRequestDispatcher("/WEB-INF/seeker/profile.jsp").forward(req, resp);
    }

    /** My Applications page */
    private void handleApplicationsPage(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            ApplicationDao appDao = new ApplicationDao(conn);
            List<Application> apps = appDao.getApplicationsBySeeker(userId);
            req.setAttribute("applications", apps);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Could not load applications.");
        }

        req.getRequestDispatcher("/WEB-INF/seeker/applications.jsp").forward(req, resp);
    }

    /** Saved Jobs page — shows jobs saved by this seeker */
    private void handleSavedPage(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            SeekerDao seekerDao = new SeekerDao(conn);
            List<Job> savedJobs = seekerDao.getSavedJobs(userId);
            req.setAttribute("savedJobs", savedJobs);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Could not load saved jobs.");
        }
        req.getRequestDispatcher("/WEB-INF/seeker/saved.jsp").forward(req, resp);
    }

    /** Browse Jobs page — shows all approved jobs with saved state */
    private void handleBrowsePage(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            JobDao jobDao = new JobDao(conn);
            SeekerDao seekerDao = new SeekerDao(conn);
            List<Job> jobs = jobDao.getApprovedJobs();
            Set<Integer> savedJobIds = seekerDao.getSavedJobIds(userId);
            req.setAttribute("jobs", jobs);
            req.setAttribute("savedJobIds", savedJobIds);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Could not load jobs.");
        }

        req.getRequestDispatcher("/WEB-INF/seeker/browse.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        if (!SeekerAuth.requireSeeker(req, resp)) {
            return;
        }
        Integer userId = SessionUtils.requireUserId(req, resp);
        if (userId == null) return;

        String action = req.getParameter("action");

        if ("apply".equals(action)) {
            handleApply(req, resp, userId);
            return;
        }

        if ("saveJob".equals(action) || "unsaveJob".equals(action)) {
            handleSaveToggle(req, resp, userId, action);
            return;
        }

        handleProfileUpdate(req, resp, userId);
    }

    /** Apply to a job */
    private void handleApply(HttpServletRequest req, HttpServletResponse resp,
            int userId) throws IOException, ServletException {
        String jobIdStr = req.getParameter("jobId");
        String coverLetter = req.getParameter("coverLetter");
        String resumePath = null;

        if (jobIdStr == null || jobIdStr.isBlank()) {
            SessionUtils.setFlashError(req, "seekerFlashError", "Invalid job.");
            resp.sendRedirect(req.getContextPath() + "/seeker?page=browse");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            ApplicationDao appDao = new ApplicationDao(conn);
            SeekerDao seekerDao = new SeekerDao(conn);
            int jobId = Integer.parseInt(jobIdStr.trim());

            if (appDao.hasApplied(userId, jobId)) {
                SessionUtils.setFlashError(req, "seekerFlashError", "You have already applied to this job.");
                resp.sendRedirect(req.getContextPath() + "/seeker?page=browse");
                return;
            }

            resumePath = savePdfUpload(req.getPart("resumeFile"), userId, "application");
            if (resumePath == null) {
                SeekerProfile profile = seekerDao.getSeekerProfile(userId);
                resumePath = profile != null ? profile.getResumePath() : null;
            }

            Application app = new Application();
            app.setSeekerId(userId);
            app.setJobId(jobId);
            app.setCoverLetter(coverLetter != null ? coverLetter.trim() : "");
            app.setResumePath(resumePath);
            app.setStatus("pending");

            if (appDao.createApplication(app)) {
                SessionUtils.setFlashSuccess(req, "seekerFlashSuccess", "Applied successfully!");
            } else {
                SessionUtils.setFlashError(req, "seekerFlashError", "Could not apply. Try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            SessionUtils.setFlashError(req, "seekerFlashError", "Error applying to job.");
        }

        resp.sendRedirect(req.getContextPath() + "/seeker?page=browse");
    }

    /** Save or unsave a job */
    private void handleSaveToggle(HttpServletRequest req, HttpServletResponse resp,
            int userId, String action) throws IOException {
        String jobIdStr = req.getParameter("jobId");
        String from = req.getParameter("from");
        boolean isAjax = "true".equals(req.getParameter("ajax"));

        if (jobIdStr == null || jobIdStr.isBlank()) {
            if (isAjax) {
                resp.setContentType("text/plain");
                resp.getWriter().write("error");
                return;
            }
            SessionUtils.setFlashError(req, "seekerFlashError", "Invalid job.");
            resp.sendRedirect(req.getContextPath() + "/seeker?page=browse");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            SeekerDao seekerDao = new SeekerDao(conn);
            int jobId = Integer.parseInt(jobIdStr.trim());

            if ("saveJob".equals(action)) {
                seekerDao.saveJob(userId, jobId);
            } else {
                seekerDao.unsaveJob(userId, jobId);
            }

            if (isAjax) {
                resp.setContentType("text/plain");
                resp.getWriter().write("ok");
                return;
            }

            SessionUtils.setFlashSuccess(req, "seekerFlashSuccess",
                    "saveJob".equals(action) ? "Job saved!" : "Job removed from saved.");
        } catch (Exception e) {
            e.printStackTrace();
            if (isAjax) {
                resp.setContentType("text/plain");
                resp.getWriter().write("error");
                return;
            }
            SessionUtils.setFlashError(req, "seekerFlashError", "Could not update saved jobs.");
        }

        String redirectPage = "saved".equals(from) ? "saved" : "browse";
        resp.sendRedirect(req.getContextPath() + "/seeker?page=" + redirectPage);
    }

    /** Update seeker profile */
    private void handleProfileUpdate(HttpServletRequest req, HttpServletResponse resp,
            int userId) throws IOException, ServletException {
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String location = req.getParameter("location");
        String dobStr = req.getParameter("dob");
        String education = req.getParameter("education");
        String skills = req.getParameter("skills");
        String addressCity = req.getParameter("addressCity");
        String expStr = req.getParameter("experienceYear");
        String uploadedResumePath = null;

        if (fullName == null || fullName.isBlank()) {
            SessionUtils.setFlashError(req, "seekerFlashError", "Full name is required.");
            resp.sendRedirect(req.getContextPath() + "/seeker?page=profile");
            return;
        }

        User user = new User();
        user.setId(userId);
        user.setFullName(fullName.trim());
        user.setPhone(phone != null ? phone.trim() : null);
        user.setLocation(location != null ? location.trim() : null);
        if (dobStr != null && !dobStr.isBlank()) {
            try {
                user.setDob(new SimpleDateFormat("yyyy-MM-dd").parse(dobStr));
            } catch (Exception ignored) {
            }
        }

        try (Connection conn = DBConnection.getConnection()) {
            UserDao userDao = new UserDao(conn);
            SeekerDao seekerDao = new SeekerDao(conn);
            User existingUser = userDao.getUserById(userId);

            if (existingUser != null && existingUser.getDob() != null && dobStr == null) {
                user.setDob(existingUser.getDob());
            }
            if (!userDao.updateUserProfile(user)) {
                SessionUtils.setFlashError(req, "seekerFlashError", "Could not update account profile.");
                resp.sendRedirect(req.getContextPath() + "/seeker?page=profile");
                return;
            }
            if (!seekerDao.insertSeekerProfileIfMissing(userId)) {
                SessionUtils.setFlashError(req, "seekerFlashError", "Could not prepare seeker profile.");
                resp.sendRedirect(req.getContextPath() + "/seeker?page=profile");
                return;
            }
            SeekerProfile profile = seekerDao.getSeekerProfile(userId);
            if (profile == null) {
                SessionUtils.setFlashError(req, "seekerFlashError", "Seeker profile not found.");
                resp.sendRedirect(req.getContextPath() + "/seeker?page=profile");
                return;
            }
            profile.setUserId(userId);
            profile.setEducation(education != null ? education.trim() : "");
            profile.setSkills(skills != null ? skills.trim() : "");
            if (addressCity != null) {
                profile.setAddressCity(!addressCity.isBlank() ? addressCity.trim() : null);
            }

            int experienceYear = profile.getExperienceYear();
            if (expStr != null && !expStr.isBlank()) {
                try {
                    experienceYear = Math.max(0, Integer.parseInt(expStr.trim()));
                } catch (NumberFormatException ignored) {
                }
            }
            profile.setExperienceYear(experienceYear);

            String resumePath = profile.getResumePath();
            uploadedResumePath = savePdfUpload(req.getPart("resumeFile"), userId, "profile");
            if (uploadedResumePath != null) {
                resumePath = uploadedResumePath;
            } else if (req.getParameter("resumePath") != null) {
                String r = req.getParameter("resumePath").trim();
                resumePath = r.isEmpty() ? null : r;
            }
            profile.setResumePath(resumePath);

            if (seekerDao.updateSeekerProfile(profile)) {
                User refreshed = userDao.getUserById(userId);
                if (refreshed != null) {
                    SessionUtils.updateSessionUser(req, refreshed);
                }
                SessionUtils.setFlashSuccess(req, "seekerFlashSuccess", "Profile saved.");
            } else {
                SessionUtils.setFlashError(req, "seekerFlashError", "Could not update seeker details.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            SessionUtils.setFlashError(req, "seekerFlashError", "An error occurred while saving.");
        }
        resp.sendRedirect(req.getContextPath() + "/seeker?page=profile");
    }

    private String savePdfUpload(Part part, int userId, String prefix) throws IOException {
        if (part == null || part.getSize() == 0) {
            return null;
        }

        String submitted = part.getSubmittedFileName();
        String lowerName = submitted != null ? submitted.toLowerCase() : "";
        String contentType = part.getContentType() != null ? part.getContentType().toLowerCase() : "";
        if (!lowerName.endsWith(".pdf") && !"application/pdf".equals(contentType)) {
            throw new IOException("Only PDF resume files are allowed.");
        }

        String uploadRoot = getServletContext().getRealPath("/uploads/resumes");
        if (uploadRoot == null) {
            uploadRoot = System.getProperty("java.io.tmpdir") + File.separator + "rojgarsetu-resumes";
        }

        File uploadDir = new File(uploadRoot);
        if (!uploadDir.exists() && !uploadDir.mkdirs()) {
            throw new IOException("Could not create resume upload folder.");
        }

        String fileName = prefix + "-user-" + userId + "-" + UUID.randomUUID() + ".pdf";
        File destination = new File(uploadDir, fileName);
        part.write(destination.getAbsolutePath());
        return "/uploads/resumes/" + fileName;
    }
}
