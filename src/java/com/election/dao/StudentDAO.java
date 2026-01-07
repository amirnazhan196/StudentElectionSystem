package com.election.dao;

import com.election.model.Student;
import com.election.util.DatabaseConnection;
import java.sql.*;

public class StudentDAO {
    
    public Student getOrCreateStudentByEmail(String email) {
        // First, try to get existing student
        Student student = getStudentByEmail(email);
        
        if (student != null) {
            return student; // Student exists
        }
        
        // Student doesn't exist - create new one
        return createNewStudent(email);
    }
    
    public Student getStudentByEmail(String email) {
        String sql = "SELECT * FROM STUDENTS WHERE EMAIL = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Student student = new Student();
                student.setStudentId(rs.getString("STUDENT_ID"));
                student.setStudentName(rs.getString("STUDENT_NAME"));
                student.setEmail(rs.getString("EMAIL"));
                student.setStudyYear(rs.getInt("STUDY_YEAR"));
                student.setProgram(rs.getString("PROGRAM"));
                return student;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting student by email: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    private Student createNewStudent(String email) {
        // Generate student ID from email (remove @student.uitm.edu.my)
        String studentId = email.substring(0, email.indexOf("@"));
        
        // Extract name from email (e.g., ali.ahmad -> Ali Ahmad)
        String localPart = email.substring(0, email.indexOf("@"));
        String studentName = capitalizeName(localPart);
        
        String sql = "INSERT INTO STUDENTS (STUDENT_ID, STUDENT_NAME, EMAIL, STUDY_YEAR, PROGRAM) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, studentId);
            stmt.setString(2, studentName);
            stmt.setString(3, email);
            stmt.setInt(4, 1); // Default: Year 1
            stmt.setString(5, "Computer Science"); // Default program
            
            int rows = stmt.executeUpdate();
            
            if (rows > 0) {
                System.out.println("✅ Created new student: " + email);
                
                // Return the newly created student
                Student newStudent = new Student();
                newStudent.setStudentId(studentId);
                newStudent.setStudentName(studentName);
                newStudent.setEmail(email);
                newStudent.setStudyYear(1);
                newStudent.setProgram("Computer Science");
                return newStudent;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error creating new student: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    private String capitalizeName(String localPart) {
        // Convert ali.ahmad to Ali Ahmad
        String[] parts = localPart.split("\\.");
        StringBuilder name = new StringBuilder();
        
        for (String part : parts) {
            if (!part.isEmpty()) {
                if (name.length() > 0) {
                    name.append(" ");
                }
                name.append(Character.toUpperCase(part.charAt(0)))
                    .append(part.substring(1));
            }
        }
        
        return name.toString().isEmpty() ? "UITM Student" : name.toString();
    }
    
    public Student getStudentById(String studentId) {
        String sql = "SELECT * FROM STUDENTS WHERE STUDENT_ID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, studentId);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Student student = new Student();
                student.setStudentId(rs.getString("STUDENT_ID"));
                student.setStudentName(rs.getString("STUDENT_NAME"));
                student.setEmail(rs.getString("EMAIL"));
                student.setStudyYear(rs.getInt("STUDY_YEAR"));
                student.setProgram(rs.getString("PROGRAM"));
                return student;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting student by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    public void updateLastLogin(String studentId) {
        String sql = "UPDATE STUDENTS SET LAST_LOGIN = CURRENT_TIMESTAMP WHERE STUDENT_ID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, studentId);
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            System.err.println("❌ Error updating last login: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public boolean updateStudent(Student student) {
        String sql = "UPDATE STUDENTS SET STUDENT_NAME = ?, EMAIL = ?, STUDY_YEAR = ?, PROGRAM = ? WHERE STUDENT_ID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, student.getStudentName());
            stmt.setString(2, student.getEmail());
            stmt.setInt(3, student.getStudyYear());
            stmt.setString(4, student.getProgram());
            stmt.setString(5, student.getStudentId());
            
            int rows = stmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ Error updating student: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean isStudentExists(String email) {
        String sql = "SELECT COUNT(*) FROM STUDENTS WHERE EMAIL = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error checking if student exists: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}