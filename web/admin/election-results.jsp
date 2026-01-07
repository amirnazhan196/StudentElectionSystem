<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Election Results - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container { max-width: 1100px; margin: 30px auto; padding: 20px; }
        .card { background: #fff; border: 1px solid #e5e7eb; border-radius: 12px; padding: 18px; margin-bottom: 16px; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 12px; }
        .stat { padding: 14px; border: 1px solid #e5e7eb; border-radius: 10px; background: #f8fafc; }
        .pill { background: #ecfeff; color: #0ea5e9; padding: 2px 8px; border-radius: 999px; font-size: 12px; }
        .result-row { display: flex; justify-content: space-between; padding: 8px 0; border-bottom: 1px solid #f3f4f6; }
    </style>
</head>
<body>
<jsp:include page="/includes/navbar.jsp" />
<div class="container">
    <div class="header" style="display:flex;justify-content:space-between;align-items:center;">
        <div>
            <h1>📊 Election Results (Admin)</h1>
            <p class="hint">Mock data only — hook to live vote counts later.</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn" style="background:#666;">← Back</a>
    </div>

    <div class="grid">
        <div class="stat"><strong>Total Voters</strong><br>1,200</div>
        <div class="stat"><strong>Votes Cast</strong><br>888 (74%)</div>
        <div class="stat"><strong>Last Updated</strong><br>2025-12-12 12:00</div>
        <div class="stat"><strong>Status</strong><br><span class="pill">Mock</span></div>
    </div>

    <%
        class AdminResultRow {
            String candidate; int votes; int percent; String position;
            AdminResultRow(String candidate, int votes, int percent, String position) {
                this.candidate = candidate; this.votes = votes; this.percent = percent; this.position = position;
            }
        }
        java.util.Map<String, java.util.List<AdminResultRow>> res = new java.util.LinkedHashMap<>();
        res.put("President", java.util.Arrays.asList(
            new AdminResultRow("Aminah Zulkifli", 340, 58, "President"),
            new AdminResultRow("Farid Rahman", 248, 42, "President")
        ));
        res.put("Vice President", java.util.Arrays.asList(
            new AdminResultRow("Nur Izzah", 310, 53, "Vice President"),
            new AdminResultRow("Daniel Lee", 278, 47, "Vice President")
        ));
    %>

    <% for (String pos : res.keySet()) { %>
        <div class="card">
            <div style="display:flex;justify-content:space-between;align-items:center;">
                <h3><%= pos %></h3>
                <span class="pill">Mock tally</span>
            </div>
            <% for (AdminResultRow r : res.get(pos)) { %>
                <div class="result-row">
                    <div><strong><%= r.candidate %></strong></div>
                    <div><%= r.votes %> votes (<%= r.percent %>%)</div>
                </div>
            <% } %>
        </div>
    <% } %>
</div>
</body>
</html>

