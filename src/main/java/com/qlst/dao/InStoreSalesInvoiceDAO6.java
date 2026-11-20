package com.qlst.dao;

import com.qlst.model.InStoreSalesInvoice6;
import com.qlst.model.InStoreSalesInvoiceDetail6;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * InStoreSalesInvoiceDAO6 – Data Access Object cho Hóa đơn bán lẻ tại quầy.
 * Phụ trách truy vấn dữ liệu từ các bảng vật lý:
 * - InStoreSalesInvoice6 (Hóa đơn tại quầy)
 * - tblInStoreSalesInvoiceDetail6 (Chi tiết hóa đơn tại quầy)
 *
 * Thực hiện phương thức +getTranSaction() theo đúng Sơ đồ lớp phân tích (Image 2).
 *
 * @author MSSV: 10B23DCCN646
 */
public class InStoreSalesInvoiceDAO6 extends DAO {

    public InStoreSalesInvoiceDAO6() {
        super();
    }

    /**
     * Phương thức +getTranSaction() lấy danh sách các giao dịch bán tại quầy của mặt hàng.
     *
     * @param productId ID của mặt hàng
     * @param startDate Ngày bắt đầu (yyyy-MM-dd)
     * @param endDate   Ngày kết thúc (yyyy-MM-dd)
     * @return Danh sách các hóa đơn InStoreSalesInvoice6 kèm chi tiết bán
     */
    public List<InStoreSalesInvoice6> getTranSaction(int productId, String startDate, String endDate) {
        List<InStoreSalesInvoice6> list = new ArrayList<>();
        String sql =
            "SELECT i.id AS invoiceId, i.saledate, d.quantity, d.unitprice, "
          + "       (d.quantity * d.unitprice) AS totalamount "
          + "FROM InStoreSalesInvoice6 i "
          + "JOIN tblInStoreSalesInvoiceDetail6 d ON i.id = d.InStoreSalesInvoice6id "
          + "WHERE d.Product6id = ? ";

        if (startDate != null && !startDate.trim().isEmpty()) {
            sql += " AND i.saledate >= ? ";
        }
        if (endDate != null && !endDate.trim().isEmpty()) {
            sql += " AND i.saledate <= ? ";
        }
        sql += " ORDER BY i.saledate DESC, i.id DESC";

        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            int paramIndex = 1;
            ps.setInt(paramIndex++, productId);
            if (startDate != null && !startDate.trim().isEmpty()) {
                ps.setString(paramIndex++, startDate.trim());
            }
            if (endDate != null && !endDate.trim().isEmpty()) {
                ps.setString(paramIndex++, endDate.trim());
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    InStoreSalesInvoice6 inv = new InStoreSalesInvoice6(
                        rs.getInt("invoiceId"),
                        rs.getDate("saledate"),
                        rs.getBigDecimal("totalamount"),
                        rs.getInt("quantity"),
                        rs.getBigDecimal("unitprice")
                    );
                    list.add(inv);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getTranSaction trong InStoreSalesInvoiceDAO6: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
}
