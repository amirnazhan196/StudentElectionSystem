package com.election.servlet;

import com.election.dao.StudentDAO;
import com.election.model.Student;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/student/profile.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        String studentId = (String) session.getAttribute("userId");
        String studentName = (String) session.getAttribute("studentName");
        
        if (studentId == null || studentName == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp?error=Please login first");
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String studyYearStr = request.getParameter("studyYear");
        String program = request.getParameter("program");
        
        String error = null;
        int studyYear = 1;
        
        // Validation
        if (fullName == null || fullName.trim().isEmpty()) {
            error = "Full name is required!";
        } else if (email == null || email.trim().isEmpty()) {
            error = "Email is required!";
        } else if (!email.toLowerCase().endsWith("@student.uitm.edu.my")) {
            error = "Please use your UITM student email (@student.uitm.edu.my)";
        } else if (studyYearStr == null || studyYearStr.trim().isEmpty()) {
            error = "Study year is required!";
        } else if (program == null || program.trim().isEmpty()) {
            error = "Program is required!";
        } else {
            // Parse study year
            try {
                studyYear = Integer.parseInt(studyYearStr);
                if (studyYear < 1 || studyYear > 4) {
                    error = "Study year must be between 1 and 4";
                }
            } catch (NumberFormatException e) {
                error = "Invalid study year format";
            }
        }
        
        if (error != null) {
            response.sendRedirect(request.getContextPath() + "/student/profile.jsp?error=" + 
                               java.net.URLEncoder.encode(error, "UTF-8"));
            return;
        }
        
        StudentDAO studentDAO = new StudentDAO();
        
        try {
            // Get current student data
            Student currentStudent = studentDAO.getStudentById(studentId);
            if (currentStudent == null) {
                response.sendRedirect(request.getContextPath() + "/student/profile.jsp?error=Student not found");
                return;
            }
            
            // Create updated student object
            Student updatedStudent = new Student();
            updatedStudent.setStudentId(studentId);
            updatedStudent.setStudentName(fullName);
            updatedStudent.setEmail(email);
            updatedStudent.setStudyYear(studyYear);
            updatedStudent.setProgram(program);
            
            boolean isUpdated = studentDAO.updateStudent(updatedStudent);
            
            if (isUpdated) {
                // Update session attributes
                session.setAttribute("studentName", fullName);
                session.setAttribute("userEmail", email);
                session.setAttribute("studyYear", studyYear);
                session.setAttribute("program", program);
                
                response.sendRedirect(request.getContextPath() + "/student/profile.jsp?message=Profile updated successfully!");
            } else {
                response.sendRedirect(request.getContextPath() + "/student/profile.jsp?error=Failed to update profile. Please try again.");
            }
            
        } catch (Exception e) {
            System.err.println("❌ Profile update exception: " + e.getMessage());
            e.printStackTrace();
            
            String errorMsg = "Database error: " + e.getMessage();
            response.sendRedirect(request.getContextPath() + "/student/profile.jsp?error=" + 
                                java.net.URLEncoder.encode(errorMsg, "UTF-8"));
        }
    }
}