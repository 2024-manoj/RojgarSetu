package com.demo.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utility class for establishing database connections to the RojgarSetu MySQL database.
 * Provides a static factory method to obtain a JDBC connection using
 * the configured database URL, username, and password.
 *
 * @author Manoj Katuwal
 */
public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/rojgarsetu";
    private static final String USER = "root";
    private static final String PASSWORD = "6767";

    /**
     * Creates and returns a new JDBC connection to the RojgarSetu database.
     *
     * @return a new database connection
     * @throws SQLException if the MySQL driver is not found or connection fails
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySql driver not found");
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

}
