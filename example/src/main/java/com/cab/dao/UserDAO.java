package com.cab.dao;

import com.cab.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    // Authenticate user (login)
    public User authenticateUser(String username, String password) {
        User user = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setMobileNumber(rs.getString("mobile_number"));
                user.setNicNumber(rs.getString("nic_number"));
                user.setGender(rs.getString("gender"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Get user by ID
    public User getUserById(int userId) {
        User user = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setMobileNumber(rs.getString("mobile_number"));
                user.setNicNumber(rs.getString("nic_number"));
                user.setGender(rs.getString("gender"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Get user details by booking ID
    public User getUserByBookingId(int bookingId) {
        User user = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT u.user_id, u.name, u.mobile_number FROM users u " +
                         "JOIN bookings b ON u.user_id = b.user_id WHERE b.booking_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setMobileNumber(rs.getString("mobile_number"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Register a new user
    public boolean registerUser(User user) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO users (username, password, name, email, address, mobile_number, nic_number, gender) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getName());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getAddress());
            stmt.setString(6, user.getMobileNumber());
            stmt.setString(7, user.getNicNumber());
            stmt.setString(8, user.getGender());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
