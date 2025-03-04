<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.cab.dao.DBConnection" %>

<%
    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
    String driverName = "", pickupLocation = "", dropLocation = "";
    double ridePrice = 0.0, distance = 0.0;
    int userId = 0;

    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT b.user_id, d.name, b.price, b.pickup_location, b.drop_location, b.distance " +
                     "FROM bookings b JOIN drivers d ON b.driver_id = d.driver_id WHERE b.booking_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, bookingId);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            userId = rs.getInt("user_id");
            driverName = rs.getString("name");
            ridePrice = rs.getDouble("price");
            pickupLocation = rs.getString("pickup_location");
            dropLocation = rs.getString("drop_location");
            distance = rs.getDouble("distance");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Successful - Mega City Cab</title>
    <style>
        body {
            background-color: #f4f4f4;
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 20px;
        }
        .container {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .button {
            background-color: black;
            color: yellow;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
        }
        .button:hover {
            background-color: yellow;
            color: black;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Payment Successful</h2>
        <p><strong>Booking ID:</strong> <%= bookingId %></p>
        <p><strong>User ID:</strong> <%= userId %></p>
        <p><strong>Driver:</strong> <%= driverName %></p>
        <p><strong>Pickup Location:</strong> <%= pickupLocation %></p>
        <p><strong>Drop Location:</strong> <%= dropLocation %></p>
        <p><strong>Distance:</strong> <%= distance %> km</p>
        <p><strong>Ride Price:</strong> LKR <%= ridePrice %></p>

        <h3>Your Payment Has Been Successfully Processed!</h3>
        <p>You will receive a confirmation email shortly.</p>

        <a href="dashboard.jsp" class="button">Go to Dashboard</a>
    </div>
</body>
</html>
