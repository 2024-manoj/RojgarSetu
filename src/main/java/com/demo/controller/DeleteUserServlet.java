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

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");

        try {
            int userId = Integer.parseInt(req.getParameter("userId"));

            Connection conn = DBConnection.getConnection();
            UserDao userDao = new UserDao(conn);

            boolean success = userDao.deleteUser(userId);
            conn.close();

            if (success) {
                resp.getWriter().write("{\"success\": true, \"message\": \"User deleted successfully\"}");
            } else {
                resp.getWriter().write("{\"success\": false, \"message\": \"Failed to delete user\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
        }
    }
}

