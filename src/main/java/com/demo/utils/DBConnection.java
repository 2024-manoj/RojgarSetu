package com.demo.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/rojgarsetu";
    private static final String USER = "root";
    private static final String PASSWORD = "6767";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySql driver not found");
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

}
