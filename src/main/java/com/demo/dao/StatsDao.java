package com.demo.dao;

import java.sql.*;

/**
 * DAO for aggregate statistics / counts.
 * Used primarily by admin dashboard and reports.
 */
public class StatsDao {
    private Connection conn;

    public StatsDao(Connection conn) {
        this.conn = conn;
    }

    // ===== USER STATS =====

    public long getTotalUsers() {
        return countQuery("SELECT COUNT(*) AS total FROM users");
    }

    public long getTotalSeekers() {
        return countQuery("SELECT COUNT(*) AS total FROM users WHERE role = 'SEEKER'");
    }

    public long getTotalEmployers() {
        return countQuery("SELECT COUNT(*) AS total FROM users WHERE role = 'EMPLOYER'");
    }

    public long getPendingUsers() {
        return countQuery("SELECT COUNT(*) AS total FROM users WHERE status = 'PENDING'");
    }

    public long getApprovedUsers() {
        return countQuery("SELECT COUNT(*) AS total FROM users WHERE status = 'APPROVED'");
    }

    public long getRejectedUsers() {
        return countQuery("SELECT COUNT(*) AS total FROM users WHERE status = 'REJECTED'");
    }

    // ===== JOB STATS =====

    public long getTotalJobs() {
        return countQuery("SELECT COUNT(*) AS total FROM jobs");
    }

    public long getPendingJobs() {
        return countQuery("SELECT COUNT(*) AS total FROM jobs WHERE status = 'pending'");
    }

    public long getApprovedJobCount() {
        return countQuery("SELECT COUNT(*) AS total FROM jobs WHERE status = 'approved'");
    }

    public long getExpiredJobs() {
        return countQuery("SELECT COUNT(*) AS total FROM jobs WHERE status = 'expired'");
    }

    // ===== EMPLOYER-SPECIFIC STATS =====

    public long getJobCountByEmployer(int employerId) {
        return countQueryParam("SELECT COUNT(*) AS total FROM jobs WHERE employer_id = ?", employerId);
    }

    public long getActiveJobCountByEmployer(int employerId) {
        return countQueryParam("SELECT COUNT(*) AS total FROM jobs WHERE employer_id = ? AND status = 'approved'", employerId);
    }

    public long getPendingJobCountByEmployer(int employerId) {
        return countQueryParam("SELECT COUNT(*) AS total FROM jobs WHERE employer_id = ? AND status = 'pending'", employerId);
    }

    // ===== HELPERS =====

    private long countQuery(String sql) {
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getLong("total");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private long countQueryParam(String sql, int param) {
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, param);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getLong("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
