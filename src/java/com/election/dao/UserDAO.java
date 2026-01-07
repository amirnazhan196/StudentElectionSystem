package com.election.dao;

import com.election.model.User;
import com.election.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    
    // Login user
    public User login(String username, String password, String role) {
        User user = null;
        String sql = "";
        
        if ("admin".equals(role)) {
            sql = "SELECT * FROM admin WHERE username = ? AND password = SHA2(?, 256)";
        } else {
            sql = "SELECT * FROM students WHERE email = ?"; // Students use email as username
        }
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            if ("admin".equals(role)) {
                stmt.setString(2, password);
            }
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                if ("admin".equals(role)) {
                    user = new User();
                    user.setUserId(rs.getInt("admin_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setRole("admin");
                } else {
                    user = new User();
                    user.setUserId(rs.getInt("student_id"));
                    user.setFullName(rs.getString("student_name"));
                    user.setEmail(rs.getString("email"));
                    user.setStudentId(rs.getString("student_id"));
                    user.setRole("student");
                    // For demo, we'll skip password check for students
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    
    // Get all students
    public List<User> getAllStudents() {
        List<User> students = new ArrayList<>();
        String sql = "SELECT * FROM students";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("student_id"));
                user.setFullName(rs.getString("student_name"));
                user.setEmail(rs.getString("email"));
                user.setStudentId(rs.getString("student_id"));
                user.setRole("student");
                students.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }
    
    // Add a new student
    public boolean addStudent(String name, String email, String studentId, String program, int year) {
        String sql = "INSERT INTO students (student_name, email, student_id, program, year) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, studentId);
            stmt.setString(4, program);
            stmt.setInt(5, year);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}