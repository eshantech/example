package com.cab.model;

public class BillingDetails {
    private int driverId;
    private String driverName;
    private int rideCount;
    private double totalKm;
    private double totalEarnings;
    private double avgRating;
    private double systemTax;
    private double finalAmount;

    public BillingDetails(int driverId, String driverName, int rideCount, double totalKm, double totalEarnings, double avgRating, double systemTax, double finalAmount) {
        this.driverId = driverId;
        this.driverName = driverName;
        this.rideCount = rideCount;
        this.totalKm = totalKm;
        this.totalEarnings = totalEarnings;
        this.avgRating = avgRating;
        this.systemTax = systemTax;
        this.finalAmount = finalAmount;
    }

    public int getDriverId() { return driverId; }
    public String getDriverName() { return driverName; }
    public int getRideCount() { return rideCount; }
    public double getTotalKm() { return totalKm; }
    public double getTotalEarnings() { return totalEarnings; }
    public double getAvgRating() { return avgRating; }
    public double getSystemTax() { return systemTax; }
    public double getFinalAmount() { return finalAmount; }
}
