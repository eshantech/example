<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cab.model.User" %>

<%
    // user is logged in
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=Please login first");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User Details</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <div class="edit-container">
        <h2>Edit Your Details</h2>
        <form action="UserEditController" method="post">
            <input type="hidden" name="userId" value="<%= user.getUserId() %>">

            <label>Name:</label>
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
                <option value="Other" <%= user.getGender().equals("Other") ? "selected" : "" %>>Other</option>
            </select>

            <button type="submit">Update</button>
        </form>
        <br>
        <a href="dashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
