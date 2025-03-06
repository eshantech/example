<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cab.model.BillingDetails" %>
<%
    List<BillingDetails> billingList = (List<BillingDetails>) request.getAttribute("billingList");

    // Calculate total system profit (sum of all system taxes)
    double totalSystemProfit = 0;
    if (billingList != null) {
        for (BillingDetails details : billingList) {
            totalSystemProfit += details.getSystemTax();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Billing System</title>
    <style>
        /* 🚀 General Styling */
        body {
            font-family: 'Poppins', sans-serif;
            background: url('images/Background.png') no-repeat center center/cover;
            text-align: center;
            margin: 0;
            padding: 20px;
            animation: fadeIn 1s ease-in-out;
        }
        h2 {
            color: #ffcc00;
            text-shadow: 2px 2px 4px black;
        }

        /* 🏆 Header Styling */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background: black;
            color: white;
            border-radius: 10px;
            margin-bottom: 20px;
            animation: fadeInUp 0.8s ease-in-out;
        }
        .total-profit {
            font-size: 18px;
            font-weight: bold;
            color: #ffcc00;
        }

        /* 🔍 Search Bar */
        .search-bar {
            margin-bottom: 20px;
            animation: fadeInUp 0.8s ease-in-out;
        }
        .search-bar input {
            padding: 10px;
            width: 250px;
            border: 2px solid black;
            border-radius: 5px;
            font-size: 16px;
        }
        .search-bar button {
            background: black;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
            transition: 0.3s;
        }
        .search-bar button:hover {
            background: #ffcc00;
            color: black;
        }

        /* 📜 Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
            border-radius: 10px;
            overflow: hidden;
            animation: fadeIn 1s ease-in-out;
        }
        th, td {
            padding: 12px;
            border: 1px solid black;
            text-align: center;
        }
        th {
            background: black;
            color: white;
        }
        tr:hover {
            background: rgba(255, 204, 0, 0.5);
            transition: 0.3s;
        }

        /* 🗑 Delete Button */
        .delete-btn {
            background: red;
            color: white;
            padding: 8px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: 0.3s;
        }
        .delete-btn:hover {
            background: darkred;
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
</head>
<body>

    <div class="header">
        <h2>Billing System</h2>
        <div class="total-profit">Total System Profit: <%= totalSystemProfit %> LKR</div>
    </div>

    <!-- 🔍 Search Bar -->
    <div class="search-bar">
        <form action="AdminBillingController" method="get">
            <input type="text" name="search" placeholder="Search by Driver ID or Name">
            <button type="submit">Search</button>
        </form>
    </div>

    <!-- 📊 Billing Table -->
    <table>
        <tr>
            <th>Driver ID</th>
            <th>Driver Name</th>
            <th>Ride Count</th>
            <th>Total KM</th>
            <th>Total Earnings</th>
            <th>Rating</th>
            <th>System Tax (6%)</th>
            <th>Final Amount</th>
            <th>Action</th>
        </tr>
        <% if (billingList != null) {
            for (BillingDetails details : billingList) { %>
                <tr>
                    <td><%= details.getDriverId() %></td>
                    <td><%= details.getDriverName() %></td>
                    <td><%= details.getRideCount() %></td>
                    <td><%= details.getTotalKm() %> km</td>
                    <td><%= details.getTotalEarnings() %> LKR</td>
                    <td><%= details.getAvgRating() %></td>
                    <td><%= details.getSystemTax() %> LKR</td>
                    <td><%= details.getFinalAmount() %> LKR</td>
                    <td>
                        <form action="DeleteBillingController" method="post">
                            <input type="hidden" name="driverId" value="<%= details.getDriverId() %>">
                            <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this driver\'s billing records?');">Delete</button>
                        </form>
                    </td>
                </tr>
        <%  }
        } %>
    </table>

</body>
</html>
