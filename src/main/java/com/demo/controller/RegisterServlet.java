package com.demo.controller;

import com.demo.dao.UserDao;
import com.demo.models.EmployerProfile;
import com.demo.models.SeekerProfile;
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

/**
 * Servlet that handles new user registration.
 * Displays the registration form on GET and processes form submission on POST.
 * Creates user accounts with role-specific profiles (Seeker or Employer)
 * and redirects to the login page on success.
 *
 * @author Manoj Katuwal
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    /**
     * Displays the registration page, or redirects already-authenticated
     * users to their respective dashboard.
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @throws ServletException if a servlet error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (SessionUtils.redirectIfLoggedIn(req, resp)) return;
        req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
    }

    /**
     * Processes the registration form submission.
     * Creates a new user and the corresponding role-specific profile,
     * then redirects to login on success or back to register on failure.
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @throws ServletException if a servlet error occurs
     * @throws IOException      if an I/O error occurs
     */
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

            if (result) {
                SessionUtils.setFlashSuccess(req, "success", "Registration Successful! Please login.");
                resp.sendRedirect(req.getContextPath() + "/login");
            } else {
                SessionUtils.setFlashError(req, "error", "Registration Failed!");
                resp.sendRedirect(req.getContextPath() + "/register");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/register?error=2");
        }
    }
}
