<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.cab.model.User, com.cab.dao.UserManageDAO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <h1>Manage Users</h1>

    <!-- Display Messages -->
    <%
        String message = request.getParameter("message");
        String error = request.getParameter("error");
        if (message != null) { 
    %>
        <p style="color:green;"><%= message %></p>
    <%
        }
        if (error != null) {
    %>
        <p style="color:red;"><%= error %></p>
    <%
        }
    %>

    <!-- Search Form -->
    <form action="UserManageServlet" method="get">
        <input type="text" name="searchQuery" placeholder="Search by Username or Email">
        <input type="hidden" name="action" value="search">
        <button type="submit">Search</button>
    </form>

    <!-- Add User Form -->
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

    <!-- Display Users -->
    <h2>Existing Users</h2>
    <table border="1">
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
                userList = userDao.getAllUsers(); // Get all users if no search results
            }
            
            for (User user : userList) {
        %>
        <tr>
            <td><%= user.getUserId() %></td>
            <td><%= user.getUsername() %></td>
            <td><%= user.getName() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getMobileNumber() %></td>
            <td>
                <a href="editUser.jsp?id=<%= user.getUserId() %>">Edit</a> |
                <a href="UserManageServlet?action=delete&id=<%= user.getUserId() %>" onclick="return confirm('Are you sure?')">Delete</a>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
