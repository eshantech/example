<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.time.*, com.cab.dao.DBConnection" %>

<%
    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
    String driverName = "", pickupLocation = "", dropLocation = "";
    double ridePrice = 0.0, distance = 0.0;
    String completedDate = "", completedTime = "";

    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT d.name, b.price, b.pickup_location, b.drop_location, b.distance, b.completed_date, b.completed_time " +
                     "FROM bookings b JOIN drivers d ON b.driver_id = d.driver_id WHERE b.booking_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, bookingId);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            driverName = rs.getString("name");
            ridePrice = rs.getDouble("price");
            pickupLocation = rs.getString("pickup_location");
            dropLocation = rs.getString("drop_location");
            distance = rs.getDouble("distance");
            completedDate = (rs.getDate("completed_date") != null) ? rs.getDate("completed_date").toString() : "N/A";
            completedTime = (rs.getTime("completed_time") != null) ? rs.getTime("completed_time").toString() : "N/A";
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Complete Ride - Mega City Cab</title>
    <style>
        /* Background and Theme */
        body {
            background: url('images/Background.png') no-repeat center center fixed;
            background-size: cover;
            font-family: Arial, sans-serif;
            color: #333;
            text-align: center;
            padding: 20px;
        }
        .container {
            background: rgba(255, 223, 76, 0.9);
            padding: 20px;
            border-radius: 10px;
            display: inline-block;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.3);
            animation: fadeIn 1s ease-in-out;
        }
        h2 {
            color: #222;
        }
        p {
            font-size: 18px;
            font-weight: bold;
        }
        .button {
            background-color: black;
            color: yellow;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            transition: 0.3s;
            border-radius: 5px;
        }
        .button:hover {
            background-color: yellow;
            color: black;
            transform: scale(1.1);
        }

        /* Star Rating Animation */
        .rating {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .rating input {
            display: none;
        }
        .rating label {
            font-size: 30px;
            cursor: pointer;
            transition: transform 0.3s ease-in-out;
        }
        .rating input:checked ~ label {
            color: green;
            transform: scale(1.3);
        }
        .rating label:hover {
            color: red;
            transform: rotate(20deg);
        }

        /* Bill Print Animation */
        @keyframes printBill {
            0% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.2); opacity: 0.7; }
            100% { transform: scale(1); opacity: 1; }
        }
        .bill-btn:hover {
            animation: printBill 0.5s ease-in-out;
        }

        /* Feedback Submission Animation */
        @keyframes submitFeedback {
            0% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
            100% { transform: translateY(0); }
        }
        .feedback-btn:hover {
            animation: submitFeedback 0.5s ease-in-out infinite;
        }

        /* Fade In Effect */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

    </style>
</head>
<body>
    <div class="container">
        <h2>Ride Completed</h2>
        <p><strong>Booking ID:</strong> <%= bookingId %></p>
        <p><strong>Driver:</strong> <%= driverName %></p>
        <p><strong>Ride Price:</strong> <%= ridePrice %> LKR</p>
        <p><strong>Pickup Location:</strong> <%= pickupLocation %></p>
        <p><strong>Drop Location:</strong> <%= dropLocation %></p>
        <p><strong>Distance:</strong> <%= distance %> km</p>
        <p><strong>Completion Date:</strong> <%= completedDate %></p>
        <p><strong>Completion Time:</strong> <%= completedTime %></p>

        <h3>Submit Feedback</h3>
        <form action="SubmitFeedbackController" method="post">
            <input type="hidden" name="bookingId" value="<%= bookingId %>">
            <input type="hidden" name="driverName" value="<%= driverName %>">
            <input type="hidden" name="ridePrice" value="<%= ridePrice %>">

            <label>Feedback:</label>
            <textarea name="feedback" required></textarea><br>

            <label>Rating:</label>
            <div class="rating">
                <input type="radio" id="star1" name="rating" value="1"><label for="star1">⭐</label>
                <input type="radio" id="star2" name="rating" value="2"><label for="star2">⭐⭐</label>
                <input type="radio" id="star3" name="rating" value="3"><label for="star3">⭐⭐⭐</label>
                <input type="radio" id="star4" name="rating" value="4"><label for="star4">⭐⭐⭐⭐</label>
                <input type="radio" id="star5" name="rating" value="5"><label for="star5">⭐⭐⭐⭐⭐</label>
            </div><br>

            <button type="submit" class="button feedback-btn">Submit Feedback</button>
        </form>

        <h3>Download Bill</h3>
        <form action="GenerateBillServlet" method="post">
            <input type="hidden" name="bookingId" value="<%= bookingId %>">
            <button type="submit" class="button bill-btn">Print Bill</button>
        </form>

        <h3>Send Bill via Email</h3>
        <form action="SendBillEmailServlet" method="post">
            <input type="hidden" name="bookingId" value="<%= bookingId %>">
            <button type="submit" class="button">Send Email</button>
        </form>
        
 <h3>Make Online Payment</h3>
        <form action="onlinePayment.jsp" method="get">
            <input type="hidden" name="bookingId" value="<%= bookingId %>">
            <input type="hidden" name="userId" value="<%= request.getAttribute("userId") %>">
            <input type="hidden" name="driverName" value="<%= driverName %>">
            <input type="hidden" name="pickupLocation" value="<%= pickupLocation %>">
            <input type="hidden" name="dropLocation" value="<%= dropLocation %>">
            <input type="hidden" name="distance" value="<%= distance %>">
            <input type="hidden" name="price" value="<%= ridePrice %>">
            <button type="submit" class="button">Proceed to Payment</button>
        </form>

        <% Boolean emailSent = (Boolean) request.getAttribute("emailSent"); %>
        <% if (emailSent != null && emailSent) { %>
            <script>
                alert("Email sent successfully! Redirecting to dashboard...");
                setTimeout(function() {
                    window.location.href = "dashboard.jsp"; 
                }, 3000);
            </script>
        <% } %>
    </div>
</body>
</html>
