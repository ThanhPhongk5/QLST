import matplotlib.pyplot as plt
import matplotlib.patches as patches
import os

# Cấu hình font chữ
plt.rcParams['font.sans-serif'] = ['Segoe UI', 'Arial', 'DejaVu Sans']
plt.rcParams['axes.unicode_minus'] = False

def draw_layer_band(ax, y_start, height, layer_num, layer_name, bg_color="#f8fafc", border_color="#cbd5e1"):
    """Vẽ dải phân tầng nằm ngang chuẩn giáo trình."""
    band = patches.Rectangle((0.015, y_start), 0.97, height, facecolor=bg_color, edgecolor=border_color,
                             linewidth=1.2, linestyle="--", zorder=1)
    ax.add_patch(band)
    
    # Tag tên tầng ở góc trên bên trái
    tag_w = 0.28
    tag_h = 0.024
    tag = patches.FancyBboxPatch((0.025, y_start + height - tag_h - 0.004), tag_w, tag_h,
                                 boxstyle="round,pad=0.002,rounding_size=0.005",
                                 facecolor="#1e293b", edgecolor="#0f172a", linewidth=1, zorder=2)
    ax.add_patch(tag)
    ax.text(0.035, y_start + height - tag_h/2 - 0.004, f"TẦNG {layer_num}: {layer_name.upper()}",
            ha="left", va="center", fontsize=9.0, weight="bold", color="#ffffff", zorder=3)

def draw_uml_class(ax, x, y, width, height, title, subtitle="", attributes=None, methods=None, 
                   header_bg="#f1f5f9", header_text_color="#0f172a", border_color="#1e293b"):
    """Vẽ hộp lớp chuẩn UML 3 ngăn: Header + Attributes + Methods."""
    bbox = patches.Rectangle((x, y), width, height, facecolor="#ffffff", edgecolor=border_color,
                             linewidth=1.4, zorder=3)
    ax.add_patch(bbox)
    
    header_h = 0.038 if subtitle else 0.030
    header_box = patches.Rectangle((x, y + height - header_h), width, header_h,
                                   facecolor=header_bg, edgecolor=border_color, linewidth=1.1, zorder=4)
    ax.add_patch(header_box)
    
    if subtitle:
        ax.text(x + width/2, y + height - header_h * 0.32, subtitle, ha="center", va="center",
                fontsize=7.8, fontstyle="italic", color="#475569", zorder=5)
        ax.text(x + width/2, y + height - header_h * 0.72, title, ha="center", va="center",
                fontsize=10.2, weight="bold", color=header_text_color, zorder=5)
    else:
        ax.text(x + width/2, y + height - header_h/2, title, ha="center", va="center",
                fontsize=10.5, weight="bold", color=header_text_color, zorder=5)
    
    # Attributes
    curr_y = y + height - header_h - 0.012
    line_step = 0.0145
    if attributes:
        for attr in attributes:
            ax.text(x + 0.008, curr_y, attr, ha="left", va="top",
                    fontsize=8.0, color="#1e293b", zorder=5, family="Segoe UI")
            curr_y -= line_step
        
        curr_y -= 0.003
        ax.plot([x, x + width], [curr_y, curr_y], color=border_color, linewidth=0.8, zorder=5)
        curr_y -= 0.009
        
    # Methods
    if methods:
        for m in methods:
            ax.text(x + 0.008, curr_y, m, ha="left", va="top",
                    fontsize=8.0, color="#0369a1", zorder=5, family="Segoe UI")
            curr_y -= line_step

