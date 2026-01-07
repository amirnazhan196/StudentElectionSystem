<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cast Vote</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .vote-container { max-width: 1100px; margin: 30px auto; padding: 20px; }
        .ballot { background: #fff; border: 1px solid #e5e7eb; border-radius: 12px; padding: 20px; margin-bottom: 20px; }
        .position-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; }
        .candidate-card { border: 1px solid #e5e7eb; border-radius: 10px; padding: 14px; margin: 8px 0; display: flex; gap: 12px; align-items: center; }
        .candidate-card input { transform: scale(1.2); }
        .candidate-info h4 { margin: 0; }
        .candidate-info p { margin: 2px 0; color: #555; }
        .pill { background: #eef2ff; color: #4338ca; padding: 2px 8px; border-radius: 999px; font-size: 12px; }
    </style>
</head>
<body>
<jsp:include page="/includes/navbar.jsp" />
<div class="vote-container">
    <h1>🗳️ Cast Your Vote</h1>
    <%
        String message = request.getParameter("message");
        String error = request.getParameter("error");
        if (message != null) {
    %>
        <div style="padding: 12px 16px; border-radius: 8px; margin-bottom: 20px; background: #d1fae5; color: #065f46; border: 1px solid #6ee7b7;">
            <%= message %>
        </div>
    <%
        }
        if (error != null) {
    %>
        <div style="padding: 12px 16px; border-radius: 8px; margin-bottom: 20px; background: #fee2e2; color: #991b1b; border: 1px solid #fca5a5;">
            <%= error %>
        </div>
    <%
        }
    %>
    <p class="hint">Select your preferred candidate for each position. You can change your vote by deleting it from "My Votes" page.</p>

    <%
        class MockCandidate {
            String position, name, manifesto;
            MockCandidate(String position, String name, String manifesto) {
                this.position = position; this.name = name; this.manifesto = manifesto;
            }
        }
        java.util.Map<String, java.util.List<MockCandidate>> ballot = new java.util.LinkedHashMap<>();
        ballot.put("President", java.util.Arrays.asList(
            new MockCandidate("President", "Aminah Zulkifli", "Transparency and weekly updates."),
            new MockCandidate("President", "Farid Rahman", "More student activities and funding.")
        ));
        ballot.put("Vice President", java.util.Arrays.asList(
            new MockCandidate("Vice President", "Nur Izzah", "Improve campus facilities."),
            new MockCandidate("Vice President", "Daniel Lee", "Support student clubs and innovation.")
        ));
        ballot.put("Secretary", java.util.Arrays.asList(
            new MockCandidate("Secretary", "Siti Mariam", "Clear communication and records."),
            new MockCandidate("Secretary", "Harith Amir", "Digitalize documentation.")
        ));
    %>

    <form action="#" method="post">
        <% for (String position : ballot.keySet()) { %>
            <div class="ballot">
                <div class="position-header">
                    <h3><%= position %></h3>
                    <span class="pill">Select 1</span>
                </div>
                <% for (MockCandidate c : ballot.get(position)) { %>
                    <label class="candidate-card">
                        <input type="radio" name="<%= position %>" value="<%= c.name %>" required>
                        <div class="candidate-info">
                            <h4><%= c.name %></h4>
                            <p><%= c.manifesto %></p>
                        </div>
                    </label>
                <% } %>
            </div>
        <% } %>

        <button type="submit" class="btn">Submit Vote (Mock)</button>
    </form>
</div>
</body>
</html>

