package com.demo.controller;

import com.demo.controller.util.AdminAuth;
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

@WebServlet("/admin/seekers")
public class AdminSeekersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!AdminAuth.requireAdmin(req, resp)) {
            return;
        }
        loadList(req);
        req.getRequestDispatcher("/WEB-INF/admin/seekers.jsp").forward(req, resp);
    }

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
        HttpSession session = req.getSession(false);
        Integer adminId = session != null ? (Integer) session.getAttribute("userId") : null;
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
