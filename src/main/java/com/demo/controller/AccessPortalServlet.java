package com.demo.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet that renders the Access Portal page.
 * Provides a gateway for users to choose between Seeker and Employer roles.
 *
 * @author Manoj Katuwal
 */
@WebServlet("/access-portal")
public class AccessPortalServlet extends HttpServlet {

    /**
     * Forwards the request to the access portal JSP page.
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @throws ServletException if a servlet error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/accessPortal.jsp").forward(req, resp);
    }
}
