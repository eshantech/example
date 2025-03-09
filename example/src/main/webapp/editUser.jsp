<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cab.dao.EditUserDAO, com.cab.model.User" %>
<%
    int userId = Integer.parseInt(request.getParameter("id"));
    EditUserDAO editUserDAO = new EditUserDAO();
    User user = editUserDAO.getUserById(userId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
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
        h1 {
            color: #ffcc00;
            text-shadow: 2px 2px 4px black;
        }

        /* 📝 Form Styling */
        .form-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            margin: 15px auto;
            width: 50%;
            max-width: 500px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
            animation: fadeInUp 0.8s ease-in-out;
        }
        .form-group {
            position: relative;
            margin-bottom: 20px;
        }
        input, select {
            width: 90%;
            padding: 12px;
            font-size: 16px;
            border: 2px solid black;
            border-radius: 5px;
            outline: none;
            transition: all 0.3s ease-in-out;
        }
        input:focus, select:focus {
            border-color: #ffcc00;
            box-shadow: 0px 0px 10px rgba(255, 204, 0, 0.5);
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        /* 🎨 Button Styling */
        .btn {
            background: black;
            color: white;
            font-size: 16px;
            font-weight: bold;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            transition: 0.3s;
        }
        .btn:hover {
            background: #ffcc00;
            color: black;
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
        // Show Password Toggle
        function togglePassword() {
            let passwordField = document.getElementById("password");
            passwordField.type = passwordField.type === "password" ? "text" : "password";
        }
    </script>
</head>
<body>

    <h1>✏️ Edit User</h1>

    <div class="form-container">
        <form action="EditUserController" method="post">
            <input type="hidden" name="userId" value="<%= user.getUserId() %>">
            
            <div class="form-group">
                <label>Username:</label>
                <input type="text" name="username" value="<%= user.getUsername() %>" required>
            </div>

            <div class="form-group">
                <label>Full Name:</label>
                <input type="text" name="name" value="<%= user.getName() %>" required>
            </div>

            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" value="<%= user.getEmail() %>" required>
            </div>

            <div class="form-group">
                <label>Address:</label>
                <input type="text" name="address" value="<%= user.getAddress() %>" required>
            </div>

            <div class="form-group">
                <label>Mobile Number:</label>
                <input type="text" name="mobileNumber" value="<%= user.getMobileNumber() %>" required>
            </div>

            <div class="form-group">
                <label>NIC Number:</label>
                <input type="text" name="nicNumber" value="<%= user.getNicNumber() %>" required>
            </div>

            <div class="form-group">
                <label>Gender:</label>
                <select name="gender" required>
                    <option value="Male" <%= user.getGender().equals("Male") ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= user.getGender().equals("Female") ? "selected" : "" %>>Female</option>
                </select>
            </div>

            <div class="form-group">
                <label>Password:</label>
                <input type="password" id="password" name="password" value="<%= user.getPassword() %>" required>
                <input type="checkbox" onclick="togglePassword()"> Show Password
            </div>

            <button type="submit" class="btn">Update User</button>
        </form>
    </div>

</body>
</html>
