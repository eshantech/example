<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cab.dao.DBConnection" %>

<%
    int userId = Integer.parseInt(request.getParameter("userId"));
    int driverId = Integer.parseInt(request.getParameter("driverId"));
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking</title>
    <style>
        .container { display: flex; }
        .form-section { width: 50%; }
        .status-section { width: 50%; }
    </style>
</head>
<body>
    <h2>Booking Page</h2>

    <div class="container">
        <!-- Booking Form -->
        <div class="form-section">
            <form action="BookingController" method="post">
                <input type="hidden" name="userId" value="<%= userId %>">
                <input type="hidden" name="driverId" value="<%= driverId %>">

                <label>Pickup Location:</label>
                <input type="text" name="pickupLocation" required><br>

                <label>Drop Location:</label>
                <input type="text" name="dropLocation" required><br>

                <label>Distance (km):</label>
                <input type="number" name="distance" step="0.1" required><br>

                <button type="submit">Confirm Booking</button>
            </form>
        </div>

       <!-- Booking Status -->
<div class="status-section">
    <h3>Your Booking Status</h3>
    <table border="1">
        <tr>
            <th>Pickup</th>
            <th>Drop</th>
            <th>Distance</th>
            <th>Price</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <%
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT booking_id, pickup_location, drop_location, distance, price, status FROM bookings WHERE user_id = ? ORDER BY booking_id DESC";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    int bookingId = rs.getInt("booking_id");
                    String status = rs.getString("status");
        %>
        <tr>
            <td><%= rs.getString("pickup_location") %></td>
            <td><%= rs.getString("drop_location") %></td>
            <td><%= rs.getDouble("distance") %> km</td>
            <td><%= rs.getDouble("price") %> LKR</td>
            <td><%= status %></td>
            <td>
                <% if ("Complete - Pending".equals(status)) { %>
                    <form action="completeRide.jsp" method="post">
                        <input type="hidden" name="bookingId" value="<%= bookingId %>">
                        <button type="submit">Ride Complete</button>
                    </form>
                <% } %>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
</div>
    </div>

    <br>
    <a href="dashboard.jsp">Cancel</a>
</body>
</html>
