package com.qlst.model;

import java.util.Date;

/**
 * Manager6 – Entity class extending Employee6.
 * Represents a store manager in QLST.
 * Actor in Module 2: View Product Revenue Statistics (Xem thống kê mặt hàng theo doanh thu).
 *
 * @author MSSV: 10B23DCCN646
 */
public class Manager6 extends Employee6 {

    public Manager6() {
        super();
        setJobPosition("Manager");
    }

    public Manager6(String username, String password, String fullName,
                    String address, Date dateOfBirth, String email, String phoneNumber,
                    Date startDate) {
        super(username, password, fullName, address, dateOfBirth, email, phoneNumber, "Manager", startDate);
    }

    @Override
    public String toString() {
        return "Manager6{username='" + getUsername() + "', fullName='" + getFullName() + "'}";
    }
}
