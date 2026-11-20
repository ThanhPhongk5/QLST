package com.qlst.dao;

import com.qlst.model.OnlineInvoice6;
import com.qlst.model.OnlineOrder6;
import com.qlst.model.OnlineOrderDetail6;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * OnlineInvoiceDAO6 – Data Access Object cho Hóa đơn bán hàng trực tuyến.
 * Phụ trách truy vấn dữ liệu từ các bảng vật lý:
 * - tblOnlineInvoice6 (Hóa đơn online)
 * - tblOnlineOrder6 (Đơn đặt hàng online)
 * - tblOnlineOrderDetail6 (Chi tiết đơn hàng online)
 *
 * Thực hiện phương thức +getTranSaction() theo đúng Sơ đồ lớp phân tích (Image 2).
 *
 * @author MSSV: 10B23DCCN646
 */
public class OnlineInvoiceDAO6 extends DAO {

    public OnlineInvoiceDAO6() {
        super();
    }

    /**
     * Phương thức +getTranSaction() lấy danh sách các giao dịch bán online của mặt hàng.
     *
     * @param productId ID của mặt hàng
     * @param startDate Ngày bắt đầu (yyyy-MM-dd)
     * @param endDate   Ngày kết thúc (yyyy-MM-dd)
     * @return Danh sách các hóa đơn OnlineInvoice6 kèm chi tiết bán
     */
    public List<OnlineInvoice6> getTranSaction(int productId, String startDate, String endDate) {
        List<OnlineInvoice6> list = new ArrayList<>();
        String sql =
            "SELECT inv.id AS invoiceId, inv.invoidate, inv.status, "
          + "       d.quatity AS quantity, d.unitprice, "
          + "       (d.quatity * d.unitprice) AS totalamount "
          + "FROM tblOnlineInvoice6 inv "
          + "JOIN tblOnlineOrder6 o ON inv.OnlineOrder6id = o.id "
          + "JOIN tblOnlineOrderDetail6 d ON o.id = d.OnlineOrder6id "
          + "WHERE d.Product6id = ? ";

        if (startDate != null && !startDate.trim().isEmpty()) {
            sql += " AND inv.invoidate >= ? ";
        }
        if (endDate != null && !endDate.trim().isEmpty()) {
            sql += " AND inv.invoidate <= ? ";
        }
        sql += " ORDER BY inv.invoidate DESC, inv.id DESC";

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
                    OnlineInvoice6 inv = new OnlineInvoice6(
                        rs.getInt("invoiceId"),
                        rs.getDate("invoidate"),
                        rs.getString("status"),
                        rs.getBigDecimal("totalamount"),
                        rs.getInt("quantity"),
                        rs.getBigDecimal("unitprice")
                    );
                    list.add(inv);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getTranSaction trong OnlineInvoiceDAO6: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
}
