package com.qlst.model;

import java.math.BigDecimal;

/**
 * Product6 – Entity class mapping to the Product table in the database.
 * Used in Module 2: View Product Revenue Statistics.
 *
 * @author MSSV: 10B23DCCN646
 */
public class Product6 {

    // ─── Attributes (theo class diagram) ──────────────────────
    private int        id;
    private String     productName;
    private String     productCategory;
    private String     unit;
    private BigDecimal importPrice;
    private BigDecimal sellingPrice;
    private int        remainingQuality;   // tồn kho
    private int        lowStockAlert;      // ngưỡng cảnh báo hết hàng
    private String     description;
    private String     image;

    // ─── Constructor rỗng ─────────────────────────────────────
    public Product6() {}

    // ─── Constructor đầy đủ ───────────────────────────────────
    public Product6(int id, String productName, String productCategory,
                    String unit, BigDecimal importPrice, BigDecimal sellingPrice,
                    int remainingQuality, int lowStockAlert,
                    String description, String image) {
        this.id               = id;
        this.productName      = productName;
        this.productCategory  = productCategory;
        this.unit             = unit;
        this.importPrice      = importPrice;
        this.sellingPrice     = sellingPrice;
        this.remainingQuality = remainingQuality;
        this.lowStockAlert    = lowStockAlert;
        this.description      = description;
        this.image            = image;
    }

    // ─── Getters & Setters ────────────────────────────────────
    public int getId()           { return id; }
    public void setId(int id)    { this.id = id; }

    public String getProductName()                   { return productName; }
    public void setProductName(String productName)   { this.productName = productName; }

    public String getProductCategory()                       { return productCategory; }
    public void setProductCategory(String productCategory)   { this.productCategory = productCategory; }

    public String getUnit()              { return unit; }
    public void setUnit(String unit)     { this.unit = unit; }

    public BigDecimal getImportPrice()                   { return importPrice; }
    public void setImportPrice(BigDecimal importPrice)   { this.importPrice = importPrice; }

    public BigDecimal getSellingPrice()                    { return sellingPrice; }
    public void setSellingPrice(BigDecimal sellingPrice)   { this.sellingPrice = sellingPrice; }

    public int getRemainingQuality()                     { return remainingQuality; }
    public void setRemainingQuality(int remainingQuality){ this.remainingQuality = remainingQuality; }

    public int getRemainingQuantity()                      { return remainingQuality; }
    public void setRemainingQuantity(int remainingQuantity){ this.remainingQuality = remainingQuantity; }

    public int getLowStockAlert()                    { return lowStockAlert; }
    public void setLowStockAlert(int lowStockAlert)  { this.lowStockAlert = lowStockAlert; }

    public String getDescription()                   { return description; }
    public void setDescription(String description)   { this.description = description; }

    public String getImage()             { return image; }
    public void setImage(String image)   { this.image = image; }

    @Override
    public String toString() {
        return "Product6{id=" + id + ", productName='" + productName
             + "', sellingPrice=" + sellingPrice + "}";
    }
}
