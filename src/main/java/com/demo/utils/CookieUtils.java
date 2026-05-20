package com.demo.utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Utility class for HTTP Cookie operations.
 * Centralizes cookie creation, retrieval, and deletion
 * to ensure consistent cookie handling across all servlets.
 *
 * @author Manoj Katuwal
 */
public final class CookieUtils {

    private CookieUtils() {
    }

    /**
     * Creates a cookie and adds it to the response.
     *
     * @param resp     the HTTP response
     * @param name     the cookie name
     * @param value    the cookie value
     * @param maxAge   the maximum age of the cookie in seconds (-1 for session, 0 to delete)
     * @param httpOnly whether the cookie should be HTTP-only (not accessible via JavaScript)
     */
    public static void addCookie(HttpServletResponse resp, String name, String value, int maxAge, boolean httpOnly) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setHttpOnly(httpOnly);
        cookie.setPath("/");
        resp.addCookie(cookie);
    }

    /**
     * Creates a simple cookie with default settings (HTTP-only, path = "/").
     *
     * @param resp   the HTTP response
     * @param name   the cookie name
     * @param value  the cookie value
     * @param maxAge the maximum age in seconds
     */
    public static void addCookie(HttpServletResponse resp, String name, String value, int maxAge) {
        addCookie(resp, name, value, maxAge, true);
    }

    /**
     * Retrieves the value of a cookie by its name from the request.
     *
     * @param req  the HTTP request
     * @param name the cookie name to search for
     * @return the cookie value, or null if the cookie does not exist
     */
    public static String getCookieValue(HttpServletRequest req, String name) {
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (name.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    /**
     * Retrieves a Cookie object by its name from the request.
     *
     * @param req  the HTTP request
     * @param name the cookie name to search for
     * @return the Cookie object, or null if not found
     */
    public static Cookie getCookie(HttpServletRequest req, String name) {
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (name.equals(cookie.getName())) {
                    return cookie;
                }
            }
        }
        return null;
    }

    /**
     * Deletes a cookie by setting its max age to 0.
     *
     * @param resp the HTTP response
     * @param name the cookie name to delete
     */
    public static void deleteCookie(HttpServletResponse resp, String name) {
        Cookie cookie = new Cookie(name, "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        resp.addCookie(cookie);
    }

    /**
     * Checks if a cookie with the given name exists in the request.
     *
     * @param req  the HTTP request
     * @param name the cookie name to check
     * @return true if the cookie exists, false otherwise
     */
    public static boolean hasCookie(HttpServletRequest req, String name) {
        return getCookieValue(req, name) != null;
    }
}
