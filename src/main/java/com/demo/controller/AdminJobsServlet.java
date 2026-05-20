package com.demo.controller;

import com.demo.filter.AdminAuth;
import com.demo.dao.JobDao;
import com.demo.utils.DBConnection;
import com.demo.utils.SessionUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

/**
 * Servlet that handles the Admin jobs management page.
 * Lists all jobs on GET and processes approve, reject, and delete
 * actions on POST for the job approval workflow.
 *
 * @author Manoj Katuwal
 */
@WebServlet("/admin/jobs")
public class AdminJobsServlet extends HttpServlet {

    /**
     * Loads all jobs and renders the admin jobs management page.
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @throws ServletException if a servlet error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!AdminAuth.requireAdmin(req, resp)) {
            return;
        }
        try (Connection conn = DBConnection.getConnection()) {
            JobDao dao = new JobDao(conn);
            req.setAttribute("jobs", dao.getAllJobs());
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("jobs", java.util.Collections.emptyList());
        }
        req.getRequestDispatcher("/WEB-INF/admin/jobs.jsp").forward(req, resp);
    }

    /**
     * Processes admin job actions (approve, reject, delete).
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @throws IOException if the redirect fails
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (!AdminAuth.requireAdmin(req, resp)) {
            return;
        }
        String action = req.getParameter("action");
        String jobIdParam = req.getParameter("jobId");
        if (jobIdParam == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/jobs");
            return;
        }
        int jobId;
        try {
            jobId = Integer.parseInt(jobIdParam);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/jobs");
            return;
        }
        Integer adminId = SessionUtils.requireUserId(req, resp);
        if (adminId == null) return;
        try (Connection conn = DBConnection.getConnection()) {
            JobDao dao = new JobDao(conn);
            if ("approve".equalsIgnoreCase(action)) {
                dao.approveJob(jobId, adminId);
            } else if ("reject".equalsIgnoreCase(action)) {
                dao.rejectJob(jobId);
            } else if ("delete".equalsIgnoreCase(action)) {
                dao.deleteJob(jobId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        String referer = req.getParameter("from");
        if ("dashboard".equals(referer)) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/jobs");
        }
    }
}
