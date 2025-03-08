<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.cab.dao.DBConnection" %>

<%
    // Get parameters
    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
    String name = request.getParameter("name");
    String number = request.getParameter("number");
    String orderDateTime = request.getParameter("orderDateTime");

    // Booking details
    String pickup = "", drop = "";
    double distance = 0.0, price = 0.0;

    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT pickup_location, drop_location, distance, price FROM bookings WHERE booking_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, bookingId);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            pickup = rs.getString("pickup_location");
            drop = rs.getString("drop_location");
            distance = rs.getDouble("distance");
            price = rs.getDouble("price");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation</title>
    
    <style>
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            background: url('images/Background.png') no-repeat center center/cover;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            color: #333;
        }

        h2 {
            text-align: center;
            font-size: 30px;
            color: #29573e;
            margin-top: 30px;
            animation: fadeIn 1s ease-out;
        }

        /* Table Styles */
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            animation: slideIn 1s ease-in-out;
        }

        table, th, td {
            border: 1px solid #ddd;
            text-align: left;
        }

        th, td {
            padding: 10px;
        }

        th {
            background-color: #ffcc00;
            color: black;
        }

        td {
            background-color: #fff;
        }

        /* Status animation */
        .status {
            font-weight: bold;
            color: #ff0000;
            animation: pulseStatus 2s infinite;
        }

        /* Link styling */
        a {
            display: block;
            text-align: center;
            font-size: 18px;
            margin-top: 20px;
            padding: 10px;
            background-color: #ffcc00;
            color: black;
            text-decoration: none;
            border-radius: 5px;
            width: 200px;
            margin: 30px auto;
            transition: 0.3s;
        }

        a:hover {
            background-color: #ffb800;
        }

        /* Animations */
        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(-30px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideIn {
            0% {
                transform: translateX(-100%);
                opacity: 0;
            }
            100% {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes pulseStatus {
            0% {
                color: #ff0000;
                transform: scale(1);
            }
            50% {
                color: #ff9900;
                transform: scale(1.1);
            }
            100% {
                color: #ff0000;
                transform: scale(1);
            }
        }
    </style>
</head>
<body>
    <h2>Booking Confirmation</h2>

    <table>
        <tr>
            <td><b>User Name:</b></td>
            <td><%= name %></td>
        </tr>
        <tr>
            <td><b>Mobile Number:</b></td>
            <td><%= number %></td>
        </tr>
        <tr>
            <td><b>Pickup Location:</b></td>
            <td><%= pickup %></td>
        </tr>
        <tr>
            <td><b>Drop Location:</b></td>
            <td><%= drop %></td>
        </tr>
        <tr>
            <td><b>Distance:</b></td>
            <td><%= distance %> km</td>
        </tr>
        <tr>
            <td><b>Price:</b></td>
            <td>LKR <%= price %></td>
        </tr>
        <tr>
            <td><b>Status:</b></td>
            <td class="status">Complete - Pending</td>
        </tr>
        <tr>
            <td><b>Order Date & Time:</b></td>
            <td><%= orderDateTime %></td>
        </tr>
    </table>

    <a href="driverDashboard.jsp">Back to Dashboard</a>

    <script>
        // You can add JS functionality if required for additional interactions
    </script>
</body>
</html>
