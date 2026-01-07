<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get ALL session attributes
    String fullName = (String) session.getAttribute("studentName");
    String studentId = (String) session.getAttribute("userId");
    String email = (String) session.getAttribute("userEmail");
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    String studyYear = (String) session.getAttribute("studyYear");
    String program = (String) session.getAttribute("program");
    
    String message = request.getParameter("message");
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile - Student</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .profile-container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 20px;
        }
        .profile-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .profile-wrap {
            display: grid;
            grid-template-columns: 1fr 1.1fr;
            gap: 20px;
        }
        .card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 25px;
        }
        .card h2 {
            margin-top: 0;
            margin-bottom: 20px;
            color: #1f2937;
        }
        .info-row {
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #f3f4f6;
        }
        .info-row:last-child {
            border-bottom: none;
        }
        .label {
            color: #6b7280;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: 5px;
        }
        .value {
            font-weight: 600;
            color: #1f2937;
            font-size: 15px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
            color: #374151;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            font-size: 14px;
        }
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }
        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        .badge-student {
            background: #dbeafe;
            color: #1e40af;
        }
        .badge-admin {
            background: #fef3c7;
            color: #92400e;
        }
        .message {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .message.success {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #6ee7b7;
        }
        .message.error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fca5a5;
        }
    </style>
</head>
<body>
<jsp:include page="/includes/navbar.jsp" />
<div class="profile-container">
    <div class="profile-header">
        <h1>👤 My Profile</h1>
        <a href="${pageContext.request.contextPath}/student/dashboard.jsp" class="btn" style="background: #666;">← Back to Dashboard</a>
    </div>
    
    <% if (message != null) { %>
        <div class="message success"><%= message %></div>
    <% } %>
    <% if (error != null) { %>
        <div class="message error"><%= error %></div>
    <% } %>
    
    <div class="profile-wrap">
        <!-- Profile Overview Card -->
        <div class="card">
            <h2>Profile Overview</h2>
            <div class="info-row">
                <div class="label">Full Name</div>
                <div class="value"><%= fullName != null ? fullName : "Not set" %></div>
            </div>
            <div class="info-row">
                <div class="label">Student ID</div>
                <div class="value"><%= studentId != null ? studentId : "-" %></div>
            </div>
            <div class="info-row">
                <div class="label">Email</div>
                <div class="value"><%= email != null ? email : "Not set" %></div>
            </div>
            <div class="info-row">
                <div class="label">Study Year</div>
                <div class="value"><%= studyYear != null ? "Year " + studyYear : "Not set" %></div>
            </div>
            <div class="info-row">
                <div class="label">Program</div>
                <div class="value"><%= program != null ? program : "Not set" %></div>
            </div>
            <div class="info-row">
                <div class="label">Role</div>
                <div class="value">
                    <span class="badge <%= "admin".equals(role) ? "badge-admin" : "badge-student" %>">
                        <%= role != null ? role : "student" %>
                    </span>
                </div>
            </div>
        </div>

        <!-- Update Profile Card -->
        <div class="card">
            <h2>Update Profile</h2>
            <p style="color: #6b7280; font-size: 13px; margin-bottom: 20px;">
                Update your profile information.
            </p>
            <form action="${pageContext.request.contextPath}/updateProfile" method="post">
                <div class="form-group">
                    <label>Full Name *</label>
                    <input type="text" name="fullName" value="<%= fullName != null ? fullName : "" %>" required>
                </div>
                
                <div class="form-group">
                    <label>Student ID</label>
                    <input type="text" value="<%= studentId != null ? studentId : "" %>" readonly>
                    <input type="hidden" name="studentId" value="<%= studentId != null ? studentId : "" %>">
                </div>
                
                <div class="form-group">
                    <label>Email *</label>
                    <input type="email" name="email" value="<%= email != null ? email : "" %>" required>
                </div>
                
                <div class="form-group">
                    <label>Study Year *</label>
                    <select name="studyYear" required>
                        <option value="">Select Year</option>
                        <option value="1" <%= "1".equals(studyYear) ? "selected" : "" %>>Year 1</option>
                        <option value="2" <%= "2".equals(studyYear) ? "selected" : "" %>>Year 2</option>
                        <option value="3" <%= "3".equals(studyYear) ? "selected" : "" %>>Year 3</option>
                        <option value="4" <%= "4".equals(studyYear) ? "selected" : "" %>>Year 4</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Program *</label>
                    <input type="text" name="program" value="<%= program != null ? program : "Computer Science" %>" required>
                </div>
                
                <!-- REMOVED PASSWORD FIELD - Students don't have passwords -->
                
                <button type="submit" class="btn">💾 Save Changes</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>