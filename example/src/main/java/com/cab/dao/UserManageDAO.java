package com.cab.dao;

import com.cab.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserManageDAO {
    
    // Get all users
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                User user = new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    "User",
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("address"),
                    rs.getString("mobile_number"),
                    rs.getString("nic_number"),
                    rs.getString("gender")
                );
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    // Add user
    public boolean addUser(User user) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO users (username, name, email, address, mobile_number, nic_number, gender, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getName());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getMobileNumber());
            stmt.setString(6, user.getNicNumber());
            stmt.setString(7, user.getGender());
            stmt.setString(8, user.getPassword());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update user (Fixed)
    public boolean updateUser(User user) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE users SET username=?, name=?, email=?, address=?, mobile_number=?, nic_number=?, gender=?, password=? WHERE user_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getName());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getMobileNumber());
            stmt.setString(6, user.getNicNumber());
            stmt.setString(7, user.getGender());
            stmt.setString(8, user.getPassword());
            stmt.setInt(9, user.getUserId());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete user
    public boolean deleteUser(int userId) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM users WHERE user_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Search users (Fixed)
    public List<User> searchUsers(String query) {
        List<User> userList = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE username LIKE ? OR email LIKE ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + query + "%");
            stmt.setString(2, "%" + query + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                User user = new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    "User",
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("address"),
                    rs.getString("mobile_number"),
                    rs.getString("nic_number"),
                    rs.getString("gender")
                );
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }
}
