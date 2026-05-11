package com.demo.controller.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public final class AdminAuth {
    private AdminAuth() {
    }

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
