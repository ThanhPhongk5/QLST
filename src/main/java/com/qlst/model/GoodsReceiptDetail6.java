package com.qlst.model;

import java.math.BigDecimal;

/**
 * GoodsReceiptDetail6 – Entity class representing line items in a goods receipt note.
 * Attributes from Class Diagram:
 * - receivedQuatity (receivedQuantity), unitPrice
 * Associations:
 * - GoodsReceiptNote6 (composition)
 * - Product6 (n-n association entity)
 *
 * @author MSSV: 10B23DCCN646
 */
public class GoodsReceiptDetail6 {

    private int               id;
    private int               receivedQuatity;    // Spelling from PDF class diagram
    private BigDecimal        unitPrice;

    private GoodsReceiptNote6 goodsReceiptNote;
    private Product6          product;

    public GoodsReceiptDetail6() {}

    public GoodsReceiptDetail6(int id, int receivedQuatity, BigDecimal unitPrice,
                               GoodsReceiptNote6 goodsReceiptNote, Product6 product) {
        this.id               = id;
        this.receivedQuatity  = receivedQuatity;
        this.unitPrice        = unitPrice;
        this.goodsReceiptNote = goodsReceiptNote;
        this.product          = product;
    }

    public int getId()                                      { return id; }
    public void setId(int id)                               { this.id = id; }

    public int getReceivedQuatity()                         { return receivedQuatity; }
    public void setReceivedQuatity(int receivedQuatity)     { this.receivedQuatity = receivedQuatity; }

    // Convenience alias for standard spelling
    public int getReceivedQuantity()                        { return receivedQuatity; }
    public void setReceivedQuantity(int receivedQuantity)   { this.receivedQuatity = receivedQuantity; }

    public BigDecimal getUnitPrice()                        { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice)          { this.unitPrice = unitPrice; }

    public GoodsReceiptNote6 getGoodsReceiptNote()          { return goodsReceiptNote; }
    public void setGoodsReceiptNote(GoodsReceiptNote6 note) { this.goodsReceiptNote = note; }

    public Product6 getProduct()                            { return product; }
    public void setProduct(Product6 product)                { this.product = product; }

    public BigDecimal getSubTotal() {
        if (unitPrice == null) return BigDecimal.ZERO;
        return unitPrice.multiply(BigDecimal.valueOf(receivedQuatity));
    }

    @Override
    public String toString() {
        return "GoodsReceiptDetail6{id=" + id + ", receivedQuatity=" + receivedQuatity
             + ", unitPrice=" + unitPrice + "}";
    }
}
