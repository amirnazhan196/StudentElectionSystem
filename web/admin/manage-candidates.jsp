<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.election.dao.CandidateDAO" %>
<%@ page import="com.election.model.Candidate" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Candidates - Admin</title>
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
            <h1>👥 Manage Candidates</h1>
            <div>
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn" style="background: #666;">← Back to Dashboard</a>
                <button onclick="openAddModal()" class="btn">+ Add New Candidate</button>
            </div>
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
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Student ID</th>
                    <th>Email</th>
                    <th>Position</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String[][] mockCandidates = {
                        {"1", "Ahmad bin Abdullah", "2023123456", "ahmad@student.uitm.edu.my", "President", "active", "I will work to improve student facilities and represent student voices."},
                        {"2", "Siti Nurhaliza", "2023123457", "siti@student.uitm.edu.my", "Vice President", "active", "My goal is to enhance student engagement and campus activities."},
                        {"3", "Muhammad Ali", "2023123458", "ali@student.uitm.edu.my", "Secretary", "active", "I promise transparent communication and efficient administration."},
                        {"4", "Fatimah Zahra", "2023123459", "fatimah@student.uitm.edu.my", "Treasurer", "active", "I will ensure responsible financial management and accountability."},
                        
                    };
                    
                    if (mockCandidates.length == 0) {
                %>
                    <tr>
                        <td colspan="7" style="text-align: center; padding: 20px;">
                            No candidates found. Click "Add New Candidate" to get started.
                        </td>
                    </tr>
                <%
                    } else {
                        for (String[] candidate : mockCandidates) {
                            int id = Integer.parseInt(candidate[0]);
                            String name = candidate[1];
                            String studentId = candidate[2];
                            String email = candidate[3];
                            String position = candidate[4];
                            String status = candidate[5];
                            String manifesto = candidate[6];
                %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= name %></td>
                        <td><%= studentId %></td>
                        <td><%= email %></td>
                        <td><%= position %></td>
                        <td><span class="badge badge-<%= status %>"><%= status %></span></td>
                        <td>
                            <button onclick="openEditModal(<%= id %>, '<%= name.replace("'", "\\'") %>', '<%= studentId %>', '<%= email %>', '<%= position %>', '<%= manifesto.replace("'", "\\'") %>', '<%= status %>')" 
                                    class="btn btn-edit" style="padding: 5px 10px; font-size: 12px;">Edit</button>
                            <a href="${pageContext.request.contextPath}/admin/CandidateServlet?action=delete&id=<%= id %>" 
                               class="btn btn-danger" 
                               style="padding: 5px 10px; font-size: 12px;"
                               onclick="return confirm('Are you sure you want to delete this candidate?')">Delete</a>
                        </td>
                    </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

    <div id="candidateModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2 id="modalTitle">Add New Candidate</h2>
            <form id="candidateForm" action="${pageContext.request.contextPath}/admin/CandidateServlet" method="post">
                <input type="hidden" id="candidateId" name="id" value="">
                <input type="hidden" id="action" name="action" value="add">
                
                <div class="form-group">
                    <label>Full Name *</label>
                    <input type="text" id="name" name="name" required>
                </div>
                
                <div class="form-group">
                    <label>Student ID *</label>
                    <input type="text" id="studentId" name="studentId" required>
                </div>
                
                <div class="form-group">
                    <label>Email *</label>
                    <input type="email" id="email" name="email" required>
                </div>
                
                <div class="form-group">
                    <label>Position *</label>
                    <select id="position" name="position" required>
                        <option value="">Select Position</option>
                        <option value="President">President</option>
                        <option value="Vice President">Vice President</option>
                        <option value="Secretary">Secretary</option>
                        <option value="Treasurer">Treasurer</option>
                        <option value="Committee Member">Committee Member</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Manifesto</label>
                    <textarea id="manifesto" name="manifesto" placeholder="Candidate's campaign statement..."></textarea>
                </div>
                
                <div class="form-group">
                    <label>Status</label>
                    <select id="status" name="status">
                        <option value="active">Active</option>
                        <option value="withdrawn">Withdrawn</option>
                    </select>
                </div>
                
                <button type="submit" class="btn">Save Candidate</button>
                <button type="button" class="btn" onclick="closeModal()" style="background: #666;">Cancel</button>
            </form>
        </div>
    </div>
    
    <script>
        function openAddModal() {
            document.getElementById('modalTitle').textContent = 'Add New Candidate';
            document.getElementById('candidateForm').reset();
            document.getElementById('candidateId').value = '';
            document.getElementById('action').value = 'add';
            document.getElementById('candidateModal').style.display = 'block';
        }
        
        function openEditModal(id, name, studentId, email, position, manifesto, status) {
            document.getElementById('modalTitle').textContent = 'Edit Candidate';
            document.getElementById('candidateId').value = id;
            document.getElementById('action').value = 'update';
            document.getElementById('name').value = name;
            document.getElementById('studentId').value = studentId;
            document.getElementById('email').value = email;
            document.getElementById('position').value = position;
            document.getElementById('manifesto').value = manifesto;
            document.getElementById('status').value = status;
            document.getElementById('candidateModal').style.display = 'block';
        }
        
        function closeModal() {
            document.getElementById('candidateModal').style.display = 'none';
        }
        
        window.onclick = function(event) {
            var modal = document.getElementById('candidateModal');
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
</body>
</html>

