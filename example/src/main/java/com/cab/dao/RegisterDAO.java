package com.cab.dao;

import com.cab.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class RegisterDAO {

    public boolean registerUser(User user) {
        boolean isRegistered = false;
        String sql = "INSERT INTO users (username, name, email, address, mobile_number, nic_number, gender, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getName());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getMobileNumber());
            stmt.setString(6, user.getNicNumber());
            stmt.setString(7, user.getGender());
            stmt.setString(8, user.getPassword());  // Ideally, use a hashed password

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                isRegistered = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isRegistered;
    }
}
