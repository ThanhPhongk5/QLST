<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Xóa session và chuyển về trang đăng nhập
    HttpSession s = request.getSession(false);
    if (s != null) {
        s.invalidate();
    }
    response.sendRedirect(request.getContextPath() + "/login.jsp?msg=logout_success");
%>
