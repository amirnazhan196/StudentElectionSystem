<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/includes/navbar.jsp" />
    <div class="dashboard">
        <div class="welcome">
            <h1>Welcome, Administrator!</h1>
            <p>Student Election System Admin Panel</p>
        </div>
        
        <div class="menu">
            <a href="${pageContext.request.contextPath}/admin/manage-candidates.jsp" class="menu-item">
                <h3>👥 Manage Candidates</h3>
                <p>Add, edit, or remove candidates</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/manage-voters.jsp" class="menu-item">
                <h3>📋 Manage Voters</h3>
                <p>View and manage student voters</p>
            </a>
            
            <a href="election-results.jsp" class="menu-item">
                <h3>📊 Election Results</h3>
                <p>View voting results</p>
            </a>
            
            <a href="settings.jsp" class="menu-item">
                <h3>⚙️ Settings</h3>
                <p>System configuration</p>
            </a>
            
            <a href="../auth/logout.jsp" class="menu-item">
                <h3>🚪 Logout</h3>
                <p>Exit admin panel</p>
            </a>
        </div>
    </div>
</body>
</html>