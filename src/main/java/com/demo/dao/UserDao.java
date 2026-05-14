package com.demo.dao;

import com.demo.models.EmployerProfile;
import com.demo.models.SeekerProfile;
import com.demo.models.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for core users table operations.
 * Handles: register, login, getUserById, update, delete, list users.
 *
 * Profile-specific ops → SeekerDao / EmployerDao
 * Stats/counts → StatsDao
 */
public class UserDao {
    private Connection conn;

    public UserDao(Connection conn) {
        this.conn = conn;
    }

    // ===== REGISTRATION =====

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
                    ps.setNull(7, Types.DATE);
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

    // ===== LOGIN =====

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
                            user = mapRow(rs);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // ===== SINGLE USER LOOKUP =====

    public User getUserById(int userId) {
        User user = null;
        try {
            String sql = "SELECT * FROM users WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        user = mapRow(rs);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean emailExists(String email) {
        try {
            String sql = "SELECT id FROM users WHERE email = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                try (ResultSet rs = ps.executeQuery()) {
                    return rs.next();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===== USER LISTS =====

    public List<User> getAllUsers() {
        return getUsersByFilter(null);
    }

    public List<User> getAllSeekers() {
        return getUsersByFilter("SEEKER");
    }

    public List<User> getAllEmployers() {
        return getUsersByFilter("EMPLOYER");
    }

    private List<User> getUsersByFilter(String role) {
        List<User> users = new ArrayList<>();
        try {
            String sql = role != null
                    ? "SELECT * FROM users WHERE role = ? ORDER BY created_at DESC"
                    : "SELECT * FROM users ORDER BY created_at DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                if (role != null) ps.setString(1, role);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        users.add(mapRow(rs));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    // ===== UPDATE / DELETE =====

    public boolean updateUserProfile(User user) {
        try {
            String sql = "UPDATE users SET full_name = ?, phone = ?, location = ?, dob = ? WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, user.getFullName());
                ps.setString(2, user.getPhone());
                ps.setString(3, user.getLocation());
                if (user.getDob() != null) {
                    ps.setDate(4, new java.sql.Date(user.getDob().getTime()));
                } else {
                    ps.setNull(4, Types.DATE);
                }
                ps.setInt(5, user.getId());
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUserStatus(int userId, String status) {
        try {
            String sql = "UPDATE users SET status = ? WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setInt(2, userId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean approveUserIfPending(int userId, String role) {
        try {
            String sql = "UPDATE users SET status = 'APPROVED' WHERE id = ? AND UPPER(TRIM(role)) = ? AND UPPER(TRIM(status)) = 'PENDING'";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ps.setString(2, role.toUpperCase());
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean rejectUserIfPending(int userId, String role) {
        try {
            String sql = "UPDATE users SET status = 'REJECTED' WHERE id = ? AND UPPER(TRIM(role)) = ? AND UPPER(TRIM(status)) = 'PENDING'";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ps.setString(2, role.toUpperCase());
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUser(int userId) {
        try {
            String sql = "DELETE FROM users WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUserWithRole(int userId, String role) {
        try {
            String sql = "DELETE FROM users WHERE id = ? AND UPPER(TRIM(role)) = ? AND UPPER(TRIM(role)) <> 'ADMIN'";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ps.setString(2, role.toUpperCase());
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===== ROW MAPPER =====

    private User mapRow(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setPassword(rs.getString("password"));
        user.setRole(rs.getString("role"));
        user.setStatus(rs.getString("status"));
        user.setLocation(rs.getString("location"));
        user.setDob(rs.getDate("dob"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        return user;
    }
}
