package com.demo.utils;

import com.demo.models.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Utility class for HTTP Session operations.
 * Centralizes session attribute access, login/logout session management,
 * flash messages, and role-based redirect logic to eliminate
 * repetitive session code scattered across servlets.
 *
 * @author Manoj Katuwal
 */
public final class SessionUtils {

    private SessionUtils() {
    }

    // ─── Session attribute keys ───────────────────────────────────────

    public static final String KEY_USER      = "user";
    public static final String KEY_USER_ID   = "userId";
    public static final String KEY_USER_ROLE = "userRole";
    public static final String KEY_ADMIN_NAME = "adminName";

    // ─── Core session access ──────────────────────────────────────────

    /**
     * Returns the current user ID from the session, or null if not logged in.
     *
     * @param req the HTTP request
     * @return the logged-in user's ID, or null
     */
    public static Integer getCurrentUserId(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return session != null ? (Integer) session.getAttribute(KEY_USER_ID) : null;
    }

    /**
     * Returns the current user's role from the session, or null if not logged in.
     *
     * @param req the HTTP request
     * @return the role string (e.g. "ADMIN", "SEEKER", "EMPLOYER"), or null
     */
    public static String getCurrentUserRole(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return null;
        Object role = session.getAttribute(KEY_USER_ROLE);
        return role != null ? String.valueOf(role) : null;
    }

    /**
     * Returns the current User object from the session, or null if not logged in.
     *
     * @param req the HTTP request
     * @return the User object, or null
     */
    public static User getCurrentUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return session != null ? (User) session.getAttribute(KEY_USER) : null;
    }

    /**
     * Checks if a user is currently logged in (session exists with a userId).
     *
     * @param req the HTTP request
     * @return true if logged in, false otherwise
     */
    public static boolean isLoggedIn(HttpServletRequest req) {
        return getCurrentUserId(req) != null;
    }

    // ─── Login / Logout ───────────────────────────────────────────────

    /**
     * Creates a login session for the given user.
     * Sets the user object, userId, and userRole in the session.
     * For ADMIN users, also sets the adminName attribute.
     *
     * @param req  the HTTP request
     * @param user the authenticated User object
     */
    public static void createLoginSession(HttpServletRequest req, User user) {
        HttpSession session = req.getSession();
        session.setAttribute(KEY_USER, user);
        session.setAttribute(KEY_USER_ID, user.getId());
        session.setAttribute(KEY_USER_ROLE, user.getRole());

        if ("ADMIN".equalsIgnoreCase(user.getRole())) {
            session.setAttribute(KEY_ADMIN_NAME, user.getFullName());
        }
    }

    /**
     * Invalidates the current session, effectively logging the user out.
     *
     * @param req the HTTP request
     */
    public static void destroySession(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }

    // ─── Flash messages ───────────────────────────────────────────────

    /**
     * Sets a flash success message in the session.
     *
     * @param req     the HTTP request
     * @param key     the session attribute key (e.g. "seekerFlashSuccess")
     * @param message the success message
     */
    public static void setFlashSuccess(HttpServletRequest req, String key, String message) {
        HttpSession session = req.getSession();
        session.setAttribute(key, message);
    }

    /**
     * Sets a flash error message in the session.
     *
     * @param req     the HTTP request
     * @param key     the session attribute key (e.g. "seekerFlashError")
     * @param message the error message
     */
    public static void setFlashError(HttpServletRequest req, String key, String message) {
        HttpSession session = req.getSession();
        session.setAttribute(key, message);
    }

    /**
     * Consumes flash messages from the session and transfers them to
     * request attributes for display. After consumption, the session
     * attributes are removed so flash messages only show once.
     *
     * @param req        the HTTP request
     * @param successKey the session key for the success flash (e.g. "seekerFlashSuccess")
     * @param errorKey   the session key for the error flash (e.g. "seekerFlashError")
     */
    public static void consumeFlash(HttpServletRequest req, String successKey, String errorKey) {
        HttpSession session = req.getSession(false);
        if (session == null) return;

        Object ok = session.getAttribute(successKey);
        if (ok != null) {
            req.setAttribute("success", ok);
            session.removeAttribute(successKey);
        }

        Object err = session.getAttribute(errorKey);
        if (err != null) {
            req.setAttribute("error", err);
            session.removeAttribute(errorKey);
        }
    }

    // ─── Session user update ─────────────────────────────────────────

    /**
     * Updates the user object stored in the session after a profile change.
     * Also refreshes the adminName attribute if the user has the ADMIN role.
     *
     * @param req  the HTTP request
     * @param user the updated User object
     */
    public static void updateSessionUser(HttpServletRequest req, User user) {
        HttpSession session = req.getSession(false);
        if (session == null || user == null) return;
        session.setAttribute(KEY_USER, user);
        if ("ADMIN".equalsIgnoreCase(user.getRole())) {
            session.setAttribute(KEY_ADMIN_NAME, user.getFullName());
        }
    }

    // ─── Role-based redirect ──────────────────────────────────────────

    /**
     * Redirects the user to their role-specific dashboard.
     * Used to prevent logged-in users from accessing login/register pages.
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @param role the user's role
     * @throws IOException if the redirect fails
     */
    public static void redirectToDashboard(HttpServletRequest req, HttpServletResponse resp, String role) throws IOException {
        String ctx = req.getContextPath();
        if ("ADMIN".equalsIgnoreCase(role)) {
            resp.sendRedirect(ctx + "/admin/dashboard");
        } else if ("SEEKER".equalsIgnoreCase(role)) {
            resp.sendRedirect(ctx + "/seeker");
        } else if ("EMPLOYER".equalsIgnoreCase(role)) {
            resp.sendRedirect(ctx + "/employer");
        } else {
            resp.sendRedirect(ctx + "/");
        }
    }

    /**
     * If the user is already logged in, redirects them to their dashboard.
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @return true if the user was redirected (already logged in), false otherwise
     * @throws IOException if the redirect fails
     */
    public static boolean redirectIfLoggedIn(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String role = getCurrentUserRole(req);
        if (role != null) {
            redirectToDashboard(req, resp, role);
            return true;
        }
        return false;
    }

    /**
     * Validates that a userId exists in the session.
     * If not, redirects to the login page.
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @return the userId if valid, or null if redirected to login
     * @throws IOException if the redirect fails
     */
    public static Integer requireUserId(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer userId = getCurrentUserId(req);
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return null;
        }
        return userId;
    }
}
