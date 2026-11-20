<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.text.NumberFormat, java.util.Locale" %>
<%@ page import="com.qlst.model.Member6, com.qlst.model.Manager6, com.qlst.model.Employee6" %>
<%@ page import="com.qlst.model.ProductRevenueStatistics6" %>
<%@ page import="com.qlst.dao.ProductStatisticsDAO6" %>
<%
    // ── Kiểm tra quyền Quản lý ────────────────────────────────────────
    Member6 currentUser = (Member6) session.getAttribute("currentUser");
    boolean isManager = (currentUser instanceof Manager6)
            || (currentUser instanceof Employee6
                && "Manager".equalsIgnoreCase(((Employee6) currentUser).getJobPosition()));
    if (!isManager) {
        request.setAttribute("outMessage",
            "Vui lòng đăng nhập bằng tài khoản Quản lý để truy cập phân hệ thống kê.");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
        return;
    }

    // ── Đọc tham số ngày ─────────────────────────────────────────────
    request.setCharacterEncoding("UTF-8");
    String startDate = request.getParameter("startDate");
    String endDate   = request.getParameter("endDate");
    String outMessage = null;

    // Kiểm tra ngày đầu vào
    if (startDate == null || startDate.trim().isEmpty() || endDate == null || endDate.trim().isEmpty()) {
        outMessage = "Vui lòng chọn đầy đủ ngày bắt đầu và ngày kết thúc.";
    } else {
        startDate = startDate.trim();
        endDate   = endDate.trim();
        if (endDate.compareTo(startDate) < 0) {
            outMessage = "Lỗi: Ngày kết thúc không được nhỏ hơn ngày bắt đầu.";
        }
    }

    // ── Gọi DAO ──────────────────────────────────────────
    List<ProductRevenueStatistics6> statisticsList = null;
    if (outMessage == null) {
        ProductStatisticsDAO6 statisticsDAO = new ProductStatisticsDAO6();
        statisticsList = statisticsDAO.getStatisticsByDateRange(startDate, endDate);
        if (statisticsList == null || statisticsList.isEmpty()) {
            outMessage = "Không có giao dịch bán hàng nào trong khoảng thời gian đã chọn.";
        }
    }

                        // ── Tính tổng ────────────────────────────────────────────────────
                        NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
                        double totalRevenue = 0;
                        int totalQuantity = 0;
                        if (statisticsList != null) {
                        for (ProductRevenueStatistics6 p : statisticsList) {
                        if (p.getRevenue() != null) totalRevenue += p.getRevenue().doubleValue();
                        totalQuantity += p.getSaleQuantity();
                        }
                        }

                        // ── Chuyển đổi định dạng ngày hiển thị ──────────────────────────
                        String displayStartDate = "Tất cả";
                        if (startDate != null && !startDate.trim().isEmpty()) {
                        String[] parts = startDate.split("-");
                        displayStartDate = (parts.length == 3) ? parts[2] + "/" + parts[1] + "/" + parts[0] : startDate;
                        }
                        String displayEndDate = "Hiện tại";
                        if (endDate != null && !endDate.trim().isEmpty()) {
                        String[] parts = endDate.split("-");
                        displayEndDate = (parts.length == 3) ? parts[2] + "/" + parts[1] + "/" + parts[0] : endDate;
                        }
                        %>
                        <!DOCTYPE html>
                        <html lang="vi">

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Báo Cáo Doanh Thu Mặt Hàng – Siêu thị</title>
                            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
                            <link rel="stylesheet"
                                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                        </head>

                        <body style="background-color: #ffffff; color: #0f172a;">

                            <!-- Thanh điều hướng chính -->
                            <header class="main-header">
                                <div class="container header-inner">
                                    <div class="logo">
                                        <i class="fas fa-store-alt"></i>
                                        <span>Siêu thị Thông minh</span>
                                    </div>
                                    <nav style="display:flex;align-items:center;gap:12px;">
                                        <span class="nav-link active" style="cursor:default;"><i
                                                class="fas fa-chart-bar"></i> Báo cáo Doanh thu</span>
                                        <span
                                            style="color: #475569; font-size: 0.88rem; background: #f1f5f9; padding: 4px 10px; border-radius: 6px;">
                                            <i class="fas fa-user-circle" style="color: #2563eb;"></i>
                                            <%= currentUser.getFullName() %>
                                        </span>
                                        <a href="${pageContext.request.contextPath}/logout.jsp" class="nav-link"
                                            style="color: #dc2626;" title="Đăng xuất">
                                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                                        </a>
                                    </nav>
                                </div>
                            </header>

                            <main>
                                <div class="container">

                                    <!-- Tiêu đề trang -->
                                    <div class="page-header"
                                        style="display: flex; justify-content: space-between; align-items: flex-end; flex-wrap: wrap; gap: 12px;">
                                        <div>
                                            <h1 class="page-title">
                                                <i class="fas fa-file-invoice-dollar" style="color:#2563eb;"></i>
                                                Báo Cáo Doanh Thu Theo Mặt Hàng
                                            </h1>
                                            <p class="page-desc">
                                                Kết quả tổng hợp doanh thu bán hàng tại quầy và trực tuyến
                                            </p>
                                        </div>
                                        <div>
                                            <a href="${pageContext.request.contextPath}/date_range.jsp?startDate=<%= startDate != null ? startDate : "" %>&endDate=<%= endDate != null ? endDate : "" %>"
                                                class="btn btn-outline">
                                                <i class="far fa-calendar-alt"></i> Thay đổi khoảng thời gian
                                            </a>
                                        </div>
                                    </div>

                                    <!-- Thanh thông tin bộ lọc đã chọn -->
                                    <div class="card"
                                        style="padding: 14px 20px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 10px; background: #f8fafc;">
                                        <div>
                                            <span style="color: var(--text-muted); font-size: 0.9rem;">Khoảng thời gian
                                                báo cáo:</span>
                                            <strong style="color: #1e3a8a; margin-left: 6px; font-size: 0.95rem;">
                                                <%= displayStartDate %> &rarr; <%= displayEndDate %>
                                            </strong>
                                        </div>
                                        <div style="font-size: 0.9rem; color: var(--text-sub);">
                                            Tổng số mặt hàng: <strong>
                                                <%= statisticsList !=null ? statisticsList.size() : 0 %>
                                            </strong>
                                        </div>
                                    </div>

                                    <!-- Thông báo (nếu có) -->
                                    <% if (outMessage !=null && !outMessage.trim().isEmpty()) { %>
                                        <div class="alert alert-info">
                                            <i class="fas fa-info-circle"></i>
                                            <span>
                                                <%= outMessage %>
                                            </span>
                                        </div>
                                        <% } %>

                    <!-- Bảng danh sách mặt hàng doanh thu -->
                    <div class="card" style="padding:0; overflow:hidden; margin: 0 auto 24px;">
                                                <div
                                                    style="padding:16px 20px; border-bottom:1px solid var(--border-color); display:flex; justify-content:space-between; align-items:center;">
                                                    <div
                                                        style="font-size:1.05rem; font-weight:600; color:var(--text-main);">
                                                        <i class="fas fa-list-ol"
                                                            style="color:#2563eb; margin-right:8px;"></i>
                                                        Danh Sách Mặt Hàng Đã Bán
                                                    </div>
                                                    <div style="font-size:0.88rem; color:var(--text-muted);">
                                                        Sắp xếp theo: <strong>Doanh thu cao nhất</strong>
                                                    </div>
                                                </div>

                                                <div class="table-responsive" style="border:none; border-radius:0;">
                                                    <table class="data-table">
                                                        <thead>
                                                            <tr>
                                                                <th class="text-center" style="width: 50px;">STT</th>
                                                                <th class="text-center" style="width: 80px;">Mã SP</th>
                                                                <th>Tên Mặt Hàng</th>
                                                                <th>Phân Loại</th>
                                                                <th class="text-center" style="width: 80px;">ĐVT</th>
                                                                <th class="text-right">Đơn Giá Bán</th>
                                                                <th class="text-center" style="width: 140px;">Số Lượng
                                                                    Đã Bán</th>
                                                                <th class="text-right" style="width: 160px;">Doanh Thu
                                                                    (VNĐ)</th>
                                                                <th class="text-center" style="width: 130px;">Chi Tiết
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% if (statisticsList !=null && !statisticsList.isEmpty()) {
                                                                int stt=1; for (ProductRevenueStatistics6 item
                                                                :statisticsList) { %>
                                                                <tr>
                                                                    <td class="text-center"
                                                                        style="color:var(--text-muted);">
                                                                        <%= stt++ %>
                                                                    </td>
                                                                    <td class="text-center"><strong>
                                                                            <%= item.getId() %>
                                                                        </strong></td>
                                                                    <td>
                                                                        <span style="font-weight:600; color:#1e293b;">
                                                                            <%= item.getProductName() %>
                                                                        </span>
                                                                    </td>
                                                                    <td><span class="badge badge-blue">
                                                                            <%= item.getProductCategory() %>
                                                                        </span></td>
                                                                    <td class="text-center">
                                                                        <%= item.getUnit() %>
                                                                    </td>
                                                                    <td class="text-right">
                                                                        <%= item.getSellingPrice() !=null ?
                                                                            nf.format(item.getSellingPrice()) : "0" %> đ
                                                                    </td>
                                                                    <td class="text-center">
                                                                        <strong style="color:#0f172a;">
                                                                            <%= item.getSaleQuantity() %>
                                                                        </strong>
                                                                    </td>
                                                                    <td class="text-right"
                                                                        style="color:#1d4ed8; font-weight:700;">
                                                                        <%= item.getRevenue() !=null ?
                                                                            nf.format(item.getRevenue()) : "0" %> đ
                                                                    </td>
                                                                    <td class="text-center">
                                                                        <a href="${pageContext.request.contextPath}/transaction_detail.jsp?productId=<%= item.getId() %>&startDate=<%= startDate != null ? startDate : "" %>&endDate=<%= endDate != null ? endDate : "" %>"
                                                                            class="btn btn-outline btn-sm">
                                                                            <i class="fas fa-eye"></i> Xem Chi Tiết
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                                <% } } else { %>
                                                                    <tr>
                                                                        <td colspan="9" class="text-center"
                                                                            style="padding: 48px 20px; color:var(--text-muted);">
                                                                            <i class="fas fa-box-open"
                                                                                style="font-size:2.2rem; margin-bottom:12px; display:block; color:#cbd5e1;"></i>
                                                                            Không có giao dịch bán hàng nào trong khoảng
                                                                            thời gian đã chọn.
                                                                        </td>
                                                                    </tr>
                                                                    <% } %>
                                                        </tbody>
                                                        <% if (statisticsList !=null && !statisticsList.isEmpty()) { %>
                                                            <tfoot style="background:#f8fafc; font-weight:700;">
                                                                <tr>
                                                                    <td colspan="6" class="text-right"
                                                                        style="padding:14px 16px;">TỔNG CỘNG:</td>
                                                                    <td class="text-center"
                                                                        style="padding:14px 16px; font-size:1.05rem;">
                                                                        <%= nf.format(totalQuantity) %>
                                                                    </td>
                                                                    <td class="text-right"
                                                                        style="padding:14px 16px; color:#1d4ed8; font-size:1.1rem;">
                                                                        <%= nf.format(totalRevenue) %> VNĐ
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                            </tfoot>
                                                            <% } %>
                                                    </table>
                                                </div>
                                            </div>

                                </div>
                            </main>

                            <footer class="main-footer">
                                <div class="container">
                                    © Hệ thống Quản lý Siêu thị
                                </div>
                            </footer>

                        </body>

                        </html>