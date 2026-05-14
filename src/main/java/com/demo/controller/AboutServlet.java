package com.demo.controller;

import com.demo.dao.StatsDao;
import com.demo.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/about")
public class AboutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            StatsDao statsDao = new StatsDao(conn);
            req.setAttribute("totalJobs", statsDao.getTotalJobs());
            req.setAttribute("totalEmployers", statsDao.getTotalEmployers());
            req.setAttribute("totalSeekers", statsDao.getTotalSeekers());
            req.setAttribute("totalApplications", statsDao.getTotalApplications());
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("totalJobs", 0L);
            req.setAttribute("totalEmployers", 0L);
            req.setAttribute("totalSeekers", 0L);
            req.setAttribute("totalApplications", 0L);
        }
        req.getRequestDispatcher("/WEB-INF/pages/about.jsp").forward(req, resp);
    }
}