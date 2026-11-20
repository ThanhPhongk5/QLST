package com.qlst.model;

import java.math.BigDecimal;
import java.util.Date;

/**
 * OnlineInvoice6 – Entity class representing an online sales invoice.
 * Theo đúng Sơ đồ lớp phân tích (Image 2):
 * - Attributes: invoidDate, status, totalAmount
 * - Method phân tích: +getTranSaction()
 *
 * @author MSSV: 10B23DCCN646
 */
public class OnlineInvoice6 {

    private int          id;
    private Date         invoidDate;     // Tên thuộc tính theo sơ đồ phân tích gốc
    private String       status;         // "Đã thanh toán"
    private BigDecimal   totalAmount;
    private OnlineOrder6 onlineOrder;    // Liên kết quan hệ với OnlineOrder6

    public OnlineInvoice6() {}

    public OnlineInvoice6(int id, Date invoidDate, String status, BigDecimal totalAmount, OnlineOrder6 onlineOrder) {
        this.id          = id;
        this.invoidDate  = invoidDate;
        this.status      = status;
        this.totalAmount = totalAmount;
        this.onlineOrder = onlineOrder;
    }

    public OnlineInvoice6(int id, Date invoidDate, String status, BigDecimal totalAmount, int quantity, BigDecimal unitPrice) {
        this.id          = id;
        this.invoidDate  = invoidDate;
        this.status      = status;
        this.totalAmount = totalAmount;

        OnlineOrderDetail6 detail = new OnlineOrderDetail6();
        detail.setQuantity(quantity);
        detail.setUnitPrice(unitPrice);

        this.onlineOrder = new OnlineOrder6();
        this.onlineOrder.getDetails().add(detail);
    }

    public int getId()                                      { return id; }
    public void setId(int id)                               { this.id = id; }

    public Date getInvoidDate()                             { return invoidDate; }
    public void setInvoidDate(Date invoidDate)               { this.invoidDate = invoidDate; }

    public Date getInvoiceDate()                            { return invoidDate; }
    public void setInvoiceDate(Date invoiceDate)            { this.invoidDate = invoiceDate; }

    public String getStatus()                               { return status; }
    public void setStatus(String status)                    { this.status = status; }

    public BigDecimal getTotalAmount()                      { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount)      { this.totalAmount = totalAmount; }

    public OnlineOrder6 getOnlineOrder()                    { return onlineOrder; }
    public void setOnlineOrder(OnlineOrder6 onlineOrder)    { this.onlineOrder = onlineOrder; }

    @Override
    public String toString() {
        return "OnlineInvoice6{id=" + id + ", invoidDate=" + invoidDate
             + ", status='" + status + "', totalAmount=" + totalAmount + "}";
    }
}
