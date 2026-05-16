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
 * Servlet that serves resume PDF files for inline viewing or download.
 * Only authenticated users can access resume files. Files are restricted
 * to the /uploads/resumes/ directory for security.
 *
 * @author Manoj Katuwal
 */
@WebServlet("/resume")
public class ResumeServlet extends HttpServlet {

    /**
     * Streams the requested resume PDF file to the client.
     * Supports both inline viewing and attachment download modes.
     *
     * @param req  the HTTP request (expects "file" and optional "download" params)
     * @param resp the HTTP response
     * @throws ServletException if a servlet error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

        if (!filePath.startsWith("/uploads/resumes/") || filePath.contains("..")) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied.");
            return;
        }

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

        boolean isDownload = "true".equals(req.getParameter("download"));
        String disposition = isDownload ? "attachment" : "inline";

        String fileName = file.getName();

        resp.setContentType("application/pdf");
        resp.setHeader("Content-Disposition", disposition + "; filename=\"" + fileName + "\"");
        resp.setContentLengthLong(file.length());

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
