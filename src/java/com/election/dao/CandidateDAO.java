package com.election.dao;

import com.election.model.Candidate;
import com.election.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CandidateDAO {
    
    public List<Candidate> getAllCandidates() throws SQLException {
        List<Candidate> candidates = new ArrayList<>();
        String sql = "SELECT * FROM candidates ORDER BY position, name";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Candidate candidate = new Candidate();
                candidate.setId(rs.getInt("id"));
                candidate.setName(rs.getString("name"));
                candidate.setStudentId(rs.getString("student_id"));
                candidate.setEmail(rs.getString("email"));
                candidate.setPosition(rs.getString("position"));
                candidate.setManifesto(rs.getString("manifesto"));
                candidate.setStatus(rs.getString("status"));
                candidates.add(candidate);
            }
        }
        return candidates;
    }
    
    public Candidate getCandidateById(int id) throws SQLException {
        String sql = "SELECT * FROM candidates WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Candidate candidate = new Candidate();
                candidate.setId(rs.getInt("id"));
                candidate.setName(rs.getString("name"));
                candidate.setStudentId(rs.getString("student_id"));
                candidate.setEmail(rs.getString("email"));
                candidate.setPosition(rs.getString("position"));
                candidate.setManifesto(rs.getString("manifesto"));
                candidate.setStatus(rs.getString("status"));
                return candidate;
            }
        }
        return null;
    }

    public boolean addCandidate(Candidate candidate) throws SQLException {
        String sql = "INSERT INTO candidates (name, student_id, email, position, manifesto, status) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, candidate.getName());
            stmt.setString(2, candidate.getStudentId());
            stmt.setString(3, candidate.getEmail());
            stmt.setString(4, candidate.getPosition());
            stmt.setString(5, candidate.getManifesto());
            stmt.setString(6, candidate.getStatus() != null ? candidate.getStatus() : "active");
            
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }
    
    public boolean updateCandidate(Candidate candidate) throws SQLException {
        String sql = "UPDATE candidates SET name = ?, student_id = ?, email = ?, position = ?, manifesto = ?, status = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, candidate.getName());
            stmt.setString(2, candidate.getStudentId());
            stmt.setString(3, candidate.getEmail());
            stmt.setString(4, candidate.getPosition());
            stmt.setString(5, candidate.getManifesto());
            stmt.setString(6, candidate.getStatus());
            stmt.setInt(7, candidate.getId());
            
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }
    
    public boolean deleteCandidate(int id) throws SQLException {
        String sql = "DELETE FROM candidates WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }
}

