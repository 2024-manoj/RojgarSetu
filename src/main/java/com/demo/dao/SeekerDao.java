package com.demo.dao;

import com.demo.models.Job;
import com.demo.models.SeekerProfile;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * DAO for seeker_profile table operations.
 * Handles all seeker profile CRUD and saved jobs management.
 *
 * @author Manoj Katuwal
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

    /**
     * Creates a bare seeker_profile row when missing (legacy / edge-case users).
     */
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

    /** Save a job for a seeker. */
    public boolean saveJob(int seekerId, int jobId) {
        try {
            String sql = "INSERT IGNORE INTO saved_jobs(seeker_id, job_id) VALUES(?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, seekerId);
                ps.setInt(2, jobId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Remove a saved job. */
    public boolean unsaveJob(int seekerId, int jobId) {
        try {
            String sql = "DELETE FROM saved_jobs WHERE seeker_id = ? AND job_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, seekerId);
                ps.setInt(2, jobId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Check if a job is saved by a seeker. */
    public boolean isJobSaved(int seekerId, int jobId) {
        try {
            String sql = "SELECT 1 FROM saved_jobs WHERE seeker_id = ? AND job_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, seekerId);
                ps.setInt(2, jobId);
                try (ResultSet rs = ps.executeQuery()) {
                    return rs.next();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Get all saved job IDs for a seeker (for quick lookup on browse page). */
    public Set<Integer> getSavedJobIds(int seekerId) {
        Set<Integer> ids = new HashSet<>();
        try {
            String sql = "SELECT job_id FROM saved_jobs WHERE seeker_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, seekerId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        ids.add(rs.getInt("job_id"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ids;
    }

    /** Get all saved jobs for a seeker (full Job objects). */
    public List<Job> getSavedJobs(int seekerId) {
        List<Job> jobs = new ArrayList<>();
        try {
            String sql = "SELECT j.* FROM saved_jobs s JOIN jobs j ON s.job_id = j.job_id WHERE s.seeker_id = ? ORDER BY s.saved_at DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, seekerId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Job job = new Job();
                        job.setJobId(rs.getInt("job_id"));
                        job.setEmployerId(rs.getInt("employer_id"));
                        job.setTitle(rs.getString("title"));
                        job.setDescription(rs.getString("description"));
                        job.setCategory(rs.getString("category"));
                        job.setLocationCity(rs.getString("location_city"));
                        job.setSalaryRange(rs.getString("salary_range"));
                        job.setJobType(rs.getString("job_type"));
                        job.setPostedAt(rs.getTimestamp("posted_at"));
                        job.setDeadline(rs.getDate("deadline"));
                        job.setStatus(rs.getString("status"));
                        job.setApprovedAt(rs.getTimestamp("approved_at"));
                        int approvedBy = rs.getInt("approved_by");
                        job.setApprovedBy(rs.wasNull() ? null : approvedBy);
                        jobs.add(job);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobs;
    }

    /** Count saved jobs for a seeker. */
    public long getSavedJobCount(int seekerId) {
        try {
            String sql = "SELECT COUNT(*) AS total FROM saved_jobs WHERE seeker_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, seekerId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next())
                        return rs.getLong("total");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
