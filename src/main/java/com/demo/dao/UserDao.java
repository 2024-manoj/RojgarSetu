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

    // Get user by ID
    public User getUserById(int userId) {
        User user = null;
        try {
            String sql = "SELECT * FROM users WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        user = new User();
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
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Check if email already exists
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

    // Get all users
    public java.util.List<User> getAllUsers() {
        java.util.List<User> users = new java.util.ArrayList<>();
        try {
            String sql = "SELECT * FROM users ORDER BY created_at DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
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
                        users.add(user);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    // Get all seekers
    public java.util.List<User> getAllSeekers() {
        java.util.List<User> seekers = new java.util.ArrayList<>();
        try {
            String sql = "SELECT * FROM users WHERE role = 'SEEKER' ORDER BY created_at DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
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
                        seekers.add(user);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return seekers;
    }

    // Get all employers
    public java.util.List<User> getAllEmployers() {
        java.util.List<User> employers = new java.util.ArrayList<>();
        try {
            String sql = "SELECT * FROM users WHERE role = 'EMPLOYER' ORDER BY created_at DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
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
                        employers.add(user);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return employers;
    }

    // Update user status (APPROVED, REJECTED, PENDING)
    public boolean updateUserStatus(int userId, String status) {
        try {
            String sql = "UPDATE users SET status = ? WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setInt(2, userId);
                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update user profile
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
                    ps.setNull(4, java.sql.Types.DATE);
                }
                ps.setInt(5, user.getId());
                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get seeker profile by user ID
    public SeekerProfile getSeekerProfile(int userId) {
        SeekerProfile profile = null;
        try {
            String sql = "SELECT * FROM seeker_profile WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        profile = new SeekerProfile();
                        profile.setId(rs.getInt("id"));
                        profile.setUserId(rs.getInt("user_id"));
                        profile.setAddressCity(rs.getString("address_city"));
                        profile.setSkills(rs.getString("skills"));
                        profile.setEducation(rs.getString("education"));
                        profile.setExperienceYear(rs.getInt("experience_year"));
                        profile.setResumePath(rs.getString("resume_path"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return profile;
    }

    // Get employer profile by user ID
    public EmployerProfile getEmployerProfile(int userId) {
        EmployerProfile profile = null;
        try {
            String sql = "SELECT * FROM employer_profile WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        profile = new EmployerProfile();
                        profile.setId(rs.getInt("id"));
                        profile.setUserId(rs.getInt("user_id"));
                        profile.setCompanyName(rs.getString("company_name"));
                        profile.setCompanyAddress(rs.getString("company_address"));
                        profile.setCompanyCategory(rs.getString("company_category"));
                        profile.setCompanyCity(rs.getString("company_city"));
                        profile.setCompanyDescription(rs.getString("company_description"));
                        profile.setContactPerson(rs.getString("contact_person"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return profile;
    }

    // Update seeker profile
    public boolean updateSeekerProfile(SeekerProfile profile) {
        try {
            String sql = "UPDATE seeker_profile SET address_city = ?, skills = ?, education = ?, experience_year = ?, resume_path = ? WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, profile.getAddressCity());
                ps.setString(2, profile.getSkills());
                ps.setString(3, profile.getEducation());
                ps.setInt(4, profile.getExperienceYear());
                ps.setString(5, profile.getResumePath());
                ps.setInt(6, profile.getUserId());
                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update employer profile
    public boolean updateEmployerProfile(EmployerProfile profile) {
        try {
            String sql = "UPDATE employer_profile SET company_name = ?, company_address = ?, company_category = ?, company_city = ?, company_description = ?, contact_person = ? WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, profile.getCompanyName());
                ps.setString(2, profile.getCompanyAddress());
                ps.setString(3, profile.getCompanyCategory());
                ps.setString(4, profile.getCompanyCity());
                ps.setString(5, profile.getCompanyDescription());
                ps.setString(6, profile.getContactPerson());
                ps.setInt(7, profile.getUserId());
                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete user
    public boolean deleteUser(int userId) {
        try {
            String sql = "DELETE FROM users WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get total user count
    public long getTotalUsers() {
        try {
            String sql = "SELECT COUNT(*) as total FROM users";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getLong("total");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get total seeker count
    public long getTotalSeekers() {
        try {
            String sql = "SELECT COUNT(*) as total FROM users WHERE role = 'SEEKER'";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getLong("total");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get total employer count
    public long getTotalEmployers() {
        try {
            String sql = "SELECT COUNT(*) as total FROM users WHERE role = 'EMPLOYER'";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getLong("total");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get pending user count (for approval)
    public long getPendingUsers() {
        try {
            String sql = "SELECT COUNT(*) as total FROM users WHERE status = 'PENDING'";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getLong("total");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get approved user count
    public long getApprovedUsers() {
        try {
            String sql = "SELECT COUNT(*) as total FROM users WHERE status = 'APPROVED'";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getLong("total");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get rejected user count
    public long getRejectedUsers() {
        try {
            String sql = "SELECT COUNT(*) as total FROM users WHERE status = 'REJECTED'";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getLong("total");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
