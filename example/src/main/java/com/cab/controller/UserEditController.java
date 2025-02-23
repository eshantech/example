package com.cab.controller;

import com.cab.dao.UserDAO;
import com.cab.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class UserEditController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please login first");
            return;
        }

        int userId = Integer.parseInt(request.getParameter("userId"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String mobileNumber = request.getParameter("mobileNumber");
        String nicNumber = request.getParameter("nicNumber");
        String gender = request.getParameter("gender");

        User updatedUser = new User();
        updatedUser.setUserId(userId);
        updatedUser.setName(name);
        updatedUser.setEmail(email);
        updatedUser.setAddress(address);
        updatedUser.setMobileNumber(mobileNumber);
        updatedUser.setNicNumber(nicNumber);
        updatedUser.setGender(gender);

        UserDAO userDao = new UserDAO();
        boolean isUpdated = userDao.updateUser(updatedUser);

        if (isUpdated) {
            session.setAttribute("user", updatedUser);
            response.sendRedirect("dashboard.jsp?message=Profile updated successfully");
        } else {
            response.sendRedirect("edituserdashboard.jsp?error=Failed to update profile");
        }
    }
}
