<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Election Results</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .results-container { max-width: 1100px; margin: 30px auto; }
        .card { background: #fff; border: 1px solid #e5e7eb; border-radius: 12px; padding: 18px; margin-bottom: 16px; }
        .result-row { display: flex; justify-content: space-between; align-items: center; padding: 10px 0; border-bottom: 1px solid #f3f4f6; }
        .bar { height: 10px; border-radius: 999px; background: #eef2ff; overflow: hidden; }
        .bar span { display: block; height: 10px; background: #6366f1; }
        .pill { background: #ecfeff; color: #0ea5e9; padding: 2px 8px; border-radius: 999px; font-size: 12px; }
    </style>
</head>
<body>
<jsp:include page="/includes/navbar.jsp" />
<div class="results-container">
    <h1>📊 Election Results</h1>
    <p class="hint">Mock data preview — replace with live tallies later.</p>

    <%
        class ResultRow {
            String position, candidate; int votes; int percent;
            ResultRow(String position, String candidate, int votes, int percent) {
                this.position = position; this.candidate = candidate; this.votes = votes; this.percent = percent;
            }
        }
        java.util.Map<String, java.util.List<ResultRow>> results = new java.util.LinkedHashMap<>();
        results.put("President", java.util.Arrays.asList(
            new ResultRow("President", "Aminah Zulkifli", 340, 58),
            new ResultRow("President", "Farid Rahman", 248, 42)
        ));
        results.put("Vice President", java.util.Arrays.asList(
            new ResultRow("Vice President", "Nur Izzah", 310, 53),
            new ResultRow("Vice President", "Daniel Lee", 278, 47)
        ));
        results.put("Secretary", java.util.Arrays.asList(
            new ResultRow("Secretary", "Siti Mariam", 360, 61),
            new ResultRow("Secretary", "Harith Amir", 228, 39)
        ));
    %>

    <% for (String pos : results.keySet()) { %>
        <div class="card">
            <div style="display:flex;justify-content:space-between;align-items:center;">
                <h3><%= pos %></h3>
                <span class="pill">Mock tally</span>
            </div>
            <% for (ResultRow r : results.get(pos)) { %>
                <div class="result-row">
                    <div>
                        <strong><%= r.candidate %></strong>
                        <div class="bar" style="width: 320px;">
                            <span style="width: <%= r.percent %>%;"></span>
                        </div>
                    </div>
                    <div><%= r.votes %> votes (<%= r.percent %>%)</div>
                </div>
            <% } %>
        </div>
    <% } %>
</div>
</body>
</html>

