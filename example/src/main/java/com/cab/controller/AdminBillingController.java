package com.cab.controller;

import com.cab.dao.AdminBillingDAO;
import com.cab.model.BillingDetails;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminBillingController")
public class AdminBillingController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchQuery = request.getParameter("search");

        AdminBillingDAO billingDAO = new AdminBillingDAO();
        List<BillingDetails> billingList = billingDAO.getBillingDetails(searchQuery);

        request.setAttribute("billingList", billingList);
        request.getRequestDispatcher("adminBilling.jsp").forward(request, response);
    }
}
