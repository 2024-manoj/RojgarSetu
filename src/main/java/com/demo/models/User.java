package com.demo.models;

import java.sql.Timestamp;
import java.util.Date;

/**
 * Represents a registered user in the RojgarSetu platform.
 * Supports three roles: SEEKER, EMPLOYER, and ADMIN.
 * Stores basic personal information, authentication credentials,
 * account status, and registration timestamp.
 *
 * @author Manoj Katuwal
 */
public class User {
    private int id;
    private String fullName;
    private String email;
    private String phone;
    private String password;
    private String role;
    private String status;
    private String location;
    private Date dob;
    private Timestamp createdAt;

    /**
     * Constructs a User with the provided personal and account information.
     *
     * @param id            unique user ID
     * @param fullName      user's full name
     * @param email         user's email address
     * @param phone         user's phone number
     * @param password      hashed password
     * @param role          user role (SEEKER, EMPLOYER, ADMIN)
     * @param location      user's city or district
     * @param status        account status (PENDING, APPROVED, REJECTED)
     * @param dob           user's date of birth
     * @param createdAt     account creation timestamp
     * @param education     seeker's education (unused, kept for compatibility)
     * @param companyName   employer's company name (unused, kept for compatibility)
     * @param industryType  employer's industry type (unused, kept for compatibility)
     */
    public User(int id, String fullName, String email, String phone, String password, String role, String location,
            String status, Date dob, Timestamp createdAt, String education, String companyName, String industryType) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.role = role;
        this.location = location;
        this.status = status;
        this.dob = dob;
        this.createdAt = createdAt;

    }

    /**
     * Default no-argument constructor.
     */
    public User() {

    }

    /**
     * Gets the unique user ID.
     *
     * @return the user ID
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the unique user ID.
     *
     * @param id the user ID to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Gets the account creation timestamp.
     *
     * @return the created-at timestamp
     */
    public Timestamp getCreatedAt() {
        return createdAt;
    }

    /**
     * Sets the account creation timestamp.
     *
     * @param createdAt the created-at timestamp to set
     */
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * Gets the user's date of birth.
     *
     * @return the date of birth
     */
    public Date getDob() {
        return dob;
    }

    /**
     * Sets the user's date of birth.
     *
     * @param dob the date of birth to set
     */
    public void setDob(Date dob) {
        this.dob = dob;
    }

    /**
     * Gets the user's location (city or district).
     *
     * @return the location
     */
    public String getLocation() {
        return location;
    }

    /**
     * Sets the user's location (city or district).
     *
     * @param location the location to set
     */
    public void setLocation(String location) {
        this.location = location;
    }

    /**
     * Gets the account status (PENDING, APPROVED, REJECTED).
     *
     * @return the account status
     */
    public String getStatus() {
        return status;
    }

    /**
     * Sets the account status.
     *
     * @param status the account status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * Gets the user role (SEEKER, EMPLOYER, ADMIN).
     *
     * @return the user role
     */
    public String getRole() {
        return role;
    }

    /**
     * Sets the user role.
     *
     * @param role the user role to set
     */
    public void setRole(String role) {
        this.role = role;
    }

    /**
     * Gets the hashed password.
     *
     * @return the hashed password
     */
    public String getPassword() {
        return password;
    }

    /**
     * Sets the hashed password.
     *
     * @param password the hashed password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Gets the user's phone number.
     *
     * @return the phone number
     */
    public String getPhone() {
        return phone;
    }

    /**
     * Sets the user's phone number.
     *
     * @param phone the phone number to set
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * Gets the user's email address.
     *
     * @return the email address
     */
    public String getEmail() {
        return email;
    }

    /**
     * Sets the user's email address.
     *
     * @param email the email address to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Gets the user's full name.
     *
     * @return the full name
     */
    public String getFullName() {
        return fullName;
    }

    /**
     * Sets the user's full name.
     *
     * @param fullName the full name to set
     */
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
}