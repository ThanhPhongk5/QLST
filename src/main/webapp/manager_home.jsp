<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.qlst.model.Member6, com.qlst.model.Manager6, com.qlst.model.Employee6" %>
<%
    // ── Kiểm tra quyền Quản lý ────────────────────────────────────────
    Member6 currentUser = (Member6) session.getAttribute("currentUser");
    boolean isManager = (currentUser instanceof Manager6)
            || (currentUser instanceof Employee6
                && "Manager".equalsIgnoreCase(((Employee6) currentUser).getJobPosition()));
    if (!isManager) {
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/HomePage.jsp");
        }
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ Quản lý – Siêu thị</title>
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
                <span class="nav-link active" style="cursor:default;"><i class="fas fa-user-tie"></i> Quản lý</span>
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
        <div class="container" style="max-width: 820px;">

            <!-- Tiêu đề trang -->
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-user-tie" style="color:#2563eb;"></i>
                    Trang Quản lý Siêu thị
                </h1>
                <p class="page-desc">
                    Bảng điều khiển các chức năng quản lý hoạt động kinh doanh siêu thị
                </p>
            </div>

            <!-- Khối chức năng Xem báo cáo thống kê -->
            <div class="card" style="text-align: center; padding: 40px 30px; margin-bottom: 24px;">
                <div style="width: 60px; height: 60px; border-radius: 50%; background: #eff6ff; color: #2563eb; display: inline-flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 16px;">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h2 style="font-size: 1.3rem; font-weight: 700; margin-bottom: 8px;">Báo Cáo &amp; Thống Kê Doanh Thu</h2>
                <p style="color: var(--text-sub); max-width: 520px; margin: 0 auto 24px; font-size: 0.95rem;">
                    Tra cứu tổng hợp kết quả kinh doanh, số lượng tiêu thụ và doanh thu bán lẻ, bán hàng online của từng mặt hàng theo khoảng thời gian.
                </p>

                <a href="${pageContext.request.contextPath}/statis_type.jsp" class="btn btn-primary" style="font-size: 1rem; padding: 12px 28px;">
                    <i class="fas fa-file-invoice-dollar"></i> Xem Báo Cáo Thống Kê
                </a>
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
