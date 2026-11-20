package com.qlst.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * OnlineOrder6 – Entity class representing an online order placed by a customer.
 * Attributes from Class Diagram:
 * - orderDate, deliveryAddress, status, totalAmout, recipientName, recipientPhone
 * Associations:
 * - Customer6 (1-n)
 * - WarehouseStaff6 (1-n, staff who approves/dispatches the order)
 *
 * @author MSSV: 10B23DCCN646
 */
public class OnlineOrder6 {

    private int            id;
    private Date           orderDate;
    private String         deliveryAddress;
    private String         status;
    private BigDecimal     totalAmout;      // Spelling from PDF class diagram
    private String         recipientName;
    private String         recipientPhone;

    private Customer6      customer;
    private WarehouseStaff6 warehouseStaff;

    private List<OnlineOrderDetail6> details = new ArrayList<>();

    public OnlineOrder6() {}

    public OnlineOrder6(int id, Date orderDate, String deliveryAddress, String status,
                        BigDecimal totalAmout, String recipientName, String recipientPhone,
                        Customer6 customer, WarehouseStaff6 warehouseStaff) {
        this.id              = id;
        this.orderDate       = orderDate;
        this.deliveryAddress = deliveryAddress;
        this.status          = status;
        this.totalAmout      = totalAmout;
        this.recipientName   = recipientName;
        this.recipientPhone  = recipientPhone;
        this.customer        = customer;
        this.warehouseStaff  = warehouseStaff;
    }

    public int getId()                                      { return id; }
    public void setId(int id)                               { this.id = id; }

    public Date getOrderDate()                              { return orderDate; }
    public void setOrderDate(Date orderDate)                { this.orderDate = orderDate; }

    public String getDeliveryAddress()                      { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress)  { this.deliveryAddress = deliveryAddress; }

    public String getStatus()                               { return status; }
    public void setStatus(String status)                    { this.status = status; }

    public BigDecimal getTotalAmout()                       { return totalAmout; }
    public void setTotalAmout(BigDecimal totalAmout)        { this.totalAmout = totalAmout; }

    public BigDecimal getTotalAmount()                      { return totalAmout; }
    public void setTotalAmount(BigDecimal totalAmount)      { this.totalAmout = totalAmount; }

    public String getRecipientName()                        { return recipientName; }
    public void setRecipientName(String recipientName)      { this.recipientName = recipientName; }

    public String getRecipientPhone()                       { return recipientPhone; }
    public void setRecipientPhone(String recipientPhone)    { this.recipientPhone = recipientPhone; }

    public Customer6 getCustomer()                          { return customer; }
    public void setCustomer(Customer6 customer)             { this.customer = customer; }

    public WarehouseStaff6 getWarehouseStaff()                    { return warehouseStaff; }
    public void setWarehouseStaff(WarehouseStaff6 warehouseStaff) { this.warehouseStaff = warehouseStaff; }

    public List<OnlineOrderDetail6> getDetails()                  { return details; }
    public void setDetails(List<OnlineOrderDetail6> details)      { this.details = details; }

    @Override
    public String toString() {
        return "OnlineOrder6{id=" + id + ", orderDate=" + orderDate
             + ", totalAmout=" + totalAmout + ", status='" + status + "'}";
    }
}
