# 🏪 QLST – Hệ Thống Quản Lý Siêu Thị

* **Nền tảng công nghệ:** Java-JSP-JDBC-Apache Tomcat 9-MySQL 8.0-Maven 3.x

---

## 📋 Giới Thiệu & Các Phân Hệ Chính

Hệ thống được thiết kế và hiện thực hóa dựa trên tài liệu **Phân tích Thiết kế Hệ thống**, tập trung vào 2 phân hệ cốt lõi:

| Phân hệ (Module) | Chức năng chi tiết | URL Điều hướng | Tầng Xử lý (DAO / Model) |
| :--- | :--- | :--- | :--- |
| **Module 1** | **Đăng ký Khách hàng Thành viên**<br>- Kiểm tra trùng lặp (username, email, SĐT)<br>- Tự động lưu thông tin khách hàng vào CSDL | `/register.jsp`<br>`/login.jsp` | `MemberDAO6`<br>`Customer6`, `Member6` |
| **Module 2** | **Báo cáo Thống kê Doanh thu Mặt hàng**<br>- Chọn loại báo cáo thống kê<br>- Chọn khoảng thời gian (từ ngày → đến ngày)<br>- Tổng hợp doanh thu bán tại quầy & online<br>- Sắp xếp doanh thu cao nhất (`DESC`)<br>- Xem chi tiết lịch sử các hóa đơn từng mặt hàng | `/manager_home.jsp`<br>`/statis_type.jsp`<br>`/date_range.jsp`<br>`/product_revenue_list.jsp`<br>`/transaction_detail.jsp` | `ProductStatisticsDAO6`<br>`InStoreSalesInvoiceDAO6`<br>`OnlineInvoiceDAO6`<br>`ProductRevenueStatistics6`<br>`TransactionDetail6` |

---

## 🔗 Luồng Điều Hướng Giao Diện (Page Flow)

```
HomePage.jsp (Trang chủ)
  │
  ├──► [Khách hàng] ──► register.jsp (Đăng ký TV) ──► login.jsp (Đăng nhập)
  │
  └──► [Quản lý] ──► login.jsp (Đăng nhập Quản lý)
                           │
                           ▼
                     manager_home.jsp (Trang chủ Quản lý)
                           │
                           ▼
                     statis_type.jsp (Chọn loại báo cáo: Mặt hàng)
                           │
                           ▼
                     date_range.jsp (Chọn khoảng ngày: Từ ngày → Đến ngày)
                           │
                           ▼
                     product_revenue_list.jsp (Bảng thống kê doanh thu mặt hàng)
                           │
                           ▼
                     transaction_detail.jsp (Chi tiết các hóa đơn của mặt hàng)
```

---

## 🗂️ Cấu Trúc Thư Mục Mã Nguồn Chuẩn Xác

```
QLST/
├── pom.xml                                  ← Cấu hình Maven Build (Java 11, Tomcat 9, MySQL Driver)
├── sql/
│   ├── qlst_database.sql                    ← CSDL gốc của hệ thống siêu thị
│   ├── final_dien_may_full.sql              ← Kịch bản CSDL hoàn chỉnh dữ liệu mẫu
│   └── update_dien_may.sql                  ← Script cập nhật dữ liệu danh mục Điện máy
├── tomcat/                                  ← Apache Tomcat 9 tích hợp sẵn trong dự án (Port 8080)
├── KHOI_DONG_TOMCAT.bat                     ← Script khởi động ứng dụng 1-click (Windows)
└── src/main/
    ├── java/com/qlst/
    │   ├── TomcatLauncher.java              ← Bộ kích hoạt máy chủ Tomcat & tự động mở trình duyệt
    │   ├── dao/
    │   │   ├── DAO.java                     ← Lớp DAO cơ sở
    │   │   ├── DBConnection.java            ← Quản lý kết nối JDBC MySQL (qlst_db)
    │   │   ├── MemberDAO6.java              ← Xử lý nghiệp vụ đăng nhập & đăng ký thành viên
    │   │   ├── ProductStatisticsDAO6.java   ← Truy vấn tổng hợp doanh thu theo khoảng ngày
    │   │   ├── InStoreSalesInvoiceDAO6.java ← Truy vấn hóa đơn bán lẻ tại quầy
    │   │   └── OnlineInvoiceDAO6.java       ← Truy vấn hóa đơn đơn hàng online
    │   └── model/
    │       ├── Member6.java                 ← Thực thể Thành viên chung
    │       ├── Customer6.java               ← Kế thừa Member6 (Khách hàng)
    │       ├── Employee6.java               ← Kế thừa Member6 (Nhân viên)
    │       ├── Manager6.java                ← Kế thừa Employee6 (Quản lý)
    │       ├── SalesStaff6.java             ← Nhân viên thu ngân / bán hàng
    │       ├── WarehouseStaff6.java         ← Nhân viên thủ kho
    │       ├── Product6.java                ← Mặt hàng kinh doanh
    │       ├── ProductRevenueStatistics6.java← Dữ liệu hiển thị bảng thống kê doanh thu
    │       ├── TransactionDetail6.java      ← Chi tiết từng hóa đơn bán hàng
    │       ├── InStoreSalesInvoice6.java    ← Hóa đơn bán lẻ tại quầy
    │       ├── InStoreSalesInvoiceDetail6.java ← Chi tiết hóa đơn tại quầy
    │       ├── OnlineOrder6.java            ← Đơn đặt hàng trực tuyến
    │       ├── OnlineOrderDetail6.java      ← Chi tiết đơn hàng trực tuyến
    │       ├── OnlineInvoice6.java          ← Hóa đơn thanh toán online
    │       ├── GoodsReceiptNote6.java       ← Phiếu nhập kho
    │       ├── GoodsReceiptDetail6.java     ← Chi tiết phiếu nhập kho
    │       └── Supplier6.java               ← Nhà cung cấp hàng hóa
    └── webapp/
        ├── WEB-INF/
        │   ├── web.xml                      ← Cấu hình Web Application (Session timeout, Error pages)
        │   └── lib/                         ← Driver JDBC (mysql-connector-j-8.0.33.jar)
        ├── css/
        │   └── style.css                    ← Bộ CSS giao diện hiện đại (16 mục quản lý tập trung)
        ├── images/                          ← Hình ảnh biểu ngữ và tư liệu hệ thống
        ├── HomePage.jsp                     ← Giao diện Trang chủ người dùng
        ├── index.jsp                        ← Chuyển tiếp tự động đến HomePage.jsp
        ├── register.jsp                     ← Giao diện Đăng ký Thành viên (Module 1)
        ├── login.jsp                        ← Giao diện Đăng nhập hệ thống (Xác thực phân quyền)
        ├── logout.jsp                       ← Xử lý đăng xuất phiên làm việc (Session)
        ├── manager_home.jsp                 ← Dashboard Quản lý siêu thị
        ├── statis_type.jsp                  ← Giao diện chọn loại báo cáo (Module 2)
        ├── date_range.jsp                   ← Giao diện chọn khoảng thời gian thống kê
        ├── product_revenue_list.jsp         ← Giao diện Bảng thống kê doanh thu mặt hàng
        ├── transaction_detail.jsp           ← Giao diện Xem lịch sử giao dịch từng mặt hàng
        ├── error404.jsp                     ← Trang xử lý lỗi 404 (Không tìm thấy trang)
        └── error500.jsp                     ← Trang xử lý lỗi 500 (Lỗi ngoại lệ hệ thống)
```

