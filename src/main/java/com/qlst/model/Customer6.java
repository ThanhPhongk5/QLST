package com.qlst.model;

import java.util.Date;

/**
 * Customer6 – Entity class extending Member6.
 * Represents a registered customer in the supermarket system.
 * Module 1: Customer Registration (Đăng ký thành viên).
 *
 * Attributes from Class Diagram:
 * - membershipRegistrationDate
 *
 * Method proposed in PDF Analysis (Page 8, 9, 14):
 * - +save() : sinh mã khách hàng, ghi nhận ngày đăng ký hiện tại, lưu vào CSDL
 *
 * @author MSSV: 10B23DCCN646
 */
public class Customer6 extends Member6 {

    // ─── Attributes (theo class diagram) ──────────────────────
    private Date membershipRegistrationDate;

    // ─── Constructors ─────────────────────────────────────────
    public Customer6() {
        super();
        this.membershipRegistrationDate = new Date();
    }

    public Customer6(String username, String password, String fullName,
            String address, Date dateOfBirth,
            String email, String phoneNumber,
            Date membershipRegistrationDate) {
        super(username, password, fullName, address, dateOfBirth, email, phoneNumber);
        this.membershipRegistrationDate = membershipRegistrationDate != null
                ? membershipRegistrationDate
                : new Date();
    }

    // ─── Getter & Setter ──────────────────────────────────────
    public Date getMembershipRegistrationDate() {
        return membershipRegistrationDate;
    }

    public void setMembershipRegistrationDate(Date membershipRegistrationDate) {
        this.membershipRegistrationDate = membershipRegistrationDate;
    }

    @Override
    public String toString() {
        return "Customer6{username='" + getUsername()
                + "', fullName='" + getFullName()
                + "', email='" + getEmail()
                + "', registrationDate=" + membershipRegistrationDate + "}";
    }

}
