<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Online Payment</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<h2>Online Payment</h2>
<p><strong>Booking ID:</strong> <%= request.getParameter("bookingId") %></p>
<p><strong>User ID:</strong> <%= request.getParameter("userId") %></p>
<p><strong>Driver:</strong> <%= request.getParameter("driver") %></p>
<p><strong>Pickup Location:</strong> <%= request.getParameter("pickup") %></p>
<p><strong>Drop Location:</strong> <%= request.getParameter("drop") %></p>
<p><strong>Distance:</strong> <%= request.getParameter("distance") %> km</p>
<p><strong>Price:</strong> <%= request.getParameter("price") %> LKR</p>

<h3>Enter Card Details</h3>
<form action="CompletePaymentServlet" method="post">
    <input type="hidden" name="bookingId" value="<%= request.getParameter("bookingId") %>">
    <input type="hidden" name="price" value="<%= request.getParameter("price") %>">
    
    <label>Card Number:</label>
    <input type="text" name="cardNumber" required><br>
    
    <label>Cardholder Name:</label>
    <input type="text" name="cardName" required><br>

    <label>Expiration Date:</label>
    <input type="month" name="expDate" required><br>

    <label>CVV:</label>
    <input type="text" name="cvv" required><br>

    <button type="submit">Pay Now</button>
</form>

</body>
</html>
