<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.cab.model.User, com.cab.dao.UserManageDAO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>
    <style>
        /* General Styling */
        body {
            font-family: 'Poppins', sans-serif;
            background: url('images/Background.png') no-repeat center center/cover;
            text-align: center;
            margin: 0;
            padding: 20px;
            animation: fadeIn 1s ease-in-out;
        }
        h1, h2 {
            color: #ffcc00;
            text-shadow: 2px 2px 4px black;
        }

        /* Form */
        form {
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            margin: 15px auto;
            width: 50%;
            max-width: 500px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
            animation: fadeInUp 0.8s ease-in-out;
        }
        input, select, button {
            width: 90%;
            padding: 10px;
            margin: 8px 0;
            border: 2px solid black;
            border-radius: 5px;
            font-size: 16px;
        }
        button {
            background: black;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: 0.3s;
        }
        button:hover {
            background: #ffcc00;
            color: black;
        }

        /* Table Styling */
        .table-container {
            width: 90%;
            margin: auto;
            overflow-x: auto;
        }
        table {
            width: 100%;
            max-width: 1000px;
            margin: 20px auto;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
            animation: fadeInUp 1s ease-in-out;
        }
        th, td {
            border: 1px solid black;
            padding: 12px;
            text-align: center;
            white-space: nowrap;
        }
        th {
            background: black;
            color: #ffcc00;
        }
        tr:hover {
            background: #f1f1f1;
            transition: 0.3s;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>

    <script>
        // Search Function
        function searchUsers() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let table = document.getElementById("usersTable");
            let rows = table.getElementsByTagName("tr");

            for (let i = 1; i < rows.length; i++) {
                let rowText = rows[i].innerText.toLowerCase();
                rows[i].style.display = rowText.includes(input) ? "" : "none";
            }
        }

        // Clipboard
        function copyToClipboard(text) {
            navigator.clipboard.writeText(text).then(() => {
                alert("Copied: " + text);
            }).catch(err => {
                console.error("Error copying: ", err);
            });
        }
    </script>
</head>
<body>

    <h1>🚖 Manage Users</h1>

    <!-- Display Messages -->
    <%
        String message = request.getParameter("message");
        String error = request.getParameter("error");
        if (message != null) { 
    %>
        <p style="color:green; font-weight:bold;"><%= message %></p>
    <%
        }
        if (error != null) {
    %>
        <p style="color:red; font-weight:bold;"><%= error %></p>
    <%
        }
    %>

    <!-- Search Form -->
    <form action="UserManageServlet" method="get">
        <input type="text" id="searchInput" name="searchQuery" placeholder="Search by Username or Email" onkeyup="searchUsers()">
        <input type="hidden" name="action" value="search">
        <button type="submit">Search</button>
    </form>

    <!-- Add User -->
    <form action="UserManageServlet" method="post">
        <h2>Add User</h2>
        <input type="hidden" name="action" value="add">
        <input type="text" name="username" placeholder="Username" required>
        <input type="text" name="name" placeholder="Full Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="text" name="address" placeholder="Address" required>
        <input type="text" name="mobileNumber" placeholder="Mobile Number" required>
        <input type="text" name="nicNumber" placeholder="NIC Number" required>
        <select name="gender" required>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Add User</button>
    </form>

    <!-- Existing Users Table -->
    <h2>Existing Users</h2>
    <div class="table-container">
        <table id="usersTable">
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Name</th>
                <th>Email</th>
                <th>Mobile</th>
                <th>Actions</th>
            </tr>
            <%
                UserManageDAO userDao = new UserManageDAO();
                List<User> userList = (List<User>) request.getAttribute("userList");
                if (userList == null) {
                    userList = userDao.getAllUsers(); // Get all search results
                }

                for (User user : userList) {
            %>
            <tr>
                <td><%= user.getUserId() %></td>
                <td><%= user.getUsername() %></td>
                <td><%= user.getName() %></td>
                <td>
                    <%= user.getEmail() %> 
                    <span style="cursor:pointer; color:blue;" onclick="copyToClipboard('<%= user.getEmail() %>')">📋</span>
                </td>
                <td>
                    <%= user.getMobileNumber() %> 
                    <span style="cursor:pointer; color:blue;" onclick="copyToClipboard('<%= user.getMobileNumber() %>')">📋</span>
                </td>
                <td>
                    <a href="editUser.jsp?id=<%= user.getUserId() %>">✏️ Edit</a> |
                    <a href="UserManageServlet?action=delete&id=<%= user.getUserId() %>" onclick="return confirm('Are you sure?')">🗑️ Delete</a>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

</body>
</html>
