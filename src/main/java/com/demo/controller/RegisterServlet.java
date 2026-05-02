package com.demo.controller;

import com.demo.models.EmployerProfile;
import com.demo.models.SeekerProfile;
import com.demo.models.User;
import com.demo.dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String check = req.getParameter("check");
            boolean result = false;

            // Common user fields
            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String password = req.getParameter("password");
            String role = req.getParameter("role");
            String city = req.getParameter("city");

            // Seeker fields
            String education = req.getParameter("education");
            String skills = req.getParameter("skills");

            // Employer fields
            String companyName = req.getParameter("companyName");
            String industry = req.getParameter("industry"); // treated as category

            // Build User object
            User user = new User();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setPassword(password);
            user.setRole(role);
            user.setLocation(city);

            System.out.println(fullName + email + password + role + city );

            // DAO object
            UserDao dao = new UserDao();

            // Role-based logic
            if ("SEEKER".equalsIgnoreCase(role)) {
                SeekerProfile seeker = new SeekerProfile();
                seeker.setEducation(education);
                seeker.setSkills(skills);

                result = dao.registerUser(user, null, seeker);

            } else if ("EMPLOYER".equalsIgnoreCase(role)) {
                EmployerProfile emp = new EmployerProfile();
                emp.setCompanyName(companyName);
                emp.setCompanyCategory(industry);

                result = dao.registerUser(user, emp, null);
            }

            // Console output only
            if (check == null) {
                System.out.println("Please check Agree & Terms Condition");
            } else if (result) {
                System.out.println("User Register Success..");
            } else {
                System.out.println("Something wrong on server..");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
