package com.demo.controller;

import com.demo.filter.AdminAuth;
import com.demo.dao.UserDao;
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
 * Servlet that handles the Admin seekers management page.
 * Lists all seekers on GET and processes approve, reject, and delete
 * actions on POST for seeker account management.
 *
 * @author Manoj Katuwal
 */
@WebServlet("/admin/seekers")
public class AdminSeekersServlet extends HttpServlet {

    /**
     * Loads all seeker users and renders the admin seekers page.
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
        loadList(req);
        req.getRequestDispatcher("/WEB-INF/admin/seekers.jsp").forward(req, resp);
    }

    /**
     * Processes admin actions on seeker accounts (approve, reject, delete).
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
        String userIdParam = req.getParameter("userId");
        if (userIdParam == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/seekers");
            return;
        }
        int userId;
        try {
            userId = Integer.parseInt(userIdParam);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/seekers");
            return;
        }
        Integer adminId = SessionUtils.getCurrentUserId(req);
        if ("delete".equalsIgnoreCase(action) && adminId != null && adminId == userId) {
            resp.sendRedirect(req.getContextPath() + "/admin/seekers");
            return;
        }
        try (Connection conn = DBConnection.getConnection()) {
            UserDao dao = new UserDao(conn);
            if ("approve".equalsIgnoreCase(action)) {
                dao.approveUserIfPending(userId, "SEEKER");
            } else if ("reject".equalsIgnoreCase(action)) {
                dao.rejectUserIfPending(userId, "SEEKER");
            } else if ("delete".equalsIgnoreCase(action)) {
                dao.deleteUserWithRole(userId, "SEEKER");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/admin/seekers");
    }

    /**
     * Helper method to load the seekers list into request attributes.
     *
     * @param req the HTTP request
     */
    private void loadList(HttpServletRequest req) {
        try (Connection conn = DBConnection.getConnection()) {
            UserDao dao = new UserDao(conn);
            req.setAttribute("seekers", dao.getAllSeekers());
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("seekers", java.util.Collections.emptyList());
        }
    }
}
