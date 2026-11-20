package com.qlst.model;

/**
 * Supplier6 – Entity class representing a product supplier.
 * Attributes from Class Diagram:
 * - name, address, phoneName, email, contactPerson
 *
 * @author MSSV: 10B23DCCN646
 */
public class Supplier6 {

    private int    id;
    private String name;
    private String address;
    private String phoneName;     // Exactly as spelled in class diagram
    private String email;
    private String contactPerson;

    public Supplier6() {}

    public Supplier6(int id, String name, String address, String phoneName, String email, String contactPerson) {
        this.id            = id;
        this.name          = name;
        this.address       = address;
        this.phoneName     = phoneName;
        this.email         = email;
        this.contactPerson = contactPerson;
    }

    public int getId()                         { return id; }
    public void setId(int id)                  { this.id = id; }

    public String getName()                    { return name; }
    public void setName(String name)           { this.name = name; }

    public String getAddress()                 { return address; }
    public void setAddress(String address)     { this.address = address; }

    public String getPhoneName()               { return phoneName; }
    public void setPhoneName(String phoneName) { this.phoneName = phoneName; }

    // Convenience alias for phoneNumber
    public String getPhoneNumber()             { return phoneName; }
    public void setPhoneNumber(String phone)   { this.phoneName = phone; }

    public String getEmail()                   { return email; }
    public void setEmail(String email)         { this.email = email; }

    public String getContactPerson()                       { return contactPerson; }
    public void setContactPerson(String contactPerson)     { this.contactPerson = contactPerson; }

    @Override
    public String toString() {
        return "Supplier6{id=" + id + ", name='" + name + "', phoneName='" + phoneName + "'}";
    }
}
