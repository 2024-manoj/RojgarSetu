package com.demo.controller;

import com.demo.controller.util.SeekerAuth;
import com.demo.dao.JobDao;
import com.demo.dao.UserDao;
import com.demo.models.SeekerProfile;
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

@WebServlet("/seeker")
public class SeekerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!SeekerAuth.requireSeeker(req, resp)) {
            return;
        }

        HttpSession session = req.getSession(false);
        Integer userId = session != null ? (Integer) session.getAttribute("userId") : null;
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        if (session != null) {
            Object ok = session.getAttribute("seekerFlashSuccess");
            if (ok != null) {
                req.setAttribute("success", ok);
                session.removeAttribute("seekerFlashSuccess");
            }
            Object err = session.getAttribute("seekerFlashError");
            if (err != null) {
                req.setAttribute("error", err);
                session.removeAttribute("seekerFlashError");
            }
        }

        try (Connection conn = DBConnection.getConnection()) {
            UserDao userDao = new UserDao(conn);
            JobDao jobDao = new JobDao(conn);

            User seekerUser = userDao.getUserById(userId);
            SeekerProfile seekerProfile = userDao.getSeekerProfile(userId);

            req.setAttribute("seekerUser", seekerUser);
            req.setAttribute("seekerProfile", seekerProfile);
            req.setAttribute("openJobsCount", jobDao.getApprovedJobCount());
            if (seekerUser != null && seekerUser.getDob() != null) {
                req.setAttribute("dobString", new SimpleDateFormat("yyyy-MM-dd").format(seekerUser.getDob()));
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("openJobsCount", 0L);
            req.setAttribute("error", "Could not load seeker dashboard.");
        }

        req.getRequestDispatcher("/WEB-INF/seeker/dashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (!SeekerAuth.requireSeeker(req, resp)) {
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
        String education = req.getParameter("education");
        String skills = req.getParameter("skills");
        String addressCity = req.getParameter("addressCity");
        String expStr = req.getParameter("experienceYear");

        if (fullName == null || fullName.isBlank()) {
            session.setAttribute("seekerFlashError", "Full name is required.");
            resp.sendRedirect(req.getContextPath() + "/seeker");
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
            UserDao dao = new UserDao(conn);
            if (!dao.updateUserProfile(user)) {
                session.setAttribute("seekerFlashError", "Could not update account profile.");
                resp.sendRedirect(req.getContextPath() + "/seeker");
                return;
            }
            if (!dao.insertSeekerProfileIfMissing(userId)) {
                session.setAttribute("seekerFlashError", "Could not prepare seeker profile.");
                resp.sendRedirect(req.getContextPath() + "/seeker");
                return;
            }
            SeekerProfile profile = dao.getSeekerProfile(userId);
            if (profile == null) {
                session.setAttribute("seekerFlashError", "Seeker profile not found.");
                resp.sendRedirect(req.getContextPath() + "/seeker");
                return;
            }
            profile.setUserId(userId);
            profile.setEducation(education != null ? education.trim() : "");
            profile.setSkills(skills != null ? skills.trim() : "");
            profile.setAddressCity(addressCity != null && !addressCity.isBlank() ? addressCity.trim() : null);

            int experienceYear = profile.getExperienceYear();
            if (expStr != null && !expStr.isBlank()) {
                try {
                    experienceYear = Math.max(0, Integer.parseInt(expStr.trim()));
                } catch (NumberFormatException ignored) {
                }
            }
            profile.setExperienceYear(experienceYear);

            String resumePath = profile.getResumePath();
            if (req.getParameter("resumePath") != null) {
                String r = req.getParameter("resumePath").trim();
                resumePath = r.isEmpty() ? null : r;
            }
            profile.setResumePath(resumePath);

            if (dao.updateSeekerProfile(profile)) {
                User refreshed = dao.getUserById(userId);
                if (refreshed != null) {
                    session.setAttribute("user", refreshed);
                }
                session.setAttribute("seekerFlashSuccess", "Profile saved.");
            } else {
                session.setAttribute("seekerFlashError", "Could not update seeker details.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("seekerFlashError", "An error occurred while saving.");
        }
        resp.sendRedirect(req.getContextPath() + "/seeker");
    }
}
