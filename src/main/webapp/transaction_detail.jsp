<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList, java.math.BigDecimal, java.text.NumberFormat, java.text.SimpleDateFormat, java.util.Locale" %>
<%@ page import="com.qlst.model.Member6, com.qlst.model.Manager6, com.qlst.model.Employee6" %>
<%@ page import="com.qlst.model.Product6, com.qlst.model.TransactionDetail6, com.qlst.model.InStoreSalesInvoice6, com.qlst.model.OnlineInvoice6" %>
<%@ page import="com.qlst.dao.ProductStatisticsDAO6, com.qlst.dao.InStoreSalesInvoiceDAO6, com.qlst.dao.OnlineInvoiceDAO6" %>
<%
    // ── Kiểm tra quyền Quản lý ────────────────────────────────────────
    Member6 currentUser = (Member6) session.getAttribute("currentUser");
    boolean isManager = (currentUser instanceof Manager6)
            || (currentUser instanceof Employee6
                && "Manager".equalsIgnoreCase(((Employee6) currentUser).getJobPosition()));
    if (!isManager) {
        request.setAttribute("outMessage",
            "Vui lòng đăng nhập bằng tài khoản Quản lý để truy cập phân hệ này.");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
        return;
    }

    // ── Lấy các tham số từ request ────────────────────────────────────
    request.setCharacterEncoding("UTF-8");
    int productId = 0;
    try {
        productId = Integer.parseInt(request.getParameter("productId"));
    } catch (Exception ignored) {}

    String startDate = request.getParameter("startDate");
    String endDate   = request.getParameter("endDate");

    // ── Gọi DAO trực tiếp ────────────────────────────────────────────
    ProductStatisticsDAO6 statsDAO = new ProductStatisticsDAO6();
    Product6 product = statsDAO.getProductById(productId);

    InStoreSalesInvoiceDAO6 inStoreDAO = new InStoreSalesInvoiceDAO6();
    OnlineInvoiceDAO6 onlineDAO       = new OnlineInvoiceDAO6();

    List<InStoreSalesInvoice6> inStoreList = inStoreDAO.getTranSaction(productId, startDate, endDate);
    List<OnlineInvoice6> onlineList       = onlineDAO.getTranSaction(productId, startDate, endDate);

    // Tổng hợp danh sách giao dịch
    List<TransactionDetail6> transactions = new ArrayList<>();
    int stt = 1;

    if (inStoreList != null) {
        for (InStoreSalesInvoice6 inv : inStoreList) {
            if (inv.getDetails() != null) {
                for (com.qlst.model.InStoreSalesInvoiceDetail6 d : inv.getDetails()) {
                    TransactionDetail6 td = new TransactionDetail6(
                        stt++, inv.getSaleDate(), d.getQuantity(),
                        d.getUnitPrice(), "Tại quầy", inv.getId()
                    );
                    transactions.add(td);
                }
            }
        }
    }

    if (onlineList != null) {
        for (OnlineInvoice6 inv : onlineList) {
            if (inv.getOnlineOrder() != null && inv.getOnlineOrder().getDetails() != null) {
                for (com.qlst.model.OnlineOrderDetail6 d : inv.getOnlineOrder().getDetails()) {
                    TransactionDetail6 td = new TransactionDetail6(
                        stt++, inv.getInvoidDate(), d.getQuantity(),
                        d.getUnitPrice(), "Trực tuyến", inv.getId()
                    );
                    transactions.add(td);
                }
            }
        }
    }

    // Sắp xếp giao dịch mới nhất lên đầu
    transactions.sort((a, b) -> {
        if (a.getTransactionDate() == null || b.getTransactionDate() == null) return 0;
        return b.getTransactionDate().compareTo(a.getTransactionDate());
    });

    // Đánh lại số thứ tự sau khi sắp xếp
    for (int i = 0; i < transactions.size(); i++) {
        transactions.get(i).setSequenceNumber(i + 1);
    }

    int totalQuantity = 0;
    BigDecimal totalAmount = BigDecimal.ZERO;
    for (TransactionDetail6 td : transactions) {
        totalQuantity += td.getQuantity();
        if (td.getTotalAmount() != null) {
            totalAmount = totalAmount.add(td.getTotalAmount());
        }
    }

    // Định dạng hiển thị ngày
    String displayStartDate = null;
    if (startDate != null && !startDate.trim().isEmpty()) {
        String[] parts = startDate.trim().split("-");
        displayStartDate = (parts.length == 3 && parts[0].length() == 4)
                ? parts[2] + "/" + parts[1] + "/" + parts[0] : startDate;
    }

    String displayEndDate = null;
    if (endDate != null && !endDate.trim().isEmpty()) {
        String[] parts = endDate.trim().split("-");
        displayEndDate = (parts.length == 3 && parts[0].length() == 4)
                ? parts[2] + "/" + parts[1] + "/" + parts[0] : endDate;
    }

    NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Giao Dịch Bán Hàng – Siêu thị</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                <span class="nav-link active" style="cursor:default;"><i class="fas fa-chart-bar"></i> Báo cáo Doanh thu</span>
                <span style="color: #475569; font-size: 0.88rem; background: #f1f5f9; padding: 4px 10px; border-radius: 6px;">
                    <i class="fas fa-user-circle" style="color: #2563eb;"></i> <%= currentUser.getFullName() %>
                </span>
                <a href="${pageContext.request.contextPath}/logout.jsp" class="nav-link" style="color: #dc2626;" title="Đăng xuất">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </nav>
        </div>
    </header>

    <main>
        <div class="container">

            <!-- Nút quay lại danh sách -->
            <div style="margin-bottom: 20px;">
                <a href="${pageContext.request.contextPath}/product_revenue_list.jsp?startDate=<%= startDate != null ? startDate : "" %>&endDate=<%= endDate != null ? endDate : "" %>"
                   class="btn btn-outline">
                    <i class="fas fa-arrow-left"></i> Quay lại Danh sách Doanh thu
                </a>
            </div>

            <!-- Khối 1: Thông tin mặt hàng -->
            <% if (product != null) { %>
            <div class="card">
                <div class="card-title">
                    <i class="fas fa-box" style="color:#2563eb;"></i>
                    Thông Tin Mặt Hàng
                </div>
                <table style="width:100%; border-collapse:collapse; border:none;">
                    <tr>
                        <td style="width:33%; padding:8px 12px 8px 0; border:none; vertical-align:top;">
                            <div style="font-size:0.85rem; color:var(--text-muted);">Mã mặt hàng:</div>
                            <div style="font-size:1.15rem; font-weight:700;">#<%= product.getId() %></div>
                        </td>
                        <td style="width:33%; padding:8px 12px; border:none; vertical-align:top;">
                            <div style="font-size:0.85rem; color:var(--text-muted);">Tên mặt hàng:</div>
                            <div style="font-size:1.15rem; font-weight:700; color:#1e293b;"><%= product.getProductName() %></div>
                        </td>
                        <td style="width:33%; padding:8px 0 8px 12px; border:none; vertical-align:top;">
                            <div style="font-size:0.85rem; color:var(--text-muted);">Phân loại:</div>
                            <div><span class="badge badge-blue"><%= product.getProductCategory() %></span></div>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding:8px 12px 0 0; border:none; vertical-align:top;">
                            <div style="font-size:0.85rem; color:var(--text-muted);">Đơn vị tính:</div>
                            <div style="font-weight:600;"><%= product.getUnit() %></div>
                        </td>
                        <td style="padding:8px 12px 0 12px; border:none; vertical-align:top;">
                            <div style="font-size:0.85rem; color:var(--text-muted);">Đơn giá bán niêm yết:</div>
                            <div style="font-weight:700; color:#2563eb;"><%= product.getSellingPrice() != null ? nf.format(product.getSellingPrice()) : "0" %> đ</div>
                        </td>
                        <td style="padding:8px 0 0 12px; border:none; vertical-align:top;">
                            <div style="font-size:0.85rem; color:var(--text-muted);">Tồn kho hiện tại:</div>
                            <div style="font-weight:600;"><%= product.getRemainingQuality() %> <%= product.getUnit() %></div>
                        </td>
                    </tr>
                </table>
            </div>
            <% } %>

            <!-- Khối 2: Lịch sử các giao dịch bán hàng -->
            <div class="card" style="padding:0; overflow:hidden;">
                <div style="padding:16px 20px; border-bottom:1px solid var(--border-color); display:flex; justify-content:space-between; align-items:center;">
                    <div style="font-size:1.05rem; font-weight:600; color:var(--text-main);">
                        <i class="fas fa-receipt" style="color:#2563eb; margin-right:8px;"></i>
                        Lịch Sử Các Giao Dịch Bán Mặt Hàng Này
                        <% if (displayStartDate != null && displayEndDate != null) { %>
                            <span style="font-size:0.88rem; font-weight:normal; color:var(--text-muted); margin-left:8px;">
                                (<%= displayStartDate %> &rarr; <%= displayEndDate %>)
                            </span>
                        <% } %>
                    </div>
                    <div style="font-size:0.88rem; color:var(--text-muted);">
                        Tổng cộng: <strong><%= transactions.size() %></strong> hóa đơn
                    </div>
                </div>

                <div class="table-responsive" style="border:none; border-radius:0;">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th class="text-center" style="width: 50px;">STT</th>
                                <th class="text-center" style="width: 120px;">Mã Hóa Đơn</th>
                                <th style="width: 170px;">Hình Thức Bán</th>
                                <th style="width: 140px;">Ngày Bán</th>
                                <th class="text-center" style="width: 130px;">Số Lượng Bán</th>
                                <th class="text-right">Đơn Giá Bán</th>
                                <th class="text-right">Thành Tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (!transactions.isEmpty()) {
                                    int count = 1;
                                    for (TransactionDetail6 tx : transactions) {
                            %>
                            <tr>
                                <td class="text-center" style="color:var(--text-muted);"><%= count++ %></td>
                                <td class="text-center"><strong><%= tx.getInvoiceId() %></strong></td>
                                <td>
                                    <% if ("Tại quầy".equals(tx.getTransactionType())) { %>
                                        <span class="badge badge-green"><i class="fas fa-store"></i> Bán tại quầy</span>
                                    <% } else { %>
                                        <span class="badge badge-blue"><i class="fas fa-globe"></i> Đơn trực tuyến</span>
                                    <% } %>
                                </td>
                                <td><%= tx.getTransactionDate() != null ? df.format(tx.getTransactionDate()) : "N/A" %></td>
                                <td class="text-center"><strong><%= tx.getQuantity() %></strong></td>
                                <td class="text-right"><%= tx.getUnitPrice() != null ? nf.format(tx.getUnitPrice()) : "0" %> đ</td>
                                <td class="text-right" style="color:#1d4ed8; font-weight:700;">
                                    <%= tx.getTotalAmount() != null ? nf.format(tx.getTotalAmount()) : "0" %> đ
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="7" class="text-center" style="padding: 40px 20px; color:var(--text-muted);">
                                    Không có giao dịch bán hàng nào của mặt hàng này trong khoảng thời gian đã chọn.
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                        <% if (!transactions.isEmpty()) { %>
                        <tfoot style="background:#f8fafc; font-weight:700;">
                            <tr>
                                <td colspan="4" class="text-right" style="padding:14px 16px;">TỔNG CỘNG:</td>
                                <td class="text-center" style="padding:14px 16px; font-size:1.05rem;"><%= nf.format(totalQuantity) %></td>
                                <td></td>
                                <td class="text-right" style="padding:14px 16px; color:#1d4ed8; font-size:1.1rem;"><%= nf.format(totalAmount) %> VNĐ</td>
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
