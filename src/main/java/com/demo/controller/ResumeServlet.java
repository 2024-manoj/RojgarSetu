package com.demo.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * Serves resume PDF files for view (inline) or download (attachment).
 *
 * Usage:
 *   View:     /resume?file=/uploads/resumes/xyz.pdf
 *   Download: /resume?file=/uploads/resumes/xyz.pdf&download=true
 *
 * Security: only authenticated users can access resume files.
 */
@WebServlet("/resume")
public class ResumeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Auth check — only logged-in users
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Please login to view resumes.");
            return;
        }

        String filePath = req.getParameter("file");
        if (filePath == null || filePath.isBlank()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "No file specified.");
            return;
        }

        // Security: only allow files from /uploads/resumes/ path
        if (!filePath.startsWith("/uploads/resumes/") || filePath.contains("..")) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied.");
            return;
        }

        // Resolve real path on disk
        String realPath = getServletContext().getRealPath(filePath);
        if (realPath == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found.");
            return;
        }

        File file = new File(realPath);
        if (!file.exists() || !file.isFile()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Resume file not found.");
            return;
        }

        // Determine disposition: inline (view) or attachment (download)
        boolean isDownload = "true".equals(req.getParameter("download"));
        String disposition = isDownload ? "attachment" : "inline";

        // Extract a clean filename
        String fileName = file.getName();

        resp.setContentType("application/pdf");
        resp.setHeader("Content-Disposition", disposition + "; filename=\"" + fileName + "\"");
        resp.setContentLengthLong(file.length());

        // Stream the file
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = resp.getOutputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
            os.flush();
        }
    }
}
