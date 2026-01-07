-- Student Election System Database Setup Script
-- Run this script in your MySQL database to create the necessary tables and admin user

-- Create database (if it doesn't exist)
CREATE DATABASE IF NOT EXISTS student_election;
USE student_election;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    student_id VARCHAR(20),
    role VARCHAR(20) NOT NULL DEFAULT 'student',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default admin user
-- Username: admin, Password: admin123
INSERT INTO users (username, password, email, full_name, student_id, role) 
VALUES ('admin', 'admin123', 'admin@student.uitm.edu.my', 'Administrator', 'ADMIN001', 'admin')
ON DUPLICATE KEY UPDATE username=username;

-- Verify the admin user was created
SELECT * FROM users WHERE role = 'admin';

