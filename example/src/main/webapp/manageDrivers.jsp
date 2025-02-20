<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.cab.dao.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Drivers</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <h2>Manage Drivers</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Name</th>
            <th>Address</th>
            <th>NIC</th>
            <th>Gender</th>
            <th>Mobile</th>
            <th>Vehicle Type</th>
            <th>Vehicle Color</th>
            <th>Vehicle Number</th>
            <th>Availability</th>
            <th>Location1</th>
            <th>Location2</th>
            <th>Action</th>
        </tr>
        
        <%
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT * FROM drivers";
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("driver_id") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("address") %></td>
            <td><%= rs.getString("nic") %></td>
            <td><%= rs.getString("gender") %></td>
            <td><%= rs.getString("mobile_number") %></td>
            <td><%= rs.getString("vehicle_type") %></td>
            <td><%= rs.getString("vehicle_color") %></td>
            <td><%= rs.getString("vehicle_number") %></td>
            <td><%= rs.getString("availability") %></td>
            <td><%= rs.getString("location1") %></td>
            <td><%= rs.getString("location2") %></td>
            <td><a href="editDriverAdmin.jsp?driverId=<%= rs.getInt("driver_id") %>">Edit</a></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
</body>
</html>
