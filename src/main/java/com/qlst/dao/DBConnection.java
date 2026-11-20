package com.qlst.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection - Lớp tiện ích quản lý kết nối cơ sở dữ liệu.
 * Theo mẫu thiết kế DAO (Data Access Object) được hướng dẫn trong LAB1.
 *
 * @author MSSV: 10B23DCCN646
 * @version 1.0
 */
public class DBConnection {

    // ─── Thông tin kết nối ──────────────────────────────────────
    private static final String DRIVER   = "com.mysql.cj.jdbc.Driver";
    private static final String URL      = "jdbc:mysql://localhost:3306/qlst_db"
                                         + "?useSSL=false"
                                         + "&allowPublicKeyRetrieval=true"
                                         + "&serverTimezone=Asia/Ho_Chi_Minh"
                                         + "&useUnicode=true"
                                         + "&characterEncoding=UTF-8";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";

    // Đăng ký driver khi class được load lần đầu
    static {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(
                "[DBConnection] Không tìm thấy JDBC Driver: " + e.getMessage());
        }
    }

    /**
     * Lấy một kết nối từ JDBC.
     *
     * @return Connection – đối tượng kết nối tới MySQL
     * @throws SQLException nếu không thể kết nối
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    /**
     * Đóng kết nối an toàn (tránh NullPointerException).
     *
     * @param conn – kết nối cần đóng
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("[DBConnection] Lỗi đóng kết nối: " + e.getMessage());
            }
        }
    }
}
