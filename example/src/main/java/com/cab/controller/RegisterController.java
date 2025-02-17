package com.cab.controller;

import com.cab.dao.RegisterDAO;
import com.cab.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String mobileNumber = request.getParameter("mobile_number");
        String nicNumber = request.getParameter("nic_number");
        String gender = request.getParameter("gender");
        String password = request.getParameter("password");

        // Basic Validation
        if (username.isEmpty() || name.isEmpty() || email.isEmpty() || 
            address.isEmpty() || mobileNumber.isEmpty() || nicNumber.isEmpty() ||
            gender.isEmpty() || password.isEmpty()) {
            response.sendRedirect("register.jsp?error=All fields are required!");
            return;
        }

        // Create User Object
        User user = new User();
        user.setUsername(username);
        user.setName(name);
        user.setEmail(email);
        user.setAddress(address);
        user.setMobileNumber(mobileNumber);
        user.setNicNumber(nicNumber);
        user.setGender(gender);
        user.setPassword(password); // Ideally, hash the password

        // Register User
        RegisterDAO registerDao = new RegisterDAO();
        boolean isRegistered = registerDao.registerUser(user);

        if (isRegistered) {
            response.sendRedirect("login.jsp?success=Registration Successful! You can now log in.");
        } else {
            response.sendRedirect("register.jsp?error=Registration Failed! Try Again.");
        }
    }
}
