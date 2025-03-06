package com.cab.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.cab.model.BillingDetails;

public class AdminBillingDAO {

    public List<BillingDetails> getBillingDetails(String searchQuery) {
        List<BillingDetails> billingList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT d.driver_id, d.name AS driver_name, " +
                    "COUNT(b.booking_id) AS ride_count, SUM(b.distance) AS total_km, " +
                    "SUM(b.price) AS total_earnings, COALESCE(AVG(r.rating), 0) AS avg_rating, " +
                    "ROUND(SUM(b.price) * 0.06, 2) AS system_tax, " +
                    "ROUND(SUM(b.price) - (SUM(b.price) * 0.06), 2) AS final_amount " +
                    "FROM drivers d " +
                    "LEFT JOIN bookings b ON d.driver_id = b.driver_id AND b.status = 'Completed' " +
                    "LEFT JOIN ride_feedback r ON b.booking_id = r.booking_id ";

            if (searchQuery != null && !searchQuery.isEmpty()) {
                sql += "WHERE d.driver_id LIKE ? OR d.name LIKE ?";
            }

            sql += " GROUP BY d.driver_id";

            PreparedStatement stmt = conn.prepareStatement(sql);

            if (searchQuery != null && !searchQuery.isEmpty()) {
                stmt.setString(1, "%" + searchQuery + "%");
                stmt.setString(2, "%" + searchQuery + "%");
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                billingList.add(new BillingDetails(
                        rs.getInt("driver_id"),
                        rs.getString("driver_name"),
                        rs.getInt("ride_count"),
                        rs.getDouble("total_km"),
                        rs.getDouble("total_earnings"),
                        rs.getDouble("avg_rating"),
                        rs.getDouble("system_tax"),
                        rs.getDouble("final_amount")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return billingList;
    }

    public boolean deleteBilling(int driverId) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM bookings WHERE driver_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, driverId);

            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
}
