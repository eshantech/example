package com.cab.dao;

import com.cab.model.Booking;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // Create booking
    public boolean createBooking(Booking booking) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO bookings (user_id, driver_id, pickup_location, drop_location, distance, price, status) VALUES (?, ?, ?, ?, ?, ?, 'Pending')";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, booking.getUserId());
            stmt.setInt(2, booking.getDriverId());
            stmt.setString(3, booking.getPickupLocation());
            stmt.setString(4, booking.getDropLocation());
            stmt.setDouble(5, booking.getDistance());
            stmt.setDouble(6, booking.getPrice());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get bookings by user ID
    public List<Booking> getUserBookings(int userId) {
        List<Booking> bookings = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT booking_id, driver_id, pickup_location, drop_location, distance, price, status FROM bookings WHERE user_id = ? ORDER BY booking_id DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                bookings.add(new Booking(
                        userId,
                        rs.getInt("driver_id"),
                        rs.getString("pickup_location"),
                        rs.getString("drop_location"),
                        rs.getDouble("distance"),
                        rs.getDouble("price"),
                        rs.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Get bookings by driver ID
    public List<Booking> getDriverBookings(int driverId, String status) {
        List<Booking> bookings = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT booking_id, user_id, pickup_location, drop_location, distance, price FROM bookings WHERE driver_id = ? AND status = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, driverId);
            stmt.setString(2, status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                bookings.add(new Booking(
                        rs.getInt("user_id"),
                        driverId,
                        rs.getString("pickup_location"),
                        rs.getString("drop_location"),
                        rs.getDouble("distance"),
                        rs.getDouble("price"),
                        status
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Update booking status
    public boolean updateBookingStatus(int bookingId, String status) {
    	try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE bookings SET status = ? WHERE booking_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, bookingId);

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    // Get user ID by booking ID
    public int getUserIdByBookingId(int bookingId) {
        int userId = -1;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT user_id FROM bookings WHERE booking_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                userId = rs.getInt("user_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userId;
    }

    // Get booking details by ID
    public Booking getBookingById(int bookingId) {
        Booking booking = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT user_id, driver_id, pickup_location, drop_location, distance, price, status FROM bookings WHERE booking_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                booking = new Booking(
                        rs.getInt("user_id"),
                        rs.getInt("driver_id"),
                        rs.getString("pickup_location"),
                        rs.getString("drop_location"),
                        rs.getDouble("distance"),
                        rs.getDouble("price"),
                        rs.getString("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return booking;
    }
    public boolean deleteBooking(int bookingId) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM bookings WHERE booking_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
 // Update booking details
    public boolean updateBooking(int bookingId, int userId, int driverId, String pickupLocation, String dropLocation, double distance, double price, String status) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE bookings SET user_id = ?, driver_id = ?, pickup_location = ?, drop_location = ?, distance = ?, price = ?, status = ? WHERE booking_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, driverId);
            stmt.setString(3, pickupLocation);
            stmt.setString(4, dropLocation);
            stmt.setDouble(5, distance);
            stmt.setDouble(6, price);
            stmt.setString(7, status);
            stmt.setInt(8, bookingId);

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
}
