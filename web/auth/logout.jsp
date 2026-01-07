<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.invalidate();
    
    response.sendRedirect(request.getContextPath() + "/auth/login.jsp?success=You have been logged out successfully.");
%>

