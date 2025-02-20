package com.cab.controller;

import com.cab.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class DriverLoginController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT driver_id FROM drivers WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int driverId = rs.getInt("driver_id");

                // Set driverId in session
                HttpSession session = request.getSession();
                session.setAttribute("driverId", driverId);

                response.sendRedirect("driverDashboard.jsp");
            } else {
                response.sendRedirect("driverLogin.jsp?error=Invalid username or password");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("driverLogin.jsp?error=Something went wrong");
        }
    }
}
