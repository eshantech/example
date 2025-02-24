<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cab.model.User" %>
<%@ page import="com.cab.dao.DBConnection" %>

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
        <tr>
    <td colspan="2" style="text-align: center;">
        <a href="edituserdashboard.jsp">
            <button>Edit</button>
        </a>
    </td>
</tr>
        

        <h3>Available Drivers</h3>
<table border="1">
    <tr>
        <th>Name</th>
        <th>Vehicle Type</th>
        <th>Vehicle Color</th>
        <th>Vehicle Number</th>
        <th>Gender</th>
        <th>Rating</th>
        <th>Action</th>
    </tr>
    <%
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT d.driver_id, d.name, d.vehicle_type, d.vehicle_color, d.vehicle_number, d.gender, " +
                         "COALESCE(AVG(rf.rating), 0) AS avg_rating " +
                         "FROM drivers d " +
                         "LEFT JOIN ride_feedback rf ON d.driver_id = (SELECT b.driver_id FROM bookings b WHERE b.booking_id = rf.booking_id) " +
                         "WHERE d.availability = 'Yes' " +
                         "GROUP BY d.driver_id, d.name, d.vehicle_type, d.vehicle_color, d.vehicle_number, d.gender";
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
        <td><%= String.format("%.1f", rs.getDouble("avg_rating")) %> ★</td>
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
 <h3>Completed Bookings</h3>
<table border="1">
    <tr>
        <th>Booking ID</th>
        <th>Driver Name</th>
        <th>Pickup Location</th>
        <th>Drop Location</th>
        <th>Distance (km)</th>
        <th>Price (LKR)</th>
        <th>Completion Date</th>
        <th>Completion Time</th>
        <th>Action</th>
    </tr>
    <%
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT b.booking_id, d.name, b.pickup_location, b.drop_location, " +
                         "b.distance, b.price, b.completed_date, b.completed_time " +
                         "FROM bookings b JOIN drivers d ON b.driver_id = d.driver_id " +
                         "WHERE b.user_id = ? AND b.status = 'Completed'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, user.getUserId());
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt("booking_id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("pickup_location") %></td>
        <td><%= rs.getString("drop_location") %></td>
        <td><%= rs.getDouble("distance") %></td>
        <td><%= rs.getDouble("price") %></td>
        <td><%= rs.getDate("completed_date") %></td>
        <td><%= rs.getTime("completed_time") %></td>
        <td>
            <form action="GenerateBillServlet" method="post">
                <input type="hidden" name="bookingId" value="<%= rs.getInt("booking_id") %>">
                <button type="submit">Print Bill</button>
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
