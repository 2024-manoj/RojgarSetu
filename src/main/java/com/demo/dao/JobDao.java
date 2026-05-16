package com.demo.dao;

import com.demo.models.Job;
import java.sql.*;
import java.util.*;

/**
 * DAO for core jobs table operations.
 * Handles: CRUD, filtering, approval workflow.
 *
 * Application ops are delegated to ApplicationDao.
 * Stats/counts are delegated to StatsDao.
 *
 * @author Manoj Katuwal
 */
public class JobDao {
    private Connection conn;

    public JobDao(Connection conn) {
        this.conn = conn;
    }

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
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

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

    public List<Job> getAllJobs() {
        return queryJobs("SELECT * FROM jobs ORDER BY posted_at DESC");
    }

    public List<Job> getApprovedJobs() {
        return queryJobs("SELECT * FROM jobs WHERE status = 'approved' ORDER BY posted_at DESC");
    }

    /** Get distinct non-empty categories from approved jobs. */
    public List<String> getDistinctCategories() {
        List<String> cats = new ArrayList<>();
        try {
            String sql = "SELECT DISTINCT category FROM jobs WHERE status = 'approved' AND category IS NOT NULL AND TRIM(category) != '' ORDER BY category";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    cats.add(rs.getString("category"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cats;
    }

    /** Get distinct non-empty locations from approved jobs. */
    public List<String> getDistinctLocations() {
        List<String> locs = new ArrayList<>();
        try {
            String sql = "SELECT DISTINCT location_city FROM jobs WHERE status = 'approved' AND location_city IS NOT NULL AND TRIM(location_city) != '' ORDER BY location_city";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    locs.add(rs.getString("location_city"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return locs;
    }

    public List<Job> searchApprovedJobs(String keyword, String district, String[] categories, String[] locations) {
        List<Job> jobs = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM jobs WHERE status = 'approved'");
        List<String> params = new ArrayList<>();

        if (keyword != null && !keyword.isBlank()) {
            sql.append(" AND (LOWER(title) LIKE ? OR LOWER(category) LIKE ? OR LOWER(description) LIKE ?)");
            String like = "%" + keyword.trim().toLowerCase().replace("-", " ") + "%";
            params.add(like);
            params.add(like);
            params.add(like);
        }

        if (district != null && !district.isBlank()) {
            sql.append(" AND LOWER(location_city) LIKE ?");
            params.add("%" + district.trim().toLowerCase().replace("-", " ") + "%");
        }

        appendInFilter(sql, params, "category", categories);
        appendInFilter(sql, params, "location_city", locations);
        sql.append(" ORDER BY posted_at DESC");

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setString(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    jobs.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobs;
    }

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

    public List<Job> getRecentJobsByEmployer(int employerId, int limit) {
        List<Job> jobs = new ArrayList<>();
        try {
            String sql = "SELECT * FROM jobs WHERE employer_id = ? ORDER BY posted_at DESC LIMIT ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, employerId);
                ps.setInt(2, limit);
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

    public boolean updateJob(Job job) {
        try {
            String sql = "UPDATE jobs SET title=?, description=?, category=?, location_city=?, salary_range=?, job_type=?, deadline=? WHERE job_id=? AND employer_id=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, job.getTitle());
                ps.setString(2, job.getDescription());
                ps.setString(3, job.getCategory());
                ps.setString(4, job.getLocationCity());
                ps.setString(5, job.getSalaryRange());
                ps.setString(6, job.getJobType());
                ps.setDate(7, job.getDeadline());
                ps.setInt(8, job.getJobId());
                ps.setInt(9, job.getEmployerId());
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateJobStatus(int jobId, String status) {
        try {
            String sql = "UPDATE jobs SET status = ? WHERE job_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setInt(2, jobId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean approveJob(int jobId, int adminId) {
        try {
            String sql = "UPDATE jobs SET status = 'approved', approved_at = NOW(), approved_by = ? WHERE job_id = ? AND LOWER(TRIM(status)) = 'pending'";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, adminId);
                ps.setInt(2, jobId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean rejectJob(int jobId) {
        try {
            String sql = "UPDATE jobs SET status = 'rejected' WHERE job_id = ? AND LOWER(TRIM(status)) = 'pending'";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, jobId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteJob(int jobId) {
        try {
            String sql = "DELETE FROM jobs WHERE job_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, jobId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteJobByEmployer(int jobId, int employerId) {
        try {
            String sql = "DELETE FROM jobs WHERE job_id = ? AND employer_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, jobId);
                ps.setInt(2, employerId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private List<Job> queryJobs(String sql) {
        List<Job> jobs = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                jobs.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobs;
    }

    private void appendInFilter(StringBuilder sql, List<String> params, String column, String[] values) {
        if (values == null || values.length == 0) {
            return;
        }

        List<String> cleanValues = new ArrayList<>();
        for (String value : values) {
            if (value != null && !value.isBlank()) {
                cleanValues.add(value.trim().toLowerCase());
            }
        }
        if (cleanValues.isEmpty()) {
            return;
        }

        sql.append(" AND LOWER(").append(column).append(") IN (");
        for (int i = 0; i < cleanValues.size(); i++) {
            if (i > 0)
                sql.append(",");
            sql.append("?");
            params.add(cleanValues.get(i));
        }
        sql.append(")");
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
}
