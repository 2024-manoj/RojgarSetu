package com.demo.controller;

import com.demo.utils.CookieUtils;
import com.demo.utils.SessionUtils;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet that handles user logout.
 * Invalidates the current session and redirects the user to the login page.
 *
 * @author Manoj Katuwal
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    /**
     * Invalidates the user session and redirects to the login page.
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @throws IOException if the redirect fails
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        CookieUtils.deleteCookie(resp, "rememberEmail");
        SessionUtils.destroySession(req);
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}
