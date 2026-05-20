package com.demo.filter;

import com.demo.utils.SessionUtils;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Authentication guard utility for Employer-only routes.
 * Validates that the current session belongs to a user with the EMPLOYER role.
 * Redirects unauthenticated or unauthorized users to the login page.
 *
 * @author Manoj Katuwal
 */
public final class EmployerAuth {
    private EmployerAuth() {
    }

    /**
     * Checks if the current request is from an authenticated employer user.
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @return true if the user is an employer, false if redirected to login
     * @throws IOException if the redirect fails
     */
    public static boolean requireEmployer(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String role = SessionUtils.getCurrentUserRole(req);
        if (role == null || !"EMPLOYER".equalsIgnoreCase(role)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        return true;
    }
}
