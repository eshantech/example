<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Mega City Cab</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <div class="register-container">
        <h2>Register</h2>
        <form action="RegisterController" method="post">
            <label>Username:</label>
            <input type="text" name="username" required>
            
            <label>Name:</label>
            <input type="text" name="name" required>

            <label>Email:</label>
            <input type="email" name="email" required>

            <label>Address:</label>
            <input type="text" name="address" required>

            <label>Mobile Number:</label>
            <input type="text" name="mobile_number" required>

            <label>NIC Number:</label>
            <input type="text" name="nic_number" required>

            <label>Gender:</label>
            <select name="gender" required>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
            </select>

            <label>Password:</label>
            <input type="password" name="password" required>

            <button type="submit">Register</button>
            <br>
            <p>Already have an account? <a href="login.jsp">Login</a></p>
        </form>

        <p style="color:green;">${param.success}</p>
        <p style="color:red;">${param.error}</p>
    </div>
</body>
</html>
