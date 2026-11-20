package com.qlst.dao;

import com.qlst.model.Product6;
import com.qlst.model.ProductRevenueStatistics6;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * ProductStatisticsDAO6 – Data Access Object cho phân hệ Thống kê Doanh thu Mặt
 * hàng (Modul 2).
 * Thực hiện truy vấn kết hợp dữ liệu bán hàng tại quầy và trực tuyến:
 * - tblProduct6
 * - InStoreSalesInvoice6 & tblInStoreSalesInvoiceDetail6 (bán lẻ tại quầy)
 * - tblOnlineOrder6 & tblOnlineOrderDetail6 & tblOnlineInvoice6 (bán hàng
 * online)
 *
 * Các phương thức chuẩn theo Sơ đồ lớp thiết kế (Design Class Diagram):
 * - +getStatisticsByDateRange(startDate, endDate)
 * - +getProductById(productId)
 *
 * @author MSSV: 10B23DCCN646
 */
public class ProductStatisticsDAO6 extends DAO {

    // ─── SQL: Thống kê doanh thu mặt hàng theo khoảng thời gian ────────────────
    private static final String SQL_GET_STATISTICS_BY_DATE = "SELECT p.id               AS id, " +
            "       p.productname      AS productName, " +
            "       p.productcategory  AS productCategory, " +
            "       p.unit             AS unit, " +
            "       p.sellinprice      AS sellingPrice, " +
            "       p.importprice      AS importPrice, " +
            "       p.remainingquatity AS remainingQuantity, " +
            "       s.totalQty         AS saleQuantity, " +
            "       s.totalRev         AS revenue " +
            "FROM tblProduct6 p " +
            "JOIN ( " +
            "    SELECT Product6id, SUM(qty) AS totalQty, SUM(qty * price) AS totalRev " +
            "    FROM ( " +
            "        SELECT d.Product6id, d.quantity AS qty, d.unitprice AS price, inv.saledate AS txDate " +
            "        FROM tblInStoreSalesInvoiceDetail6 d " +
            "        JOIN InStoreSalesInvoice6 inv ON d.InStoreSalesInvoice6id = inv.id " +
            "        UNION ALL " +
            "        SELECT od.Product6id, od.quatity AS qty, od.unitprice AS price, oi.invoidate AS txDate " +
            "        FROM tblOnlineOrderDetail6 od " +
            "        JOIN tblOnlineInvoice6 oi ON od.OnlineOrder6id = oi.OnlineOrder6id " +
            "    ) all_sales " +
            "    WHERE txDate >= ? AND txDate <= ? " +
            "    GROUP BY Product6id " +
            ") s ON p.id = s.Product6id " +
            "ORDER BY revenue DESC, saleQuantity DESC";

    public ProductStatisticsDAO6() {
        super();
    }

    /**
     * getStatisticsByDateRange – Lấy danh sách thống kê doanh thu mặt hàng trong
     * khoảng ngày [startDate, endDate].
     * Được gọi bởi ProductRevenueStatisticsServlet6 để hiển thị bảng
     * ProductRevenueListUI6.
     */
    public List<ProductRevenueStatistics6> getStatisticsByDateRange(String startDate, String endDate) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<ProductRevenueStatistics6> list = new ArrayList<>();

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(SQL_GET_STATISTICS_BY_DATE);

            String sDate = (startDate != null && !startDate.trim().isEmpty()) ? startDate.trim() : "2020-01-01";
            String eDate = (endDate != null && !endDate.trim().isEmpty()) ? endDate.trim() : "2030-12-31";

            ps.setString(1, sDate);
            ps.setString(2, eDate);

            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("[ProductStatisticsDAO6.getStatisticsByDateRange] SQL Error: " + e.getMessage());
        } finally {
            closeResources(rs, ps, conn);
        }

        return list;
    }

    /**
     * getProductById – Lấy thông tin chi tiết một mặt hàng theo ID.
     * Dùng để hiển thị thông tin sản phẩm trên giao diện Chi tiết giao dịch
     * (TranSactionDetailUI6).
     */
    public Product6 getProductById(int productId) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Product6 p = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM tblProduct6 WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            rs = ps.executeQuery();

            if (rs.next()) {
                p = new Product6();
                p.setId(rs.getInt("id"));
                p.setProductName(rs.getString("productname"));
                p.setProductCategory(rs.getString("productcategory"));
                p.setUnit(rs.getString("unit"));
                p.setImportPrice(BigDecimal.valueOf(rs.getDouble("importprice")));
                p.setSellingPrice(BigDecimal.valueOf(rs.getDouble("sellinprice")));
                p.setRemainingQuality(rs.getInt("remainingquatity"));
                p.setLowStockAlert(rs.getInt("lowstockalert"));
                p.setDescription(rs.getString("description"));
                p.setImage(rs.getString("image"));
            }
        } catch (SQLException e) {
            System.err.println("[ProductStatisticsDAO6.getProductById] SQL Error: " + e.getMessage());
        } finally {
            closeResources(rs, ps, conn);
        }

        return p;
    }

    // ─── Helper methods ────────────────────────────────────────

    private ProductRevenueStatistics6 mapRow(ResultSet rs) throws SQLException {
        ProductRevenueStatistics6 p = new ProductRevenueStatistics6();
        p.setId(rs.getInt("id"));
        p.setProductName(rs.getString("productName"));
        p.setProductCategory(rs.getString("productCategory"));
        p.setUnit(rs.getString("unit"));
        p.setSellingPrice(BigDecimal.valueOf(rs.getDouble("sellingPrice")));
        p.setImportPrice(BigDecimal.valueOf(rs.getDouble("importPrice")));
        p.setRemainingQuality(rs.getInt("remainingQuantity"));
        p.setSaleQuantity(rs.getInt("saleQuantity"));
        p.setRevenue(BigDecimal.valueOf(rs.getDouble("revenue")));
        return p;
    }

    private void closeResources(ResultSet rs, Statement st, Connection conn) {
        try {
            if (rs != null)
                rs.close();
        } catch (SQLException ignored) {
        }
        try {
            if (st != null)
                st.close();
        } catch (SQLException ignored) {
        }
        DBConnection.closeConnection(conn);
    }
}
