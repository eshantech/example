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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <link rel="stylesheet" href="CSS/style.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #f4d03f, #16a085);
            color: #333;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        .dashboard-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: white;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            animation: fadeIn 1.5s ease-in-out;
        }

        h2, h3 {
            text-align: center;
            opacity: 0;
            transform: translateY(-20px);
            animation: fadeInUp 1s ease-in-out forwards;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 1s ease-in-out forwards;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background: #f4d03f;
            color: black;
        }

        button {
            background: #16a085;
            color: white;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            transition: 0.3s;
            border-radius: 5px;
        }

        button:hover {
            background: #f39c12;
            transform: scale(1.1);
        }

        .logout-btn {
            margin-top: 20px;
            display: inline-block;
            background: #e74c3c;
            padding: 10px 15px;
            border-radius: 5px;
            color: white;
            text-decoration: none;
            transition: 0.3s;
        }

        .logout-btn:hover {
            background: #c0392b;
        }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <h2>Welcome, <%= user.getName() %>!</h2>

    <h3>Your Details</h3>
    <table>
        <tr><th>Username</th><td><%= user.getUsername() %></td></tr>
        <tr><th>Email</th><td><%= user.getEmail() %></td></tr>
        <tr><th>Address</th><td><%= user.getAddress() %></td></tr>
        <tr><th>Mobile Number</th><td><%= user.getMobileNumber() %></td></tr>
        <tr><th>NIC Number</th><td><%= user.getNicNumber() %></td></tr>
        <tr><th>Gender</th><td><%= user.getGender() %></td></tr>
    </table>

    <br>
    <a href="edituserdashboard.jsp">
        <button>Edit</button>
    </a>

    <h3>Available Drivers</h3>
    <table>
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
    <table>
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
    <a href="logout.jsp" class="logout-btn">Logout</a>
</div>

</body>
</html>
