# 🏪 QLST – Hệ thống Quản lý Siêu Thị

**MSSV:** 10B23DCCN646 | **Môn:** Phân Tích Thiết Kế Hệ Thống  
**Công nghệ:** Java EE (Servlet + JSP) · JDBC · MySQL · Apache Tomcat

---

## 📋 Mô tả Dự án

Hệ thống QLST gồm **2 module chính**:

| Module | Tính năng | URL |
|--------|-----------|-----|
| **Module 1** | Đăng ký Thành viên | `/dangky` |
| **Module 2** | Thống kê Doanh thu theo Mặt hàng | `/thongke` |

---

## 🗂️ Cấu trúc Thư mục

```
QLST/
├── pom.xml                              ← Maven build file
├── sql/
│   └── qlst_database.sql               ← Script tạo CSDL + dữ liệu mẫu
└── src/main/
    ├── java/com/qlst/
    │   ├── dao/
    │   │   ├── DBConnection.java        ← Kết nối JDBC
    │   │   ├── ThanhVienDAO.java        ← DAO Module 1
    │   │   └── ThongKeDAO.java          ← DAO Module 2
    │   ├── model/
    │   │   ├── ThanhVien.java           ← Entity thành viên
    │   │   └── ThongKeDoanhThu.java     ← Model thống kê
    │   └── web/
    │       ├── DangKyServlet.java       ← Controller Module 1
    │       └── ThongKeServlet.java      ← Controller Module 2
    └── webapp/
        ├── WEB-INF/web.xml              ← Deployment descriptor
        ├── css/style.css                ← Global CSS (dark theme)
        ├── js/
        │   ├── main.js                  ← Script chung
        │   ├── dangky.js               ← Validate Module 1
        │   └── thongke.js              ← Logic Module 2
        ├── index.jsp                    ← Trang chủ
        ├── dangky.jsp                   ← Form đăng ký (View Module 1)
        ├── dangky_success.jsp           ← Thông báo thành công
        ├── thongke.jsp                  ← Bảng thống kê (View Module 2)
        ├── error404.jsp
        └── error500.jsp
```

---

## ⚙️ Yêu cầu Hệ thống

- **JDK:** 11 trở lên
- **Maven:** 3.6+
- **Apache Tomcat:** 10.x (hỗ trợ Jakarta EE 9+)
- **MySQL:** 8.0+

---

## 🚀 Hướng dẫn Cài đặt

### Bước 1 – Tạo CSDL MySQL

```sql
-- Mở MySQL Workbench hoặc chạy lệnh (chú ý cờ --default-character-set=utf8mb4 để không bị lỗi tiếng Việt):
mysql -u root -p --default-character-set=utf8mb4 < sql/qlst_database.sql
```

Hoặc mở file `sql/qlst_database.sql` và nhấn Run (Execute) trực tiếp trong MySQL Workbench.

### Bước 2 – Cấu hình kết nối DB

Mở file [`src/main/java/com/qlst/dao/DBConnection.java`](src/main/java/com/qlst/dao/DBConnection.java) và chỉnh:

```java
private static final String URL      = "jdbc:mysql://localhost:3306/qlst_db...";
private static final String USERNAME = "root";       // ← thay bằng username MySQL của bạn
private static final String PASSWORD = "root";       // ← thay bằng password MySQL của bạn
```

### Bước 3 – Build bằng Maven

```bash
cd QLST
mvn clean package
```

File WAR sẽ được tạo tại: `target/QLSieuThi.war`

### Bước 4 – Deploy lên Tomcat

1. Copy `target/QLSieuThi.war` vào thư mục `webapps/` của Tomcat
2. Khởi động Tomcat: `bin/startup.bat` (Windows)
3. Truy cập: `http://localhost:8080/QLSieuThi/`

---

## 🗃️ Sơ đồ CSDL

```
ThanhVien (Module 1)
  id | hoTen | email | matKhau | soDienThoai | diaChi | ngaySinh | gioiTinh | ngayDangKy | trangThai

DanhMuc
  id | tenDM | moTa

SanPham
  id | maSP | tenSP | idDanhMuc(FK) | donGia | soLuongTon | donVi | moTa | anhSP | trangThai

HoaDon
  id | maHD | idThanhVien(FK) | ngayLap | tongTien | trangThai | ghiChu

ChiTietHoaDon (Module 2 – nguồn dữ liệu thống kê)
  id | idHoaDon(FK) | idSanPham(FK) | soLuong | donGia | thanhTien
```

---

## 🔗 URL Mapping

| URL | Method | Chức năng |
|-----|--------|-----------|
| `/` hoặc `/index.jsp` | GET | Trang chủ |
| `/dangky` | GET | Hiển thị form đăng ký |
| `/dangky` | POST | Xử lý đăng ký thành viên |
| `/thongke` | GET | Thống kê tất cả mặt hàng |
| `/thongke?loai=thoigian&tuNgay=...&denNgay=...` | GET | Lọc theo thời gian |
| `/thongke?loai=danhmuc&idDM=2` | GET | Lọc theo danh mục |

---

## 📐 Kiến trúc MVC (theo LAB1)

```
Browser
   │
   ▼  HTTP Request
[Servlet] ← Controller (DangKyServlet / ThongKeServlet)
   │
   ├── [DAO] ← Model (ThanhVienDAO / ThongKeDAO)
   │     │
   │     └── [MySQL CSDL] via JDBC
   │
   └── [JSP] ← View (dangky.jsp / thongke.jsp)
         │
         ▼  HTTP Response
      Browser
```

---

## 🎨 Tính năng Giao diện

### Module 1 – Đăng ký Thành viên
- ✅ Form đầy đủ: họ tên, email, mật khẩu, SĐT, ngày sinh, địa chỉ, giới tính
- ✅ Validate **phía client** (JavaScript) theo thời gian thực
- ✅ Validate **phía server** (Servlet) – kiểm tra email trùng, độ dài mật khẩu
- ✅ Hiển thị thông báo lỗi chi tiết bên cạnh từng trường
- ✅ Chỉ thị độ mạnh mật khẩu
- ✅ Toggle hiện/ẩn mật khẩu
- ✅ Trang thành công với animated checkmark

### Module 2 – Thống kê Doanh thu
- ✅ Bảng thống kê đầy đủ: mã SP, tên, danh mục, đơn giá, SL bán, doanh thu, %
- ✅ **Bộ lọc 3 chế độ**: Tất cả / Theo thời gian / Theo danh mục
- ✅ **Biểu đồ cột Chart.js** Top 10 mặt hàng doanh thu cao nhất
- ✅ **4 KPI cards**: số mặt hàng, doanh thu lọc, tổng DT hệ thống, tỉ lệ
- ✅ Thanh progress bar % doanh thu từng mặt hàng
- ✅ Sort bảng khi click vào header cột
- ✅ Xếp hạng 🥇🥈🥉 Top 3 mặt hàng

---

> Dự án tuân theo mẫu thiết kế **DAO Pattern + MVC** theo hướng dẫn LAB1-JavaProgrammingBasic.
