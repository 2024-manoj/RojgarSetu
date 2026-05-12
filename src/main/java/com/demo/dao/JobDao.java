package com.demo.dao;

import com.demo.models.Job;
import java.sql.*;
import java.util.*;

public class JobDao {
    private Connection conn;

    public JobDao(Connection conn) {
        this.conn = conn;
    }

    // Create new job
    public boolean createJob(Job job) {
        try {
            String sql = "INSERT INTO jobs(employer_id, title, description, category, location_city, salary_range, job_type, deadline, status) VALUES(?,?,?,?,?,?,?,?,?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, job.getEmployerId());
                ps.setString(2, job.getTitle());
                ps.setString(3, job.getDescription());
                ps.setString(4, job.getCategory());
                ps.setString(5, job.getLocationCity());
                ps.setString(6, job.getSalaryRange());
                ps.setString(7, job.getJobType());
                ps.setDate(8, new java.sql.Date(job.getDeadline().getTime()));
                ps.setString(9, "pending");

                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get job by ID
    public Job getJobById(int jobId) {
        Job job = null;
        try {
            String sql = "SELECT * FROM jobs WHERE job_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, jobId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        job = mapRow(rs);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return job;
    }

    public List<Job> getRecentPendingJobs(int limit) {
        List<Job> jobs = new ArrayList<>();
        try {
            String sql = "SELECT * FROM jobs WHERE LOWER(TRIM(status)) = 'pending' ORDER BY posted_at DESC LIMIT ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, limit);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        jobs.add(mapRow(rs));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobs;
    }

    private Job mapRow(ResultSet rs) throws SQLException {
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
        return job;
    }

    // Get all jobs
    public List<Job> getAllJobs() {
        List<Job> jobs = new ArrayList<>();
        try {
            String sql = "SELECT * FROM jobs ORDER BY posted_at DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        jobs.add(mapRow(rs));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobs;
    }

    // Get jobs by employer
    public List<Job> getJobsByEmployer(int employerId) {
        List<Job> jobs = new ArrayList<>();
        try {
            String sql = "SELECT * FROM jobs WHERE employer_id = ? ORDER BY posted_at DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, employerId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        jobs.add(mapRow(rs));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobs;
    }

    // Get approved jobs (for seekers to view)
    public List<Job> getApprovedJobs() {
        List<Job> jobs = new ArrayList<>();
        try {
            String sql = "SELECT * FROM jobs WHERE status = 'approved' ORDER BY posted_at DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        jobs.add(mapRow(rs));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobs;
    }

    // Update job status
    public boolean updateJobStatus(int jobId, String status) {
        try {
            String sql = "UPDATE jobs SET status = ? WHERE job_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setInt(2, jobId);
                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Approve job
    public boolean approveJob(int jobId, int adminId) {
        try {
            String sql = "UPDATE jobs SET status = 'approved', approved_at = NOW(), approved_by = ? WHERE job_id = ? AND LOWER(TRIM(status)) = 'pending'";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, adminId);
                ps.setInt(2, jobId);
                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Reject job
    public boolean rejectJob(int jobId) {
        try {
            String sql = "UPDATE jobs SET status = 'rejected' WHERE job_id = ? AND LOWER(TRIM(status)) = 'pending'";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, jobId);
                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete job
    public boolean deleteJob(int jobId) {
        try {
            String sql = "DELETE FROM jobs WHERE job_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, jobId);
                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get total job count
    public long getTotalJobs() {
        try {
            String sql = "SELECT COUNT(*) as total FROM jobs";
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

    // Get pending job count
    public long getPendingJobs() {
        try {
            String sql = "SELECT COUNT(*) as total FROM jobs WHERE status = 'pending'";
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

    // Get approved job count
    public long getApprovedJobCount() {
        try {
            String sql = "SELECT COUNT(*) as total FROM jobs WHERE status = 'approved'";
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

    // Get expired job count
    public long getExpiredJobs() {
        try {
            String sql = "SELECT COUNT(*) as total FROM jobs WHERE status = 'expired'";
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

    // Search jobs by category
    public List<Job> getJobsByCategory(String category) {
        List<Job> jobs = new ArrayList<>();
        try {
            String sql = "SELECT * FROM jobs WHERE category = ? AND status = 'approved' ORDER BY posted_at DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, category);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        jobs.add(mapRow(rs));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobs;
    }

    // Search jobs by location
    public List<Job> getJobsByLocation(String location) {
        List<Job> jobs = new ArrayList<>();
        try {
            String sql = "SELECT * FROM jobs WHERE location_city = ? AND status = 'approved' ORDER BY posted_at DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, location);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        jobs.add(mapRow(rs));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobs;
    }

    // ===== APPLICATION METHODS =====

    /** Get all applications submitted by a seeker (joined with job title). */
    public List<com.demo.models.Application> getApplicationsBySeeker(int seekerId) {
        List<com.demo.models.Application> apps = new ArrayList<>();
        try {
            String sql = "SELECT * FROM applications WHERE seeker_id = ? ORDER BY applied_at DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, seekerId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        com.demo.models.Application a = new com.demo.models.Application();
                        a.setId(rs.getInt("id"));
                        a.setJobId(rs.getInt("job_id"));
                        a.setSeekerId(rs.getInt("seeker_id"));
                        a.setCoverLetter(rs.getString("cover_letter"));
                        a.setStatus(rs.getString("status"));
                        a.setAppliedAt(rs.getTimestamp("applied_at"));
                        a.setReviewedAt(rs.getTimestamp("reviewed_at"));
                        apps.add(a);
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

    /** Insert a new application. */
    public boolean createApplication(com.demo.models.Application app) {
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
}

