package com.cab.controller;

import com.cab.dao.UserManageDAO;
import com.cab.model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UserManageServlet")  // Fixed the mapping to match the JSP
public class UserManageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserManageDAO userDao = new UserManageDAO();

        if ("add".equals(action)) {
            String username = request.getParameter("username");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String mobileNumber = request.getParameter("mobileNumber");
            String nicNumber = request.getParameter("nicNumber");
            String gender = request.getParameter("gender");
            String password = request.getParameter("password");

            User user = new User(0, username, password, "User", name, email, address, mobileNumber, nicNumber, gender);
            if (userDao.addUser(user)) {
                response.sendRedirect("manageUsers.jsp?message=User Added Successfully");
            } else {
                response.sendRedirect("manageUsers.jsp?error=Failed to Add User");
            }
        } else if ("update".equals(action)) {
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
            if (userDao.updateUser(user)) {
                response.sendRedirect("manageUsers.jsp?message=User Updated Successfully");
            } else {
                response.sendRedirect("manageUsers.jsp?error=Failed to Update User");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserManageDAO userDao = new UserManageDAO();

        if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            if (userDao.deleteUser(userId)) {
                response.sendRedirect("manageUsers.jsp?message=User Deleted Successfully");
            } else {
                response.sendRedirect("manageUsers.jsp?error=Failed to Delete User");
            }
        } else if ("search".equals(action)) {
            String query = request.getParameter("searchQuery");
            List<User> userList = userDao.searchUsers(query);
            request.setAttribute("userList", userList);
            request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
        }
    }
}
