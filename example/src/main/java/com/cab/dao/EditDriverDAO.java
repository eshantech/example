package com.cab.dao;

import com.cab.model.Driver;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class EditDriverDAO {
    public boolean updateDriver(Driver driver) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE drivers SET name = ?, address = ?, mobile_number = ?, vehicle_type = ?, vehicle_color = ?, vehicle_number = ?, password = ? WHERE driver_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, driver.getName());
            stmt.setString(2, driver.getAddress());
            stmt.setString(3, driver.getMobileNumber());
            stmt.setString(4, driver.getVehicleType());
            stmt.setString(5, driver.getVehicleColor());
            stmt.setString(6, driver.getVehicleNumber());
            stmt.setString(7, driver.getPassword());
            stmt.setInt(8, driver.getDriverId());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
