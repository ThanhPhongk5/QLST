package com.qlst.model;

import java.math.BigDecimal;

/**
 * InStoreSalesInvoiceDetail6 – Entity class representing line items in an in-store sales invoice.
 * Attributes from Class Diagram:
 * - quantity, unitPrice
 * Associations:
 * - InStoreSalesInvoice6 (composition)
 * - Product6 (n-n association entity)
 *
 * @author MSSV: 10B23DCCN646
 */
public class InStoreSalesInvoiceDetail6 {

    private int                   id;
    private int                   quantity;
    private BigDecimal            unitPrice;

    private InStoreSalesInvoice6  inStoreSalesInvoice;
    private Product6              product;

    public InStoreSalesInvoiceDetail6() {}

    public InStoreSalesInvoiceDetail6(int id, int quantity, BigDecimal unitPrice,
                                      InStoreSalesInvoice6 inStoreSalesInvoice, Product6 product) {
        this.id                  = id;
        this.quantity            = quantity;
        this.unitPrice           = unitPrice;
        this.inStoreSalesInvoice = inStoreSalesInvoice;
        this.product             = product;
    }

    public int getId()                                        { return id; }
    public void setId(int id)                                 { this.id = id; }

    public int getQuantity()                                  { return quantity; }
    public void setQuantity(int quantity)                     { this.quantity = quantity; }

    public BigDecimal getUnitPrice()                          { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice)            { this.unitPrice = unitPrice; }

    public InStoreSalesInvoice6 getInStoreSalesInvoice()      { return inStoreSalesInvoice; }
    public void setInStoreSalesInvoice(InStoreSalesInvoice6 invoice) { this.inStoreSalesInvoice = invoice; }

    public Product6 getProduct()                              { return product; }
    public void setProduct(Product6 product)                  { this.product = product; }

    public BigDecimal getSubTotal() {
        if (unitPrice == null) return BigDecimal.ZERO;
        return unitPrice.multiply(BigDecimal.valueOf(quantity));
    }

    @Override
    public String toString() {
        return "InStoreSalesInvoiceDetail6{id=" + id + ", quantity=" + quantity
             + ", unitPrice=" + unitPrice + "}";
    }
}
