<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Login - Mega City Cab</title>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('images/Driver login.png') no-repeat center center/cover;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            text-align: center;
            width: 350px;
            animation: fadeIn 1s ease-in-out;
            position: relative;
        }

        @keyframes fadeIn {
            from {
                transform: translateY(-30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        h2 {
            color: black;
            font-size: 24px;
        }

        input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        button {
            background: black;
            color: #FFD700;
            border: none;
            padding: 12px;
            width: 100%;
            font-size: 18px;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
        }

        button:hover {
            background: #FFD700;
            color: black;
        }

        p {
            margin-top: 10px;
            font-size: 14px;
        }

        a {
            color: #FFD700;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            margin-top: 10px;
            font-size: 14px;
        }

        .floating-taxi {
            position: absolute;
            top: -60px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            animation: floatTaxi 2s infinite ease-in-out;
        }

        @keyframes floatTaxi {
            0%, 100% { transform: translateX(-50%) translateY(0); }
            50% { transform: translateX(-50%) translateY(-10px); }
        }

    </style>
</head>
<body>

    <div class="login-container">
        <img src="images/customer login page icon.png" alt="Taxi Icon" class="floating-taxi">
        <h2>Driver Login</h2>

        <% if (request.getParameter("error") != null) { %>
            <p class="error-message">Invalid Username, Password, or reCAPTCHA</p>
        <% } %>

        <form action="DriverLoginController" method="post">
            <label>Username:</label>
            <input type="text" name="username" required placeholder="Enter your username">
            
            <label>Password:</label>
            <input type="password" name="password" required placeholder="Enter your password">
            
            <!-- Google reCAPTCHA -->
            <div class="g-recaptcha" data-sitekey="6Lc7b-sqAAAAAHY-zPfyFTJ-vLFG5X-tIn9c0Lub"></div>

            <button type="submit">Login</button>

            <p>Don't have an account? <a href="registerDriver.jsp">Sign Up</a></p>
        </form>
    </div>

</body>
</html>
