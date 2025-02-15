package com.cab.controller;

import com.cab.dao.DriverDAO;
import com.cab.model.Driver;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig
public class DriverRegisterController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String gender = request.getParameter("gender");
        String mobileNumber = request.getParameter("mobileNumber");
        String vehicleType = request.getParameter("vehicleType");
        String vehicleColor = request.getParameter("vehicleColor");
        String vehicleNumber = request.getParameter("vehicleNumber");
        String password = request.getParameter("password");

        // Photo Upload Handling
        Part filePart = request.getPart("photo");
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = "C:/uploads/" + fileName;
        File uploadDir = new File("C:/uploads/");
        if (!uploadDir.exists()) uploadDir.mkdir();
        Files.copy(filePart.getInputStream(), new File(uploadPath).toPath(), StandardCopyOption.REPLACE_EXISTING);

        Driver driver = new Driver(0, username, name, address, nic, gender, mobileNumber, vehicleType, vehicleColor, vehicleNumber, uploadPath, password);
        DriverDAO driverDAO = new DriverDAO();

        if (driverDAO.registerDriver(driver)) {
            response.sendRedirect("registerDriver.jsp?message=Registration Successful!");
        } else {
            response.sendRedirect("registerDriver.jsp?error=Registration Failed. Try again.");
        }
    }
}
