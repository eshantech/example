package com.cab.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.LocalTime;
import com.cab.dao.DBConnection;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class GenerateBillServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=bill.pdf");
        OutputStream out = response.getOutputStream();

        try {
            Connection conn = DBConnection.getConnection();

            // Get current date and time
            LocalDate currentDate = LocalDate.now();
            LocalTime currentTime = LocalTime.now();

            // Update booking status and store completion time/date
            String updateSql = "UPDATE bookings SET status = 'Completed', completed_date = ?, completed_time = ? WHERE booking_id = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setDate(1, java.sql.Date.valueOf(currentDate));
            updateStmt.setTime(2, java.sql.Time.valueOf(currentTime));
            updateStmt.setInt(3, bookingId);
            updateStmt.executeUpdate();

            // Retrieve booking details including completion time/date
            String sql = "SELECT d.name, b.price, b.pickup_location, b.drop_location, b.distance, b.completed_date, b.completed_time " +
                         "FROM bookings b JOIN drivers d ON b.driver_id = d.driver_id WHERE b.booking_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();

            Document document = new Document();
            PdfWriter.getInstance(document, out);
            document.open();
            document.add(new Paragraph("Mega City Cab", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18)));
            document.add(new Paragraph("\n"));

            if (rs.next()) {
                document.add(new Paragraph("Booking ID: " + bookingId));
                document.add(new Paragraph("Driver Name: " + rs.getString("name")));
                document.add(new Paragraph("Ride Price: " + rs.getDouble("price") + " LKR"));
                document.add(new Paragraph("Pickup Location: " + rs.getString("pickup_location")));
                document.add(new Paragraph("Drop Location: " + rs.getString("drop_location")));
                document.add(new Paragraph("Distance: " + rs.getDouble("distance") + " km"));
                document.add(new Paragraph("Completion Date: " + rs.getDate("completed_date")));
                document.add(new Paragraph("Completion Time: " + rs.getTime("completed_time")));
            }

            document.add(new Paragraph("\nThank you for riding with Mega City Cab!"));
            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
