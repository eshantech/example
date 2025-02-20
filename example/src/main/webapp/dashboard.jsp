<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cab.model.User" %>
<%@ page import="com.cab.dao.DBConnection" %>

<%
    // Check if the user is logged in
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
    <title>User Dashboard</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <div class="dashboard-container">
        <h2>Welcome, <%= user.getName() %>!</h2>

        <!-- User Details Table -->
        <h3>Your Details</h3>
        <table border="1">
            <tr><th>Username</th><td><%= user.getUsername() %></td></tr>
            <tr><th>Email</th><td><%= user.getEmail() %></td></tr>
            <tr><th>Address</th><td><%= user.getAddress() %></td></tr>
            <tr><th>Mobile Number</th><td><%= user.getMobileNumber() %></td></tr>
            <tr><th>NIC Number</th><td><%= user.getNicNumber() %></td></tr>
            <tr><th>Gender</th><td><%= user.getGender() %></td></tr>
        </table>

        <br><br>

        <h3>Available Drivers</h3>
<table border="1">
    <tr>
        <th>Name</th>
        <th>Vehicle Type</th>
        <th>Vehicle Color</th>
        <th>Vehicle Number</th>
        <th>Gender</th>
        <th>Action</th>
    </tr>
    <%
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT driver_id, name, vehicle_type, vehicle_color, vehicle_number, gender FROM drivers WHERE availability = 'Yes'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("vehicle_type") %></td>
        <td><%= rs.getString("vehicle_color") %></td>
        <td><%= rs.getString("vehicle_number") %></td>
        <td><%= rs.getString("gender") %></td>
        <td>
    <form action="booking.jsp" method="post">
        <input type="hidden" name="driverId" value="<%= rs.getInt("driver_id") %>">
        <input type="hidden" name="userId" value="<%= user.getUserId() %>">
        <button type="submit">Book Now</button>
    </form>
</td>
    </tr>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    
</table>

        <br>
        <a href="logout.jsp">Logout</a>
    </div>
</body>
</html>
