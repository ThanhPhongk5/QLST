package com.qlst.model;

import java.util.Date;

/**
 * WarehouseStaff6 – Entity class extending Employee6.
 * Represents a warehouse staff member handling GoodsReceiptNote6 and OnlineOrder6 approval.
 *
 * @author MSSV: 10B23DCCN646
 */
public class WarehouseStaff6 extends Employee6 {

    public WarehouseStaff6() {
        super();
        setJobPosition("WarehouseStaff");
    }

    public WarehouseStaff6(String username, String password, String fullName,
                           String address, Date dateOfBirth, String email, String phoneNumber,
                           Date startDate) {
        super(username, password, fullName, address, dateOfBirth, email, phoneNumber, "WarehouseStaff", startDate);
    }

    @Override
    public String toString() {
        return "WarehouseStaff6{username='" + getUsername() + "', fullName='" + getFullName() + "'}";
    }
}
