package com.demo.controller;

import com.demo.dao.UserDao;
import com.demo.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/approveUser")
public class ApproveUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");

        try {
            int userId = Integer.parseInt(req.getParameter("userId"));
            String status = req.getParameter("status"); // APPROVED or REJECTED

            Connection conn = DBConnection.getConnection();
            UserDao userDao = new UserDao(conn);

            boolean success = userDao.updateUserStatus(userId, status);
            conn.close();

            if (success) {
                resp.getWriter().write("{\"success\": true, \"message\": \"User " + status.toLowerCase() + " successfully\"}");
            } else {
                resp.getWriter().write("{\"success\": false, \"message\": \"Failed to update user status\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
        }
    }
}

