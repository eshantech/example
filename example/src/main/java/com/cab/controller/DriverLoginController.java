package com.cab.controller;

import com.cab.dao.DBConnection;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;
import org.json.JSONObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class DriverLoginController extends HttpServlet {
    
    private static final String SECRET_KEY = "6Lc7b-sqAAAAACvQBhH5AzqLIYxH9uRpo24S9W73"; // Replace with your actual Secret Key
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");

        if (!verifyRecaptcha(gRecaptchaResponse)) {
            response.sendRedirect("driverLogin.jsp?error=Invalid reCAPTCHA");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT driver_id FROM drivers WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int driverId = rs.getInt("driver_id");

                // Set driverId in session
                HttpSession session = request.getSession();
                session.setAttribute("driverId", driverId);

                response.sendRedirect("driverDashboard.jsp");
            } else {
                response.sendRedirect("driverLogin.jsp?error=Invalid username or password");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("driverLogin.jsp?error=Something went wrong");
        }
    }

    // Function to verify Google reCAPTCHA
    private boolean verifyRecaptcha(String gRecaptchaResponse) throws IOException {
        String url = "https://www.google.com/recaptcha/api/siteverify";
        String params = "secret=" + SECRET_KEY + "&response=" + gRecaptchaResponse;

        HttpURLConnection http = (HttpURLConnection) new URL(url).openConnection();
        http.setRequestMethod("POST");
        http.setDoOutput(true);
        http.getOutputStream().write(params.getBytes());

        Scanner scanner = new Scanner(http.getInputStream());
        String response = scanner.useDelimiter("\\A").next();
        scanner.close();

        JSONObject jsonResponse = new JSONObject(response);
        return jsonResponse.getBoolean("success");
    }
}
