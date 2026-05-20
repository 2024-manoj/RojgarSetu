package com.demo.utils;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class for password hashing and verification using BCrypt.
 * Centralizes all password-related operations to ensure consistent
 * hashing across registration, login, and password change flows.
 *
 * @author Manoj Katuwal
 */
public class PasswordUtils {

    /**
     * Hashes a plain-text password using BCrypt with a randomly generated salt.
     *
     * @param plainPassword the plain-text password to hash
     * @return the BCrypt hashed password string
     */
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    /**
     * Verifies a plain-text password against a BCrypt hashed password.
     *
     * @param plainPassword  the plain-text password to check
     * @param hashedPassword the BCrypt hashed password to compare against
     * @return true if the password matches, false otherwise
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}
