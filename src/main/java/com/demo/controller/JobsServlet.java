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

/**
 * Servlet that handles the public job listing page.
 * Supports keyword search, district filtering, and multi-select category
 * and location filters to display approved job postings.
 *
 * @author Manoj Katuwal
 */
@WebServlet("/jobs")
public class JobsServlet extends HttpServlet {

    /**
     * Searches and displays approved jobs based on user-supplied filters.
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @throws ServletException if a servlet error occurs
     * @throws IOException      if an I/O error occurs
     */
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

    /**
     * Returns the first non-blank string from two candidates.
     *
     * @param first  the first candidate
     * @param second the second candidate
     * @return the first non-blank value, or empty string if both are blank
     */
    private String firstNonBlank(String first, String second) {
        if (first != null && !first.isBlank()) return first;
        if (second != null && !second.isBlank()) return second;
        return "";
    }
}
