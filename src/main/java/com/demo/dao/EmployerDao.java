package com.demo.dao;

import com.demo.models.EmployerProfile;

import java.sql.*;

/**
 * DAO for employer_profile table operations.
 * Handles all employer profile CRUD.
 */
public class EmployerDao {
    private Connection conn;

    public EmployerDao(Connection conn) {
        this.conn = conn;
    }

    /** Get employer profile by user ID. */
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

    /** Creates a bare employer_profile row when missing. */
    public boolean insertEmployerProfileIfMissing(int userId) {
        if (getEmployerProfile(userId) != null) {
            return true;
        }
        try {
            String sql = "INSERT INTO employer_profile(user_id, company_name, company_category) VALUES(?,?,?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ps.setString(2, "");
                ps.setString(3, "");
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Update employer profile. */
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
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
