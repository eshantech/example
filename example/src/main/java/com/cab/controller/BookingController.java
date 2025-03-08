package com.cab.controller;

import com.cab.dao.BookingDAO;
import com.cab.model.Booking;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BookingController")
public class BookingController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	
        
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            int driverId = Integer.parseInt(request.getParameter("driverId"));
            String pickupLocation = request.getParameter("pickupLocation");
            String dropLocation = request.getParameter("dropLocation");
            double distance = Double.parseDouble(request.getParameter("distance"));
            double price = Math.ceil(distance / 5) * 90.30;
            
            // status
            Booking booking = new Booking(userId, driverId, pickupLocation, dropLocation, distance, price, "Pending");
            BookingDAO bookingDAO = new BookingDAO();
            
            if (bookingDAO.createBooking(booking)) {
                response.sendRedirect("dashboard.jsp?message=Booking successful!");
            } else {
                response.sendRedirect("booking.jsp?error=Booking failed!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("booking.jsp?error=Invalid input!");
        }
    }
}
