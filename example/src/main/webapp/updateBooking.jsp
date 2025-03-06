<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.cab.dao.DBConnection" %>

<%
    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String pickupLocation = "", dropLocation = "", status = "";
    double distance = 0, price = 0;
    int userId = 0, driverId = 0;

    try {
        conn = DBConnection.getConnection();
        String sql = "SELECT * FROM bookings WHERE booking_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, bookingId);
        rs = stmt.executeQuery();

        if (rs.next()) {
            userId = rs.getInt("user_id");
            driverId = rs.getInt("driver_id");
            pickupLocation = rs.getString("pickup_location");
            dropLocation = rs.getString("drop_location");
            distance = rs.getDouble("distance");
            price = rs.getDouble("price");
            status = rs.getString("status");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Booking</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #FF9800, #FF5722);
            background: url('images/Background.png') no-repeat center center/cover;
            color: white;
            text-align: center;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .container {
            background: rgba(0, 0, 0, 0.8);
            padding: 30px;
            border-radius: 10px;
            width: 400px;
            animation: fadeIn 1s ease-in-out;
            box-shadow: 0 0 20px rgba(255, 255, 255, 0.2);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        h2 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        label {
            display: block;
            text-align: left;
            font-weight: bold;
            margin-top: 10px;
        }

        input, select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            color: black;
        }

        button {
            width: 100%;
            padding: 10px;
            margin-top: 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            background: #FFC107;
            color: black;
            cursor: pointer;
            transition: 0.3s ease-in-out;
        }

        button:hover {
            background: #FFD54F;
            transform: scale(1.05);
        }

        a {
            display: block;
            margin-top: 15px;
            color: #FFC107;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function showSuccessMessage() {
            alert("Booking updated successfully!");
            window.location.href = "manageBookings.jsp";
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Update Booking</h2>
        <form action="UpdateBookingController" method="post">
            <input type="hidden" name="bookingId" value="<%= bookingId %>">

            <label>User ID:</label>
            <input type="text" name="userId" value="<%= userId %>" required>

            <label>Driver ID:</label>
            <input type="text" name="driverId" value="<%= driverId %>" required>

            <label>Pickup Location:</label>
            <input type="text" name="pickupLocation" value="<%= pickupLocation %>" required>

            <label>Drop Location:</label>
            <input type="text" name="dropLocation" value="<%= dropLocation %>" required>

            <label>Distance (km):</label>
            <input type="number" name="distance" step="0.1" value="<%= distance %>" required>

            <label>Price (LKR):</label>
            <input type="number" name="price" step="0.1" value="<%= price %>" required>

            <label>Status:</label>
            <select name="status">
                <option value="Pending" <%= status.equals("Pending") ? "selected" : "" %>>Pending</option>
                <option value="Confirm" <%= status.equals("Confirm") ? "selected" : "" %>>Confirm</option>
                <option value="Complete - Pending" <%= status.equals("Complete - Pending") ? "selected" : "" %>>Complete - Pending</option>
                <option value="Completed" <%= status.equals("Completed") ? "selected" : "" %>>Completed</option>
            </select>

            <button type="submit">Update Booking</button>
        </form>
        <a href="manageBookings.jsp">Go to Manage Bookings</a>
    </div>
</body>
</html>
