package com.cab.model;

public class User {
    private int userId;
    private String username;
    private String password;
    
    private String name;
    private String email;
    private String address;
    private String mobileNumber;
    private String nicNumber;
    private String gender;

    public User() {}

    public User(int userId, String username, String password, String role, 
                String name, String email, String address, 
                String mobileNumber, String nicNumber, String gender) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        
        this.name = name;
        this.email = email;
        this.address = address;
        this.mobileNumber = mobileNumber;
        this.nicNumber = nicNumber;
        this.gender = gender;
    }

    // Getter and Setter
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

   

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getMobileNumber() { return mobileNumber; }
    public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }

    public String getNicNumber() { return nicNumber; }
    public void setNicNumber(String nicNumber) { this.nicNumber = nicNumber; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
}