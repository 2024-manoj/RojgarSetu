package com.demo.models;

import java.util.Date;

/**
 * Represents the extended profile of an employer on the RojgarSetu platform.
 * Stores company details such as name, address, category, description,
 * contact person, and admin verification information.
 *
 * @author Manoj Katuwal
 */
public class EmployerProfile {
    private int id;
    private int userId;
    private String companyName;
    private String companyAddress;
    private String companyCategory;
    private String companyDescription;
    private String contactPerson;
    private Integer verifiedBy;
    private Date verifiedAt;
    private String companyCity;

    /**
     * Constructs an EmployerProfile with all provided company details.
     *
     * @param id                 unique profile ID
     * @param userId             linked user account ID
     * @param companyName        name of the company
     * @param companyAddress     full company address
     * @param companyCategory    industry or business category
     * @param companyDescription brief description of the company
     * @param contactPerson      name of the contact person
     * @param verifiedBy         admin user ID who verified this profile
     * @param verifiedAt         timestamp of profile verification
     * @param companyCity        city where the company is located
     */
    public EmployerProfile(int id, int userId, String companyName, String companyAddress,
            String companyCategory, String companyDescription, String contactPerson,
            Integer verifiedBy, Date verifiedAt, String companyCity) {
        this.id = id;
        this.userId = userId;
        this.companyName = companyName;
        this.companyAddress = companyAddress;
        this.companyCategory = companyCategory;
        this.companyDescription = companyDescription;
        this.contactPerson = contactPerson;
        this.verifiedBy = verifiedBy;
        this.verifiedAt = verifiedAt;
        this.companyCity = companyCity;
    }

    /** Default no-argument constructor. */
    public EmployerProfile() {}

    /** @return the profile ID */
    public int getId() { return id; }
    /** @param id the profile ID to set */
    public void setId(int id) { this.id = id; }

    /** @return the user ID */
    public int getUserId() { return userId; }
    /** @param userId the user ID to set */
    public void setUserId(int userId) { this.userId = userId; }

    /** @return the company name */
    public String getCompanyName() { return companyName; }
    /** @param companyName the company name to set */
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    /** @return the company address */
    public String getCompanyAddress() { return companyAddress; }
    /** @param companyAddress the company address to set */
    public void setCompanyAddress(String companyAddress) { this.companyAddress = companyAddress; }

    /** @return the company category */
    public String getCompanyCategory() { return companyCategory; }
    /** @param companyCity the company category to set */
    public void setCompanyCategory(String companyCity) { this.companyCategory = companyCity; }

    /** @return the company description */
    public String getCompanyDescription() { return companyDescription; }
    /** @param companyDescription the company description to set */
    public void setCompanyDescription(String companyDescription) { this.companyDescription = companyDescription; }

    /** @return the contact person name */
    public String getContactPerson() { return contactPerson; }
    /** @param contactPerson the contact person name to set */
    public void setContactPerson(String contactPerson) { this.contactPerson = contactPerson; }

    /** @return the admin user ID who verified this profile */
    public Integer getVerifiedBy() { return verifiedBy; }
    /** @param verifiedBy the admin user ID to set */
    public void setVerifiedBy(Integer verifiedBy) { this.verifiedBy = verifiedBy; }

    /** @return the verification timestamp */
    public Date getVerifiedAt() { return verifiedAt; }
    /** @param verifiedAt the verification timestamp to set */
    public void setVerifiedAt(Date verifiedAt) { this.verifiedAt = verifiedAt; }

    /** @return the company city */
    public String getCompanyCity() { return companyCity; }
    /** @param companyCity the company city to set */
    public void setCompanyCity(String companyCity) { this.companyCity = companyCity; }
}
