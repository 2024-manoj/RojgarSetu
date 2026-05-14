package com.demo.controller;

import com.demo.controller.util.AdminAuth;
import com.demo.dao.JobDao;
import com.demo.dao.StatsDao;
import com.demo.dao.UserDao;
import com.demo.models.Job;
import com.demo.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!AdminAuth.requireAdmin(req, resp)) {
            return;
        }
        try (Connection conn = DBConnection.getConnection()) {
            UserDao userDao = new UserDao(conn);
            JobDao jobDao = new JobDao(conn);
            StatsDao statsDao = new StatsDao(conn);

            req.setAttribute("totalUsers", statsDao.getTotalUsers());
            req.setAttribute("totalEmployers", statsDao.getTotalEmployers());
            req.setAttribute("totalSeekers", statsDao.getTotalSeekers());
            req.setAttribute("totalJobs", statsDao.getTotalJobs());
            req.setAttribute("pendingApprovals", statsDao.getPendingJobs());
            req.setAttribute("pendingUsers", statsDao.getPendingUsers());
            req.setAttribute("approvedJobs", statsDao.getApprovedJobCount());

            List<Job> pendingJobs = jobDao.getRecentPendingJobs(20);
            req.setAttribute("jobs", pendingJobs);

            // Recent users for dashboard
            java.util.List<com.demo.models.User> allUsers = userDao.getAllUsers();
            java.util.List<com.demo.models.User> recentUsers = allUsers.size() > 5 ? allUsers.subList(0, 5) : allUsers;
            req.setAttribute("recentUsers", recentUsers);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("totalUsers", 0L);
            req.setAttribute("totalEmployers", 0L);
            req.setAttribute("totalSeekers", 0L);
            req.setAttribute("totalJobs", 0L);
            req.setAttribute("pendingApprovals", 0L);
            req.setAttribute("pendingUsers", 0L);
            req.setAttribute("approvedJobs", 0L);
            req.setAttribute("jobs", List.<Job>of());
            req.setAttribute("recentUsers", List.<com.demo.models.User>of());
            req.setAttribute("error", "Could not load dashboard data.");
        }
        req.getRequestDispatcher("/WEB-INF/admin/dashboard.jsp").forward(req, resp);
    }
}
