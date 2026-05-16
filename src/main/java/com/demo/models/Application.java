package com.demo.models;

import java.sql.Timestamp;

/**
 * Represents a job application submitted by a seeker for a specific job posting.
 * Stores cover letter, resume path, application status, and timestamps for tracking
 * the lifecycle of an application from submission to review.
 *
 * @author Manoj Katuwal
 */
public class Application {

    private int id;
    private int jobId;
    private int seekerId;
    private String coverLetter;
    private String resumePath;
    private String status;
    private Timestamp appliedAt;
    private Timestamp reviewedAt;

    private String jobTitle;
    private String seekerName;
    private String seekerEmail;

    /**
     * Default no-argument constructor.
     */
    public Application() {}

    /**
     * Gets the unique application ID.
     *
     * @return the application ID
     */
    public int getId() { return id; }

    /**
     * Sets the unique application ID.
     *
     * @param id the application ID to set
     */
    public void setId(int id) { this.id = id; }

    /**
     * Gets the job ID this application is associated with.
     *
     * @return the job ID
     */
    public int getJobId() { return jobId; }

    /**
     * Sets the job ID this application is associated with.
     *
     * @param jobId the job ID to set
     */
    public void setJobId(int jobId) { this.jobId = jobId; }

    /**
     * Gets the seeker's user ID who submitted this application.
     *
     * @return the seeker ID
     */
    public int getSeekerId() { return seekerId; }

    /**
     * Sets the seeker's user ID who submitted this application.
     *
     * @param seekerId the seeker ID to set
     */
    public void setSeekerId(int seekerId) { this.seekerId = seekerId; }

    /**
     * Gets the cover letter text submitted with the application.
     *
     * @return the cover letter content
     */
    public String getCoverLetter() { return coverLetter; }

    /**
     * Sets the cover letter text submitted with the application.
     *
     * @param coverLetter the cover letter content to set
     */
    public void setCoverLetter(String coverLetter) { this.coverLetter = coverLetter; }

    /**
     * Gets the file path to the uploaded resume.
     *
     * @return the resume file path
     */
    public String getResumePath() { return resumePath; }

    /**
     * Sets the file path to the uploaded resume.
     *
     * @param resumePath the resume file path to set
     */
    public void setResumePath(String resumePath) { this.resumePath = resumePath; }

    /**
     * Gets the current status of the application (pending, shortlisted, rejected, hired).
     *
     * @return the application status
     */
    public String getStatus() { return status; }

    /**
     * Sets the current status of the application.
     *
     * @param status the application status to set
     */
    public void setStatus(String status) { this.status = status; }

    /**
     * Gets the timestamp when the application was submitted.
     *
     * @return the applied-at timestamp
     */
    public Timestamp getAppliedAt() { return appliedAt; }

    /**
     * Sets the timestamp when the application was submitted.
     *
     * @param appliedAt the applied-at timestamp to set
     */
    public void setAppliedAt(Timestamp appliedAt) { this.appliedAt = appliedAt; }

    /**
     * Gets the timestamp when the application was reviewed by the employer.
     *
     * @return the reviewed-at timestamp
     */
    public Timestamp getReviewedAt() { return reviewedAt; }

    /**
     * Sets the timestamp when the application was reviewed by the employer.
     *
     * @param reviewedAt the reviewed-at timestamp to set
     */
    public void setReviewedAt(Timestamp reviewedAt) { this.reviewedAt = reviewedAt; }

    /**
     * Gets the job title (transient display field, not persisted).
     *
     * @return the job title
     */
    public String getJobTitle() { return jobTitle; }

    /**
     * Sets the job title (transient display field, not persisted).
     *
     * @param jobTitle the job title to set
     */
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }

    /**
     * Gets the seeker's full name (transient display field, not persisted).
     *
     * @return the seeker's name
     */
    public String getSeekerName() { return seekerName; }

    /**
     * Sets the seeker's full name (transient display field, not persisted).
     *
     * @param seekerName the seeker's name to set
     */
    public void setSeekerName(String seekerName) { this.seekerName = seekerName; }

    /**
     * Gets the seeker's email address (transient display field, not persisted).
     *
     * @return the seeker's email
     */
    public String getSeekerEmail() { return seekerEmail; }

    /**
     * Sets the seeker's email address (transient display field, not persisted).
     *
     * @param seekerEmail the seeker's email to set
     */
    public void setSeekerEmail(String seekerEmail) { this.seekerEmail = seekerEmail; }
}
