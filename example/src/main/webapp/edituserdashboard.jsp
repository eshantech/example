<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cab.model.User" %>

<%
    // Check if user is logged in
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
    <title>Edit User Details</title>
    <link rel="stylesheet" href="CSS/style.css">
    <style>
        /* Taxi Theme Colors */
        body {
            font-family: Arial, sans-serif;
            background: url('images/edit customer.png') no-repeat center center fixed;
            background-size: cover;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .edit-container {
            background: rgba(255, 215, 0, 0.9);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3);
            width: 350px;
            text-align: center;
            position: relative;
            animation: fadeIn 1s ease-in-out;
        }

        /* Form Styling */
        label {
            display: block;
            font-weight: bold;
            margin: 10px 0 5px;
            text-align: left;
        }

        input, select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 2px solid black;
            border-radius: 5px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        input:focus, select:focus {
            border-color: #ffcc00;
            box-shadow: 0 0 5px #ffcc00;
        }

        /* Button Styling */
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

        /* Back Button */
        .back-link {
            display: inline-block;
            margin-top: 15px;
            color: black;
            font-weight: bold;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .back-link:hover {
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

        /* Fade In Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <div class="edit-container">
        <div class="taxi"></div>
        <h2>🚖 Edit Your Details</h2>
        <form action="UserEditController" method="post">
            <input type="hidden" name="userId" value="<%= user.getUserId() %>">

            <label>Name:</label>
            <input type="text" name="name" value="<%= user.getName() %>" required>

            <label>Email:</label>
            <input type="email" name="email" value="<%= user.getEmail() %>" required>

            <label>Address:</label>
            <input type="text" name="address" value="<%= user.getAddress() %>" required>

            <label>Mobile Number:</label>
            <input type="text" name="mobileNumber" value="<%= user.getMobileNumber() %>" required>

            <label>NIC Number:</label>
            <input type="text" name="nicNumber" value="<%= user.getNicNumber() %>" required>

            <label>Gender:</label>
            <select name="gender" required>
                <option value="Male" <%= user.getGender().equals("Male") ? "selected" : "" %>>Male</option>
                <option value="Female" <%= user.getGender().equals("Female") ? "selected" : "" %>>Female</option>
                <option value="Other" <%= user.getGender().equals("Other") ? "selected" : "" %>>Other</option>
            </select>

            <button type="submit">Update</button>
        </form>
        <br>
        <a href="dashboard.jsp" class="back-link">⬅ Back to Dashboard</a>
    </div>

</body>
</html>
