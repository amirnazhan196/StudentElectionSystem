<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // MOCK DATA FOR DEMO - Replace with database query later
    // This demonstrates READ operation for students
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Votes - Student</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .vote-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
        }
        .vote-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f3f4f6;
        }
        .vote-header h3 {
            margin: 0;
            color: #1f2937;
        }
        .vote-date {
            color: #6b7280;
            font-size: 13px;
        }
        .candidate-info {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 12px;
            background: #f9fafb;
            border-radius: 8px;
            margin-top: 10px;
        }
        .candidate-info strong {
            color: #1f2937;
        }
        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        .status-completed {
            background: #d1fae5;
            color: #065f46;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6b7280;
        }
        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }
        .vote-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #e5e7eb;
        }
        .btn-delete {
            background: #ef4444;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-delete:hover {
            background: #dc2626;
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
<div class="container">
    <div class="header">
        <h1>📋 My Voting History</h1>
        <a href="${pageContext.request.contextPath}/student/dashboard.jsp" class="btn" style="background: #666;">← Back to Dashboard</a>
    </div>
    
    <p class="hint" style="margin-bottom: 20px;">
        View all your past votes. You can delete a vote to choose a new candidate for that position.
    </p>
    
    <%
        String message = request.getParameter("message");
        String error = request.getParameter("error");
        if (message != null) {
    %>
        <div class="message success" style="padding: 12px 16px; border-radius: 8px; margin-bottom: 20px; background: #d1fae5; color: #065f46; border: 1px solid #6ee7b7;">
            <%= message %>
        </div>
    <%
        }
        if (error != null) {
    %>
        <div class="message error" style="padding: 12px 16px; border-radius: 8px; margin-bottom: 20px; background: #fee2e2; color: #991b1b; border: 1px solid #fca5a5;">
            <%= error %>
        </div>
    <%
        }
    %>
    
    <%
        // MOCK VOTING DATA - Replace with database query later
        String[][] mockVotes = {
            {"1", "President", "Ahmad bin Abdullah", "2024-01-20 10:30 AM", "completed"},
            {"2", "Vice President", "Siti Nurhaliza", "2024-01-20 10:32 AM", "completed"},
            {"3", "Secretary", "Muhammad Ali", "2024-01-20 10:33 AM", "completed"},
            {"4", "Treasurer", "Fatimah Zahra", "2024-01-20 10:34 AM", "completed"}
        };
        
        if (mockVotes.length == 0) {
    %>
        <div class="empty-state">
            <div class="empty-state-icon">🗳️</div>
            <h3>No Votes Yet</h3>
            <p>You haven't cast any votes yet. Visit the voting page to participate in the election.</p>
            <a href="${pageContext.request.contextPath}/student/vote.jsp" class="btn" style="margin-top: 20px;">Cast Your Vote</a>
        </div>
    <%
        } else {
            for (String[] vote : mockVotes) {
                String voteId = vote[0];
                String position = vote[1];
                String candidateName = vote[2];
                String voteDate = vote[3];
                String status = vote[4];
    %>
        <div class="vote-card">
            <div class="vote-header">
                <div>
                    <h3><%= position %></h3>
                    <div class="vote-date">Voted on: <%= voteDate %></div>
                </div>
                <span class="status-badge status-<%= status %>">✓ Completed</span>
            </div>
            <div class="candidate-info">
                <strong>Your Vote:</strong>
                <span><%= candidateName %></span>
            </div>
            <div class="vote-actions">
                <a href="${pageContext.request.contextPath}/deleteVote?id=<%= voteId %>&position=<%= java.net.URLEncoder.encode(position, "UTF-8") %>" 
                   class="btn-delete"
                   onclick="return confirm('Are you sure you want to delete this vote? You will be able to vote again for <%= position %>.')">
                    🗑️ Delete Vote
                </a>
                <a href="${pageContext.request.contextPath}/student/vote.jsp" class="btn" style="padding: 8px 16px; font-size: 13px;">
                    ✏️ Vote Again
                </a>
            </div>
        </div>
    <%
            }
        }
    %>
    
    <div style="margin-top: 30px; padding: 20px; background: #f9fafb; border-radius: 8px;">
        <h3 style="margin-top: 0;">📊 Summary</h3>
        <p><strong>Total Votes Cast:</strong> <%= mockVotes.length %></p>
        <p><strong>Last Vote Date:</strong> <%= mockVotes.length > 0 ? mockVotes[mockVotes.length-1][3] : "N/A" %></p>
    </div>
</div>
</body>
</html>

