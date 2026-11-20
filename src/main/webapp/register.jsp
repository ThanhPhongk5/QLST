<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.qlst.model.Customer6, com.qlst.model.Member6, com.qlst.dao.MemberDAO6" %>
<%@ page import="java.text.ParseException, java.text.SimpleDateFormat, java.util.Date" %>
<%
    /* ── Xử lý POST: đăng ký thành viên ────────────────────────────── */
    request.setCharacterEncoding("UTF-8");

    String outMessage = null;
    boolean isSuccess = false;

    /* Giá trị giữ lại trên form khi có lỗi */
    String fFullName = null;
    String fUsername = null;
    String fEmail    = null;
    String fPhone    = null;
    String fAddress  = null;
    String fDob      = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        fFullName = request.getParameter("fullName");
        fUsername = request.getParameter("username");
        fEmail    = request.getParameter("email");
        String password   = request.getParameter("password");
        String confirmPwd = request.getParameter("confirmPassword");
        fPhone    = request.getParameter("phoneNumber");
        fAddress  = request.getParameter("address");
        fDob      = request.getParameter("dateOfBirth");

        if (fUsername == null || fUsername.trim().isEmpty()) {
            fUsername = fEmail;
        }

        /* ── Bước 1: Kiểm tra định dạng ────────────────────────────── */
        StringBuilder errors = new StringBuilder();

        if (fFullName == null || fFullName.trim().isEmpty()) {
            errors.append("Họ và tên là bắt buộc.<br/>");
        }
        if (fEmail == null || fEmail.trim().isEmpty()) {
            errors.append("Email là bắt buộc.<br/>");
        } else if (!fEmail.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            errors.append("Email không đúng định dạng (vd: user@example.com).<br/>");
        }
        if (password == null || password.length() < 6) {
            errors.append("Mật khẩu phải có ít nhất 6 ký tự.<br/>");
        } else if (!password.equals(confirmPwd)) {
            errors.append("Mật khẩu xác nhận không khớp.<br/>");
        }
        if (fPhone != null && !fPhone.trim().isEmpty() && !fPhone.trim().matches("^0[0-9]{9}$")) {
            errors.append("Số điện thoại phải bắt đầu bằng 0 và đủ 10 chữ số.<br/>");
        }

        /* ── Bước 2: Kiểm tra trùng lặp qua MemberDAO6 ───────────── */
        MemberDAO6 memberDAO = new MemberDAO6();
        if (errors.length() == 0) {
            String dupError = memberDAO.checkDuplicate(
                fUsername != null ? fUsername.trim() : "",
                fEmail.trim(),
                fPhone != null ? fPhone.trim() : ""
            );
            if (dupError != null) {
                errors.append(dupError).append("<br/>");
            }
        }

        /* ── Bước 3: Đóng gói Customer6 và gọi MemberDAO6 lưu ─────── */
        if (errors.length() == 0) {
            Customer6 customer = new Customer6();
            customer.setFullName(fFullName.trim());
            customer.setUsername(fUsername != null ? fUsername.trim() : fEmail.trim());
            customer.setEmail(fEmail.trim());
            customer.setPassword(password);
            customer.setPhoneNumber(fPhone != null ? fPhone.trim() : "");
            customer.setAddress(fAddress != null ? fAddress.trim() : "");
            customer.setMembershipRegistrationDate(new Date());
            if (fDob != null && !fDob.trim().isEmpty()) {
                try {
                    customer.setDateOfBirth(new SimpleDateFormat("yyyy-MM-dd").parse(fDob.trim()));
                } catch (ParseException e) {
                    customer.setDateOfBirth(null);
                }
            }

            boolean saved = memberDAO.register(customer);
            if (saved) {
                /* Đăng ký thành công → redirect về trang đăng nhập */
                session.setAttribute("flashSuccess",
                    "Đăng ký thành viên thành công! Vui lòng đăng nhập để tiếp tục.");
                session.setAttribute("registeredUsername", customer.getUsername());
                response.sendRedirect(request.getContextPath() + "/login.jsp?msg=register_success");
                return;
            } else {
                outMessage = "Lỗi hệ thống khi lưu thông tin. Vui lòng thử lại.";
            }
        } else {
            outMessage = errors.toString();
        }
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Khách Hàng Thành Viên – Siêu thị</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
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
                <span class="nav-link active" style="cursor:default;"><i class="fas fa-user-plus"></i> Đăng ký Thành viên</span>
            </nav>
        </div>
    </header>

    <main class="auth-main">
        <div class="auth-card">

            <!-- Card Header -->
            <div class="auth-card-header">
                <div class="auth-icon"><i class="fas fa-user-plus"></i></div>
                <h1>Đăng Ký Thành Viên</h1>
                <p>Điền thông tin bên dưới để mở tài khoản khách hàng thân thiết</p>
            </div>

            <!-- Thông báo kết quả / lỗi -->
            <% if (outMessage != null && !outMessage.trim().isEmpty()) { %>
            <div class="alert alert-danger" style="margin: 20px 30px 0;">
                <i class="fas fa-exclamation-triangle"></i>
                <div><%= outMessage %></div>
            </div>
            <% } %>

            <!-- Form đăng ký: action trỏ về chính register.jsp -->
            <form action="${pageContext.request.contextPath}/register.jsp" method="POST"
                  class="auth-form" id="registerForm" novalidate>

                <!-- Họ và tên -->
                <div class="form-group">
                    <label for="fullName">Họ và tên: <span class="required">*</span></label>
                    <input type="text" id="fullName" name="fullName" class="form-control"
                           placeholder="Ví dụ: Nguyễn Văn An"
                           value="<%= fFullName != null ? fFullName : (request.getParameter("fullName") != null ? request.getParameter("fullName") : "") %>" required>
                </div>

                <div class="form-row">
                    <!-- Tên đăng nhập -->
                    <div class="form-group">
                        <label for="username">Tên tài khoản: <span class="required">*</span></label>
                        <input type="text" id="username" name="username" class="form-control"
                               placeholder="an.nguyen"
                               value="<%= fUsername != null ? fUsername : (request.getParameter("username") != null ? request.getParameter("username") : "") %>" required>
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label for="email">Địa chỉ Email: <span class="required">*</span></label>
                        <input type="email" id="email" name="email" class="form-control"
                               placeholder="an.nguyen@gmail.com"
                               value="<%= fEmail != null ? fEmail : (request.getParameter("email") != null ? request.getParameter("email") : "") %>" required>
                    </div>
                </div>

                <div class="form-row">
                    <!-- Số điện thoại -->
                    <div class="form-group">
                        <label for="phoneNumber">Số điện thoại: <span class="required">*</span></label>
                        <input type="tel" id="phoneNumber" name="phoneNumber" class="form-control"
                               placeholder="0901234567"
                               value="<%= fPhone != null ? fPhone : (request.getParameter("phoneNumber") != null ? request.getParameter("phoneNumber") : "") %>" required>
                    </div>

                    <!-- Ngày sinh -->
                    <div class="form-group">
                        <label for="dateOfBirth">Ngày sinh:</label>
                        <input type="date" id="dateOfBirth" name="dateOfBirth" class="form-control"
                               value="<%= fDob != null ? fDob : (request.getParameter("dateOfBirth") != null ? request.getParameter("dateOfBirth") : "") %>">
                    </div>
                </div>

                <!-- Địa chỉ -->
                <div class="form-group">
                    <label for="address">Địa chỉ thường trú:</label>
                    <input type="text" id="address" name="address" class="form-control"
                           placeholder="Số 12 Chùa Bộc, Hà Nội"
                           value="<%= fAddress != null ? fAddress : (request.getParameter("address") != null ? request.getParameter("address") : "") %>">
                </div>

                <div class="form-row">
                    <!-- Mật khẩu -->
                    <div class="form-group">
                        <label for="password">Mật khẩu: <span class="required">*</span></label>
                        <input type="password" id="password" name="password" class="form-control"
                               placeholder="Tối thiểu 6 ký tự" required>
                    </div>

                    <!-- Xác nhận mật khẩu -->
                    <div class="form-group">
                        <label for="confirmPassword">Xác nhận mật khẩu: <span class="required">*</span></label>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control"
                               placeholder="Nhập lại mật khẩu" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary btn-block btn-submit" style="margin-top:10px;">
                    <i class="fas fa-check-circle"></i> Đăng Ký Tài Khoản
                </button>

                <div class="auth-footer-text">
                    Đã có tài khoản? <a href="${pageContext.request.contextPath}/login.jsp">Đến trang đăng nhập</a>
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
