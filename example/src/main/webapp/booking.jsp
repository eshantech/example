<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cab.dao.DBConnection" %>

<%
    int userId = Integer.parseInt(request.getParameter("userId"));
    int driverId = Integer.parseInt(request.getParameter("driverId"));
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking - Mega City Cab</title>
    <link rel="stylesheet" href="CSS/style.css">
    <style>
        /* Taxi Theme Styling */
        body {
            font-family: Arial, sans-serif;
            background: url('images/Background.png') no-repeat center center fixed;
            background-size: cover;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 80%;
            background: rgba(255, 215, 0, 0.9);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3);
            display: flex;
            justify-content: space-between;
            animation: fadeIn 1s ease-in-out;
        }

        .form-section, .status-section {
            width: 48%;
            padding: 20px;
            background: white;
            border-radius: 9px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
            animation: slideIn 1s ease-in-out;
        }

        h2, h3 {
            text-align: center;
            color: black;
        }

        label {
            display: block;
            font-weight: bold;
            margin: 10px 0 5px;
        }

        input {
            width: 95%;
            padding: 8px;
            margin-bottom: 10px;
            border: 2px solid black;
            border-radius: 15px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        input:focus {
            border-color: #ffcc00;
            box-shadow: 0 0 5px #ffcc00;
        }

        /* Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: black;
            color: yellow;
        }

        td {
            background-color: white;
        }

        /* Buttons */
        button {
            background-color: black;
            color: yellow;
            font-size: 16px;
            font-weight: bold;
            padding: 10px;
            width: 100%;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        button:hover {
            background-color: yellow;
            color: black;
        }

        /* Cancel Link */
        .cancel {
            display: block;
            text-align: center;
            margin-top: 15px;
            font-weight: bold;
            color: black;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .cancel:hover {
            color: #ffcc00;
        }

        /* Taxi Animation */
        .taxi {
            position: absolute;
            top: -40px;
            left: -60px;
            width: 50px;
            height: 50px;
            background: url('images/taxi-icon.png') no-repeat center center;
            background-size: cover;
            animation: moveTaxi 3s infinite linear;
        }

        @keyframes moveTaxi {
            0% { left: -60px; }
            100% { left: 120%; }
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-50px); }
            to { opacity: 1; transform: translateX(0); }
        }

    </style>
</head>
<body>

    <div class="container">
        <div class="taxi"></div>

        <!-- Booking Form -->
        <div class="form-section">
            <h2>🚖 Book Your Ride</h2>
            <form action="BookingController" method="post">
                <input type="hidden" name="userId" value="<%= userId %>">
                <input type="hidden" name="driverId" value="<%= driverId %>">

                <label>Pickup Location:</label>
                <input type="text" name="pickupLocation" required>

                <label>Drop Location:</label>
                <input type="text" name="dropLocation" required>

                <label>Distance (km):</label>
                <input type="number" name="distance" step="0.1" required>

                <button type="submit">Confirm Booking</button>
            </form>
        </div>

        <!-- Booking Status -->
        <div class="status-section">
            <h3>Your Booking Status</h3>
            <table>
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
    <a href="dashboard.jsp" class="cancel">⬅ Cancel</a>

</body>
</html>
