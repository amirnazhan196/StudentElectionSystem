package com.election.servlet;

import com.election.dao.CandidateDAO;
import com.election.model.Candidate;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CandidateServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");
        
        if ("delete".equals(action) && idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                CandidateDAO candidateDAO = new CandidateDAO();
                boolean deleted = candidateDAO.deleteCandidate(id);
                
                if (deleted) {
                    response.sendRedirect(request.getContextPath() + "/admin/manage-candidates.jsp?message=Candidate deleted successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/manage-candidates.jsp?error=Failed to delete candidate");
                }
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/admin/manage-candidates.jsp?error=" + 
                                    java.net.URLEncoder.encode("Error: " + e.getMessage(), "UTF-8"));
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/manage-candidates.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CandidateDAO candidateDAO = new CandidateDAO();
        
        try {
            if ("add".equals(action)) {
                // Add new candidate
                Candidate candidate = new Candidate();
                candidate.setName(request.getParameter("name"));
                candidate.setStudentId(request.getParameter("studentId"));
                candidate.setEmail(request.getParameter("email"));
                candidate.setPosition(request.getParameter("position"));
                candidate.setManifesto(request.getParameter("manifesto"));
                candidate.setStatus(request.getParameter("status") != null ? request.getParameter("status") : "active");
                
                boolean added = candidateDAO.addCandidate(candidate);
                
                if (added) {
                    response.sendRedirect(request.getContextPath() + "/admin/manage-candidates.jsp?message=Candidate added successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/manage-candidates.jsp?error=Failed to add candidate");
                }
                
            } else if ("update".equals(action)) {
                Candidate candidate = new Candidate();
                candidate.setId(Integer.parseInt(request.getParameter("id")));
                candidate.setName(request.getParameter("name"));
                candidate.setStudentId(request.getParameter("studentId"));
                candidate.setEmail(request.getParameter("email"));
                candidate.setPosition(request.getParameter("position"));
                candidate.setManifesto(request.getParameter("manifesto"));
                candidate.setStatus(request.getParameter("status"));
                
                boolean updated = candidateDAO.updateCandidate(candidate);
                
                if (updated) {
                    response.sendRedirect(request.getContextPath() + "/admin/manage-candidates.jsp?message=Candidate updated successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/manage-candidates.jsp?error=Failed to update candidate");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/manage-candidates.jsp?error=Invalid action");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/manage-candidates.jsp?error=" + 
                                java.net.URLEncoder.encode("Error: " + e.getMessage(), "UTF-8"));
        }
    }
}

