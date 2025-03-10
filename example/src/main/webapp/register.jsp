<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Mega City Cab</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            background: url('images/customer registration.png') no-repeat center center/cover;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
            overflow: hidden;
        }

        /* Registration Container */
        .register-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            text-align: center;
            width: 400px;
            max-height: 90vh;
            overflow-y: auto;
            animation: fadeIn 1s ease-in-out;
            position: relative;
        }

        /* Fade In Animation */
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

        /* Input Fields */
        input, select {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        /* Submit Button */
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

        /* Sign In Link */
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

        /* Scrollable Form */
        .register-container::-webkit-scrollbar {
            width: 8px;
        }

        .register-container::-webkit-scrollbar-thumb {
            background-color: black;
            border-radius: 10px;
        }

        /* Floating Taxi Animation */
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

        /* Scroll Animation */
        .scroll-in {
            opacity: 0;
            transform: translateY(40px);
            transition: all 0.8s ease-in-out;
        }

        .scroll-in.active {
            opacity: 1;
            transform: translateY(0);
        }

    </style>
</head>
<body>

    <div class="register-container scroll-in">
        <img src="images/customer login page icon.png" alt="Taxi Icon" class="floating-taxi">
        <h2>Customer Register</h2>
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

            <p>Already have an account? <a href="login.jsp">Login</a></p>
        </form>

        <p style="color:green;">${param.success}</p>
        <p style="color:red;">${param.error}</p>
    </div>

    <script>
        // Scroll Animation
        document.addEventListener("DOMContentLoaded", function () {
            let elements = document.querySelectorAll(".scroll-in");

            function scrollHandler() {
                elements.forEach((el) => {
                    if (el.getBoundingClientRect().top < window.innerHeight - 50) {
                        el.classList.add("active");
                    }
                });
            }

            window.addEventListener("scroll", scrollHandler);
            scrollHandler();
        });
    </script>

</body>
</html>
