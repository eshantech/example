<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.cab.dao.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Drivers</title>
    <style>
        /* 🚀 General Styling */
        body {
            font-family: 'Poppins', sans-serif;
            background: url('images/Background.png') no-repeat center center/cover;
            background-color: #f4f4f9;
            color: #333;
            padding: 20px;
            animation: fadeIn 1s ease-in-out;
        }
        h2 {
            color: #ffcc00;
            text-align: center;
            font-size: 32px;
            text-shadow: 2px 2px 4px black;
        }

        /* 🔥 Success/Error Messages */
        p {
            font-weight: bold;
        }
        .success {
            color: green;
        }
        .error {
            color: red;
        }

        /* 🎯 Header */
        h3 {
            color: #333;
            font-size: 24px;
            margin-bottom: 10px;
        }

        /* 🔍 Search Bar */
        #searchBar {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 2px solid #ddd;
            font-size: 16px;
            box-sizing: border-box;
            transition: 0.3s;
        }
        #searchBar:focus {
            border-color: #ffcc00;
        }

        /* 🚗 Driver Registration Form */
        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            animation: fadeInUp 1s ease-in-out;
            
        }
        form input, form select, form button {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 16px;
            box-sizing: border-box;
            transition: 0.3s;
        }
        form input:focus, form select:focus {
            border-color: #ffcc00;
        }
        form button {
            background-color: #ffcc00;
            color: #333;
            border: none;
            cursor: pointer;
        }
        form button:hover {
            background-color: #ff9900;
        }

        /* 📋 Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            animation: fadeIn 1s ease-in-out;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
            font-size: 16px;
        }
        th {
            background-color: #ffcc00;
            color: #fff;
        }
        tr:hover {
            background-color: rgba(255, 204, 0, 0.1);
            transition: 0.3s;
        }

        /* 🗑 Delete Button */
        button {
            background-color: #ff4d4d;
            color: #fff;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 5px;
            transition: 0.3s;
        }
        button:hover {
            background-color: #ff0000;
        }

        /* 🎭 Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>

    <script>
        // 🎯 Confirm Delete
        function confirmDelete(driverId) {
            if (confirm("Are you sure you want to delete this driver?")) {
                window.location.href = "DeleteDriverController?driverId=" + driverId;
            }
        }

        // 🏁 Update Availability
        function updateAvailability(driverId, checkbox) {
            let availability = checkbox.checked ? "Yes" : "No";
            fetch("UpdateAvailabilityController", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "driverId=" + driverId + "&availability=" + availability
            }).then(() => {
                alert("Availability updated successfully!");
                location.reload();
            });
        }

        // 🔍 Filter Drivers by Search Input
        function filterDrivers() {
            let search = document.getElementById("searchBar").value.toLowerCase();
            let rows = document.querySelectorAll("#driversTable tbody tr");
            rows.forEach(row => {
                let text = row.innerText.toLowerCase();
                row.style.display = text.includes(search) ? "" : "none";
            });
        }
    </script>
</head>
<body>

    <h2>Manage Drivers</h2>

    <!-- 🚀 Success/Error Messages -->
    <% if (request.getParameter("message") != null) { %>
        <p class="success"><%= request.getParameter("message") %></p>
    <% } %>
    <% if (request.getParameter("error") != null) { %>
        <p class="error"><%= request.getParameter("error") %></p>
    <% } %>

    <!-- 🔍 Search Bar -->
    <input type="text" id="searchBar" onkeyup="filterDrivers()" placeholder="Search Drivers..." />

    <!-- 🚗 Driver Registration Form -->
    <form action="DriverRegisterController" method="post" enctype="multipart/form-data">
        <h3>Register New Driver</h3>
        <input type="text" name="username" placeholder="Username" required />
        <input type="text" name="name" placeholder="Full Name" required />
        <input type="text" name="address" placeholder="Address" required />
        <input type="text" name="nic" placeholder="NIC" required />
        <select name="gender" required>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select>
        <input type="text" name="mobileNumber" placeholder="Mobile Number" required />
        <select name="vehicleType" required>
            <option value="4 Seats">Car - 4 Seats</option>
            <option value="3 Seats">Car - 3 Seats</option>
            <option value="6 Seats">Car - 6 Seats</option>
        </select>
        <input type="text" name="vehicleColor" placeholder="Vehicle Color" required />
        <input type="text" name="vehicleNumber" placeholder="Vehicle Number" required />
        <input type="file" name="photo" accept="image/*" required />
        <input type="password" name="password" placeholder="Password" required />
        <button type="submit">Register</button>
    </form>

    <!-- 📋 Drivers Table -->
    <table id="driversTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Name</th>
                <th>Mobile</th>
                <th>Vehicle Type</th>
                <th>Vehicle Number</th>
                <th>Availability</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                try (Connection conn = DBConnection.getConnection()) {
                    String sql = "SELECT * FROM drivers";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("driver_id") %></td>
                <td><%= rs.getString("username") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("mobile_number") %></td>
                <td><%= rs.getString("vehicle_type") %></td>
                <td><%= rs.getString("vehicle_number") %></td>
                <td>
                    <input type="checkbox" <%= rs.getString("availability").equals("Yes") ? "checked" : "" %>
                        onclick="updateAvailability(<%= rs.getInt("driver_id") %>, this)" />
                </td>
                <td>
                    <a href="editDriverAdmin.jsp?driverId=<%= rs.getInt("driver_id") %>">Edit</a> |
                    <button onclick="confirmDelete(<%= rs.getInt("driver_id") %>)">Delete</button>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>
</body>
</html>
