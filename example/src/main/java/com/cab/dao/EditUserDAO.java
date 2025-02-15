package com.cab.dao;

import com.cab.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class EditUserDAO {
    
    public User getUserById(int userId) {
        User user = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE user_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = new User(
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
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

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
}
