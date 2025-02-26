package com.cab.controller;

import com.cab.dao.EditDriverDAO;
import com.cab.model.Driver;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class EditDriverController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int driverId = Integer.parseInt(request.getParameter("driverId"));
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String mobileNumber = request.getParameter("mobileNumber");
        String vehicleType = request.getParameter("vehicleType");
        String vehicleColor = request.getParameter("vehicleColor");
        String vehicleNumber = request.getParameter("vehicleNumber");
        String password = request.getParameter("password");

        Driver driver = new Driver(driverId, "", name, address, "", "", mobileNumber, vehicleType, vehicleColor, vehicleNumber, "", password);
        EditDriverDAO editDriverDAO = new EditDriverDAO();

        if (editDriverDAO.updateDriver(driver)) {
            response.sendRedirect("driverDashboard.jsp?message=Update Successful");
        } else {
            response.sendRedirect("editDriverDashboard.jsp?error=Update Failed");
        }
    }
}
