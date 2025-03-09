package com.cab.controller;

import com.cab.dao.AdminBillingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteBillingController")
public class DeleteBillingController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int driverId = Integer.parseInt(request.getParameter("driverId"));

            AdminBillingDAO billingDAO = new AdminBillingDAO();
            boolean deleted = billingDAO.deleteBilling(driverId);

            if (deleted) {
                request.setAttribute("message", "Billing records deleted successfully.");
            } else {
                request.setAttribute("error", "Failed to delete billing records.");
            }

        } catch (Exception e) {
            request.setAttribute("error", "Invalid driver ID.");
        }

        // Redirect back to the billing page
        response.sendRedirect("AdminBillingController");
    }
}
