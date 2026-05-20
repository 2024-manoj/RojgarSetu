package com.demo.controller;

import com.demo.filter.AdminAuth;
import com.demo.dao.UserDao;
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

/**
 * Servlet that handles the Admin profile page.
 * Displays the admin's personal information on GET and processes
 * profile update form submissions on POST.
 *
 * @author Manoj Katuwal
 */
@WebServlet("/admin/profile")
public class AdminProfileServlet extends HttpServlet {

    /**
     * Loads the admin user's profile and renders the profile page.
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
        Integer userId = SessionUtils.requireUserId(req, resp);
        if (userId == null) return;

        SessionUtils.consumeFlash(req, "flashSuccess", "flashError");
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

    /**
     * Processes the admin profile update form submission.
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
        Integer userId = SessionUtils.requireUserId(req, resp);
        if (userId == null) return;

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
                    SessionUtils.updateSessionUser(req, refreshed);
                }
                SessionUtils.setFlashSuccess(req, "flashSuccess", "Profile updated.");
            } else {
                SessionUtils.setFlashError(req, "flashError", "Could not update profile.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            SessionUtils.setFlashError(req, "flashError", "An error occurred.");
        }
        resp.sendRedirect(req.getContextPath() + "/admin/profile");
    }
}
