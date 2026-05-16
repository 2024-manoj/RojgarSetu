package com.demo.controller;

import com.demo.filter.AdminAuth;
import com.demo.dao.JobDao;
import com.demo.dao.StatsDao;
import com.demo.dao.UserDao;
import com.demo.models.Job;
import com.demo.models.User;
import com.demo.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.util.List;

/**
 * Servlet that handles the Admin reports page and CSV export downloads.
 * Displays aggregate platform statistics on GET and streams downloadable
 * CSV reports for users and jobs when the "download" parameter is provided.
 *
 * @author Manoj Katuwal
 */
@WebServlet("/admin/reports")
public class AdminReportsServlet extends HttpServlet {

    /**
     * Renders the reports overview page or streams a CSV download
     * based on the "download" query parameter.
     *
     * @param req  the HTTP request
     * @param resp the HTTP response
     * @throws ServletException if a servlet error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!AdminAuth.requireAdmin(req, resp)) {
            return;
        }
        String download = req.getParameter("download");
        if ("users".equalsIgnoreCase(download)) {
            streamUsersCsv(resp);
            return;
        }
        if ("jobs".equalsIgnoreCase(download)) {
            streamJobsCsv(resp);
            return;
        }
        try (Connection conn = DBConnection.getConnection()) {
            StatsDao statsDao = new StatsDao(conn);
            req.setAttribute("totalUsers", statsDao.getTotalUsers());
            req.setAttribute("totalSeekers", statsDao.getTotalSeekers());
            req.setAttribute("totalEmployers", statsDao.getTotalEmployers());
            req.setAttribute("pendingUsers", statsDao.getPendingUsers());
            req.setAttribute("totalJobs", statsDao.getTotalJobs());
            req.setAttribute("pendingJobs", statsDao.getPendingJobs());
            req.setAttribute("approvedJobs", statsDao.getApprovedJobCount());
        } catch (Exception e) {
            e.printStackTrace();
        }
        req.getRequestDispatcher("/WEB-INF/admin/reports.jsp").forward(req, resp);
    }

    /**
     * Streams the users report as a CSV file download.
     *
     * @param resp the HTTP response
     * @throws IOException if an I/O error occurs
     */
    private void streamUsersCsv(HttpServletResponse resp) throws IOException {
        resp.setCharacterEncoding(StandardCharsets.UTF_8.name());
        resp.setContentType("text/csv; charset=UTF-8");
        resp.setHeader("Content-Disposition", "attachment; filename=\"users-report.csv\"");
        try (Connection conn = DBConnection.getConnection();
                PrintWriter out = resp.getWriter()) {
            UserDao dao = new UserDao(conn);
            out.println("id,full_name,email,role,status,location,created_at");
            List<User> users = dao.getAllUsers();
            for (User u : users) {
                out.printf("%d,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"%n",
                        u.getId(),
                        csvEscape(u.getFullName()),
                        csvEscape(u.getEmail()),
                        csvEscape(u.getRole()),
                        csvEscape(u.getStatus()),
                        csvEscape(u.getLocation()),
                        u.getCreatedAt() != null ? u.getCreatedAt().toString() : "");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Streams the jobs report as a CSV file download.
     *
     * @param resp the HTTP response
     * @throws IOException if an I/O error occurs
     */
    private void streamJobsCsv(HttpServletResponse resp) throws IOException {
        resp.setCharacterEncoding(StandardCharsets.UTF_8.name());
        resp.setContentType("text/csv; charset=UTF-8");
        resp.setHeader("Content-Disposition", "attachment; filename=\"jobs-report.csv\"");
        try (Connection conn = DBConnection.getConnection();
                PrintWriter out = resp.getWriter()) {
            JobDao dao = new JobDao(conn);
            out.println("job_id,employer_id,title,category,location_city,status,posted_at,deadline");
            List<Job> jobs = dao.getAllJobs();
            for (Job j : jobs) {
                out.printf("%d,%d,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"%n",
                        j.getJobId(),
                        j.getEmployerId(),
                        csvEscape(j.getTitle()),
                        csvEscape(j.getCategory()),
                        csvEscape(j.getLocationCity()),
                        csvEscape(j.getStatus()),
                        j.getPostedAt() != null ? j.getPostedAt().toString() : "",
                        j.getDeadline() != null ? j.getDeadline().toString() : "");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Escapes double quotes in CSV field values.
     *
     * @param s the string to escape
     * @return the escaped string, or empty string if null
     */
    private static String csvEscape(String s) {
        if (s == null) {
            return "";
        }
        return s.replace("\"", "\"\"");
    }
}
