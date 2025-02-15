<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cab.dao.EditUserDAO, com.cab.model.User" %>
<%
    int userId = Integer.parseInt(request.getParameter("id"));
    EditUserDAO editUserDAO = new EditUserDAO();
    User user = editUserDAO.getUserById(userId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <h1>Edit User</h1>
    <form action="EditUserController" method="post">
        <input type="hidden" name="userId" value="<%= user.getUserId() %>">
        <label>Username:</label>
        <input type="text" name="username" value="<%= user.getUsername() %>" required>
        
        <label>Full Name:</label>
        <input type="text" name="name" value="<%= user.getName() %>" required>
        
        <label>Email:</label>
        <input type="email" name="email" value="<%= user.getEmail() %>" required>
        
        <label>Address:</label>
        <input type="text" name="address" value="<%= user.getAddress() %>" required>
        
        <label>Mobile Number:</label>
        <input type="text" name="mobileNumber" value="<%= user.getMobileNumber() %>" required>
        
        <label>NIC Number:</label>
        <input type="text" name="nicNumber" value="<%= user.getNicNumber() %>" required>
        
        <label>Gender:</label>
        <select name="gender" required>
            <option value="Male" <%= user.getGender().equals("Male") ? "selected" : "" %>>Male</option>
            <option value="Female" <%= user.getGender().equals("Female") ? "selected" : "" %>>Female</option>
        </select>
        
        <label>Password:</label>
        <input type="password" name="password" value="<%= user.getPassword() %>" required>
        
        <button type="submit">Update User</button>
    </form>
</body>
</html>
