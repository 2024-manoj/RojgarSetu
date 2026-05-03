package com.demo.controller;

import com.demo.dao.JobDao;
import com.demo.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/deleteJob")
public class DeleteJobServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");

        try {
            int jobId = Integer.parseInt(req.getParameter("jobId"));

            Connection conn = DBConnection.getConnection();
            JobDao jobDao = new JobDao(conn);

            boolean success = jobDao.deleteJob(jobId);
            conn.close();

            if (success) {
                resp.getWriter().write("{\"success\": true, \"message\": \"Job deleted successfully\"}");
            } else {
                resp.getWriter().write("{\"success\": false, \"message\": \"Failed to delete job\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
        }
    }
}

