package com.qlst.model;

import java.util.Date;

/**
 * SalesStaff6 – Entity class extending Employee6.
 * Represents a counter sales staff member creating InStoreSalesInvoice6.
 *
 * @author MSSV: 10B23DCCN646
 */
public class SalesStaff6 extends Employee6 {

    public SalesStaff6() {
        super();
        setJobPosition("SalesStaff");
    }

    public SalesStaff6(String username, String password, String fullName,
                       String address, Date dateOfBirth, String email, String phoneNumber,
                       Date startDate) {
        super(username, password, fullName, address, dateOfBirth, email, phoneNumber, "SalesStaff", startDate);
    }

    @Override
    public String toString() {
        return "SalesStaff6{username='" + getUsername() + "', fullName='" + getFullName() + "'}";
    }
}
