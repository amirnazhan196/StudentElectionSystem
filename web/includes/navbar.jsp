<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String currentUser = (String) session.getAttribute("username");
    String userRole = (String) session.getAttribute("role");
%>
<nav class="navbar">
    <div class="nav-container">
        <div class="nav-brand">
            <a href="${pageContext.request.contextPath}/index.jsp">
                <span class="brand-icon">🎓</span>
                <span class="brand-text">Student Election System</span>
            </a>
        </div>
        <div class="nav-menu">
            <% if (currentUser != null) { %>
                <span class="nav-user">Welcome, <%= currentUser %>!</span>
                <% if ("admin".equals(userRole)) { %>
                    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="nav-link">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/admin/manage-candidates.jsp" class="nav-link">Candidates</a>
                    <a href="${pageContext.request.contextPath}/admin/manage-voters.jsp" class="nav-link">Voters</a>
                <% } else if ("student".equals(userRole)) { %>
                    <a href="${pageContext.request.contextPath}/student/dashboard.jsp" class="nav-link">Dashboard</a>
                <% } %>
                <a href="${pageContext.request.contextPath}/auth/logout.jsp" class="nav-link nav-logout">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/auth/login.jsp" class="nav-link">Login</a>
                <!-- REMOVED: Register link -->
            <% } %>
        </div>
    </div>
</nav>