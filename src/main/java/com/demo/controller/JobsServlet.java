package com.demo.controller;

import com.demo.dao.JobDao;
import com.demo.models.Job;
import com.demo.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/jobs")
public class JobsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = firstNonBlank(req.getParameter("keyword"), req.getParameter("job"));
        String district = req.getParameter("district");
        String[] categories = req.getParameterValues("category");
        String[] locations = req.getParameterValues("location");

        try (Connection conn = DBConnection.getConnection()) {
            JobDao jobDao = new JobDao(conn);
            List<Job> jobs = jobDao.searchApprovedJobs(keyword, district, categories, locations);
            req.setAttribute("jobs", jobs);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Could not load jobs right now.");
        }

        req.setAttribute("keyword", keyword != null ? keyword : "");
        req.setAttribute("district", district != null ? district : "");
        req.setAttribute("selectedCategories", categories);
        req.setAttribute("selectedLocations", locations);
        req.getRequestDispatcher("/WEB-INF/pages/jobs.jsp").forward(req, resp);
    }

    private String firstNonBlank(String first, String second) {
        if (first != null && !first.isBlank()) return first;
        if (second != null && !second.isBlank()) return second;
        return "";
    }
}
