<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payment Success</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<h2>Payment Successful!</h2>
<p>Your payment has been successfully processed.</p>

<%
    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
%>

<!-- Auto send email -->
<form action="SendBillEmailServlet" method="post">
    <input type="hidden" name="bookingId" value="<%= bookingId %>">
    <button type="submit">Send Invoice via Email</button>
</form>

</body>
</html>
