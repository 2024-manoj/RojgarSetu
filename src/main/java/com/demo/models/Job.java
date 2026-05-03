package com.demo.models;



import java.sql.Date;
import java.sql.Timestamp;

public class Job {
    private int jobId;
    private int employerId;
    private String title;
    private String description;
    private String category;
    private String locationCity;
    private String salaryRange;
    private String jobType; // Full-time, Part-time, Contract, Internship
    private Timestamp postedAt;
    private Date deadline;
    private String status; // pending, approved, rejected, expired
    private Timestamp approvedAt;
    private Integer approvedBy;

    // --- Constructors ---
    public Job() {}

    public Job(int jobId, int employerId, String title, String description, String category,
               String locationCity, String salaryRange, String jobType, Timestamp postedAt,
               Date deadline, String status, Timestamp approvedAt, Integer approvedBy) {
        this.jobId = jobId;
        this.employerId = employerId;
        this.title = title;
        this.description = description;
        this.category = category;
        this.locationCity = locationCity;
        this.salaryRange = salaryRange;
        this.jobType = jobType;
        this.postedAt = postedAt;
        this.deadline = deadline;
        this.status = status;
        this.approvedAt = approvedAt;
        this.approvedBy = approvedBy;
    }

    // --- Getters and Setters ---
    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public int getEmployerId() {
        return employerId;
    }

    public void setEmployerId(int employerId) {
        this.employerId = employerId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getLocationCity() {
        return locationCity;
    }

    public void setLocationCity(String locationCity) {
        this.locationCity = locationCity;
    }

    public String getSalaryRange() {
        return salaryRange;
    }

    public void setSalaryRange(String salaryRange) {
        this.salaryRange = salaryRange;
    }

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public Timestamp getPostedAt() {
        return postedAt;
    }

    public void setPostedAt(Timestamp postedAt) {
        this.postedAt = postedAt;
    }

    public Date getDeadline() {
        return deadline;
    }

    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getApprovedAt() {
        return approvedAt;
    }

    public void setApprovedAt(Timestamp approvedAt) {
        this.approvedAt = approvedAt;
    }

    public Integer getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(Integer approvedBy) {
        this.approvedBy = approvedBy;
    }


}

