<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cab.dao.DBConnection" %>
<%@ page import="java.util.List, com.cab.dao.BookingDAO, com.cab.model.Booking" %>
<%@ page import="com.cab.dao.UserDAO, com.cab.model.User" %>

<%-- Check if the user is logged in --%>
<%
    Integer driverIdObj = (Integer) session.getAttribute("driverId");
    if (driverIdObj == null) {
        response.sendRedirect("driverLogin.jsp?error=Please login first");
        return;
    }
    int driverId = driverIdObj; // Now we are sure driverId is not null
%>

<!DOCTYPE html>
<html>
<head>
    <title>Driver Dashboard</title>
    <link rel="stylesheet" href="CSS/style.css">
    <script>
        function updateAvailability() {
            document.getElementById("availabilityForm").submit();
        }
    </script>
</head>
<body>
    <h2>Driver Dashboard</h2>

    <%-- Get Driver Data from Database --%>
    <% 
        String username = "";
        String name = "";
        String address = "";
        String nic = "";
        String gender = "";
        String mobileNumber = "";
        String vehicleType = "";
        String vehicleColor = "";
        String vehicleNumber = "";
        String photoPath = "";
        String availability = "No";
        String location1 = "";
        String location2 = "";

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT username, name, address, nic, gender, mobile_number, vehicle_type, vehicle_color, vehicle_number, photo_path, availability, location1, location2 FROM drivers WHERE driver_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, driverId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                username = rs.getString("username");
                name = rs.getString("name");
                address = rs.getString("address");
                nic = rs.getString("nic");
                gender = rs.getString("gender");
                mobileNumber = rs.getString("mobile_number");
                vehicleType = rs.getString("vehicle_type");
                vehicleColor = rs.getString("vehicle_color");
                vehicleNumber = rs.getString("vehicle_number");
                photoPath = rs.getString("photo_path");
                availability = rs.getString("availability");
                location1 = rs.getString("location1");
                location2 = rs.getString("location2");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <p>Welcome, <b><%= username %></b>!</p>

    <h3>Driver Details</h3>
    <table border="1">
        <tr>
            <td><b>Name:</b></td>
            <td><%= name %></td>
        </tr>
        <tr>
            <td><b>Address:</b></td>
            <td><%= address %></td>
        </tr>
        <tr>
            <td><b>NIC:</b></td>
            <td><%= nic %></td>
        </tr>
        <tr>
            <td><b>Gender:</b></td>
            <td><%= gender %></td>
        </tr>
        <tr>
            <td><b>Mobile Number:</b></td>
            <td><%= mobileNumber %></td>
        </tr>
        <tr>
            <td><b>Vehicle Type:</b></td>
            <td><%= vehicleType %></td>
        </tr>
        <tr>
            <td><b>Vehicle Color:</b></td>
            <td><%= vehicleColor %></td>
        </tr>
        <tr>
            <td><b>Vehicle Number:</b></td>
            <td><%= vehicleNumber %></td>
        </tr>
        <tr>
            <td><b>Photo:</b></td>
            <td>
                <% if (photoPath != null && !photoPath.isEmpty()) { %>
                    <img src="<%= photoPath %>" alt="Driver Photo" width="100">
                <% } else { %>
                    No Photo Available
                <% } %>
            </td>
        </tr>
    </table>

    <h3>Availability</h3>
    <form id="availabilityForm" action="UpdateAvailabilityController" method="post">
        <input type="hidden" name="driverId" value="<%= driverId %>">
        <label>Available:</label>
        <select name="availability" onchange="updateAvailability()">
            <option value="Yes" <%= "Yes".equals(availability) ? "selected" : "" %>>Yes</option>
            <option value="No" <%= "No".equals(availability) ? "selected" : "" %>>No</option>
        </select>
    </form>

    <h3>Select Locations</h3>
    <form action="UpdateLocationController" method="post">
        <input type="hidden" name="driverId" value="<%= driverId %>">
        
        <label>Location Slot 1:</label>
        <select name="location1">
            <option value="Downtown" <%= "Downtown".equals(location1) ? "selected" : "" %>>Downtown</option>
            <option value="Airport" <%= "Airport".equals(location1) ? "selected" : "" %>>Airport</option>
            <option value="Suburbs" <%= "Suburbs".equals(location1) ? "selected" : "" %>>Suburbs</option>
        </select>

        <label>Location Slot 2:</label>
        <select name="location2">
            <option value="Downtown" <%= "Downtown".equals(location2) ? "selected" : "" %>>Downtown</option>
            <option value="Airport" <%= "Airport".equals(location2) ? "selected" : "" %>>Airport</option>
            <option value="Suburbs" <%= "Suburbs".equals(location2) ? "selected" : "" %>>Suburbs</option>
        </select>

        <button type="submit">Update Locations</button>
    </form>
    <br>
    <form action="editDriverDashboard.jsp" method="post">
    <input type="hidden" name="driverId" value="<%= driverId %>">
    <button type="submit">Edit Profile</button>
</form>
<h3>Pending Bookings</h3>
<table border="1">
    <tr>
        <th>Pickup Location</th>
        <th>Drop Location</th>
        <th>Distance (km)</th>
        <th>Price (LKR)</th>
        <th>Actions</th>
    </tr>
    <%
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT b.booking_id, b.pickup_location, b.drop_location, b.distance, b.price " +
                         "FROM bookings b WHERE b.driver_id = ? AND b.status = 'Pending'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, driverId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int bookingId = rs.getInt("booking_id");
    %>
    <tr>
        <td><%= rs.getString("pickup_location") %></td>
        <td><%= rs.getString("drop_location") %></td>
        <td><%= rs.getDouble("distance") %></td>
        <td><%= rs.getDouble("price") %></td>
        <td>
            <form action="BookingActionController" method="post" style="display:inline;">
                <input type="hidden" name="bookingId" value="<%= bookingId %>">
                <button type="submit" name="action" value="confirm">Confirm</button>
                <button type="submit" name="action" value="cancel">Cancel</button>
            </form>
        </td>
    </tr>
    <% } } catch (Exception e) { e.printStackTrace(); } %>
</table>

<%-- Display Confirmed User Details --%>
<%
    User confirmedUser = (User) session.getAttribute("confirmedUser");
    if (confirmedUser != null) {
%>
    <h3>Confirmed Booking Details</h3>
    <table border="1">
        <tr>
            <td><b>User Name:</b></td>
            <td><%= confirmedUser.getName() %></td>
        </tr>
        <tr>
            <td><b>Mobile Number:</b></td>
            <td><%= confirmedUser.getMobileNumber() %></td>
        </tr>
    </table>
<%
        // Clear the session attribute after displaying the details
        session.removeAttribute("confirmedUser");
    }
%>

</body>
</html>
