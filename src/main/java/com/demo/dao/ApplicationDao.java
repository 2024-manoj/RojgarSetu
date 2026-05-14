package com.demo.dao;

import com.demo.models.Application;
import com.demo.models.Job;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for applications table operations.
 * Handles all application CRUD and queries.
 */
public class ApplicationDao {
    private Connection conn;

    public ApplicationDao(Connection conn) {
        this.conn = conn;
    }

    /** Insert a new application. */
    public boolean createApplication(Application app) {
        try {
            String sql = "INSERT INTO applications(job_id, seeker_id, cover_letter, status) VALUES(?,?,?,?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, app.getJobId());
                ps.setInt(2, app.getSeekerId());
                ps.setString(3, app.getCoverLetter());
                ps.setString(4, app.getStatus() != null ? app.getStatus() : "pending");
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Check if seeker already applied to a job. */
    public boolean hasApplied(int seekerId, int jobId) {
        try {
            String sql = "SELECT id FROM applications WHERE seeker_id = ? AND job_id = ?";
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

    /** Get all applications submitted by a seeker. */
    public List<Application> getApplicationsBySeeker(int seekerId) {
        List<Application> apps = new ArrayList<>();
        try {
            String sql = "SELECT * FROM applications WHERE seeker_id = ? ORDER BY applied_at DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, seekerId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        apps.add(mapRow(rs));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return apps;
    }

    /** Count applications by seeker. */
    public long getApplicationCountBySeeker(int seekerId) {
        try {
            String sql = "SELECT COUNT(*) AS total FROM applications WHERE seeker_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, seekerId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) return rs.getLong("total");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /** Count total applicants across all jobs of an employer. */
    public long getApplicationCountByEmployer(int employerId) {
        try {
            String sql = "SELECT COUNT(*) AS total FROM applications a JOIN jobs j ON a.job_id = j.job_id WHERE j.employer_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, employerId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) return rs.getLong("total");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /** Get all applications for an employer's jobs with seeker and job info. */
    public List<Application> getApplicationsForEmployer(int employerId) {
        List<Application> apps = new ArrayList<>();
        try {
            String sql = "SELECT a.*, j.title AS job_title, u.full_name AS seeker_name, u.email AS seeker_email " +
                    "FROM applications a " +
                    "JOIN jobs j ON a.job_id = j.job_id " +
                    "JOIN users u ON a.seeker_id = u.id " +
                    "WHERE j.employer_id = ? " +
                    "ORDER BY a.applied_at DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, employerId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Application a = mapRow(rs);
                        a.setJobTitle(rs.getString("job_title"));
                        a.setSeekerName(rs.getString("seeker_name"));
                        a.setSeekerEmail(rs.getString("seeker_email"));
                        apps.add(a);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return apps;
    }

    /** Update application status (only for jobs owned by the employer). */
    public boolean updateApplicationStatus(int applicationId, String status, int employerId) {
        try {
            String sql = "UPDATE applications a JOIN jobs j ON a.job_id = j.job_id " +
                    "SET a.status = ?, a.reviewed_at = NOW() " +
                    "WHERE a.id = ? AND j.employer_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setInt(2, applicationId);
                ps.setInt(3, employerId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Map a ResultSet row to Application. */
    private Application mapRow(ResultSet rs) throws SQLException {
        Application a = new Application();
        a.setId(rs.getInt("id"));
        a.setJobId(rs.getInt("job_id"));
        a.setSeekerId(rs.getInt("seeker_id"));
        a.setCoverLetter(rs.getString("cover_letter"));
        a.setStatus(rs.getString("status"));
        a.setAppliedAt(rs.getTimestamp("applied_at"));
        a.setReviewedAt(rs.getTimestamp("reviewed_at"));
        return a;
    }
}
