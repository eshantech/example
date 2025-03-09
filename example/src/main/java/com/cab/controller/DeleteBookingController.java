package com.cab.controller;

import com.cab.dao.BookingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteBookingController")
public class DeleteBookingController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        BookingDAO bookingDAO = new BookingDAO();

        if (bookingDAO.deleteBooking(bookingId)) {
            response.sendRedirect("manageBookings.jsp?message=Booking Deleted Successfully");
        } else {
            response.sendRedirect("manageBookings.jsp?error=Failed to Delete Booking");
        }
    }
}
