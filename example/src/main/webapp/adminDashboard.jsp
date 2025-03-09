<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Mega City Cab</title>

    <%--  CSS Styling --%>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('images/Background.png') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .dashboard-container {
            background: rgba(255, 204, 0, 0.95);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
            text-align: center;
            width: 400px;
            animation: fadeIn 1s ease-in-out;
        }
        h1 {
            color: black;
            font-size: 26px;
            margin-bottom: 20px;
        }
        ul {
            list-style: none;
            padding: 0;
        }
        li {
            margin: 10px 0;
        }
        a {
            display: block;
            padding: 12px;
            text-decoration: none;
            background: black;
            color: #ffcc00;
            font-size: 18px;
            font-weight: bold;
            border-radius: 5px;
            transition: 0.3s ease-in-out;
        }
        a:hover {
            background: #222;
            color: white;
            transform: scale(1.05);
        }
        .logout {
            background: red;
        }
        .logout:hover {
            background: darkred;
        }
        
        /* Page Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>

    <%--  JavaScript for Animation --%>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            let links = document.querySelectorAll("a");
            links.forEach(link => {
                link.addEventListener("mouseover", function() {
                    this.style.boxShadow = "0px 4px 10px rgba(0, 0, 0, 0.3)";
                });
                link.addEventListener("mouseout", function() {
                    this.style.boxShadow = "none";
                });
            });
        });
    </script>
</head>
<body>

    <div class="dashboard-container">
        <h1>🚖 Welcome, Admin</h1>
        <ul>
            <li><a href="manageBookings.jsp">📅 Manage Bookings</a></li>
            <li><a href="manageUsers.jsp">👥 Manage Users</a></li>
            <li><a href="manageDrivers.jsp">🚕 Manage Drivers</a></li>
            <li><a href="adminBilling.jsp">💰 Billing System</a></li>
            <li><a href="adminLogout.jsp" class="logout">🚪 Logout</a></li>
        </ul>
    </div>

</body>
</html>
