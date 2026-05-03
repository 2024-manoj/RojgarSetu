package com.demo.controller;

import com.demo.dao.JobDao;
import com.demo.dao.UserDao;
import com.demo.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Check if user is admin
        Object userRole = session.getAttribute("userRole");
        if (userRole == null || !("ADMIN".equalsIgnoreCase(userRole.toString()))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            Connection conn = DBConnection.getConnection();
            UserDao userDao = new UserDao(conn);
            JobDao jobDao = new JobDao(conn);

            // Load stats
            long totalUsers = userDao.getTotalUsers();
            long totalEmployers = userDao.getTotalEmployers();
            long totalJobs = jobDao.getTotalJobs();
            long pendingApprovals = userDao.getPendingUsers() + jobDao.getPendingJobs();

            req.setAttribute("totalUsers", totalUsers);
            req.setAttribute("totalEmployers", totalEmployers);
            req.setAttribute("totalJobs", totalJobs);
            req.setAttribute("pendingApprovals", pendingApprovals);
            
            // Load lists for tables
            req.setAttribute("seekers", userDao.getAllSeekers());
            req.setAttribute("employers", userDao.getAllEmployers());
            req.setAttribute("jobs", jobDao.getAllJobs());
            
            conn.close();
            
            req.getRequestDispatcher("/WEB-INF/pages/admin.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/login?error=1");
        }
    }
}
