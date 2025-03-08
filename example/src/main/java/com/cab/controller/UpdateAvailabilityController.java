package com.cab.controller;

import com.cab.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class UpdateAvailabilityController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        String availability = request.getParameter("availability");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE drivers SET availability = ? WHERE driver_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, availability);
            stmt.setInt(2, driverId);

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("driverDashboard.jsp");
    }
}
