<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Settings - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container { max-width: 900px; margin: 30px auto; padding: 20px; }
        .card { background: #fff; border: 1px solid #e5e7eb; border-radius: 12px; padding: 18px; margin-bottom: 16px; }
        .form-group { margin-bottom: 12px; }
        .form-group label { display:block; font-weight:600; margin-bottom:6px; }
        .form-group input, .form-group select { width:100%; padding:10px; border:1px solid #e5e7eb; border-radius:8px; }
    </style>
</head>
<body>
<jsp:include page="/includes/navbar.jsp" />
<div class="container">
    <div class="header" style="display:flex;justify-content:space-between;align-items:center;">
        <div>
            <h1>⚙️ Settings</h1>
            <p class="hint">Mock fields — wire to config storage later.</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn" style="background:#666;">← Back</a>
    </div>

    <div class="card">
        <h3>Election Window</h3>
        <form action="#" method="post">
            <div class="form-group">
                <label>Start Date</label>
                <input type="date" name="startDate" value="2025-12-15">
            </div>
            <div class="form-group">
                <label>End Date</label>
                <input type="date" name="endDate" value="2025-12-30">
            </div>
            <div class="form-group">
                <label>Timezone</label>
                <select name="timezone">
                    <option>GMT+8 (Kuala Lumpur)</option>
                    <option>GMT+7</option>
                    <option>GMT+9</option>
                </select>
            </div>
            <button type="submit" class="btn">Save Settings (Mock)</button>
        </form>
    </div>

    <div class="card">
        <h3>Notifications</h3>
        <form action="#" method="post">
            <div class="form-group">
                <label>Sender Email</label>
                <input type="email" name="sender" value="no-reply@student-els.com">
            </div>
            <div class="form-group">
                <label>Reminder Days Before Closing</label>
                <input type="number" name="reminderDays" value="2">
            </div>
            <button type="submit" class="btn">Update Notifications (Mock)</button>
        </form>
    </div>
</div>
</body>
</html>

