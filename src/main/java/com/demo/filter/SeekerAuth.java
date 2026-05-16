package com.demo.filter;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Authentication guard utility for Seeker-only routes.
 * Validates that the current session belongs to a user with the SEEKER role.
 * Redirects unauthenticated or unauthorized users to the login page.
 *
 * @author Manoj Katuwal
 */
public final class SeekerAuth {
    private SeekerAuth() {
    }

    /**
     * Checks if the current request is from an authenticated seeker user.
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @return true if the user is a seeker, false if redirected to login
     * @throws IOException if the redirect fails
     */
    public static boolean requireSeeker(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        Object role = session.getAttribute("userRole");
        if (role == null || !"SEEKER".equalsIgnoreCase(String.valueOf(role))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        return true;
    }
}
