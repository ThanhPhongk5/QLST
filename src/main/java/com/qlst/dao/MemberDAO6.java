package com.qlst.dao;

import com.qlst.model.Customer6;
import com.qlst.model.Employee6;
import com.qlst.model.Manager6;
import com.qlst.model.Member6;

import java.sql.*;

/**
 * MemberDAO6 – Data Access Object for tblMember6 & tblCustomer6.
 * Module 1: Customer Registration (Đăng ký thành viên).
 * 
 * Mapped strictly to Physical Relational Model:
 * - tblMember6 (id, username, password, fullname, address, dateOfBirth, email, phonenumber)
 * - tblCustomer6 (Member6id, membershipregistrationdate)
 *
 * @author MSSV: 10B23DCCN646
 */
public class MemberDAO6 extends DAO {

    // ─── SQL Statements ────────────────────────────────────────
    private static final String SQL_INSERT_MEMBER =
        "INSERT INTO tblMember6 (username, password, fullname, address, dateOfBirth, email, phonenumber) "
      + "VALUES (?, ?, ?, ?, ?, ?, ?)";

    private static final String SQL_INSERT_CUSTOMER =
        "INSERT INTO tblCustomer6 (Member6id, membershipregistrationdate) VALUES (?, ?)";

    private static final String SQL_CHECK_EMAIL =
        "SELECT COUNT(*) FROM tblMember6 WHERE email = ?";

    private static final String SQL_CHECK_PHONE =
        "SELECT COUNT(*) FROM tblMember6 WHERE phonenumber = ?";

    private static final String SQL_CHECK_USERNAME =
        "SELECT COUNT(*) FROM tblMember6 WHERE username = ?";

    private static final String SQL_LOGIN =
        "SELECT m.id, m.username, m.password, m.fullname, m.address, m.dateOfBirth, m.email, m.phonenumber, "
      + "       e.jobposition, e.startdate, "
      + "       (mgr.Member6id IS NOT NULL) AS is_manager "
      + "FROM tblMember6 m "
      + "LEFT JOIN tblEmployee6 e ON m.id = e.Member6id "
      + "LEFT JOIN tblManager6 mgr ON m.id = mgr.Member6id "
      + "WHERE (m.username = ? OR m.email = ?) AND m.password = ?";


    /**
     * Register a new Customer6 into tblMember6 and tblCustomer6.
     *
     * @param customer Customer6 instance
     * @return true if successful
     */
    public boolean register(Customer6 customer) {
        Connection conn = null;
        PreparedStatement psMember = null;
        PreparedStatement psCust = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            psMember = conn.prepareStatement(SQL_INSERT_MEMBER, Statement.RETURN_GENERATED_KEYS);
            String uname = (customer.getUsername() != null && !customer.getUsername().trim().isEmpty())
                         ? customer.getUsername().trim() : customer.getEmail().trim();

            psMember.setString(1, uname);
            psMember.setString(2, customer.getPassword());
            psMember.setString(3, customer.getFullName());
            psMember.setString(4, customer.getAddress() != null ? customer.getAddress() : "");

            if (customer.getDateOfBirth() != null) {
                psMember.setDate(5, new java.sql.Date(customer.getDateOfBirth().getTime()));
            } else {
                psMember.setNull(5, Types.DATE);
            }

            psMember.setString(6, customer.getEmail().trim());
            psMember.setString(7, customer.getPhoneNumber() != null ? customer.getPhoneNumber().trim() : null);

            int rows = psMember.executeUpdate();
            if (rows > 0) {
                rs = psMember.getGeneratedKeys();
                int memberId = 0;
                if (rs.next()) {
                    memberId = rs.getInt(1);
                }

                if (memberId > 0) {
                    psCust = conn.prepareStatement(SQL_INSERT_CUSTOMER);
                    psCust.setInt(1, memberId);
                    java.util.Date regDate = customer.getMembershipRegistrationDate() != null
                                           ? customer.getMembershipRegistrationDate() : new java.util.Date();
                    psCust.setDate(2, new java.sql.Date(regDate.getTime()));
                    psCust.executeUpdate();

                    conn.commit();
                    return true;
                }
            }

            conn.rollback();
            return false;

        } catch (SQLException e) {
            System.err.println("[MemberDAO6.register] SQL Error: " + e.getMessage());
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ignored) {}
            }
            return false;
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (psMember != null) psMember.close(); } catch (SQLException ignored) {}
            try { if (psCust != null) psCust.close(); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }


    /**
     * Check whether username, email or phoneNumber already exists.
     */
    public String checkDuplicate(String username, String email, String phoneNumber) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();

            // 1. Check email
            ps = conn.prepareStatement(SQL_CHECK_EMAIL);
            ps.setString(1, email != null ? email.trim() : "");
            rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return "Email \"" + email + "\" đã tồn tại trên hệ thống.";
            }
            rs.close();
            ps.close();

            // 2. Check phone
            if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
                ps = conn.prepareStatement(SQL_CHECK_PHONE);
                ps.setString(1, phoneNumber.trim());
                rs = ps.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    return "Số điện thoại \"" + phoneNumber + "\" đã được đăng ký.";
                }
                rs.close();
                ps.close();
            }

            // 3. Check username
            if (username != null && !username.trim().isEmpty()) {
                ps = conn.prepareStatement(SQL_CHECK_USERNAME);
                ps.setString(1, username.trim());
                rs = ps.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    return "Tên đăng nhập \"" + username + "\" đã có người sử dụng.";
                }
            }

        } catch (SQLException e) {
            System.err.println("[MemberDAO6.checkDuplicate] SQL Error: " + e.getMessage());
        } finally {
            closeResources(rs, ps, conn);
        }

        return null;
    }

    /**
     * Authenticate member login with username/email and password.
     *
     * @param username username or email
     * @param password raw password string
     * @return Member6 (subclassed as Manager6 if manager, Employee6 if employee), or null if invalid
     */
    public Member6 login(String username, String password) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(SQL_LOGIN);
            String u = username != null ? username.trim() : "";
            ps.setString(1, u);
            ps.setString(2, u);
            ps.setString(3, password != null ? password : "");
            rs = ps.executeQuery();

            if (rs.next()) {
                boolean isManager = rs.getBoolean("is_manager");
                String jobPosition = rs.getString("jobposition");

                Member6 user;
                if (isManager || "Manager".equalsIgnoreCase(jobPosition)) {
                    Manager6 mgr = new Manager6();
                    mgr.setJobPosition(jobPosition != null ? jobPosition : "Manager");
                    user = mgr;
                } else if (jobPosition != null && !jobPosition.trim().isEmpty()) {
                    Employee6 emp = new Employee6();
                    emp.setJobPosition(jobPosition);
                    user = emp;
                } else {
                    user = new Member6();
                }

                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("fullname"));
                user.setAddress(rs.getString("address"));
                user.setDateOfBirth(rs.getDate("dateOfBirth"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phonenumber"));

                return user;
            }
        } catch (SQLException e) {
            System.err.println("[MemberDAO6.login] SQL Error: " + e.getMessage());
        } finally {
            closeResources(rs, ps, conn);
        }

        return null;
    }


    private void closeResources(ResultSet rs, Statement st, Connection conn) {
        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
        try { if (st != null) st.close(); } catch (SQLException ignored) {}
        DBConnection.closeConnection(conn);
    }
}
