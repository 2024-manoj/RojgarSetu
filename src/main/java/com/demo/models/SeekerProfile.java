package com.demo.models;

/**
 * Represents the extended profile of a job seeker on the RojgarSetu platform.
 * Stores professional details such as skills, education, experience,
 * resume path, and address information linked to a user account.
 *
 * @author Manoj Katuwal
 */
public class SeekerProfile {
    private int id;
    private int userId;
    private String skills;
    private String education;
    private int experienceYear;
    private String resumePath;
    private String addressCity;

    /**
     * Constructs a SeekerProfile with the provided seeker details.
     *
     * @param id             unique profile ID
     * @param userId         linked user account ID
     * @param addressCity    seeker's city or district
     * @param skills         comma-separated skills
     * @param education      highest education qualification
     * @param experienceYear years of professional experience
     * @param resumePath     file path to the uploaded resume
     */
    public SeekerProfile(int id, int userId, String addressCity, String skills,
            String education, int experienceYear, String resumePath) {
        this.id = id;
        this.userId = userId;
        this.addressCity = addressCity;
        this.skills = skills;
        this.education = education;
        this.experienceYear = experienceYear;
        this.resumePath = resumePath;
    }

    /** Default no-argument constructor. */
    public SeekerProfile() {}

    /** @return the profile ID */
    public int getId() { return id; }
    /** @param id the profile ID to set */
    public void setId(int id) { this.id = id; }

    /** @return the user ID */
    public int getUserId() { return userId; }
    /** @param userId the user ID to set */
    public void setUserId(int userId) { this.userId = userId; }

    /** @return the comma-separated skills */
    public String getSkills() { return skills; }
    /** @param skills the skills to set */
    public void setSkills(String skills) { this.skills = skills; }

    /** @return the education level */
    public String getEducation() { return education; }
    /** @param education the education level to set */
    public void setEducation(String education) { this.education = education; }

    /** @return the experience in years */
    public int getExperienceYear() { return experienceYear; }
    /** @param experienceYear the experience in years to set */
    public void setExperienceYear(int experienceYear) { this.experienceYear = experienceYear; }

    /** @return the resume file path */
    public String getResumePath() { return resumePath; }
    /** @param resumePath the resume file path to set */
    public void setResumePath(String resumePath) { this.resumePath = resumePath; }

    /** @return the address city */
    public String getAddressCity() { return addressCity; }
    /** @param addressCity the address city to set */
    public void setAddressCity(String addressCity) { this.addressCity = addressCity; }
}
