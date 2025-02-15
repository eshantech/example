package com.cab.controller;

import com.cab.dao.EditUserDAO;
import com.cab.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EditUserController")
public class EditUserController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String mobileNumber = request.getParameter("mobileNumber");
        String nicNumber = request.getParameter("nicNumber");
        String gender = request.getParameter("gender");
        String password = request.getParameter("password");

        User user = new User(userId, username, password, "User", name, email, address, mobileNumber, nicNumber, gender);
        EditUserDAO editUserDAO = new EditUserDAO();

        if (editUserDAO.updateUser(user)) {
            response.sendRedirect("manageUsers.jsp?message=User Updated Successfully");
        } else {
            response.sendRedirect("editUser.jsp?id=" + userId + "&error=Failed to Update User");
        }
    }
}
