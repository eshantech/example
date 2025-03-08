package com.cab.controller;

import com.cab.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class UpdateLocationController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        String location1 = request.getParameter("location1");
        String location2 = request.getParameter("location2");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE drivers SET location1 = ?, location2 = ? WHERE driver_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, location1);
            stmt.setString(2, location2);
            stmt.setInt(3, driverId);

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("driverDashboard.jsp");
    }
}
