package com.demo.controller;

import com.demo.filter.AdminAuth;
import com.demo.dao.JobDao;
import com.demo.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/admin/jobs")
public class AdminJobsServlet extends HttpServlet {

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
        HttpSession session = req.getSession(false);
        Integer adminId = session != null ? (Integer) session.getAttribute("userId") : null;
        if (adminId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
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
