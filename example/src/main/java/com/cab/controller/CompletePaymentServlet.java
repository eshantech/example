package com.cab.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.cab.dao.DBConnection;

@WebServlet("/CompletePaymentServlet")
public class CompletePaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        double price = Double.parseDouble(request.getParameter("price"));

        // Mark booking as paid
        try (Connection conn = DBConnection.getConnection()) {
            String updateQuery = "UPDATE bookings SET status = 'Paid' WHERE booking_id = ?";
            PreparedStatement stmt = conn.prepareStatement(updateQuery);
            stmt.setInt(1, bookingId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect to success page
        response.sendRedirect("paymentsuccess.jsp?bookingId=" + bookingId);
    }
}
