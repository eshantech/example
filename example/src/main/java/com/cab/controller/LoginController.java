package com.cab.controller;

import com.cab.dao.UserDAO;
import com.cab.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginController extends HttpServlet { 
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO userDao = new UserDAO();  // Corrected variable name
        User user = userDao.authenticateUser(username, password);  // Ensure method exists

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Redirect based on user role
            if ("Admin".equals(user.getRole())) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("dashboard.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?error=Invalid Credentials");
        }
    }
}