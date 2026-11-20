package com.qlst.model;

import java.util.Date;

/**
 * Employee6 – Entity class extending Member6.
 * Represents an employee in the supermarket management system (QLST).
 *
 * @author MSSV: 10B23DCCN646
 */
public class Employee6 extends Member6 {

    // ─── Attributes (theo class diagram) ──────────────────────
    private String jobPosition;
    private Date   startDate;

    // ─── Constructors ─────────────────────────────────────────
    public Employee6() {
        super();
    }

    public Employee6(String username, String password, String fullName,
                     String address, Date dateOfBirth, String email, String phoneNumber,
                     String jobPosition, Date startDate) {
        super(username, password, fullName, address, dateOfBirth, email, phoneNumber);
        this.jobPosition = jobPosition;
        this.startDate   = startDate;
    }

    // ─── Getters & Setters ────────────────────────────────────
    public String getJobPosition() {
        return jobPosition;
    }

    public void setJobPosition(String jobPosition) {
        this.jobPosition = jobPosition;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    @Override
    public String toString() {
        return "Employee6{fullName='" + getFullName()
             + "', jobPosition='" + jobPosition
             + "', startDate=" + startDate + "}";
    }
}
