<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Voters - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container {
            max-width: 1400px;
            margin: 40px auto;
            padding: 20px;
        }
    </style>
</head>
<body>
    <jsp:include page="/includes/navbar.jsp" />
    <div class="container">
        <div class="header">
            <h1>📋 Manage Voters</h1>
            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn" style="background: #666;">← Back to Dashboard</a>
        </div>
        
        <%
            String message = request.getParameter("message");
            String error = request.getParameter("error");
            if (message != null) {
        %>
            <div class="message success"><%= message %></div>
        <%
            }
            if (error != null) {
        %>
            <div class="message error"><%= error %></div>
        <%
            }
        %>
        
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="Search by name, email, or student ID..." 
                   onkeyup="filterTable()">
        </div>
        
        <table id="votersTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Full Name</th>
                    <th>Student ID</th>
                    <th>Email</th>
                    <th>Username</th>
                    <th>Role</th>
                    <th>Registered Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String[][] mockVoters = {
                        {"1", "Ahmad bin Abdullah", "2023123456", "ahmad@student.uitm.edu.my", "ahmad", "student", "2024-01-15"},
                        {"2", "Siti Nurhaliza", "2023123457", "siti@student.uitm.edu.my", "siti", "student", "2024-01-16"},
                        {"3", "Muhammad Ali", "2023123458", "ali@student.uitm.edu.my", "ali", "student", "2024-01-17"},
                        {"4", "Fatimah Zahra", "2023123459", "fatimah@student.uitm.edu.my", "fatimah", "student", "2024-01-18"},
                        {"5", "Hassan bin Ismail", "2023123460", "hassan@student.uitm.edu.my", "hassan", "student", "2024-01-19"},
                        {"6", "Nurul Aina", "2023123461", "nurul@student.uitm.edu.my", "nurul", "student", "2024-01-20"},
                        {"7", "Ibrahim bin Ahmad", "2023123462", "ibrahim@student.uitm.edu.my", "ibrahim", "student", "2024-01-21"},
                        {"8", "Aisyah binti Mohd", "2023123463", "aisyah@student.uitm.edu.my", "aisyah", "student", "2024-01-22"}
                    };
                    
                    if (mockVoters.length == 0) {
                %>
                    <tr>
                        <td colspan="7" style="text-align: center; padding: 20px;">
                            No student voters found. Students can register through the "Create Account" page.
                        </td>
                    </tr>
                <%
                    } else {
                        for (String[] voter : mockVoters) {
                %>
                    <tr>
                        <td><%= voter[0] %></td>
                        <td><%= voter[1] %></td>
                        <td><%= voter[2] %></td>
                        <td><%= voter[3] %></td>
                        <td><%= voter[4] %></td>
                        <td>
                            <span class="badge badge-<%= voter[5] %>">
                                <%= voter[5] %>
                            </span>
                        </td>
                        <td><%= voter[6] %></td>
                    </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
    
    <script>
        function filterTable() {
            var input = document.getElementById("searchInput");
            var filter = input.value.toLowerCase();
            var table = document.getElementById("votersTable");
            var tr = table.getElementsByTagName("tr");
            
            for (var i = 1; i < tr.length; i++) {
                var td = tr[i].getElementsByTagName("td");
                var found = false;
                
                for (var j = 0; j < td.length; j++) {
                    if (td[j]) {
                        var txtValue = td[j].textContent || td[j].innerText;
                        if (txtValue.toLowerCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                }
                
                tr[i].style.display = found ? "" : "none";
            }
        }
    </script>
</body>
</html>

