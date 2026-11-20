<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.qlst.dao.MemberDAO6, com.qlst.model.Member6, com.qlst.model.Manager6, com.qlst.model.Employee6"
        %>
        <%
    /* ── Xử lý thiết lập bảng mã UTF-8 ───────────────────────────── */
    request.setCharacterEncoding("UTF-8");

    String outMessage     = null;
    String successMessage = null;
    String prefillUser    = null;

    /* ── 1. Xử lý đăng xuất ───────────────────────────────────────── */
    if ("logout".equals(request.getParameter("action"))) {
        HttpSession s = request.getSession(false);
        if (s != null) {
            s.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/login.jsp?msg=logout_success");
        return;
    }

    /* ── 2. Nếu đã đăng nhập rồi thì chuyển thẳng vào trang Quản lý ─ */
    HttpSession existingSession = request.getSession(false);
    if ("GET".equalsIgnoreCase(request.getMethod()) && existingSession != null
            && existingSession.getAttribute("currentUser") != null) {
        response.sendRedirect(request.getContextPath() + "/manager_home.jsp");
        return;
    }

    /* ── 3. Xử lý thông báo flash từ tham số msg trên URL ─────────── */
    String msg = request.getParameter("msg");
    if ("logout_success".equals(msg)) {
        successMessage = "Bạn đã đăng xuất thành công khỏi hệ thống.";
    } else if ("register_success".equals(msg)) {
        HttpSession sess = request.getSession(false);
        if (sess != null) {
            String flash = (String) sess.getAttribute("flashSuccess");
            sess.removeAttribute("flashSuccess");
            String regUser = (String) sess.getAttribute("registeredUsername");
            sess.removeAttribute("registeredUsername");
            successMessage = (flash != null) ? flash : "Đăng ký thành viên thành công! Vui lòng đăng nhập.";
            prefillUser = regUser;
        } else {
            successMessage = "Đăng ký thành viên thành công! Vui lòng đăng nhập.";
        }
    }

    /* ── 4. Xử lý POST: Đăng nhập tài khoản ───────────────────────── */
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            outMessage = "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.";
            prefillUser = username;
        } else {
            MemberDAO6 memberDAO = new MemberDAO6();
            Member6 user = memberDAO.login(username.trim(), password);

            if (user == null) {
                outMessage = "Tên đăng nhập hoặc mật khẩu không chính xác.";
                prefillUser = username;
            } else {
                /* Đăng nhập thành công → Lưu thông tin vào session */
                HttpSession sess = request.getSession(true);
                sess.setAttribute("currentUser", user);
                boolean isManager = (user instanceof Manager6)
                        || (user instanceof Employee6
                            && "Manager".equalsIgnoreCase(((Employee6) user).getJobPosition()));
                sess.setAttribute("isManager", isManager);
                response.sendRedirect(request.getContextPath() + "/manager_home.jsp");
                return;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập Hệ Thống – Siêu Thị</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=4">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="background-color: #ffffff; color: #0f172a;">

    <!-- Thanh điều hướng chính -->
    <header class="main-header">
        <div class="container header-inner">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/" style="text-decoration:none;color:inherit;display:flex;align-items:center;gap:10px">
                    <i class="fas fa-store-alt"></i>
                    <span>Siêu thị Thông minh</span>
                </a>
            </div>
            <nav>
                <span class="nav-link active" style="cursor:default;"><i class="fas fa-sign-in-alt"></i> Đăng nhập</span>
            </nav>
        </div>
    </header>

    <main class="auth-main" style="padding: 40px 20px;">
        <div class="auth-card" style="max-width: 480px; margin: 0 auto;">

            <!-- Card Header -->
            <div class="auth-card-header">
                <div class="auth-icon"><i class="fas fa-user-shield"></i></div>
                <h1>Đăng Nhập</h1>
                <p>Nhập thông tin xác thực để truy cập hệ thống siêu thị</p>
            </div>

            <!-- Thông báo lỗi -->
            <% if (outMessage != null && !outMessage.trim().isEmpty()) { %>
            <div class="alert alert-danger" style="margin: 20px 30px 0;">
                <i class="fas fa-exclamation-triangle"></i>
                <div><%= outMessage %></div>
            </div>
            <% } %>

            <!-- Thông báo thành công -->
            <% if (successMessage != null && !successMessage.trim().isEmpty()) { %>
            <div class="alert alert-success" style="margin: 20px 30px 0;">
                <i class="fas fa-check-circle"></i>
                <div><%= successMessage %></div>
            </div>
            <% } %>

            <!-- Form đăng nhập -->
            <form action="${pageContext.request.contextPath}/login.jsp" method="POST" class="auth-form" novalidate>

                <!-- Tên đăng nhập -->
                <div class="form-group">
                    <label for="username">Tên đăng nhập hoặc Email: <span class="required">*</span></label>
                    <div class="input-icon-right">
                        <input type="text" id="username" name="username" class="form-control"
                               placeholder="Nhập tên đăng nhập hoặc email"
                               value="<%= prefillUser != null ? prefillUser : "" %>"
                               required autofocus>
                    </div>
                </div>

                <!-- Mật khẩu -->
                <div class="form-group">
                    <label for="password">Mật khẩu: <span class="required">*</span></label>
                    <div class="input-icon-right">
                        <input type="password" id="password" name="password" class="form-control"
                               placeholder="Nhập mật khẩu" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary btn-block btn-submit" >
                    <i class="fas fa-sign-in-alt"></i> Đăng Nhập
                </button>

                <div class="auth-footer-text" style="margin-top: 16px;">
                    Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register.jsp">Đăng ký thành viên mới</a>
                </div>
            </form>
        </div>
    </main>

    <footer class="main-footer">
        <div class="container">
            © Hệ thống Quản lý Siêu thị
        </div>
    </footer>

</body>
</html>