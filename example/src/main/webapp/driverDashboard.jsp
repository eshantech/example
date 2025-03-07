<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cab.dao.DBConnection" %>
<%@ page import="java.util.List, com.cab.dao.BookingDAO, com.cab.model.Booking" %>
<%@ page import="com.cab.dao.UserDAO, com.cab.model.User" %>

<%-- Check if the driver is logged in --%>
<%
    Integer driverIdObj = (Integer) session.getAttribute("driverId");
    if (driverIdObj == null) {
        response.sendRedirect("driverLogin.jsp?error=Please login first");
        return;
    }
    int driverId = driverIdObj; // driverId is not null
%>
<!DOCTYPE html>
<html>
<head>
    <title>Driver Dashboard</title>
    <meta charset="UTF-8">
    <%-- jQuery CDN for animations and interactions --%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    
    <%-- CSS Styling --%>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #f4d03f, #16a085);
            color: #333;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        .container {
            max-width: 900px;
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

        h2 {
            color: #16a085;
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

        button, .button {
            background: #16a085;
            color: white;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            transition: 0.3s;
            border-radius: 5px;
        }

        button:hover, .button:hover {
            background: #f39c12;
            transform: scale(1.1);
        }

        select {
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ddd;
            background: #fff;
            transition: 0.3s;
        }

        select:hover {
            border-color: #16a085;
        }

        .status {
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 5px;
            display: inline-block;
        }

        .pending {
            background: #f39c12;
            color: white;
        }

        .completed {
            background: #16a085;
            color: white;
        }

        .earnings-box {
            background: #f4d03f;
            color: black;
            padding: 15px;
            text-align: center;
            border-radius: 10px;
            font-size: 18px;
            font-weight: bold;
            position: absolute;
            top: 10px;
            right: 20px;
            animation: bounce 2s infinite;
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

        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-5px);
            }
        }

        img {
            border-radius: 5px;
            box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.1);
        }
    </style>

    <%-- JavaScript --%>
    <script>
        function updateAvailability() {
            $("#availabilityForm").submit();
        }

        $(document).ready(function() {
            $(".container").css("opacity", 0).animate({ opacity: 1 }, 1000);
            $("table").each(function(index) {
                $(this).delay(200 * index).animate({ opacity: 1, transform: "translateY(0)" }, 800);
            });

            $("button[name='action']").click(function(e) {
                let action = $(this).val();
                if (!confirm("Are you sure you want to " + action + " this booking?")) {
                    e.preventDefault();
                }
            });
        });
    </script>
</head>
<body>
    <div class="container">
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
        <table>
            <tr><th>Name</th><td><%= name %></td></tr>
            <tr><th>Address</th><td><%= address %></td></tr>
            <tr><th>NIC</th><td><%= nic %></td></tr>
            <tr><th>Gender</th><td><%= gender %></td></tr>
            <tr><th>Mobile Number</th><td><%= mobileNumber %></td></tr>
            <tr><th>Vehicle Type</th><td><%= vehicleType %></td></tr>
            <tr><th>Vehicle Color</th><td><%= vehicleColor %></td></tr>
            <tr><th>Vehicle Number</th><td><%= vehicleNumber %></td></tr>
            <tr><th>Photo</th><td>
                <% if (photoPath != null && !photoPath.isEmpty()) { %>
                    <img src="<%= photoPath %>" alt="Driver Photo" width="100">
                <% } else { %>
                    No Photo Available
                <% } %>
            </td></tr>
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
        <table>
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
        <table>
            <tr><th>User Name</th><td><%= confirmedUser.getName() %></td></tr>
            <tr><th>Mobile Number</th><td><%= confirmedUser.getMobileNumber() %></td></tr>
        </table>
        <%
                session.removeAttribute("confirmedUser");
            }
        %>

        <h3>Completed Bookings</h3>
        <table>
            <tr>
                <th>Booking ID</th>
                <th>Pickup Location</th>
                <th>Drop Location</th>
                <th>Distance (km)</th>
                <th>Price (LKR)</th>
                <th>Completed Date</th>
                <th>Completed Time</th>
            </tr>
            <%
                double totalEarnings = 0;
                double taxRate = 0.06; // 6% tax
                double totalAfterTax = 0;

                try (Connection conn = DBConnection.getConnection()) {
                    String sql = "SELECT booking_id, pickup_location, drop_location, distance, price, completed_date, completed_time FROM bookings WHERE driver_id = ? AND status = 'Completed'";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, driverId);
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                        double price = rs.getDouble("price");
                        double afterTax = price - (price * taxRate);
                        totalEarnings += price;
                        totalAfterTax += afterTax;
            %>
            <tr>
                <td><%= rs.getInt("booking_id") %></td>
                <td><%= rs.getString("pickup_location") %></td>
                <td><%= rs.getString("drop_location") %></td>
                <td><%= rs.getDouble("distance") %> km</td>
                <td>
                    <%= price %> LKR <br>
                    <b>Available (6% Tax)</b> <%= String.format("%.2f", afterTax) %> LKR
                </td>
                <td><%= rs.getDate("completed_date") %></td>
                <td><%= rs.getTime("completed_time") %></td>
            </tr>
            <% 
                    }
                } catch (Exception e) { e.printStackTrace(); } 
            %>
        </table>

        <div class="earnings-box">
            <h3>Total Earnings: <%= totalEarnings %> LKR</h3>
            <h3>Available Balance (6% Tax): <%= String.format("%.2f", totalAfterTax) %> LKR</h3>
        </div>
    </div>
</body>
</html>