def generate_module1_diagram():
    fig, ax = plt.subplots(figsize=(19, 14.5), dpi=300)
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    ax.axis("off")
    
    plt.title("BIỂU ĐỒ LỚP THIẾT KẾ 4 TẦNG (DESIGN CLASS DIAGRAM) – MODUL ĐĂNG KÝ THÀNH VIÊN\n"
              "Mã sinh viên: 10B23DCCN646 | Kiến trúc Java EE: JSP → Servlet → DAO → Entity | Các lớp cùng tầng xếp theo HÀNG NGANG",
              fontsize=13.5, weight="bold", pad=20, color="#0f172a")
    
    # 4 dải phân tầng nằm ngang
    draw_layer_band(ax, 0.765, 0.195, 1, "Giao diện (JSP / Presentation Layer)", "#f8fafc", "#cbd5e1")
    draw_layer_band(ax, 0.545, 0.190, 2, "Điều khiển (Servlet / Controller)", "#fffbeb", "#fde68a")
    draw_layer_band(ax, 0.285, 0.230, 3, "Truy xuất CSDL (Data Access Object - DAO)", "#faf5ff", "#e9d5ff")
    draw_layer_band(ax, 0.015, 0.240, 4, "Thực thể & Nghiệp vụ (Entity / Model)", "#f0fdf4", "#bbf7d0")
    
    # TẦNG 1: JSP (2 giao diện chuẩn theo biểu đồ phân tích p8_Image48 & p14_Image63)
    draw_uml_class(ax, 0.10, 0.765, 0.35, 0.170, "HomePageUI6", "«JSP View: index.jsp»",
                   attributes=["- subRegisterMember: link"],
                   methods=["+ displayHomePage(): void", "+ clickRegister(): void"],
                   header_bg="#f1f5f9")
    
    draw_uml_class(ax, 0.52, 0.755, 0.40, 0.190, "RegisterUI6", "«JSP View: register.jsp»",
                   attributes=[
                       "- inFullName, inDateOfBirth: String, Date",
                       "- inAddress, inEmail, inPhoneNumber: String",
                       "- inUsername, inPassword, inConfirmPassword: String",
                       "- subRegistration: submit",
                       "- outMessage: String (hiển thị kết quả / lỗi)"
                   ],
                   methods=[
                       "+ displayRegisterForm(): void",
                       "+ validateClient(): boolean",
                       "+ submitRegister(): void"
                   ],
                   header_bg="#e0f2fe", header_text_color="#0369a1", border_color="#0369a1")
    
    # TẦNG 2: SERVLET
    draw_uml_class(ax, 0.25, 0.565, 0.50, 0.145, "CustomerRegistrationServlet6", "«HttpServlet Controller: @WebServlet(\"/register\")»",
                   attributes=[
                       "- serialVersionUID: long = 1L",
                       "- memberDAO: MemberDAO6"
                   ],
                   methods=[
                       "+ doGet(request: HttpServletRequest, response: HttpServletResponse): void",
                       "+ doPost(request: HttpServletRequest, response: HttpServletResponse): void",
                       "- validateInput(fullName, username, email, pass, confirm, phone): String"
                   ],
                   header_bg="#fef3c7", header_text_color="#92400e", border_color="#b45309")
    
    # TẦNG 3: DAO & DATABASE
    draw_uml_class(ax, 0.05, 0.305, 0.22, 0.175, "DAO", "«Data Access Base Class»",
                   attributes=["- con: Connection"],
                   methods=[
                       "+ DAO()",
                       "+ getConnection(): Connection",
                       "+ closeConnection(): void"
                   ],
                   header_bg="#f1f5f9")
    
    draw_uml_class(ax, 0.32, 0.300, 0.44, 0.185, "MemberDAO6", "«Data Access Object: extends DAO»",
                   attributes=["# con: Connection (kế thừa từ DAO cơ sở)"],
                   methods=[
                       "+ MemberDAO6()",
                       "+ checkDuplicate(username: String, email: String, phone: String): String",
                       "+ register(customer: Customer6): boolean"
                   ],
                   header_bg="#f3e8ff", header_text_color="#6b21a8", border_color="#7e22ce")
    
    draw_uml_class(ax, 0.80, 0.305, 0.17, 0.175, "MySQL: qlst_db", "«Database Server: MySQL 8.0»",
                   attributes=["• tblMember6", "• tblCustomer6", "• tblEmployee6"],
                   methods=["Port: 3306", "Engine: InnoDB", "Encoding: UTF-8"],
                   header_bg="#ffedd5", header_text_color="#9a3412", border_color="#c2410c")
    
    # TẦNG 4: ENTITY / MODEL (Hạ y xuống 0.025 để không che Tag Tầng 4)
    draw_uml_class(ax, 0.08, 0.025, 0.38, 0.190, "Member6", "«Entity Model: com.qlst.model»",
                   attributes=[
                       "# id: int",
                       "# username, password, fullName: String",
                       "# address, email, phoneNumber: String",
                       "# dateOfBirth: Date"
                   ],
                   methods=[
                       "+ check(): boolean  (Kiểm tra hợp lệ thông tin)",
                       "+ getId(), getUsername(), getFullName(): String",
                       "+ getEmail(), getPhoneNumber(), getAddress(): String",
                       "+ getters / setters đầy đủ"
                   ],
                   header_bg="#dcfce7", header_text_color="#14532d", border_color="#15803d")
    
    draw_uml_class(ax, 0.54, 0.025, 0.40, 0.190, "Customer6", "«Entity Model: extends Member6»",
                   attributes=[
                       "- customerId: String  (Mã KH tự sinh, VD: KH-2026-...)",
                       "- membershipRegistrationDate: Date",
                       "- memberLevel: String = \"BRONZE\"",
                       "- accumulatedPoints: int = 0"
                   ],
                   methods=[
                       "+ save(): boolean  (Lưu khách hàng vào CSDL)",
                       "+ getCustomerId(), setCustomerId(id: String): void",
                       "+ getMembershipRegistrationDate(): Date",
                       "+ getters / setters"
                   ],
                   header_bg="#e0f2fe", header_text_color="#075985", border_color="#0369a1")
    
    # MŨI TÊN
    arrow_normal = dict(arrowstyle="-|>", color="#0f172a", lw=1.5, mutation_scale=12)
    arrow_dash = dict(arrowstyle="-|>", color="#0284c7", lw=1.5, linestyle="--", mutation_scale=12)
    arrow_inherit = dict(arrowstyle="-|>", color="#15803d", lw=2.0, mutation_scale=16)
    
    # 1. HomePage -> RegisterUI
    ax.annotate("", xy=(0.52, 0.85), xytext=(0.45, 0.85), arrowprops=arrow_normal)
    ax.text(0.47, 0.86, "click link", fontsize=7.5, color="#64748b")
    
    # 2. RegisterUI -> Servlet
    ax.annotate("", xy=(0.60, 0.71), xytext=(0.60, 0.755), arrowprops=arrow_normal)
    ax.text(0.608, 0.73, "1. HTTP POST (form data)", fontsize=8.5, weight="bold", color="#b91c1c")
    
    # 3. Servlet -> RegisterUI (forward outMessage)
    arrow_dash_green = dict(arrowstyle="-|>", color="#15803d", lw=1.5, linestyle="--", mutation_scale=12)
    ax.annotate("", xy=(0.72, 0.755), xytext=(0.72, 0.71), arrowprops=arrow_dash_green)
    ax.text(0.728, 0.73, "4. forward (outMessage)", fontsize=8.5, weight="bold", color="#15803d")
    
    # 5. Servlet -> MemberDAO6
    ax.annotate("", xy=(0.50, 0.485), xytext=(0.50, 0.565), arrowprops=arrow_normal)
    ax.text(0.51, 0.525, "2 & 3. checkDuplicate() & register(customer)", fontsize=8.5, weight="bold", color="#7e22ce")
    
    # 6. MemberDAO6 extends DAO
    ax.annotate("", xy=(0.27, 0.385), xytext=(0.32, 0.385), arrowprops=arrow_inherit)
    ax.text(0.28, 0.395, "«extends»", fontsize=8.2, fontstyle="italic", color="#475569")
    
    # 7. MemberDAO6 -> MySQL
    ax.annotate("", xy=(0.80, 0.385), xytext=(0.76, 0.385), arrowprops=arrow_normal)
    ax.text(0.765, 0.40, "SQL INSERT", fontsize=8, weight="bold", color="#c2410c")
    
    # 8. Customer6 extends Member6
    ax.annotate("", xy=(0.46, 0.12), xytext=(0.54, 0.12), arrowprops=arrow_inherit)
    ax.text(0.48, 0.135, "«extends»", fontsize=9, weight="bold", color="#15803d")
    
    # 9. MemberDAO6 -> Customer6
    ax.annotate("", xy=(0.68, 0.215), xytext=(0.58, 0.300), arrowprops=arrow_dash)
    ax.text(0.64, 0.255, "«use / persist»", fontsize=8, color="#0284c7")
    
    plt.tight_layout()
    out_path = "docs/design_diagram_module1.png"
    plt.savefig(out_path, bbox_inches="tight")
    plt.close()
    print("Regenerated Module 1 diagram:", out_path)

