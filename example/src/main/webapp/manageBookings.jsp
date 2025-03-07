<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.cab.dao.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Bookings - Mega City Cab</title>

    <%-- CSS Styling --%>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('images/Background.png') no-repeat center center/cover;
            margin: 0;
            padding: 20px;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }
        h2 {
            color: #ffcc00;
            text-shadow: 2px 2px 4px black;
        }

        /* Responsive Table Wrapper */
        .table-container {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            max-width: 1200px;
            margin: 10px auto;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
            animation: fadeInUp 1s ease-in-out;
            table-layout: auto;
        }
        th, td {
            border: 1px solid black;
            padding: 12px;
            text-align: center;
            white-space: nowrap; /* wrapping */
        }
        th {
            background: black;
            color: #ffcc00;
        }
        tr:hover {
            background: #f1f1f1;
            transition: 0.3s;
        }
        .copy-icon {
            cursor: pointer;
            margin-left: 5px;
            color: blue;
            font-size: 18px;
            transition: 0.3s;
        }
        .copy-icon:hover {
            color: darkblue;
        }
        input[type="text"] {
            width: 50%;
            padding: 10px;
            margin-bottom: 15px;
            border: 2px solid black;
            border-radius: 5px;
            font-size: 16px;
        }
        button {
            background: black;
            color: white;
            padding: 8px 12px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            border-radius: 5px;
            transition: 0.3s;
        }
        button:hover {
            background: #ffcc00;
            color: black;
        }
        .delete-btn {
            background: red;
        }
        .delete-btn:hover {
            background: darkred;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>

    <%-- 🚖 JavaScript for Search & Copy Feature --%>
    <script>
        function copyToClipboard(text) {
            navigator.clipboard.writeText(text).then(() => {
                alert("Copied: " + text);
            }).catch(err => {
                console.error("Error copying: ", err);
            });
        }

        function searchBookings() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let table = document.getElementById("bookingsTable");
            let rows = table.getElementsByTagName("tr");

            for (let i = 1; i < rows.length; i++) {
                let rowText = rows[i].innerText.toLowerCase();
                rows[i].style.display = rowText.includes(input) ? "" : "none";
            }
        }
    </script>
</head>
<body>

    <h2>🚖 Manage Bookings</h2>
    
    <input type="text" id="searchInput" onkeyup="searchBookings()" placeholder="Search by Booking ID, Customer, Driver, etc.">

    <div class="table-container">
        <table id="bookingsTable">
            <tr>
                <th>Booking ID</th>
                <th>Customer ID</th>
                <th>Customer Name</th>
                <th>Customer Mobile</th>
                <th>Customer Email</th>
                <th>Driver ID</th>
                <th>Driver Name</th>
                <th>Driver Mobile</th>
                <th>Pickup</th>
                <th>Drop</th>
                <th>Distance</th>
                <th>Price</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>

            <%
                try (Connection conn = DBConnection.getConnection()) {
                    String sql = "SELECT b.booking_id, b.user_id, u.name AS user_name, u.mobile_number AS user_mobile, u.email AS user_email, " +
                                 "b.driver_id, d.name AS driver_name, d.mobile_number AS driver_mobile, " +
                                 "b.pickup_location, b.drop_location, b.distance, b.price, b.status " +
                                 "FROM bookings b " +
                                 "JOIN users u ON b.user_id = u.user_id " +
                                 "JOIN drivers d ON b.driver_id = d.driver_id " +
                                 "ORDER BY b.booking_id DESC";

                    PreparedStatement stmt = conn.prepareStatement(sql);
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("booking_id") %></td>
                <td><%= rs.getInt("user_id") %></td>
                <td><%= rs.getString("user_name") %></td>
                <td>
                    <%= rs.getString("user_mobile") %> 
                    <span class="copy-icon" onclick="copyToClipboard('<%= rs.getString("user_mobile") %>')">📋</span>
                </td>
                <td>
                    <%= rs.getString("user_email") %> 
                    <span class="copy-icon" onclick="copyToClipboard('<%= rs.getString("user_email") %>')">📋</span>
                </td>
                <td><%= rs.getInt("driver_id") %></td>
                <td><%= rs.getString("driver_name") %></td>
                <td>
                    <%= rs.getString("driver_mobile") %> 
                    <span class="copy-icon" onclick="copyToClipboard('<%= rs.getString("driver_mobile") %>')">📋</span>
                </td>
                <td><%= rs.getString("pickup_location") %></td>
                <td><%= rs.getString("drop_location") %></td>
                <td><%= rs.getDouble("distance") %> km</td>
                <td><%= rs.getDouble("price") %> LKR</td>
                <td><%= rs.getString("status") %></td>
                <td>
                    <form action="UpdateBookingController" method="post" style="display:inline;">
                        <input type="hidden" name="bookingId" value="<%= rs.getInt("booking_id") %>">
                        <button type="submit">Update</button>
                    </form>
                    <form action="DeleteBookingController" method="post" style="display:inline;">
                        <input type="hidden" name="bookingId" value="<%= rs.getInt("booking_id") %>">
                        <button type="submit" class="delete-btn" onclick="return confirm('Are you sure?')">Delete</button>
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
    </div>

</body>
</html>
