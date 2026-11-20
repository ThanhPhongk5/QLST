package com.qlst.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * InStoreSalesInvoice6 – Entity class representing a counter sales invoice.
 * Attributes from Class Diagram:
 * - saleDate, totalAmout
 * Associations:
 * - SalesStaff6 (1-n, staff who created the invoice)
 *
 * @author MSSV: 10B23DCCN646
 */
public class InStoreSalesInvoice6 {

    private int        id;
    private Date       saleDate;
    private BigDecimal totalAmout;     // Spelling from PDF class diagram
    private SalesStaff6 salesStaff;

    private List<InStoreSalesInvoiceDetail6> details = new ArrayList<>();

    public InStoreSalesInvoice6() {}

    public InStoreSalesInvoice6(int id, Date saleDate, BigDecimal totalAmout, SalesStaff6 salesStaff) {
        this.id         = id;
        this.saleDate   = saleDate;
        this.totalAmout = totalAmout;
        this.salesStaff = salesStaff;
    }

    public InStoreSalesInvoice6(int id, Date saleDate, BigDecimal totalAmount, int quantity, BigDecimal unitPrice) {
        this.id         = id;
        this.saleDate   = saleDate;
        this.totalAmout = totalAmount;

        InStoreSalesInvoiceDetail6 detail = new InStoreSalesInvoiceDetail6();
        detail.setQuantity(quantity);
        detail.setUnitPrice(unitPrice);
        this.details.add(detail);
    }

    public int getId()                                  { return id; }
    public void setId(int id)                           { this.id = id; }

    public Date getSaleDate()                           { return saleDate; }
    public void setSaleDate(Date saleDate)              { this.saleDate = saleDate; }

    public BigDecimal getTotalAmout()                   { return totalAmout; }
    public void setTotalAmout(BigDecimal totalAmout)    { this.totalAmout = totalAmout; }

    public BigDecimal getTotalAmount()                  { return totalAmout; }
    public void setTotalAmount(BigDecimal totalAmount)  { this.totalAmout = totalAmount; }

    public SalesStaff6 getSalesStaff()                  { return salesStaff; }
    public void setSalesStaff(SalesStaff6 salesStaff)   { this.salesStaff = salesStaff; }

    public List<InStoreSalesInvoiceDetail6> getDetails() { return details; }
    public void setDetails(List<InStoreSalesInvoiceDetail6> details) { this.details = details; }

    @Override
    public String toString() {
        return "InStoreSalesInvoice6{id=" + id + ", saleDate=" + saleDate
             + ", totalAmout=" + totalAmout + "}";
    }
}
