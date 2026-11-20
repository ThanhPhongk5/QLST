<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hệ thống Quản lý Siêu thị</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=6">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>

    <body class="home-compact">

        <!-- Thanh điều hướng chính -->
        <header class="main-header">
            <div class="container header-inner">
                <div class="logo">
                    <i class="fas fa-store-alt"></i>
                    <span>Siêu thị Thông minh</span>
                </div>
                <nav style="display:flex;align-items:center;gap:10px;">
                    <a href="${pageContext.request.contextPath}/HomePage.jsp" class="nav-link active">
                        <i class="fas fa-home"></i> Trang chủ
                    </a>
                    <% if (session.getAttribute("currentUser") !=null) { %>
                        <span
                            style="color: #475569; font-size: 0.88rem; background: #f1f5f9; padding: 4px 10px; border-radius: 6px; display:inline-flex; align-items:center; gap:6px;">
                            <i class="fas fa-user-circle" style="color: #2563eb;"></i>
                            <%= ((com.qlst.model.Member6)session.getAttribute("currentUser")).getFullName() %>
                        </span>
                        <a href="${pageContext.request.contextPath}/logout.jsp" class="nav-link" style="color: #dc2626;"
                            title="Đăng xuất"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                        <% } else { %>
                            <a href="${pageContext.request.contextPath}/login.jsp" class="nav-link"><i
                                    class="fas fa-sign-in-alt"></i> Đăng nhập</a>
                            <% } %>
                                <a href="${pageContext.request.contextPath}/register.jsp" class="nav-link">
                                    <i class="fas fa-user-plus"></i> Đăng kí thành viên
                                </a>
                                <a href="${pageContext.request.contextPath}/manager_home.jsp" class="nav-link">
                                    <i class="fas fa-user-tie"></i> Quản lý
                                </a>
                </nav>
            </div>
        </header>

        <!-- Banner chính -->
        <section class="hero">
            <div class="container hero-content">
                <h1 class="hero-title">
                    Hệ thống Quản lý Bán hàng Siêu thị
                </h1>
                <p class="hero-sub">
                    Nền tảng quản lý bán lẻ, đăng ký thẻ thành viên khách hàng và tổng hợp báo cáo doanh thu bán lẻ, bán
                    hàng trực tuyến toàn diện.
                </p>
            </div>
        </section>

        <!-- Hình ảnh hoạt động siêu thị -->
        <section class="gallery-section">
            <div class="container">
                <div class="gallery-grid">
                    <div class="gallery-card">
                        <div class="gallery-img-wrapper">
                            <img src="${pageContext.request.contextPath}/images/supermarket_store.jpg"
                                alt="Không gian mua sắm tiện nghi" class="gallery-img">
                        </div>
                        <div class="gallery-card-body">
                            <h3 class="gallery-card-title">Không Gian Mua Sắm Tiện Nghi</h3>
                            <p class="gallery-card-text">Hệ thống trưng bày hàng hóa khoa học, tiện lợi, cung cấp đa
                                dạng sản phẩm chất lượng cao phục vụ người tiêu dùng.</p>
                        </div>
                    </div>

                    <div class="gallery-card">
                        <div class="gallery-img-wrapper">
                            <img src="${pageContext.request.contextPath}/images/supermarket_checkout.jpg"
                                alt="Dịch vụ khách hàng tận tâm" class="gallery-img">
                        </div>
                        <div class="gallery-card-body">
                            <h3 class="gallery-card-title">Dịch Vụ Khách Hàng Tận Tâm</h3>
                            <p class="gallery-card-text">Quầy giao dịch và thu ngân hiện đại, hỗ trợ đăng ký thành viên
                                nhanh chóng với nhiều quyền lợi và ưu đãi tích điểm.</p>
                        </div>
                    </div>

                    <div class="gallery-card">
                        <div class="gallery-img-wrapper">
                            <img src="${pageContext.request.contextPath}/images/supermarket_analytics.jpg"
                                alt="Quản trị bán hàng và doanh thu" class="gallery-img">
                        </div>
                        <div class="gallery-card-body">
                            <h3 class="gallery-card-title">Quản Trị Bán Hàng & Doanh Thu</h3>
                            <p class="gallery-card-text">Hệ thống phân tích kinh doanh trực quan, thống kê doanh thu mặt
                                hàng chuẩn xác theo thời gian thực cho nhà quản lý.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Chân trang -->
        <footer class="main-footer">
            <div class="container">
                <p>© Hệ thống Quản lý Siêu thị</p>
            </div>
        </footer>

    </body>

    </html>