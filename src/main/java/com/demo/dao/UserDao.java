package com.demo.dao;

import com.demo.models.EmployerProfile;
import com.demo.models.SeekerProfile;
import com.demo.models.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;

public class UserDao {
    private Connection conn;

    public UserDao(Connection conn) {
        this.conn = conn;
    }

    public boolean registerUser(User user, SeekerProfile seekerProfile, EmployerProfile employerProfile) {
        boolean success = false;
        try {
            conn.setAutoCommit(false);

            String sql = "INSERT INTO users(full_name,email,password,role,status,location,dob) VALUES(?,?,?,?,?,?,?)";
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, user.getFullName());
                ps.setString(2, user.getEmail());

                String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
                ps.setString(3, hashedPassword);
                ps.setString(4, user.getRole());
                ps.setString(5, "PENDING");
                ps.setString(6, user.getLocation());

                if (user.getDob() != null) {
                    ps.setDate(7, new java.sql.Date(user.getDob().getTime()));
                } else {
                    ps.setNull(7, java.sql.Types.DATE);
                }

                int i = ps.executeUpdate();
                if (i > 0) {
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        int userId = 0;
                        if (rs.next()) {
                            userId = rs.getInt(1);
                        }

                        if ("SEEKER".equalsIgnoreCase(user.getRole()) && seekerProfile != null) {
                            String sSql = "INSERT INTO seeker_profile(user_id, education, skills) VALUES(?,?,?)";
                            try (PreparedStatement ps2 = conn.prepareStatement(sSql)) {
                                ps2.setInt(1, userId);
                                ps2.setString(2, seekerProfile.getEducation());
                                ps2.setString(3, seekerProfile.getSkills());
                                ps2.executeUpdate();
                            }
                        } else if ("EMPLOYER".equalsIgnoreCase(user.getRole()) && employerProfile != null) {
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

    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;
        try {
            String sql = "SELECT * FROM users WHERE email = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String hashedPassword = rs.getString("password");
                        if (hashedPassword != null && BCrypt.checkpw(password, hashedPassword)) {
                            user = new User();
                            user.setId(rs.getInt("id"));
                            user.setFullName(rs.getString("full_name"));
                            user.setEmail(rs.getString("email"));
                            user.setPhone(rs.getString("phone"));
                            user.setPassword(hashedPassword);
                            user.setRole(rs.getString("role"));
                            user.setStatus(rs.getString("status"));
                            user.setLocation(rs.getString("location"));
                            user.setDob(rs.getDate("dob"));
                            user.setCreatedAt(rs.getTimestamp("created_at"));
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}
