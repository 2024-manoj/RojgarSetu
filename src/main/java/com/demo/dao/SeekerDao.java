package com.demo.dao;

import com.demo.models.SeekerProfile;

import java.sql.*;

/**
 * DAO for seeker_profile table operations.
 * Handles all seeker profile CRUD.
 */
public class SeekerDao {
    private Connection conn;

    public SeekerDao(Connection conn) {
        this.conn = conn;
    }

    /** Get seeker profile by user ID. */
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

    /** Creates a bare seeker_profile row when missing (legacy / edge-case users). */
    public boolean insertSeekerProfileIfMissing(int userId) {
        if (getSeekerProfile(userId) != null) {
            return true;
        }
        try {
            String sql = "INSERT INTO seeker_profile(user_id, address_city, skills, education, experience_year, resume_path) VALUES(?,?,?,?,0,NULL)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ps.setNull(2, Types.VARCHAR);
                ps.setString(3, "");
                ps.setString(4, "");
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Update seeker profile. */
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
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
