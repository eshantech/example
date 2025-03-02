<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - Mega City Cab</title>

    <%-- 🚖 CSS Styling (Taxi-Themed) --%>
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
        .login-container {
            background: rgba(255, 204, 0, 0.95);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 350px;
            animation: fadeIn 1s ease-in-out;
        }
        h2 {
            color: black;
            font-size: 24px;
            margin-bottom: 15px;
        }
        label {
            display: block;
            text-align: left;
            font-weight: bold;
            margin: 10px 0 5px;
        }
        input {
            width: 95%;
            padding: 8px;
            margin-bottom: 15px;
            border: 2px solid black;
            border-radius: 5px;
            transition: 0.3s;
        }
        input:focus {
            border-color: #222;
            background: rgba(0, 0, 0, 0.1);
        }
        button {
            width: 100%;
            padding: 10px;
            border: none;
            background: black;
            color: #ffcc00;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
            border-radius: 5px;
        }
        button:hover {
            background: #222;
            color: white;
        }
        .error {
            color: red;
            margin-top: 10px;
            font-weight: bold;
            animation: shake 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes shake {
            0% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            50% { transform: translateX(5px); }
            75% { transform: translateX(-5px); }
            100% { transform: translateX(0); }
        }
    </style>

    <%-- 🚖 JavaScript for Input Focus Effects --%>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            let inputs = document.querySelectorAll("input");
            inputs.forEach(input => {
                input.addEventListener("focus", function() {
                    this.style.backgroundColor = "rgba(0, 0, 0, 0.1)";
                });
                input.addEventListener("blur", function() {
                    this.style.backgroundColor = "white";
                });
            });
        });
    </script>
</head>
<body>

    <div class="login-container">
        <h2>🚖 Admin Login</h2>
        <form action="AdminLoginController" method="post">
            <label>Username:</label>
            <input type="text" name="username" required>
            <label>Password:</label>
            <input type="password" name="password" required>
            <button type="submit">Login</button>
        </form>
        <p class="error">${param.error}</p>
    </div>

</body>
</html>
