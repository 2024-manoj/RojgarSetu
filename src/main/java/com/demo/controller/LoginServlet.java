package com.demo.controller;

import com.demo.dao.UserDao;
import com.demo.models.User;
import com.demo.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            UserDao dao = new UserDao(conn);
            User user = dao.getUserByEmailAndPassword(email, password);

            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("userRole", user.getRole());

                if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                    session.setAttribute("adminName",user.getFullName());
                    resp.sendRedirect(req.getContextPath() + "/admin");


                } else if ("SEEKER".equalsIgnoreCase(user.getRole())) {
                    resp.sendRedirect(req.getContextPath() + "/seeker");
                } else if ("EMPLOYER".equalsIgnoreCase(user.getRole())) {
                    resp.sendRedirect(req.getContextPath() + "/employer");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/");
                }
            } else {
                req.setAttribute("error", "Invalid email or password!");
                req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "An error occurred during login!");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
        }
    }
}
