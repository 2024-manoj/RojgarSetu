package com.demo.controller;

import com.demo.controller.util.AdminAuth;
import com.demo.dao.UserDao;
import com.demo.models.User;
import com.demo.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;

@WebServlet("/admin/profile")
public class AdminProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!AdminAuth.requireAdmin(req, resp)) {
            return;
        }
        HttpSession session = req.getSession(false);
        Integer userId = session != null ? (Integer) session.getAttribute("userId") : null;
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        if (session != null) {
            Object ok = session.getAttribute("flashSuccess");
            if (ok != null) {
                req.setAttribute("success", ok);
                session.removeAttribute("flashSuccess");
            }
            Object err = session.getAttribute("flashError");
            if (err != null) {
                req.setAttribute("error", err);
                session.removeAttribute("flashError");
            }
        }
        try (Connection conn = DBConnection.getConnection()) {
            UserDao dao = new UserDao(conn);
            User user = dao.getUserById(userId);
            req.setAttribute("adminUser", user);
            if (user != null && user.getDob() != null) {
                req.setAttribute("dobString", new SimpleDateFormat("yyyy-MM-dd").format(user.getDob()));
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Could not load profile.");
        }
        req.getRequestDispatcher("/WEB-INF/admin/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (!AdminAuth.requireAdmin(req, resp)) {
            return;
        }
        HttpSession session = req.getSession(false);
        Integer userId = session != null ? (Integer) session.getAttribute("userId") : null;
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String location = req.getParameter("location");
        String dobStr = req.getParameter("dob");
        User user = new User();
        user.setId(userId);
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setLocation(location);
        if (dobStr != null && !dobStr.isBlank()) {
            try {
                user.setDob(new SimpleDateFormat("yyyy-MM-dd").parse(dobStr));
            } catch (Exception ignored) {
            }
        }
        try (Connection conn = DBConnection.getConnection()) {
            UserDao dao = new UserDao(conn);
            if (dao.updateUserProfile(user)) {
                User refreshed = dao.getUserById(userId);
                if (refreshed != null) {
                    session.setAttribute("user", refreshed);
                    session.setAttribute("adminName", refreshed.getFullName());
                }
                session.setAttribute("flashSuccess", "Profile updated.");
            } else {
                session.setAttribute("flashError", "Could not update profile.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("flashError", "An error occurred.");
        }
        resp.sendRedirect(req.getContextPath() + "/admin/profile");
    }
}
