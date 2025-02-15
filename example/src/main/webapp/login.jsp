<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Mega City Cab</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form action="LoginController" method="post">
            <label>Username:</label>
            <input value="admin" type="text" name="username" required>
            <label>Password:</label>
            <input value="123" type="password" name="password" required>
            <button type="submit">Login</button>
            <br>
            <p>Don't have an account? <a href="register.jsp">Sign Up</a></p>
            
        </form>
        <p style="color:red;">${param.error}</p>
    </div>
</body>
</html>