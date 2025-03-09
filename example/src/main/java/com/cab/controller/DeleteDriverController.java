package com.cab.controller;

import com.cab.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DeleteDriverController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int driverId = Integer.parseInt(request.getParameter("driverId"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM drivers WHERE driver_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, driverId);
            int rows = stmt.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("managedriver.jsp?message=Driver deleted successfully!");
            } else {
                response.sendRedirect("managedriver.jsp?error=Failed to delete driver.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("managedriver.jsp?error=An error occurred.");
        }
    }
}
