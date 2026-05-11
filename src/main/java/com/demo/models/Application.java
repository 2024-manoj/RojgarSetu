package com.demo.models;

import java.sql.Timestamp;

public class Application {

    private int id;
    private int jobId;
    private int seekerId;
    private String coverLetter;
    private String status;     // pending, shortlisted, rejected, hired
    private Timestamp appliedAt;
    private Timestamp reviewedAt;

    public Application() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getJobId() { return jobId; }
    public void setJobId(int jobId) { this.jobId = jobId; }

    public int getSeekerId() { return seekerId; }
    public void setSeekerId(int seekerId) { this.seekerId = seekerId; }

    public String getCoverLetter() { return coverLetter; }
    public void setCoverLetter(String coverLetter) { this.coverLetter = coverLetter; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getAppliedAt() { return appliedAt; }
    public void setAppliedAt(Timestamp appliedAt) { this.appliedAt = appliedAt; }

    public Timestamp getReviewedAt() { return reviewedAt; }
    public void setReviewedAt(Timestamp reviewedAt) { this.reviewedAt = reviewedAt; }
}