package com.demo.dao;

import com.demo.models.EmployerProfile;
import com.demo.models.SeekerProfile;
import com.demo.models.User;
import com.demo.utils.DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class UserDao {
    private Connection conn;

    public UserDao() {
        try {
            this.conn = DBConnection.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Create Register User
    public boolean registerUser(User user, EmployerProfile employer, SeekerProfile seeker) {
        boolean success = false;
        String sql = "INSERT INTO users(full_name,email,phone,password,role,status,location,dob) VALUES (?,?,?,?,?,?,?,?)";

        try {
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, user.getFullName());
                ps.setString(2, user.getEmail());
                ps.setString(3, user.getPhone());
                ps.setString(4, user.getPassword());
                ps.setString(5, user.getRole());
                ps.setString(6, "PENDING");
                ps.setString(7, user.getLocation());
                ps.setDate(8, user.getDob() != null ? new Date(user.getDob().getTime()) : null);

                int i = ps.executeUpdate();

                if (i > 0) {
                    ResultSet rs = ps.getGeneratedKeys();
                    int userId = 0;
                    if (rs.next()) {
                        userId = rs.getInt(1);
                    }

                    if ("SEEKER".equalsIgnoreCase(user.getRole())) {
                        String query = "INSERT INTO seeker_profile(user_id, education, skills) VALUES (?,?,?)";
                        try (PreparedStatement pps = conn.prepareStatement(query)) {
                            pps.setInt(1, userId);
                            pps.setString(2, seeker.getEducation());
                            pps.setString(3, seeker.getSkills());
                            pps.executeUpdate();
                        }
                    } else if ("EMPLOYER".equalsIgnoreCase(user.getRole())) {
                        String qry = "INSERT INTO employer_profile(user_id, company_name, company_category) VALUES (?,?,?)";
                        try (PreparedStatement pps2 = conn.prepareStatement(qry)) {
                            pps2.setInt(1, userId);
                            pps2.setString(2, employer.getCompanyName());
                            pps2.setString(3, employer.getCompanyCategory());
                            pps2.executeUpdate();
                        }
                    }
                    conn.commit();
                    success = true;
                }
            } catch (Exception e) {
                conn.rollback(); // error आयो भने rollback
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }
}
