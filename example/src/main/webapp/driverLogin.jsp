<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Driver Login</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <h2>Driver Login</h2>

    <%-- Display error message if login fails --%>
    <% if (request.getParameter("error") != null) { %>
        <p style="color: red;">Invalid Username or Password</p>
    <% } %>

    <form action="DriverLoginController" method="post">
        <label>Username:</label>
        <input type="text" name="username" required>

        <label>Password:</label>
        <input type="password" name="password" required>

        <button type="submit">Login</button>
        
        <br>
            <p>Don't have an account? <a href="registerDriver.jsp">Sign Up</a></p>
    </form>
</body>
</html>
