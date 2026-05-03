package com.demo.controller;

import com.demo.dao.UserDao;
import com.demo.models.EmployerProfile;
import com.demo.models.SeekerProfile;
import com.demo.models.User;
import com.demo.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String role = req.getParameter("role");

        User user = new User();
        user.setFullName(req.getParameter("fullName"));
        user.setEmail(req.getParameter("email"));
        user.setPassword(req.getParameter("password"));
        user.setRole(role);
        user.setLocation(req.getParameter("city"));

        try {
            user.setDob(java.sql.Date.valueOf(req.getParameter("dob")));
        } catch (Exception e) {
            user.setDob(null);
        }

        SeekerProfile seeker = null;
        EmployerProfile employer = null;

        if ("SEEKER".equalsIgnoreCase(role)) {
            seeker = new SeekerProfile();
            seeker.setEducation(req.getParameter("education"));
            seeker.setSkills("");
        } else if ("EMPLOYER".equalsIgnoreCase(role)) {
            employer = new EmployerProfile();
            employer.setCompanyName(req.getParameter("companyName"));
            employer.setCompanyCategory(req.getParameter("industry"));
        }

        try (Connection conn = DBConnection.getConnection()) {
            UserDao dao = new UserDao(conn);
            boolean result = dao.registerUser(user, seeker, employer);

            HttpSession session = req.getSession();
            if (result) {
                session.setAttribute("success", "Registration Successful! Please login.");
                resp.sendRedirect(req.getContextPath() + "/login");
            } else {
                session.setAttribute("error", "Registration Failed!");
                resp.sendRedirect(req.getContextPath() + "/register");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/register?error=2");
        }
    }
}
