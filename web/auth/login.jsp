<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Election System - Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/includes/navbar.jsp" />
    <div class="container">
        <div class="login-box">
            <h1>🎓 Student Election System</h1>
            
            <% 
                String success = request.getParameter("success");
                if (success != null) {
            %>
                <div class="success-message">
                    <%= success %>
                </div>
            <% } %>
            
            <% 
                String error = request.getParameter("error");
                if (error != null) {
            %>
                <div class="error-message">
                    <%= error %>  
                </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="username">Username/Email:</label>
                    <input type="text" id="username" name="username" required 
                           placeholder="admin or student@student.uitm.edu.my"
                           value="<%= request.getParameter("username") != null ? 
                                   request.getParameter("username") : "" %>">
                </div>
                
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" 
                           placeholder="Required for admin only">
                    <p class="hint">For students: Password not required</p>
                    <p class="hint">For admin: Use password 'admin123'</p>
                </div>
                
                <div class="form-group">
                    <label for="role">Login as:</label>
                    <select id="role" name="role" required>
                        <option value="">Select Role</option>
                        <option value="student" 
                                <% if ("student".equals(request.getParameter("role"))) out.print("selected"); %>>
                            Student
                        </option>
                        <option value="admin"
                                <% if ("admin".equals(request.getParameter("role"))) out.print("selected"); %>>
                            Administrator
                        </option>
                    </select>
                </div>
                
                <button type="submit" class="btn-login">Login</button>
                
                <div class="register-link">
                    <p><strong>No registration needed!</strong></p>
                    <p>Any UITM student email (@student.uitm.edu.my) can login.</p>
                    <p>First-time login will automatically create your account.</p>
                </div>
            </form>
        </div>
    </div>
</body>
</html>