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
                        job = new Job();
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
                        job.setApprovedBy(rs.getInt("approved_by"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
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
                        job.setApprovedBy(rs.getInt("approved_by"));
                        jobs.add(job);
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
                        job.setApprovedBy(rs.getInt("approved_by"));
                        jobs.add(job);
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
                        job.setApprovedBy(rs.getInt("approved_by"));
                        jobs.add(job);
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
            String sql = "UPDATE jobs SET status = 'approved', approved_at = NOW(), approved_by = ? WHERE job_id = ?";
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
            String sql = "UPDATE jobs SET status = 'rejected' WHERE job_id = ?";
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
                        job.setApprovedBy(rs.getInt("approved_by"));
                        jobs.add(job);
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
                        job.setApprovedBy(rs.getInt("approved_by"));
                        jobs.add(job);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobs;
    }
}

