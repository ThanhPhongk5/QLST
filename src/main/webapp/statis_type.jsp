<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.qlst.model.Member6, com.qlst.model.Manager6, com.qlst.model.Employee6" %>
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
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn Loại Báo Cáo Thống Kê – Siêu thị</title>
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
        <div class="container" style="max-width: 720px;">

            <!-- Tiêu đề trang -->
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-list-alt" style="color:#2563eb;"></i>
                    Chọn Loại Báo Cáo Thống Kê
                </h1>
                <p class="page-desc">
                    Vui lòng chọn loại báo cáo cần xem để tiếp tục chọn khoảng thời gian thống kê
                </p>
            </div>

            <!-- Form lựa chọn loại thống kê -->
            <div class="card">
                <form action="${pageContext.request.contextPath}/date_range.jsp" method="GET">

                    <div style="margin-bottom: 24px;">
                        <label style="font-weight: 600; color: var(--text-main); margin-bottom: 14px; display: block; font-size: 1rem;">
                            Danh mục báo cáo:
                        </label>

                        <!-- Tùy chọn 1: Thống kê doanh thu mặt hàng -->
                        <div style="border: 2px solid #2563eb; background: #eff6ff; border-radius: 8px; padding: 16px 20px; margin-bottom: 12px; display: flex; align-items: flex-start; gap: 12px; cursor: pointer;">
                            <input type="radio" id="type_product" name="statisticType" value="product_revenue" checked style="width: 18px; height: 18px; accent-color: #2563eb; margin-top: 3px;">
                            <label for="type_product" style="font-weight: 600; color: #1e3a8a; cursor: pointer; flex: 1;">
                                1. Thống kê Doanh thu theo Mặt hàng
                                <div style="font-weight: 400; font-size: 0.88rem; color: #3b82f6; margin-top: 4px;">
                                    Tổng hợp số lượng sản phẩm tiêu thụ, tổng doanh thu bán tại quầy và trực tuyến theo từng mặt hàng; cho phép xem chi tiết từng giao dịch.
                                </div>
                            </label>
                        </div>

                        <!-- Tùy chọn 2: Theo nhân viên -->
                        <div style="border: 1px solid var(--border-color); background: #ffffff; border-radius: 8px; padding: 14px 18px; margin-bottom: 12px; display: flex; align-items: center; gap: 12px; opacity: 0.55;">
                            <input type="radio" id="type_staff" name="statisticType" value="staff" disabled style="width: 18px; height: 18px;">
                            <label for="type_staff" style="color: var(--text-sub); flex: 1;">
                                2. Thống kê Doanh thu theo Nhân viên Bán hàng
                                <div style="font-size: 0.85rem; color: var(--text-muted); margin-top: 2px;">(Chức năng phát triển thêm)</div>
                            </label>
                        </div>

                        <!-- Tùy chọn 3: Theo nhà cung cấp -->
                        <div style="border: 1px solid var(--border-color); background: #ffffff; border-radius: 8px; padding: 14px 18px; display: flex; align-items: center; gap: 12px; opacity: 0.55;">
                            <input type="radio" id="type_supplier" name="statisticType" value="supplier" disabled style="width: 18px; height: 18px;">
                            <label for="type_supplier" style="color: var(--text-sub); flex: 1;">
                                3. Thống kê Nhập hàng từ Nhà cung cấp
                                <div style="font-size: 0.85rem; color: var(--text-muted); margin-top: 2px;">(Chức năng phát triển thêm)</div>
                            </label>
                        </div>
                    </div>

                    <div style="display: flex; gap: 12px; justify-content: flex-end; padding-top: 18px; border-top: 1px solid var(--border-color);">
                        <a href="${pageContext.request.contextPath}/manager_home.jsp" class="btn btn-outline">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                        <button type="submit" class="btn btn-primary">
                            Tiếp tục <i class="fas fa-arrow-right"></i>
                        </button>
                    </div>
                </form>
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
