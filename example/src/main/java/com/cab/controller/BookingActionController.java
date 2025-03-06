package com.cab.controller;

import com.cab.dao.BookingDAO;
import com.cab.dao.UserDAO;
import com.cab.model.User;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BookingActionController")
public class BookingActionController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            String action = request.getParameter("action");

            BookingDAO bookingDAO = new BookingDAO();

            if ("confirm".equals(action)) {
                // Update booking status
                bookingDAO.updateBookingStatus(bookingId, "Complete - Pending");

                // Get user details
                int userId = bookingDAO.getUserIdByBookingId(bookingId);
                UserDAO userDAO = new UserDAO();
                User user = userDAO.getUserById(userId);

                // Get current date and time
                LocalDateTime now = LocalDateTime.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                String orderDateTime = now.format(formatter);

                // Redirect to confirmation page with details
                response.sendRedirect("driverBookConfirm.jsp?bookingId=" + bookingId + 
                                      "&name=" + user.getName() + 
                                      "&number=" + user.getMobileNumber() + 
                                      "&orderDateTime=" + orderDateTime);
            } else if ("cancel".equals(action)) {
                bookingDAO.updateBookingStatus(bookingId, "Cancelled");
                response.sendRedirect("driverDashboard.jsp?message=Booking cancelled");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("driverDashboard.jsp?error=Error processing request");
        }
    }
}
