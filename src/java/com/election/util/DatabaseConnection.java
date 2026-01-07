package com.election.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    
    // Connection details for NetBeans database
    private static final String URL = "jdbc:derby://localhost:1527/StudentElectionDB";
    private static final String USER = "app";
    private static final String PASSWORD = "app";
    
    // Static block to load driver and test connection
    static {
        loadDriver();
    }
    
    private static void loadDriver() {
        try {
            // Try to load the Derby client driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            System.out.println("✅ Derby ClientDriver loaded successfully");
            
            // Optional: Test connection on startup
            testConnectionSilently();
            
        } catch (ClassNotFoundException e) {
            System.err.println("❌ CRITICAL: Derby ClientDriver not found!");
            System.err.println("Please add derbyclient.jar to project libraries");
            System.err.println("Path: C:\\Program Files\\javadb\\lib\\derbyclient.jar");
        }
    }
    
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    
    private static void testConnectionSilently() {
        try (Connection conn = getConnection()) {
            System.out.println("✅ Database connection test passed");
            System.out.println("   Database: " + conn.getCatalog());
        } catch (SQLException e) {
            System.err.println("⚠️  Database connection test failed");
            System.err.println("   Error: " + e.getMessage());
            System.err.println("   Make sure:");
            System.err.println("   1. Java DB Server is running");
            System.err.println("   2. StudentElectionDB exists");
        }
    }
    
    public static void testConnection() {
        System.out.println("\n=== Database Connection Test ===");
        System.out.println("URL: " + URL);
        System.out.println("User: " + USER);
        
        try {
            // Test driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            System.out.println("✅ Driver: Loaded");
            
            // Test connection
            try (Connection conn = getConnection()) {
                System.out.println("✅ Connection: Successful");
                System.out.println("   Database: " + conn.getCatalog());
                System.out.println("   Auto-commit: " + conn.getAutoCommit());
            }
            
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Driver: NOT FOUND");
            System.err.println("Fix: Add derbyclient.jar to project libraries");
        } catch (SQLException e) {
            System.err.println("❌ Connection: FAILED");
            System.err.println("   Error: " + e.getMessage());
            System.err.println("   SQL State: " + e.getSQLState());
        }
        
        System.out.println("===============================\n");
    }
    
    // For use in servlets/JSPs
    public static String getConnectionStatus() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            try (Connection conn = getConnection()) {
                return "✅ Connected to " + conn.getCatalog();
            }
        } catch (ClassNotFoundException e) {
            return "❌ Driver missing: derbyclient.jar";
        } catch (SQLException e) {
            return "❌ Connection failed: " + e.getMessage();
        }
    }
}