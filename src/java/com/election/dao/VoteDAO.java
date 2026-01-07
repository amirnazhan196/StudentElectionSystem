package com.election.dao;

import com.election.util.DatabaseConnection;
import java.sql.*;

public class VoteDAO {

    public boolean deleteVote(int voteId) throws SQLException {
        String sql = "DELETE FROM VOTE WHERE VOTE_ID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, voteId);
            
            int rows = stmt.executeUpdate();
            System.out.println("Vote deletion: Deleted " + rows + " row(s) for vote ID: " + voteId);
            return rows > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ Delete vote SQL Error: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            throw e;
        }
    }
    
    // CHANGE: Use String studentId instead of int userId
    public boolean deleteVoteByPosition(String studentId, String positionName) throws SQLException {
        String sql = "DELETE FROM VOTE WHERE STUDENT_ID = ? AND POSITION_ID IN " +
                     "(SELECT POSITION_ID FROM POSITION WHERE POSITION_NAME = ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, studentId);
            stmt.setString(2, positionName);
            
            int rows = stmt.executeUpdate();
            System.out.println("Vote deletion by position: Deleted " + rows + " row(s) for student ID: " + studentId + ", position: " + positionName);
            return rows > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ Delete vote by position SQL Error: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    
    // CHANGE: Use String studentId instead of int userId
    public boolean hasStudentVoted(String studentId, int positionId) {
        String sql = "SELECT COUNT(*) FROM VOTE WHERE STUDENT_ID = ? AND POSITION_ID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, studentId);
            stmt.setInt(2, positionId);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error checking if student has voted: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    // NEW: Add vote
    public boolean castVote(String studentId, int candidateId, int positionId) throws SQLException {
        String sql = "INSERT INTO VOTE (STUDENT_ID, CANDIDATE_ID, POSITION_ID) VALUES (?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, studentId);
            stmt.setInt(2, candidateId);
            stmt.setInt(3, positionId);
            
            int rows = stmt.executeUpdate();
            System.out.println("Vote cast: Inserted " + rows + " row(s) for student: " + studentId);
            return rows > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ Cast vote SQL Error: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    
    // NEW: Get votes by student
    public ResultSet getVotesByStudent(String studentId) throws SQLException {
        String sql = "SELECT v.VOTE_ID, v.VOTE_TIMESTAMP, c.CANDIDATE_ID, " +
                     "s.STUDENT_NAME AS CANDIDATE_NAME, p.POSITION_NAME " +
                     "FROM VOTE v " +
                     "JOIN CANDIDATE c ON v.CANDIDATE_ID = c.CANDIDATE_ID " +
                     "JOIN STUDENTS s ON c.STUDENT_ID = s.STUDENT_ID " +
                     "JOIN POSITION p ON v.POSITION_ID = p.POSITION_ID " +
                     "WHERE v.STUDENT_ID = ? " +
                     "ORDER BY v.VOTE_TIMESTAMP DESC";
        
        Connection conn = DatabaseConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, studentId);
        return stmt.executeQuery();
    }
    
    // NEW: Check if student has voted for any position in election
    public boolean hasStudentVotedInElection(String studentId, int electionId) {
        String sql = "SELECT COUNT(*) FROM VOTE v " +
                     "JOIN POSITION p ON v.POSITION_ID = p.POSITION_ID " +
                     "WHERE v.STUDENT_ID = ? AND p.ELECTION_ID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, studentId);
            stmt.setInt(2, electionId);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error checking if student has voted in election: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}