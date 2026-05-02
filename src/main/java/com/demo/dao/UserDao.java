package com.demo.dao;

import com.demo.models.EmployerProfile;
import com.demo.models.SeekerProfile;
import com.demo.models.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class UserDao {

    private Connection conn;

    public UserDao(Connection conn) {
        this.conn = conn;
    }

    public boolean registerUser(User user, SeekerProfile seekerProfile, EmployerProfile employerProfile) {
        boolean success = false;

        try {
            conn.setAutoCommit(false);

            // 1. Insert into users
            String sql = "INSERT INTO users(full_name,email,password,role,status,location,dob) VALUES(?,?,?,?,?,?,?)";
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, user.getFullName());
                ps.setString(2, user.getEmail());

                ps.setString(3, user.getPassword()); // hash before saving in production
                ps.setString(4, user.getRole());
                ps.setString(5, "PENDING");
                ps.setString(6, user.getLocation());
                ps.setDate(7, new java.sql.Date(user.getDob().getTime()));

                int i = ps.executeUpdate();

                if (i > 0) {
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        int userId = 0;
                        if (rs.next()) {
                            userId = rs.getInt(1);
                        }

                        // 2. Insert role-specific profile
                        if (user.getRole().equalsIgnoreCase("SEEKER") && seekerProfile != null) {
                            String sSql = "INSERT INTO seeker_profile(user_id, education, skills) VALUES(?,?,?)";
                            try (PreparedStatement ps2 = conn.prepareStatement(sSql)) {
                                ps2.setInt(1, userId);
                                ps2.setString(2, seekerProfile.getEducation());
                                ps2.setString(3, seekerProfile.getSkills());
                                ps2.executeUpdate();
                            }
                        } else if (user.getRole().equalsIgnoreCase("EMPLOYER") && employerProfile != null) {
                            String eSql = "INSERT INTO employer_profile(user_id, company_name, company_category) VALUES(?,?,?)";
                            try (PreparedStatement ps2 = conn.prepareStatement(eSql)) {
                                ps2.setInt(1, userId);
                                ps2.setString(2, employerProfile.getCompanyName());
                                ps2.setString(3, employerProfile.getCompanyCategory());
                                ps2.executeUpdate();
                            }
                        }
                    }
                    conn.commit();
                    success = true;
                }
            }
        } catch (Exception e) {
            try {
                conn.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return success;
    }
}
