package com.cab.controller;

import com.cab.dao.UserDAO;
import com.cab.model.User;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;

public class LoginController extends HttpServlet { 
    private static final long serialVersionUID = 1L;

    // Your Google reCAPTCHA Secret Key
    private static final String SECRET_KEY = "6Lc7b-sqAAAAACvQBhH5AzqLIYxH9uRpo24S9W73"; 

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");

        // Verify reCAPTCHA response
        boolean isCaptchaVerified = verifyRecaptcha(gRecaptchaResponse);
        if (!isCaptchaVerified) {
            response.sendRedirect("login.jsp?error=Captcha verification failed");
            return;
        }

        // Hardcoded admin login
        if ("admin".equals(username) && "admin".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("adminUser", username);
            response.sendRedirect("adminLogin.jsp"); 
            return;
        }

        // Normal user authentication
        UserDAO userDao = new UserDAO();
        User user = userDao.authenticateUser(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("UserController");  
        } else {
            response.sendRedirect("login.jsp?error=Invalid Credentials");
        }
    }

    // Verify Google reCAPTCHA response
    private boolean verifyRecaptcha(String gRecaptchaResponse) {
        try {
            String url = "https://www.google.com/recaptcha/api/siteverify";
            String params = "secret=" + SECRET_KEY + "&response=" + gRecaptchaResponse;

            // Open connection
            HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);

            // Send request
            OutputStream outputStream = connection.getOutputStream();
            outputStream.write(params.getBytes());
            outputStream.flush();
            outputStream.close();

            // Read response
            Scanner scanner = new Scanner(connection.getInputStream());
            String response = scanner.useDelimiter("\\A").next();
            scanner.close();

            // Parse JSON response
            JSONObject json = new JSONObject(response);
            return json.getBoolean("success");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