---

## 🗄️ Mô Hình Cơ Sở Dữ Liệu Quan Hệ (`qlst_db`)

Dữ liệu được tổ chức theo chuẩn Phân tích Thiết kế Hệ thống với hậu tố `6` (theo quy ước mã đề tài):

1. **Nhóm Tài khoản & Người dùng:**
   * `tblMember6`: Bảng cơ sở chứa thông tin chung (họ tên, email, mật khẩu, SĐT, ngày sinh, địa chỉ).
   * `tblCustomer6`: Kế thừa thành viên khách hàng (ngày đăng ký, tích điểm...).
   * `tblEmployee6`: Kế thừa nhân viên siêu thị (vị trí công việc, tiền lương).
   * `tblManager6`: Kế thừa nhân viên cấp quản lý.
2. **Nhóm Hàng hóa:**
   * `tblProduct6`: Thông tin sản phẩm, loại hàng, đơn vị tính, đơn giá bán, giá nhập, số lượng tồn kho.
3. **Nhóm Bán hàng (Nguồn dữ liệu thống kê Module 2):**
   * **Bán lẻ tại quầy:** `InStoreSalesInvoice6` (Hóa đơn) liên kết `tblInStoreSalesInvoiceDetail6` (Chi tiết).
   * **Bán trực tuyến:** `tblOnlineOrder6` (Đơn đặt hàng) ➔ `tblOnlineOrderDetail6` (Chi tiết đơn) ➔ `tblOnlineInvoice6` (Hóa đơn giao dịch).

---

## 🚀 Hướng Dẫn Cài Đặt & Chạy Ứng Dụng

### 1. Chuẩn bị Môi trường
* **JDK:** Java 11 hoặc mới hơn (Khuyến nghị: JDK 17, JDK 21 hoặc JDK 24).
* **MySQL:** MySQL Server 8.0 (chạy qua Docker hoặc cài trực tiếp trên máy qua Port `3306`).
* **Máy chủ:** Apache Tomcat 9 (đã được tích hợp sẵn trong dự án).

### 2. Thiết lập Cơ sở dữ liệu
Chạy kịch bản SQL tạo bảng và nạp dữ liệu mẫu vào MySQL:
```bash
mysql -u root -p --default-character-set=utf8mb4 qlst_db < sql/final_dien_may_full.sql
```

### 3. Cấu hình Kết nối CSDL
Mở file `src/main/java/com/qlst/dao/DBConnection.java` để điều chỉnh tài khoản MySQL nếu cần:
```java
private static final String URL      = "jdbc:mysql://localhost:3306/qlst_db?useSSL=false&serverTimezone=Asia/Ho_Chi_Minh&characterEncoding=UTF-8";
private static final String USERNAME = "root";
private static final String PASSWORD = "root";
```

### 4. Khởi chạy Ứng dụng (Cách nhanh nhất)

* **Cách 1 – Bằng tập lệnh 1-Click (Khuyến nghị trên Windows):**
  Nhấp đúp chuột vào file:
  ```
  KHOI_DONG_TOMCAT.bat
  ```
* **Cách 2 – Chạy trực tiếp qua Java:**
  Chạy hàm `main()` trong file `src/main/java/com/qlst/TomcatLauncher.java`.

Ứng dụng sẽ tự động khởi động và mở trình duyệt tại địa chỉ:
👉 **`http://localhost:8080/QLSieuThi/`**

---

## 🔑 Tài Khoản Trải Nghiệm Mẫu

| Phân quyền | Tên đăng nhập (`username`) | Mật khẩu | Chức năng truy cập |
| :--- | :--- | :--- | :--- |
| **Quản lý (Manager)** | `manager` | `123456` | Toàn quyền truy cập phân hệ **Báo cáo & Thống kê Doanh thu (Module 2)** |
| **Khách hàng (Customer)** | `an.nguyen` | `123456` | Trải nghiệm luồng **Đăng ký Thành viên (Module 1)** |
