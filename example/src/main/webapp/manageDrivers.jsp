<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.cab.dao.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Drivers</title>
    <link rel="stylesheet" href="CSS/style.css">
    <script>
        function confirmDelete(driverId) {
            if (confirm("Are you sure you want to delete this driver?")) {
                window.location.href = "DeleteDriverController?driverId=" + driverId;
            }
        }

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

    <!-- Success/Error Messages -->
    <% if (request.getParameter("message") != null) { %>
        <p style="color: green;"><%= request.getParameter("message") %></p>
    <% } %>
    <% if (request.getParameter("error") != null) { %>
        <p style="color: red;"><%= request.getParameter("error") %></p>
    <% } %>

    <!-- Search Bar -->
    <input type="text" id="searchBar" onkeyup="filterDrivers()" placeholder="Search Drivers...">

    <!-- Driver Registration Form -->
    <form action="DriverRegisterController" method="post" enctype="multipart/form-data">
        <h3>Register New Driver</h3>
        <input type="text" name="username" placeholder="Username" required>
        <input type="text" name="name" placeholder="Full Name" required>
        <input type="text" name="address" placeholder="Address" required>
        <input type="text" name="nic" placeholder="NIC" required>
        <select name="gender" required>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select>
        <input type="text" name="mobileNumber" placeholder="Mobile Number" required>
        <select name="vehicleType" required>
            <option value="4 Seats">Car - 4 Seats</option>
            <option value="3 Seats">Car - 3 Seats</option>
            <option value="6 Seats">Car - 6 Seats</option>
        </select>
        <input type="text" name="vehicleColor" placeholder="Vehicle Color" required>
        <input type="text" name="vehicleNumber" placeholder="Vehicle Number" required>
        <input type="file" name="photo" accept="image/*" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Register</button>
    </form>

    <!-- Drivers Table -->
    <table border="1" id="driversTable">
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
                        onclick="updateAvailability(<%= rs.getInt("driver_id") %>, this)">
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
