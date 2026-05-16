package com.demo.filter;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Authentication guard utility for Admin-only routes.
 * Validates that the current session belongs to a user with the ADMIN role.
 * Redirects unauthenticated or unauthorized users to the login page.
 *
 * @author Manoj Katuwal
 */
public final class AdminAuth {
    private AdminAuth() {
    }

    /**
     * Checks if the current request is from an authenticated admin user.
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @return true if the user is an admin, false if redirected to login
     * @throws IOException if the redirect fails
     */
    public static boolean requireAdmin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        Object role = session.getAttribute("userRole");
        if (role == null || !"ADMIN".equalsIgnoreCase(String.valueOf(role))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        return true;
    }
}
