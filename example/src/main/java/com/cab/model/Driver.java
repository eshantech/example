package com.cab.model;

public class Driver {
    private int driverId;
    private String username;
    private String name;
    private String address;
    private String nic;
    private String gender;
    private String mobileNumber;
    private String vehicleType;
    private String vehicleColor;
    private String vehicleNumber;
    private String photoPath;
    private String password;

    public Driver() {}

    public Driver(int driverId, String username, String name, String address, String nic, String gender,
                  String mobileNumber, String vehicleType, String vehicleColor, String vehicleNumber, String photoPath, String password) {
        this.driverId = driverId;
        this.username = username;
        this.name = name;
        this.address = address;
        this.nic = nic;
        this.gender = gender;
        this.mobileNumber = mobileNumber;
        this.vehicleType = vehicleType;
        this.vehicleColor = vehicleColor;
        this.vehicleNumber = vehicleNumber;
        this.photoPath = photoPath;
        this.password = password;
    }

    public int getDriverId() { return driverId; }
    public void setDriverId(int driverId) { this.driverId = driverId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getMobileNumber() { return mobileNumber; }
    public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }

    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }

    public String getVehicleColor() { return vehicleColor; }
    public void setVehicleColor(String vehicleColor) { this.vehicleColor = vehicleColor; }

    public String getVehicleNumber() { return vehicleNumber; }
    public void setVehicleNumber(String vehicleNumber) { this.vehicleNumber = vehicleNumber; }

    public String getPhotoPath() { return photoPath; }
    public void setPhotoPath(String photoPath) { this.photoPath = photoPath; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
