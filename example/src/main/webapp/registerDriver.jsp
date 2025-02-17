<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Driver Registration</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <h2>Driver Registration</h2>

    <%-- Display success message --%>
    <% if (request.getParameter("message") != null) { %>
        <p style="color: green;"><%= request.getParameter("message") %></p>
    <% } %>

    <%-- Display error message --%>
    <% if (request.getParameter("error") != null) { %>
        <p style="color: red;"><%= request.getParameter("error") %></p>
    <% } %>

    <form action="DriverRegisterController" method="post" enctype="multipart/form-data">
        <label>Username:</label>
        <input type="text" name="username" required>

        <label>Full Name:</label>
        <input type="text" name="name" required>

        <label>Address:</label>
        <input type="text" name="address" required>

        <label>NIC:</label>
        <input type="text" name="nic" required>

        <label>Gender:</label>
        <select name="gender" required>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select>

        <label>Mobile Number:</label>
        <input type="text" name="mobileNumber" required>

        <label>Select Vehicle:</label>
        <select name="vehicleType" required>
            <option value="4 Seats">Car - 4 Seats</option>
            <option value="3 Seats">Car - 3 Seats</option>
            <option value="6 Seats">Car - 6 Seats</option>
        </select>

        <label>Vehicle Color:</label>
        <input type="text" name="vehicleColor" required>

        <label>Vehicle Number:</label>
        <input type="text" name="vehicleNumber" required>

        <label>Upload Photo:</label>
        <input type="file" name="photo" accept="image/*" required>

        <label>Password:</label>
        <input type="password" name="password" required>

        <button type="submit">Register</button>
    </form>
</body>
</html>
