package com.cab.controller;

import com.cab.dao.UserDAO;
import com.cab.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please login first");
            return;
        }

        User user = (User) session.getAttribute("user");

        UserDAO userDao = new UserDAO();
        User fullUserDetails = userDao.getUserById(user.getUserId());

        if (fullUserDetails != null) {
            session.setAttribute("user", fullUserDetails);
            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("dashboard.jsp?error=Unable to fetch user details");
        }
    }
}
