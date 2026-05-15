package com.demo.controller;

import com.demo.filter.AdminAuth;
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

@WebServlet("/admin/employers")
public class AdminEmployersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!AdminAuth.requireAdmin(req, resp)) {
            return;
        }
        try (Connection conn = DBConnection.getConnection()) {
            UserDao dao = new UserDao(conn);
            req.setAttribute("employers", dao.getAllEmployers());
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("employers", java.util.Collections.emptyList());
        }
        req.getRequestDispatcher("/WEB-INF/admin/employers.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (!AdminAuth.requireAdmin(req, resp)) {
            return;
        }
        String action = req.getParameter("action");
        String userIdParam = req.getParameter("userId");
        if (userIdParam == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/employers");
            return;
        }
        int userId;
        try {
            userId = Integer.parseInt(userIdParam);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/employers");
            return;
        }
        HttpSession session = req.getSession(false);
        Integer adminId = session != null ? (Integer) session.getAttribute("userId") : null;
        if ("delete".equalsIgnoreCase(action) && adminId != null && adminId == userId) {
            resp.sendRedirect(req.getContextPath() + "/admin/employers");
            return;
        }
        try (Connection conn = DBConnection.getConnection()) {
            UserDao dao = new UserDao(conn);
            if ("approve".equalsIgnoreCase(action)) {
                dao.approveUserIfPending(userId, "EMPLOYER");
            } else if ("reject".equalsIgnoreCase(action)) {
                dao.rejectUserIfPending(userId, "EMPLOYER");
            } else if ("delete".equalsIgnoreCase(action)) {
                dao.deleteUserWithRole(userId, "EMPLOYER");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/admin/employers");
    }
}
