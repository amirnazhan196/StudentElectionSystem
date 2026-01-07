package com.election.model;

public class Candidate {
    private int id;
    private String name;
    private String studentId;
    private String email;
    private String position; 
    private String manifesto; 
    private String status; 
    
    public Candidate() {}
    
    public Candidate(String name, String studentId, String email, String position, String manifesto) {
        this.name = name;
        this.studentId = studentId;
        this.email = email;
        this.position = position;
        this.manifesto = manifesto;
        this.status = "active";
    }
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }
    
    public String getManifesto() { return manifesto; }
    public void setManifesto(String manifesto) { this.manifesto = manifesto; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}

