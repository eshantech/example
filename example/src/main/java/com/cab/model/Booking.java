package com.cab.model;

public class Booking {
    private int userId;
    private int driverId;
    private String pickupLocation;
    private String dropLocation;
    private double distance;
    private double price;
    private String status;

    // Constructor with status
    public Booking(int userId, int driverId, String pickupLocation, String dropLocation, double distance, double price, String status) {
        this.userId = userId;
        this.driverId = driverId;
        this.pickupLocation = pickupLocation;
        this.dropLocation = dropLocation;
        this.distance = distance;
        this.price = price;
        this.status = status;
    }

    // Constructor without status (For fetching existing bookings)
    public Booking(int userId, int driverId, String pickupLocation, String dropLocation, double distance, double price) {
        this(userId, driverId, pickupLocation, dropLocation, distance, price, "Pending");
    }

    public int getUserId() { return userId; }
    public int getDriverId() { return driverId; }
    public String getPickupLocation() { return pickupLocation; }
    public String getDropLocation() { return dropLocation; }
    public double getDistance() { return distance; }
    public double getPrice() { return price; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
