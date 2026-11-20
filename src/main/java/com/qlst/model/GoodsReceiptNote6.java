package com.qlst.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * GoodsReceiptNote6 – Entity class representing a goods receipt note from a supplier.
 * Attributes from Class Diagram:
 * - receivedDate, totalAmout
 * Associations:
 * - Supplier6 (1-n)
 * - WarehouseStaff6 (1-n, staff who received the goods)
 *
 * @author MSSV: 10B23DCCN646
 */
public class GoodsReceiptNote6 {

    private int              id;
    private Date             receivedDate;
    private BigDecimal       totalAmout;       // Spelling from PDF class diagram
    private Supplier6        supplier;
    private WarehouseStaff6  warehouseStaff;

    private List<GoodsReceiptDetail6> details = new ArrayList<>();

    public GoodsReceiptNote6() {}

    public GoodsReceiptNote6(int id, Date receivedDate, BigDecimal totalAmout,
                             Supplier6 supplier, WarehouseStaff6 warehouseStaff) {
        this.id             = id;
        this.receivedDate   = receivedDate;
        this.totalAmout     = totalAmout;
        this.supplier       = supplier;
        this.warehouseStaff = warehouseStaff;
    }

    public int getId()                                      { return id; }
    public void setId(int id)                               { this.id = id; }

    public Date getReceivedDate()                           { return receivedDate; }
    public void setReceivedDate(Date receivedDate)          { this.receivedDate = receivedDate; }

    public BigDecimal getTotalAmout()                       { return totalAmout; }
    public void setTotalAmout(BigDecimal totalAmout)        { this.totalAmout = totalAmout; }

    public BigDecimal getTotalAmount()                      { return totalAmout; }
    public void setTotalAmount(BigDecimal totalAmount)      { this.totalAmout = totalAmount; }

    public Supplier6 getSupplier()                          { return supplier; }
    public void setSupplier(Supplier6 supplier)             { this.supplier = supplier; }

    public WarehouseStaff6 getWarehouseStaff()                    { return warehouseStaff; }
    public void setWarehouseStaff(WarehouseStaff6 warehouseStaff) { this.warehouseStaff = warehouseStaff; }

    public List<GoodsReceiptDetail6> getDetails()                 { return details; }
    public void setDetails(List<GoodsReceiptDetail6> details)     { this.details = details; }

    @Override
    public String toString() {
        return "GoodsReceiptNote6{id=" + id + ", receivedDate=" + receivedDate
             + ", totalAmout=" + totalAmout + "}";
    }
}
