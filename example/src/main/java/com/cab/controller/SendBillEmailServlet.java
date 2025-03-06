package com.cab.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Properties;
import com.cab.dao.DBConnection;

@WebServlet("/SendBillEmailServlet")
public class SendBillEmailServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String userEmail = "", driverName = "", pickupLocation = "", dropLocation = "";
        double ridePrice = 0.0, distance = 0.0;
        String completedDate = "", completedTime = "";

        // booking details and user email
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT u.email, d.name, b.price, b.pickup_location, b.drop_location, b.distance, b.completed_date, b.completed_time " +
                         "FROM bookings b JOIN users u ON b.user_id = u.user_id " +
                         "JOIN drivers d ON b.driver_id = d.driver_id WHERE b.booking_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                userEmail = rs.getString("email");
                driverName = rs.getString("name");
                ridePrice = rs.getDouble("price");
                pickupLocation = rs.getString("pickup_location");
                dropLocation = rs.getString("drop_location");
                distance = rs.getDouble("distance");
                
                // Set time issue
                completedDate = (rs.getDate("completed_date") != null) ? rs.getDate("completed_date").toString() : java.time.LocalDate.now().toString();
                completedTime = (rs.getTime("completed_time") != null) ? rs.getTime("completed_time").toString() : java.time.LocalTime.now().toString();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Email
        String subject = "Your Ride Bill - Mega City Cab";
        String messageContent = "<h2>Mega City Cab - Ride Invoice</h2>" +
                "<p><strong>Booking ID:</strong> " + bookingId + "</p>" +
                "<p><strong>Driver:</strong> " + driverName + "</p>" +
                "<p><strong>Ride Price:</strong> " + ridePrice + " LKR</p>" +
                "<p><strong>Pickup Location:</strong> " + pickupLocation + "</p>" +
                "<p><strong>Drop Location:</strong> " + dropLocation + "</p>" +
                "<p><strong>Distance:</strong> " + distance + " km</p>" +
                "<p><strong>Completion Date:</strong> " + completedDate + "</p>" +
                "<p><strong>Completion Time:</strong> " + completedTime + "</p>";

        // Send email
        boolean emailSent = sendEmail(userEmail, subject, messageContent);

        if (emailSent) {
            request.setAttribute("message", "Bill sent successfully to " + userEmail);
            request.getRequestDispatcher("emailSuccess.jsp").forward(request, response); // Forward to a success page
        } else {
            request.setAttribute("error", "Failed to send email.");
            request.getRequestDispatcher("completedride.jsp?bookingId=" + bookingId).forward(request, response); // Forward to completed ride page
        }
    }

    // JavaMail API - Send Email
    private boolean sendEmail(String to, String subject, String content) {
        final String fromEmail = "megacabcolombo@gmail.com";  //email
        final String password = "cobn qmvj rofb sgpo"; // email password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); 
        props.put("mail.smtp.port", "587"); 
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setContent(content, "text/html");

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return false;
    }
}
