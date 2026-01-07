package com.election.model;

public class Student {
    private String studentId;
    private String studentName;
    private String email;
    private int studyYear;
    private String program;
    
    // Getters and setters
    public String getStudentId() {
        return studentId;
    }
    
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    
    public String getStudentName() {
        return studentName;
    }
    
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public int getStudyYear() {
        return studyYear;
    }
    
    public void setStudyYear(int studyYear) {
        this.studyYear = studyYear;
    }
    
    public String getProgram() {
        return program;
    }
    
    public void setProgram(String program) {
        this.program = program;
    }
}