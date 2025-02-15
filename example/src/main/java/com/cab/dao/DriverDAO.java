package com.cab.dao;

import com.cab.model.Driver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DriverDAO {

    // Register driver (already exists)
    public boolean registerDriver(Driver driver) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO drivers (username, name, address, nic, gender, mobile_number, vehicle_type, vehicle_color, vehicle_number, photo_path, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, driver.getUsername());
            stmt.setString(2, driver.getName());
            stmt.setString(3, driver.getAddress());
            stmt.setString(4, driver.getNic());
            stmt.setString(5, driver.getGender());
            stmt.setString(6, driver.getMobileNumber());
            stmt.setString(7, driver.getVehicleType());
            stmt.setString(8, driver.getVehicleColor());
            stmt.setString(9, driver.getVehicleNumber());
            stmt.setString(10, driver.getPhotoPath());
            stmt.setString(11, driver.getPassword());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Authenticate driver
    public Driver authenticateDriver(String username, String password) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM drivers WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Driver(
                    rs.getInt("driver_id"),
                    rs.getString("username"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("nic"),
                    rs.getString("gender"),
                    rs.getString("mobile_number"),
                    rs.getString("vehicle_type"),
                    rs.getString("vehicle_color"),
                    rs.getString("vehicle_number"),
                    rs.getString("photo_path"),
                    rs.getString("password")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
