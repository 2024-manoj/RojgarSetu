package com.demo.models;

import java.util.Date;

public class EmployerProfile {
    private int id;
    private int userId;
    private String companyName;
    private String companyAddress;
    private String companyCategory;
    private String companyDescription;
    private String contactPerson;
    private Integer verifiedBy;   // admin user id
    private Date verifiedAt;      // timestamp


    public EmployerProfile(int id, int userId, String companyName, String companyAddress,
                           String companyCategory, String companyDescription, String contactPerson,
                           Integer verifiedBy, Date verifiedAt) {
        this.id = id;
        this.userId = userId;
        this.companyName = companyName;
        this.companyAddress = companyAddress;
        this.companyCategory = companyCategory;
        this.companyDescription = companyDescription;
        this.contactPerson = contactPerson;
        this.verifiedBy = verifiedBy;
        this.verifiedAt = verifiedAt;
    }

    public EmployerProfile() {

    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getCompanyAddress() { return companyAddress; }
    public void setCompanyAddress(String companyAddress) { this.companyAddress = companyAddress; }

    public String getCompanyCategory() { return companyCategory; }
    public void setCompanyCategory(String companyCity) { this.companyCategory = companyCity; }

    public String getCompanyDescription() { return companyDescription; }
    public void setCompanyDescription(String companyDescription) { this.companyDescription = companyDescription; }

    public String getContactPerson() { return contactPerson; }
    public void setContactPerson(String contactPerson) { this.contactPerson = contactPerson; }

    public Integer getVerifiedBy() { return verifiedBy; }
    public void setVerifiedBy(Integer verifiedBy) { this.verifiedBy = verifiedBy; }

    public Date getVerifiedAt() { return verifiedAt; }
    public void setVerifiedAt(Date verifiedAt) { this.verifiedAt = verifiedAt; }
}
