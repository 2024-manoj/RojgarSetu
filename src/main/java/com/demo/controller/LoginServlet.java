package com.demo.controller;

import com.demo.dao.UserDao;
import com.demo.models.User;
import com.demo.utils.CookieUtils;
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
 * Servlet that handles user login authentication.
 * Displays the login form on GET and processes credentials on POST.
 * On successful authentication, creates a session and redirects the user
 * to the appropriate dashboard based on their role (ADMIN, SEEKER, EMPLOYER).
 *
 * @author Manoj Katuwal
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    /**
     * Displays the login page, or redirects already-authenticated users
     * to their respective dashboard.
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @throws ServletException if a servlet error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (SessionUtils.redirectIfLoggedIn(req, resp)) return;

        // Pre-fill email from "Remember Me" cookie
        String rememberedEmail = CookieUtils.getCookieValue(req, "rememberEmail");
        if (rememberedEmail != null) {
            req.setAttribute("rememberedEmail", rememberedEmail);
        }

        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
    }

    /**
     * Authenticates the user with email and password credentials.
     * On success, creates a session and redirects to the role-specific dashboard.
     * On failure, forwards back to the login page with an error message.
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @throws ServletException if a servlet error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String next = req.getParameter("next");

        try (Connection conn = DBConnection.getConnection()) {
            UserDao dao = new UserDao(conn);
            User user = dao.getUserByEmailAndPassword(email, password);

            if (user != null) {
                SessionUtils.createLoginSession(req, user);

                // Handle "Remember Me" cookie
                String remember = req.getParameter("remember");
                if ("on".equals(remember) || "true".equals(remember)) {
                    CookieUtils.addCookie(resp, "rememberEmail", email, 30 * 24 * 60 * 60); // 30 days
                } else {
                    CookieUtils.deleteCookie(resp, "rememberEmail");
                }

                if ("SEEKER".equalsIgnoreCase(user.getRole()) && "browse".equalsIgnoreCase(next)) {
                    resp.sendRedirect(req.getContextPath() + "/seeker?page=browse");
                } else {
                    SessionUtils.redirectToDashboard(req, resp, user.getRole());
                }
            } else {
                req.setAttribute("error", "Invalid email or password!");
                req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "An error occurred during login!");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
        }
    }
}
