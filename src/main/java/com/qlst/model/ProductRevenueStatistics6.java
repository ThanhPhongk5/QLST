package com.qlst.model;

import java.math.BigDecimal;

/**
 * ProductRevenueStatistics6 – Model class for Module 2.
 * Represents aggregated revenue data per product.
 * Extends Product6 according to the PDF class diagram (Figure 3.7 & 3.8).
 *
 * Attributes from Class Diagram:
 * - saleQuantity (soluongban)
 * - revenue (doanhthu)
 *
 * Methods from Class Diagram:
 * - +getStatisticsByDateRange(startDate, endDate)
 * - +getTransactionDetail(productId, startDate, endDate)
 *
 * @author MSSV: 10B23DCCN646
 */
public class ProductRevenueStatistics6 extends Product6 {

    // ─── Attributes (theo class diagram) ──────────────────────
    private int        saleQuantity;   // Tổng số lượng đã bán
    private BigDecimal revenue;        // Tổng doanh thu

    // ─── Constructors ─────────────────────────────────────────
    public ProductRevenueStatistics6() {
        super();
    }

    public ProductRevenueStatistics6(int id, String productName, String productCategory,
                                     BigDecimal sellingPrice, int saleQuantity, BigDecimal revenue) {
        super(id, productName, productCategory, "Cái", BigDecimal.ZERO, sellingPrice,
              0, 10, "", "");
        this.saleQuantity = saleQuantity;
        this.revenue      = revenue;
    }

    // ─── Getters & Setters ────────────────────────────────────
    public int getSaleQuantity()                  { return saleQuantity; }
    public void setSaleQuantity(int saleQuantity) { this.saleQuantity = saleQuantity; }

    public BigDecimal getRevenue()                { return revenue; }
    public void setRevenue(BigDecimal revenue)    { this.revenue = revenue; }

    @Override
    public String toString() {
        return "ProductRevenueStatistics6{id=" + getId()
             + ", productName='" + getProductName()
             + "', saleQuantity=" + saleQuantity
             + ", revenue=" + revenue + "}";
    }
}
