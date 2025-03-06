package com.cab.controller;

import com.cab.dao.BookingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateBookingController")
public class UpdateBookingController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get parameters with null checks
            String bookingIdStr = request.getParameter("bookingId");
            String userIdStr = request.getParameter("userId");
            String driverIdStr = request.getParameter("driverId");

            // If any required field is missing, redirect with error
            if (bookingIdStr == null || userIdStr == null || driverIdStr == null || 
                bookingIdStr.isEmpty() || userIdStr.isEmpty() || driverIdStr.isEmpty()) {
                response.sendRedirect("updateBooking.jsp?bookingId=" + bookingIdStr + "&error=missingFields");
                return;
            }

            // Convert to integers safely
            int bookingId = Integer.parseInt(bookingIdStr);
            int userId = Integer.parseInt(userIdStr);
            int driverId = Integer.parseInt(driverIdStr);

            String pickupLocation = request.getParameter("pickupLocation");
            String dropLocation = request.getParameter("dropLocation");
            String distanceStr = request.getParameter("distance");
            String priceStr = request.getParameter("price");
            String status = request.getParameter("status");

            // Default values if distance or price are missing
            double distance = (distanceStr != null && !distanceStr.isEmpty()) ? Double.parseDouble(distanceStr) : 0.0;
            double price = (priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0.0;

            BookingDAO bookingDAO = new BookingDAO();
            boolean updated = bookingDAO.updateBooking(bookingId, userId, driverId, pickupLocation, dropLocation, distance, price, status);

            if (updated) {
                response.sendRedirect("updateBooking.jsp?bookingId=" + bookingId + "&success=true");
            } else {
                response.sendRedirect("updateBooking.jsp?bookingId=" + bookingId + "&error=true");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("updateBooking.jsp?error=invalidNumberFormat");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("updateBooking.jsp?error=exception");
        }
    }
}
