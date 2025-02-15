<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cab.model.Driver" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <title>Driver Dashboard</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <h2>Driver Dashboard</h2>

    <%
        HttpSession sessionObj = request.getSession(false);
        if (sessionObj == null || sessionObj.getAttribute("driver") == null) {
            response.sendRedirect("driverLogin.jsp");
        }
        Driver driver = (Driver) sessionObj.getAttribute("driver");
    %>

    <p><strong>Welcome, <%= driver.getName() %>!</strong></p>
    
    <h3>Your Details:</h3>
    <p><strong>Username:</strong> <%= driver.getUsername() %></p>
    <p><strong>Address:</strong> <%= driver.getAddress() %></p>
    <p><strong>NIC:</strong> <%= driver.getNic() %></p>
    <p><strong>Gender:</strong> <%= driver.getGender() %></p>
    <p><strong>Mobile Number:</strong> <%= driver.getMobileNumber() %></p>
    <p><strong>Vehicle Type:</strong> <%= driver.getVehicleType() %></p>
    <p><strong>Vehicle Color:</strong> <%= driver.getVehicleColor() %></p>
    <p><strong>Vehicle Number:</strong> <%= driver.getVehicleNumber() %></p>
    
    <% if (driver.getPhotoPath() != null && !driver.getPhotoPath().isEmpty()) { %>
        <p><strong>Profile Photo:</strong></p>
        <img src="<%= driver.getPhotoPath() %>" alt="Profile Photo" width="150">
    <% } %>

    <br><br>
    <a href="logout.jsp">Logout</a>
</body>
</html>
