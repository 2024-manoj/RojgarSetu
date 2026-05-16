package com.demo.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet filter that prevents browser caching on all pages.
 * Sets HTTP headers to ensure the browser always fetches fresh content,
 * preventing stale pages from appearing when using the back button
 * (e.g., accessing the login page after the user has already logged in).
 *
 * @author Manoj Katuwal
 */
@WebFilter("/*")
public class NoCacheFilter implements Filter {

    /**
     * Adds no-cache headers to every HTTP response and passes the request
     * down the filter chain.
     *
     * @param request  the servlet request
     * @param response the servlet response
     * @param chain    the filter chain
     * @throws IOException      if an I/O error occurs
     * @throws ServletException if a servlet error occurs
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletResponse httpResp = (HttpServletResponse) response;
        httpResp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        httpResp.setHeader("Pragma", "no-cache");
        httpResp.setDateHeader("Expires", 0);

        chain.doFilter(request, response);
    }
}
