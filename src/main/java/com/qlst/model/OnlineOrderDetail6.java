package com.qlst.model;

import java.math.BigDecimal;

/**
 * OnlineOrderDetail6 – Entity class representing line items in an online order.
 * Attributes from Class Diagram:
 * - quality (quantity), unitPrice
 * Associations:
 * - OnlineOrder6 (composition)
 * - Product6 (n-n association entity)
 *
 * @author MSSV: 10B23DCCN646
 */
public class OnlineOrderDetail6 {

    private int          id;
    private int          quality;      // Spelling from PDF class diagram
    private BigDecimal   unitPrice;

    private OnlineOrder6 onlineOrder;
    private Product6     product;

    public OnlineOrderDetail6() {}

    public OnlineOrderDetail6(int id, int quality, BigDecimal unitPrice,
                              OnlineOrder6 onlineOrder, Product6 product) {
        this.id          = id;
        this.quality     = quality;
        this.unitPrice   = unitPrice;
        this.onlineOrder = onlineOrder;
        this.product     = product;
    }

    public int getId()                                { return id; }
    public void setId(int id)                         { this.id = id; }

    public int getQuality()                           { return quality; }
    public void setQuality(int quality)               { this.quality = quality; }

    // Convenience alias for standard spelling
    public int getQuantity()                          { return quality; }
    public void setQuantity(int quantity)             { this.quality = quantity; }

    public BigDecimal getUnitPrice()                  { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice)    { this.unitPrice = unitPrice; }

    public OnlineOrder6 getOnlineOrder()              { return onlineOrder; }
    public void setOnlineOrder(OnlineOrder6 order)    { this.onlineOrder = order; }

    public Product6 getProduct()                      { return product; }
    public void setProduct(Product6 product)          { this.product = product; }

    public BigDecimal getSubTotal() {
        if (unitPrice == null) return BigDecimal.ZERO;
        return unitPrice.multiply(BigDecimal.valueOf(quality));
    }

    @Override
    public String toString() {
        return "OnlineOrderDetail6{id=" + id + ", quality=" + quality
             + ", unitPrice=" + unitPrice + "}";
    }
}
