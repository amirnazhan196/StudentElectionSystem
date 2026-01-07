package com.election.servlet;

import com.election.dao.StudentDAO;
import com.election.model.Student;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        HttpSession session = request.getSession();
        
        System.out.println("Login attempt:");
        System.out.println("Username: " + username);
        System.out.println("Password: " + password);
        System.out.println("Role: " + role);
        
        // Validation
        if (username == null || username.trim().isEmpty() || 
            role == null || role.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp?error=All fields are required");
            return;
        }
        
        // Admin Login (still needs password)
        if ("admin".equals(role)) {
            if (password == null || password.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/auth/login.jsp?error=Password required for admin");
                return;
            }
            
            if ("admin".equals(username) && "admin123".equals(password)) {
                session.setAttribute("username", "Administrator");
                session.setAttribute("role", "admin");
                session.setAttribute("userId", "admin");
                System.out.println("Admin login successful");
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
                return;
            } else {
                response.sendRedirect(request.getContextPath() + "/auth/login.jsp?error=Invalid admin credentials");
                return;
            }
        }
        
        // Student Login (email-based, NO password required)
        if ("student".equals(role)) {
            // Verify email format
            if (!username.toLowerCase().endsWith("@student.uitm.edu.my")) {
                response.sendRedirect(request.getContextPath() + 
                    "/auth/login.jsp?error=Please use your UITM student email (@student.uitm.edu.my)");
                return;
            }
            
            try {
                StudentDAO studentDAO = new StudentDAO();
                
                // Try to get student from database
                Student student = studentDAO.getOrCreateStudentByEmail(username);
                
                if (student != null) {
                    session.setAttribute("userId", student.getStudentId());
                    session.setAttribute("username", student.getStudentName());
                    session.setAttribute("role", "student");
                    session.setAttribute("userEmail", student.getEmail());
                    session.setAttribute("studentName", student.getStudentName());
                    session.setAttribute("studyYear", student.getStudyYear());
                    session.setAttribute("program", student.getProgram());
                    session.setAttribute("fullName", student.getStudentName()); 

                    
                    // Update last login timestamp
                    studentDAO.updateLastLogin(student.getStudentId());
                    
                    System.out.println("Login successful for student: " + student.getStudentName());
                    response.sendRedirect(request.getContextPath() + "/student/dashboard.jsp");
                    return;
                } else {
                    // Should not happen if getOrCreateStudentByEmail works properly
                    System.err.println("Failed to get/create student for email: " + username);
                    response.sendRedirect(request.getContextPath() + 
                        "/auth/login.jsp?error=Login failed. Please try again.");
                    return;
                }
            } catch (Exception e) {
                System.err.println("Database error: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/auth/login.jsp?error=Database error");
                return;
            }
        }
        
        // Invalid role
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp?error=Invalid role selected");
    }
}