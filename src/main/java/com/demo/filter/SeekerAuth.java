package com.demo.filter;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public final class SeekerAuth {
    private SeekerAuth() {
    }

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
