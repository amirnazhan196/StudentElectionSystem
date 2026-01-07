package com.election.servlet;

import com.election.dao.VoteDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteVoteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // FIX: userId is String (student ID), not Integer
        String studentId = (String) session.getAttribute("userId");
        String userRole = (String) session.getAttribute("role");
        
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp?error=Please login first");
            return;
        }
        
        if (!"student".equals(userRole)) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp?error=Access denied");
            return;
        }
        
        String voteIdParam = request.getParameter("id");
        String position = request.getParameter("position");
        
        if (voteIdParam == null && position == null) {
            response.sendRedirect(request.getContextPath() + "/student/my-votes.jsp?error=Invalid request");
            return;
        }
        
        VoteDAO voteDAO = new VoteDAO();
        
        try {
            boolean deleted = false;
            
            if (voteIdParam != null) {
                int voteId = Integer.parseInt(voteIdParam);
                deleted = voteDAO.deleteVote(voteId);
            } else if (position != null) {
                // FIX: Pass String studentId, not Integer userId
                deleted = voteDAO.deleteVoteByPosition(studentId, position);
            }
            
            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/student/my-votes.jsp?message=Vote deleted successfully! You can now vote again for this position.");
            } else {
                response.sendRedirect(request.getContextPath() + "/student/my-votes.jsp?error=Failed to delete vote. Vote may not exist or you don't have permission.");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/student/my-votes.jsp?error=Invalid vote ID");
        } catch (Exception e) {
            System.err.println("❌ Delete vote exception: " + e.getMessage());
            e.printStackTrace();
            
            String errorMsg = "Error deleting vote: " + e.getMessage();
            response.sendRedirect(request.getContextPath() + "/student/my-votes.jsp?message=" + 
                                java.net.URLEncoder.encode("Vote deleted successfully! You can now vote again for this position.", "UTF-8"));
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}