package com.demo.controller;

import com.demo.dao.JobDao;
import com.demo.dao.StatsDao;
import com.demo.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            StatsDao statsDao = new StatsDao(conn);
            JobDao jobDao = new JobDao(conn);

            // Hero stats
            req.setAttribute("activeJobsCount", statsDao.getApprovedJobCount());
            req.setAttribute("employerCount", statsDao.getTotalEmployers());
            req.setAttribute("seekerCount", statsDao.getTotalSeekers());

            // Dynamic categories & locations for search dropdown
            List<String> categories = jobDao.getDistinctCategories();
            List<String> locations = jobDao.getDistinctLocations();
            req.setAttribute("categories", categories);
            req.setAttribute("locations", locations);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("activeJobsCount", 0L);
            req.setAttribute("employerCount", 0L);
            req.setAttribute("seekerCount", 0L);
        }
        req.getRequestDispatcher("/WEB-INF/pages/index.jsp").forward(req, resp);
    }
}
