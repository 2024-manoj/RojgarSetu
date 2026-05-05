package com.demo.controller;

import com.demo.dao.JobDao;
import com.demo.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/approveJob")
public class ApproveJobServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");

        try {
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                resp.getWriter().write("{\"success\": false, \"message\": \"Unauthorized\"}");
                return;
            }

            int jobId = Integer.parseInt(req.getParameter("jobId"));
            String status = req.getParameter("status"); // approved or rejected
            int adminId = Integer.parseInt(session.getAttribute("userId").toString());

            Connection conn = DBConnection.getConnection();
            JobDao jobDao = new JobDao(conn);

            boolean success = false;
            if ("approved".equalsIgnoreCase(status)) {
                success = jobDao.approveJob(jobId, adminId);
            } else if ("rejected".equalsIgnoreCase(status)) {
                success = jobDao.rejectJob(jobId);
            }

            conn.close();

            if (success) {
                resp.getWriter().write("{\"success\": true, \"message\": \"Job " + status + " successfully\"}");
            } else {
                resp.getWriter().write("{\"success\": false, \"message\": \"Failed to update job status\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
        }
    }
}


