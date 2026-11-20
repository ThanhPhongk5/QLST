<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>500 – Lỗi hệ thống | QLST</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .error-page { display:flex; flex-direction:column; align-items:center; justify-content:center; min-height:60vh; text-align:center; padding:40px; }
        .error-code { font-size:7rem; font-weight:800; background:linear-gradient(135deg,#ef4444,#f59e0b); -webkit-background-clip:text; -webkit-text-fill-color:transparent; }
        .error-msg { font-size:1.2rem; color:#94a3b8; margin:12px 0 32px; }
    </style>
</head>
<body>
    <header class="main-header">
        <div class="container header-inner">
            <div class="logo"><i class="fas fa-store-alt"></i><span>QLST</span></div>
        </div>
    </header>
    <main>
        <div class="error-page">
            <div class="error-code">500</div>
            <h2>Lỗi hệ thống</h2>
            <p class="error-msg">Đã xảy ra lỗi không mong đợi. Vui lòng thử lại sau.</p>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg">
                <i class="fas fa-home"></i> Về trang chủ
            </a>
        </div>
    </main>
</body>
</html>
