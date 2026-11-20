package com.qlst.dao;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * DAO – Lớp cơ sở (Base Class) cho tất cả các lớp Data Access Object.
 * Quản lý kết nối JDBC Connection tới cơ sở dữ liệu MySQL theo giáo trình PTIT.
 *
 * @author MSSV: 10B23DCCN646
 */
public class DAO {

    protected Connection con;

    public DAO() {
        try {
            this.con = DBConnection.getConnection();
        } catch (SQLException e) {
            System.err.println("Lỗi kết nối cơ sở dữ liệu trong DAO: " + e.getMessage());
        }
    }

    public Connection getConnection() throws SQLException {
        if (con == null || con.isClosed()) {
            con = DBConnection.getConnection();
        }
        return con;
    }

    public void closeConnection() {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                System.err.println("Lỗi đóng kết nối DAO: " + e.getMessage());
            }
        }
    }
}
