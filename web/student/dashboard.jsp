<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/includes/navbar.jsp" />
    <div class="dashboard">
        <div class="welcome">
            <h1>Welcome, Student!</h1>
            <p>Online Student Election System</p>
        </div>
        
        <div class="menu">
            <a href="${pageContext.request.contextPath}/student/vote.jsp" class="menu-item">
                <h3>🗳️ Cast Vote</h3>
                <p>Vote for your candidates</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/student/profile.jsp" class="menu-item">
                <h3>👤 My Profile</h3>
                <p>View and update profile</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/student/my-votes.jsp" class="menu-item">
                <h3>📋 My Votes</h3>
                <p>View your voting history</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/student/results.jsp" class="menu-item">
                <h3>📊 View Results</h3>
                <p>See election results</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/auth/logout.jsp" class="menu-item">
                <h3>🚪 Logout</h3>
                <p>Exit system</p>
            </a>
        </div>
    </div>
</body>
</html>