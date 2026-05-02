package com.demo.models;

public class SeekerProfile {
    private int id;
    private int userId;
    private String skills;
    private String education;
    private int experienceYear;
    private String resumePath;
    private String addressCity;

    // Constructor
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

    public SeekerProfile() {

    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }

    public String getEducation() { return education; }
    public void setEducation(String education) { this.education = education; }

    public int getExperienceYear() { return experienceYear; }
    public void setExperienceYear(int experienceYear) { this.experienceYear = experienceYear; }

    public String getResumePath() { return resumePath; }
    public void setResumePath(String resumePath) { this.resumePath = resumePath; }

    public String getAddressCity() { return addressCity; }
    public void setAddressCity(String addressCity) { this.addressCity = addressCity; }
}