def generate_module2_diagram():
    fig, ax = plt.subplots(figsize=(19, 14.5), dpi=300)
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    ax.axis("off")
    
    plt.title("BIỂU ĐỒ LỚP THIẾT KẾ 4 TẦNG (DESIGN CLASS DIAGRAM) – MODUL THỐNG KÊ DOANH THU MẶT HÀNG\n"
              "Mã sinh viên: 10B23DCCN646 | Kiến trúc Java EE: JSP → Servlet → DAO → Entity | Các lớp cùng tầng xếp theo HÀNG NGANG",
              fontsize=13.5, weight="bold", pad=20, color="#0f172a")
    
    # 4 dải phân tầng nằm ngang
    draw_layer_band(ax, 0.765, 0.195, 1, "Giao diện (JSP / Presentation Layer)", "#f8fafc", "#cbd5e1")
    draw_layer_band(ax, 0.545, 0.190, 2, "Điều khiển (Servlet / Controller)", "#fffbeb", "#fde68a")
    draw_layer_band(ax, 0.285, 0.230, 3, "Truy xuất CSDL (Data Access Object - DAO)", "#faf5ff", "#e9d5ff")
    draw_layer_band(ax, 0.015, 0.240, 4, "Thực thể & Nghiệp vụ (Entity / Model)", "#f0fdf4", "#bbf7d0")
    
    # TẦNG 1: JSP
    draw_uml_class(ax, 0.03, 0.78, 0.17, 0.150, "ManagerHomeUI6", "«JSP View: index.jsp»",
                   attributes=["- subViewReport: link", "- currentUser: Employee6"],
                   methods=["+ displayMenu(): void", "+ selectViewReports(): void"],
                   header_bg="#f1f5f9")
    
    draw_uml_class(ax, 0.22, 0.78, 0.17, 0.150, "StatisticTypeUI6", "«JSP Component»",
                   attributes=["- inoutStatisticType: select", "- selectedType: String"],
                   methods=["+ displayTypes(): void", "+ onSelectType(): void"],
                   header_bg="#f1f5f9")
    
    draw_uml_class(ax, 0.41, 0.775, 0.33, 0.165, "ProductRevenueListUI6", "«JSP View: product_revenue_statistics.jsp»",
                   attributes=[
                       "- inStartDate, inEndDate: Date  (DateRangeUI6)",
                       "- subViewStatistics: submit",
                       "- outsubProductList: Table<ProductRevenueStatistics6>",
                       "- grandTotalRevenue: double | - outMessage: String"
                   ],
                   methods=[
                       "+ displayDateRangeFilter(): void",
                       "+ displayTableAndChart(): void",
                       "+ onClickProductRow(productId: int): void"
                   ],
                   header_bg="#e0f2fe", header_text_color="#0369a1", border_color="#0369a1")
    
    draw_uml_class(ax, 0.76, 0.775, 0.21, 0.165, "TransactionDetailUI6", "«JSP View: transaction_detail.jsp»",
                   attributes=[
                       "- outProductInfo: Product6",
                       "- outTransactionList: Table<TxDetail6>",
                       "- filterStartDate, filterEndDate: Date",
                       "- btnBack: link"
                   ],
                   methods=[
                       "+ displayTransactionHistory(): void",
                       "+ btnBackToList(): void"
                   ],
                   header_bg="#dcfce7", header_text_color="#15803d", border_color="#15803d")
    
    # TẦNG 2: SERVLET
    draw_uml_class(ax, 0.26, 0.565, 0.50, 0.145, "ProductRevenueStatisticsServlet6", "«HttpServlet: @WebServlet(\"/statistics\")»",
                   attributes=[
                       "- serialVersionUID: long = 1L",
                       "- statisticsDAO: ProductStatisticsDAO6"
                   ],
                   methods=[
                       "+ doGet(request: HttpServletRequest, response: HttpServletResponse): void",
                       "+ doPost(request: HttpServletRequest, response: HttpServletResponse): void",
                       "- handleFilter(req, resp, start: Date, end: Date): void",
                       "- handleDetail(req, resp, productId: int, ...): void"
                   ],
                   header_bg="#fef3c7", header_text_color="#92400e", border_color="#b45309")
    
    # TẦNG 3: DAO & DATABASE
    draw_uml_class(ax, 0.04, 0.305, 0.22, 0.175, "DAO", "«Data Access Base Class»",
                   attributes=["- con: Connection"],
                   methods=[
                       "+ DAO()",
                       "+ getConnection(): Connection",
                       "+ closeConnection(): void"
                   ],
                   header_bg="#f1f5f9")
    
    draw_uml_class(ax, 0.29, 0.300, 0.49, 0.185, "ProductStatisticsDAO6", "«Data Access Object: extends DAO»",
                   attributes=["# con: Connection (kế thừa từ DAO cơ sở)"],
                   methods=[
                       "+ ProductStatisticsDAO6()",
                       "+ getProductStatistics(start: Date, end: Date): List<ProductRevenueStatistics6>",
                       "+ getTransactionDetail(prodId: int, start, end): List<TransactionDetail6>",
                       "+ getProductById(productId: int): Product6 | + getTotalRevenue(...): double"
                   ],
                   header_bg="#f3e8ff", header_text_color="#6b21a8", border_color="#7e22ce")
    
    draw_uml_class(ax, 0.81, 0.305, 0.16, 0.175, "MySQL: qlst_db", "«Database Server: MySQL 8.0»",
                   attributes=["• tblProduct6", "• HoaDon & Detail", "• OnlineOrder & Detail"],
                   methods=["Queries: SUM, GROUP BY", "ORDER BY revenue DESC", "Port: 3306"],
                   header_bg="#ffedd5", header_text_color="#9a3412", border_color="#c2410c")
    
    # TẦNG 4: ENTITY / MODEL (Hạ y xuống 0.025 để không che Tag Tầng 4)
    draw_uml_class(ax, 0.03, 0.025, 0.27, 0.190, "Product6", "«Entity Model»",
                   attributes=[
                       "- id: int",
                       "- productName, productCategory: String",
                       "- unit: String",
                       "- importPrice, sellingPrice: double",
                       "- remainingQuantity: int"
                   ],
                   methods=[
                       "+ getId(): int | + setId(id: int): void",
                       "+ getProductName(): String",
                       "+ getSellingPrice(): double",
                       "+ getters / setters"
                   ],
                   header_bg="#e0f2fe", header_text_color="#075985", border_color="#0369a1")
    
    draw_uml_class(ax, 0.32, 0.025, 0.33, 0.190, "ProductRevenueStatistics6", "«Entity Model: extends Product6»",
                   attributes=[
                       "- saleQuantity: int  (tổng số lượng bán)",
                       "- revenue: double  (tổng doanh thu)",
                       "# (kế thừa đầy đủ Product6)"
                   ],
                   methods=[
                       "+ getProductStatistics(): List<...>",
                       "+ getTransactionDetail(): List<...>",
                       "+ getSaleQuantity(): int",
                       "+ getRevenue(): double",
                       "+ getters / setters"
                   ],
                   header_bg="#dcfce7", header_text_color="#14532d", border_color="#15803d")
    
    draw_uml_class(ax, 0.67, 0.025, 0.30, 0.190, "TransactionDetail6", "«Entity Model / DTO»",
                   attributes=[
                       "- transactionId: int",
                       "- transactionDate: Date",
                       "- invoiceCode, customerName: String",
                       "- quantity: int | - unitPrice: double",
                       "- subTotal: double | - txType: String"
                   ],
                   methods=[
                       "+ getTransactionDate(): Date",
                       "+ getInvoiceCode(): String",
                       "+ getSubTotal(): double",
                       "+ getters / setters"
                   ],
                   header_bg="#f3e8ff", header_text_color="#6b21a8", border_color="#7e22ce")
    
    # MŨI TÊN
    arrow_normal = dict(arrowstyle="-|>", color="#0f172a", lw=1.5, mutation_scale=12)
    arrow_dash = dict(arrowstyle="-|>", color="#0284c7", lw=1.5, linestyle="--", mutation_scale=12)
    arrow_inherit = dict(arrowstyle="-|>", color="#15803d", lw=2.0, mutation_scale=16)
    
    # 1. UI Navigation
    ax.annotate("", xy=(0.22, 0.85), xytext=(0.20, 0.85), arrowprops=arrow_normal)
    ax.annotate("", xy=(0.41, 0.85), xytext=(0.39, 0.85), arrowprops=arrow_normal)
    
    # 2. ProductRevenueListUI -> Servlet (Submit Filter)
    ax.annotate("", xy=(0.47, 0.71), xytext=(0.47, 0.775), arrowprops=arrow_normal)
    ax.text(0.38, 0.74, "1. HTTP GET (dates)", fontsize=8.2, weight="bold", color="#b91c1c")
    
    # 3. Servlet -> ProductRevenueListUI (forward statList)
    ax.annotate("", xy=(0.60, 0.775), xytext=(0.60, 0.71), arrowprops=arrow_dash)
    ax.text(0.61, 0.74, "3. forward(statList)", fontsize=8.2, weight="bold", color="#0284c7")
    
    # 4. Servlet -> TransactionDetailUI (forward txList)
    ax.annotate("", xy=(0.82, 0.775), xytext=(0.74, 0.71), arrowprops=arrow_dash)
    ax.text(0.78, 0.735, "forward(txList)", fontsize=8.0, weight="bold", color="#0284c7")
    
    # 5. Servlet -> ProductStatisticsDAO6
    ax.annotate("", xy=(0.50, 0.485), xytext=(0.50, 0.565), arrowprops=arrow_normal)
    ax.text(0.51, 0.525, "2. getProductStatistics() & getTransactionDetail()", fontsize=8.5, weight="bold", color="#7e22ce")
    
    # 6. DAO extends DAO
    ax.annotate("", xy=(0.26, 0.385), xytext=(0.29, 0.385), arrowprops=arrow_inherit)
    ax.text(0.265, 0.395, "«extends»", fontsize=8.2, fontstyle="italic", color="#475569")
    
    # 7. DAO -> MySQL
    ax.annotate("", xy=(0.81, 0.385), xytext=(0.78, 0.385), arrowprops=arrow_normal)
    ax.text(0.785, 0.40, "SQL JOIN", fontsize=8, weight="bold", color="#c2410c")
    
    # 8. ProductRevenueStatistics6 extends Product6
    ax.annotate("", xy=(0.30, 0.12), xytext=(0.32, 0.12), arrowprops=arrow_inherit)
    ax.text(0.295, 0.135, "«extends»", fontsize=9, weight="bold", color="#15803d")
    
    # 9. DAO maps ResultSet -> Entities
    ax.annotate("", xy=(0.48, 0.215), xytext=(0.48, 0.300), arrowprops=arrow_dash)
    ax.text(0.49, 0.255, "Map List<ProductRevenueStatistics6>", fontsize=8, weight="bold", color="#0284c7")
    
    ax.annotate("", xy=(0.78, 0.215), xytext=(0.68, 0.300), arrowprops=arrow_dash)
    ax.text(0.74, 0.255, "Map List<TransactionDetail6>", fontsize=8, weight="bold", color="#7e22ce")
    
    plt.tight_layout()
    out_path = "docs/design_diagram_module2.png"
    plt.savefig(out_path, bbox_inches="tight")
    plt.close()
    print("Regenerated Module 2 diagram:", out_path)

if __name__ == "__main__":
    generate_module1_diagram()
    generate_module2_diagram()
