package com.demo.models;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Represents a job posting on the RojgarSetu platform.
 * Contains all details about a job including title, description, category,
 * location, salary range, type, deadlines, and approval workflow information.
 *
 * @author Manoj Katuwal
 */
public class Job {
    private int jobId;
    private int employerId;
    private String title;
    private String description;
    private String category;
    private String locationCity;
    private String salaryRange;
    private String jobType;
    private Timestamp postedAt;
    private Date deadline;
    private String status;
    private Timestamp approvedAt;
    private Integer approvedBy;

    /**
     * Default no-argument constructor.
     */
    public Job() {}

    /**
     * Constructs a Job with all the provided job posting details.
     *
     * @param jobId        unique job ID
     * @param employerId   ID of the employer who posted this job
     * @param title        job title
     * @param description  detailed job description
     * @param category     job category (e.g., IT, Healthcare, Engineering)
     * @param locationCity city or district where the job is located
     * @param salaryRange  salary range offered (e.g., "20000-30000")
     * @param jobType      type of employment (Full-time, Part-time, Contract, Internship)
     * @param postedAt     timestamp when the job was posted
     * @param deadline     application deadline date
     * @param status       current job status (pending, approved, rejected, expired)
     * @param approvedAt   timestamp when the job was approved by admin
     * @param approvedBy   ID of the admin who approved the job
     */
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

    /**
     * Gets the unique job ID.
     *
     * @return the job ID
     */
    public int getJobId() {
        return jobId;
    }

    /**
     * Sets the unique job ID.
     *
     * @param jobId the job ID to set
     */
    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    /**
     * Gets the employer's user ID who posted this job.
     *
     * @return the employer ID
     */
    public int getEmployerId() {
        return employerId;
    }

    /**
     * Sets the employer's user ID who posted this job.
     *
     * @param employerId the employer ID to set
     */
    public void setEmployerId(int employerId) {
        this.employerId = employerId;
    }

    /**
     * Gets the job title.
     *
     * @return the job title
     */
    public String getTitle() {
        return title;
    }

    /**
     * Sets the job title.
     *
     * @param title the job title to set
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * Gets the detailed job description.
     *
     * @return the job description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the detailed job description.
     *
     * @param description the job description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Gets the job category.
     *
     * @return the category
     */
    public String getCategory() {
        return category;
    }

    /**
     * Sets the job category.
     *
     * @param category the category to set
     */
    public void setCategory(String category) {
        this.category = category;
    }

    /**
     * Gets the city or district where the job is located.
     *
     * @return the location city
     */
    public String getLocationCity() {
        return locationCity;
    }

    /**
     * Sets the city or district where the job is located.
     *
     * @param locationCity the location city to set
     */
    public void setLocationCity(String locationCity) {
        this.locationCity = locationCity;
    }

    /**
     * Gets the salary range offered for this job.
     *
     * @return the salary range
     */
    public String getSalaryRange() {
        return salaryRange;
    }

    /**
     * Sets the salary range offered for this job.
     *
     * @param salaryRange the salary range to set
     */
    public void setSalaryRange(String salaryRange) {
        this.salaryRange = salaryRange;
    }

    /**
     * Gets the type of employment (Full-time, Part-time, Contract, Internship).
     *
     * @return the job type
     */
    public String getJobType() {
        return jobType;
    }

    /**
     * Sets the type of employment.
     *
     * @param jobType the job type to set
     */
    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    /**
     * Gets the timestamp when the job was posted.
     *
     * @return the posted-at timestamp
     */
    public Timestamp getPostedAt() {
        return postedAt;
    }

    /**
     * Sets the timestamp when the job was posted.
     *
     * @param postedAt the posted-at timestamp to set
     */
    public void setPostedAt(Timestamp postedAt) {
        this.postedAt = postedAt;
    }

    /**
     * Gets the application deadline date.
     *
     * @return the deadline date
     */
    public Date getDeadline() {
        return deadline;
    }

    /**
     * Sets the application deadline date.
     *
     * @param deadline the deadline date to set
     */
    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }

    /**
     * Gets the current job status (pending, approved, rejected, expired).
     *
     * @return the job status
     */
    public String getStatus() {
        return status;
    }

    /**
     * Sets the current job status.
     *
     * @param status the job status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * Gets the timestamp when the job was approved by an admin.
     *
     * @return the approved-at timestamp
     */
    public Timestamp getApprovedAt() {
        return approvedAt;
    }

    /**
     * Sets the timestamp when the job was approved by an admin.
     *
     * @param approvedAt the approved-at timestamp to set
     */
    public void setApprovedAt(Timestamp approvedAt) {
        this.approvedAt = approvedAt;
    }

    /**
     * Gets the ID of the admin who approved this job.
     *
     * @return the admin user ID, or null if not yet approved
     */
    public Integer getApprovedBy() {
        return approvedBy;
    }

    /**
     * Sets the ID of the admin who approved this job.
     *
     * @param approvedBy the admin user ID to set
     */
    public void setApprovedBy(Integer approvedBy) {
        this.approvedBy = approvedBy;
    }
}
