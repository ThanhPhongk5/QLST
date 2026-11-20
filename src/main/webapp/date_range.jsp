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

    String outMessage = (String) request.getAttribute("outMessage");
    String startDate  = request.getParameter("startDate");
    String endDate    = request.getParameter("endDate");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn Khoảng Thời Gian Thống Kê – Siêu thị</title>
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
        <div class="container" style="max-width: 680px;">

            <!-- Tiêu đề trang -->
            <div class="page-header">
                <h1 class="page-title">
                    <i class="far fa-calendar-alt" style="color:#2563eb;"></i>
                    Chọn Khoảng Thời Gian Thống Kê
                </h1>
                <p class="page-desc">
                    Vui lòng chọn ngày bắt đầu và ngày kết thúc để tổng hợp báo cáo doanh thu bán hàng
                </p>
            </div>

            <!-- Thông báo lỗi (nếu có) -->
            <% if (outMessage != null && !outMessage.trim().isEmpty()) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i>
                    <span><%= outMessage %></span>
                </div>
            <% } %>

            <!-- Form chọn ngày tháng: submit đến product_revenue_list.jsp -->
            <div class="card">
                <form action="${pageContext.request.contextPath}/product_revenue_list.jsp" method="GET">

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 24px;">
                        <div class="form-group">
                            <label for="startDate">Từ ngày: <span class="required">*</span></label>
                            <input type="date" id="startDate" name="startDate" class="form-control"
                                   value="<%= startDate != null ? startDate : "2026-10-01" %>" required>
                        </div>

                        <div class="form-group">
                            <label for="endDate">Đến ngày: <span class="required">*</span></label>
                            <input type="date" id="endDate" name="endDate" class="form-control"
                                   value="<%= endDate != null ? endDate : "2026-10-31" %>" required>
                        </div>
                    </div>

                    <div style="display: flex; gap: 12px; justify-content: flex-end; padding-top: 18px; border-top: 1px solid var(--border-color);">
                        <a href="${pageContext.request.contextPath}/statis_type.jsp" class="btn btn-outline">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search"></i> Xem Báo Cáo Thống Kê
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
