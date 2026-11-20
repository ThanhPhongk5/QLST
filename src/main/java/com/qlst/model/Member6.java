package com.qlst.model;

import java.util.Date;

/**
 * Member6 – Entity class mapping to Member in the supermarket system.
 * Module 1: Customer Registration (Đăng ký thành viên).
 *
 * Class hierarchy (from PDF class diagram):
 *   Member6
 *     ├── Employee6
 *     │     ├── Manager6
 *     │     ├── SalesStaff6
 *     │     └── WarehouseStaff6
 *     └── Customer6
 *
 * Attributes from Class Diagram:
 * - username, password, fullName, address, dateOfBirth, email, phoneNumber
 *
 * Method proposed in PDF Analysis (Page 8, 9, 14):
 * - +Check() / check() : kiểm tra tên đăng nhập, email, số điện thoại đã tồn tại trong CSDL chưa
 *
 * @author MSSV: 10B23DCCN646
 */
public class Member6 {

    // ─── Attributes (theo class diagram) ──────────────────────
    private int    id;
    private String username;
    private String password;
    private String fullName;
    private String address;
    private Date   dateOfBirth;
    private String email;
    private String phoneNumber;

    // ─── Constructors ─────────────────────────────────────────
    public Member6() {}

    public Member6(String username, String password, String fullName,
                   String address, Date dateOfBirth,
                   String email, String phoneNumber) {
        this.username    = username;
        this.password    = password;
        this.fullName    = fullName;
        this.address     = address;
        this.dateOfBirth = dateOfBirth;
        this.email       = email;
        this.phoneNumber = phoneNumber;
    }

    // ─── Getters & Setters ────────────────────────────────────
    public int getId()                       { return id; }
    public void setId(int id)                { this.id = id; }

    public String getUsername()              { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword()              { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName()              { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getAddress()               { return address; }
    public void setAddress(String address)   { this.address = address; }

    public Date getDateOfBirth()                 { return dateOfBirth; }
    public void setDateOfBirth(Date dateOfBirth) { this.dateOfBirth = dateOfBirth; }

    public String getEmail()             { return email; }
    public void setEmail(String email)   { this.email = email; }

    public String getPhoneNumber()                 { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    @Override
    public String toString() {
        return "Member6{username='" + username + "', email='" + email
             + "', fullName='" + fullName + "'}";
    }

    /**
     * Phương thức check() / Check() theo đúng Biểu đồ Phân tích (Analysis Class Diagram).
     * Kiểm tra tính hợp lệ và trùng lặp thông tin tài khoản thành viên.
     *
     * @return true nếu thông tin hợp lệ (chưa bị trùng lặp)
     */
    public boolean check() {
        com.qlst.dao.MemberDAO6 dao = new com.qlst.dao.MemberDAO6();
        String err = dao.checkDuplicate(this.username, this.email, this.phoneNumber);
        return err == null;
    }

    public boolean Check() {
        return check();
    }
}
