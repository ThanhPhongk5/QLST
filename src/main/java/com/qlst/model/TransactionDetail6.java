package com.qlst.model;

import java.math.BigDecimal;
import java.util.Date;

/**
 * TransactionDetail6 – Model class for individual product transactions.
 * Used in Module 2: TransactionDetailUI6 (Giao diện chi tiết giao dịch).
 *
 * Attributes from PDF Analysis (Page 9, 10, 16, 17):
 * - TT (sequenceNumber)
 * - Ngày giao dịch (transactionDate)
 * - Số lượng bán (quantity)
 * - Đơn giá (unitPrice)
 * - Loại giao dịch (transactionType: "Tại quầy" / "Trực tuyến" or "InStore" /
 * "Online")
 *
 * @author MSSV: 10B23DCCN646
 */
public class TransactionDetail6 {

    private int sequenceNumber; // TT (Thứ tự)
    private int invoiceId; // Mã Hóa đơn (kiểu int theo đúng thiết kế CSDL)
    private Date transactionDate; // Ngày giao dịch
    private int quantity; // Số lượng bán
    private BigDecimal unitPrice; // Đơn giá
    private String transactionType; // "Tại quầy" (In-Store) hoặc "Trực tuyến" (Online)
    private String transactionCode; // Mã Hóa đơn dạng chuỗi
    private BigDecimal totalAmount; // Thành tiền = quantity * unitPrice

    public TransactionDetail6() {
    }

    public TransactionDetail6(int sequenceNumber, Date transactionDate, int quantity,
            BigDecimal unitPrice, String transactionType, int invoiceId) {
        this.sequenceNumber = sequenceNumber;
        this.transactionDate = transactionDate;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.transactionType = transactionType;
        this.invoiceId = invoiceId;
        this.transactionCode = String.valueOf(invoiceId);
        if (unitPrice != null) {
            this.totalAmount = unitPrice.multiply(BigDecimal.valueOf(quantity));
        }
    }

    public TransactionDetail6(int sequenceNumber, Date transactionDate, int quantity,
            BigDecimal unitPrice, String transactionType, String transactionCode) {
        this.sequenceNumber = sequenceNumber;
        this.transactionDate = transactionDate;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.transactionType = transactionType;
        this.transactionCode = transactionCode;
        try {
            this.invoiceId = Integer.parseInt(transactionCode.replaceAll("[^0-9]", ""));
        } catch (Exception ignored) {
        }
        if (unitPrice != null) {
            this.totalAmount = unitPrice.multiply(BigDecimal.valueOf(quantity));
        }
    }

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
        this.transactionCode = String.valueOf(invoiceId);
    }

    public int getSequenceNumber() {
        return sequenceNumber;
    }

    public void setSequenceNumber(int sequenceNumber) {
        this.sequenceNumber = sequenceNumber;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getTransactionCode() {
        if (transactionCode != null && !transactionCode.isEmpty()) {
            return transactionCode;
        }
        return String.valueOf(invoiceId);
    }

    public void setTransactionCode(String transactionCode) {
        this.transactionCode = transactionCode;
        try {
            this.invoiceId = Integer.parseInt(transactionCode.replaceAll("[^0-9]", ""));
        } catch (Exception ignored) {
        }
    }

    public BigDecimal getTotalAmount() {
        if (totalAmount != null)
            return totalAmount;
        if (unitPrice != null)
            return unitPrice.multiply(BigDecimal.valueOf(quantity));
        return BigDecimal.ZERO;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    @Override
    public String toString() {
        return "TransactionDetail6{TT=" + sequenceNumber
                + ", date=" + transactionDate
                + ", qty=" + quantity
                + ", price=" + unitPrice
                + ", type='" + transactionType + "'}";
    }
}
