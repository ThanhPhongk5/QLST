-- ============================================================
-- CẬP NHẬT CƠ SỞ DỮ LIỆU SANG HỆ THỐNG SIÊU THỊ ĐIỆN MÁY
-- MSSV: 10B23DCCN646 - PTIT
-- Phù hợp chính xác với bảng 12 loại mặt hàng:
-- 1. Tivi: Samsung Smart TV Crystal UHD 4K 55 inch, Smart Tivi LG OLED 4K 65 inch, Google Tivi Sony Bravia 4K 55 inch, Android Tivi TCL 4K 50 inch
-- 2. Tủ lạnh: Tủ lạnh Samsung Inverter 236L, Tủ lạnh LG Inverter 394L, Tủ lạnh Panasonic Inverter 325L, Tủ lạnh Toshiba Inverter 253L
-- 3. Máy giặt: Máy giặt LG Inverter Cửa trước 9kg, Máy giặt Toshiba Cửa trên 8.2kg, Máy giặt sấy Samsung AddWash 9.5kg
-- 4. Điều hòa: Điều hòa Daikin Inverter 1 HP, Điều hòa Panasonic Inverter 1.5 HP, Điều hòa Casper 1 HP, Điều hòa LG Inverter 1 HP
-- 5. Máy tính: Laptop ASUS Vivobook 15, Laptop Dell Inspiron 15, Laptop HP Pavilion 14, Laptop Lenovo ThinkPad E14, Máy tính để bàn HP ProTower
-- 6. Điện thoại: iPhone 15 Pro 128GB, Samsung Galaxy S24 256GB, OPPO Reno11 5G, Xiaomi Redmi Note 13
-- 7. Máy tính bảng: iPad 10.2 inch Wi-Fi 64GB, Samsung Galaxy Tab S9 FE, Xiaomi Pad 6 128GB
-- 8. Thiết bị nhà bếp: Nồi cơm điện tử Tefal 1.8L, Nồi chiên không dầu Philips 4.1L, Lò vi sóng có nướng Sharp 20L, Bếp từ đôi Kangaroo
-- 9. Thiết bị gia dụng: Máy hút bụi cầm tay Philips, Máy lọc nước RO Kangaroo 10 lõi, Quạt đứng Toshiba, Máy lọc không khí Xiaomi Elite
-- 10. Thiết bị âm thanh: Loa Bluetooth JBL Charge 5, Loa vi tính Microlab 2.1, Tai nghe Sony WH-1000XM5, Amply karaoke Boston Audio
-- 11. Thiết bị văn phòng: Máy in đa năng Canon LBP2900, Máy scan HP ScanJet Pro, Máy chiếu Epson EB-E01
-- 12. Phụ kiện điện tử: Chuột không dây Logitech M331, Bàn phím cơ DareU EK87, USB Kingston 64GB 3.2, Ổ cứng di động WD 1TB, Cáp HDMI 2.1 Ugreen 2m, Củ sạc nhanh Anker 30W Type-C
-- ============================================================

USE qlst_db;
SET FOREIGN_KEY_CHECKS = 0;

-- 1. Cập nhật các nhà cung cấp điện máy
DELETE FROM tblSupplier6;
INSERT INTO tblSupplier6 (id, name, address, phonenumber, email, contactperson) VALUES
(1, 'Công ty TNHH Điện tử Samsung Vina',       'Quận 1, TP. Hồ Chí Minh',       '02839157310', 'contact@samsung.com',   'Nguyễn Văn A'),
(2, 'Công ty TNHH LG Electronics Việt Nam',    'KCN Tràng Duệ, Hải Phòng',      '02253556688', 'b2b.lg@lge.com',        'Trần Thị B'),
(3, 'Công ty TNHH Sony Electronics Việt Nam',  'Quận 3, TP. Hồ Chí Minh',       '02838222227', 'sales@sony.com.vn',     'Lê Văn C'),
(4, 'Tập đoàn Công nghệ ASUS Việt Nam',        'Tòa nhà Viettel, Quận 10, HCM', '02838688668', 'support@asus.vn',       'Phạm Minh D'),
(5, 'Tập đoàn Apple Distribution International','Quận 1, TP. Hồ Chí Minh',      '18001127',    'orders@apple.com',      'Vũ Quang E'),
(6, 'Công ty Cổ phần Tập đoàn Daikin Việt Nam','Hà Đông, Hà Nội',               '02436888666', 'service@daikin.com.vn', 'Hoàng Gia F');

-- 2. Cập nhật danh sách sản phẩm Siêu thị điện máy (tblProduct6)
DELETE FROM tblProduct6;
INSERT INTO tblProduct6 (id, productname, productcategory, unit, importprice, sellinprice, remainingquatity, lowstockalert, description, image) VALUES
-- 1. Tivi
(1,  'Samsung Smart TV Crystal UHD 4K 55 inch', 'Tivi',              'Chiếc', 9500000,  12490000, 35,  5, 'Smart TV UHD 4K viền mỏng ba cạnh, công nghệ PurColor', 'tv_samsung_55.jpg'),
(2,  'Smart Tivi LG OLED 4K 65 inch',           'Tivi',              'Chiếc', 28000000, 34990000, 18,  3, 'Tivi OLED điểm ảnh tự phát sáng, âm thanh Dolby Atmos', 'tv_lg_oled_65.jpg'),
(3,  'Google Tivi Sony Bravia 4K 55 inch',      'Tivi',              'Chiếc', 11500000, 14990000, 24,  5, 'Bộ xử lý 4K HDR Processor X1, Motionflow XR 200',      'tv_sony_55.jpg'),
(4,  'Android Tivi TCL 4K 50 inch',             'Tivi',              'Chiếc', 5800000,  7690000,  30,  5, 'Màn hình 4K HDR, Dolby Audio, trợ lý giọng nói Google','tv_tcl_50.jpg'),

-- 2. Tủ lạnh
(5,  'Tủ lạnh Samsung Inverter 236L',           'Tủ lạnh',           'Chiếc', 4800000,  6290000,  25,  5, 'Công nghệ làm lạnh vòm All-around Cooling, khử mùi than hoạt tính', 'tulanh_samsung_236.jpg'),
(6,  'Tủ lạnh LG Inverter 394L',                'Tủ lạnh',           'Chiếc', 9200000,  11990000, 16,  3, 'Door Cooling làm lạnh nhanh từ cánh tủ, Inverter tiết kiệm điện',    'tulanh_lg_394.jpg'),
(7,  'Tủ lạnh Panasonic Inverter 325L',         'Tủ lạnh',           'Chiếc', 8900000,  11490000, 20,  4, 'Ngăn đông mềm Prime Fresh chuẩn -3 độ C diệt khuẩn Blue Ag+',        'tulanh_pana_325.jpg'),
(8,  'Tủ lạnh Toshiba Inverter 253L',           'Tủ lạnh',           'Chiếc', 5100000,  6690000,  22,  5, 'Công nghệ Air Fall Cooling làm lạnh đa chiều',                      'tulanh_toshiba_253.jpg'),

-- 3. Máy giặt
(9,  'Máy giặt LG Inverter Cửa trước 9kg',      'Máy giặt',          'Chiếc', 6800000,  8890000,  28,  5, 'Giặt hơi nước Steam diệt khuẩn 99.9%, động cơ truyền động trực tiếp','maygiat_lg_9kg.jpg'),
(10, 'Máy giặt Toshiba Cửa trên 8.2kg',         'Máy giặt',          'Chiếc', 3800000,  4990000,  32,  6, 'Lồng giặt ngôi sao pha lê, mâm giặt kháng khuẩn Mega Power',       'maygiat_toshiba_8kg.jpg'),
(11, 'Máy giặt sấy Samsung AddWash 9.5kg',      'Máy giặt',          'Chiếc', 11000000, 14290000, 15,  3, 'Cửa phụ thông minh AddDoor, giặt sấy 2 trong 1 tiện lợi',          'maygiat_samsung_add.jpg'),

-- 4. Điều hòa
(12, 'Điều hòa Daikin Inverter 1 HP',           'Điều hòa',          'Bộ',    7800000,  9990000,  30,  5, 'Luồng gió Coanda làm lạnh dễ chịu, phin lọc Enzyme Blue diệt khuẩn','dieuhoa_daikin_1hp.jpg'),
(13, 'Điều hòa Panasonic Inverter 1.5 HP',      'Điều hòa',          'Bộ',    10200000, 13190000, 20,  4, 'Công nghệ lọc khí Nanoe-X bảo vệ sức khỏe suốt 24 giờ',             'dieuhoa_pana_15hp.jpg'),
(14, 'Điều hòa Casper 1 HP',                    'Điều hòa',          'Bộ',    4200000,  5490000,  35,  6, 'Làm lạnh nhanh Super trong 30 giây, dàn tản nhiệt mạ vàng',        'dieuhoa_casper_1hp.jpg'),
(15, 'Điều hòa LG Inverter 1 HP',               'Điều hòa',          'Bộ',    6400000,  8190000,  26,  5, 'Dual Inverter tiết kiệm điện 70%, màng lọc bụi mịn PM 2.5',         'dieuhoa_lg_1hp.jpg'),

-- 5. Máy tính
(16, 'Laptop ASUS Vivobook 15 i5',              'Máy tính',          'Chiếc', 12500000, 15490000, 25,  5, 'Intel Core i5 Gen 13, 16GB RAM, 512GB SSD PCIe, màn 15.6 FHD',     'laptop_asus_v15.jpg'),
(17, 'Laptop Dell Inspiron 15 i5',              'Máy tính',          'Chiếc', 13000000, 16290000, 22,  4, 'Thiết kế bản lề nâng công thái học, độ bền chuẩn quân đội',         'laptop_dell_15.jpg'),
(18, 'Laptop HP Pavilion 14 i5',                'Máy tính',          'Chiếc', 12800000, 15990000, 20,  4, 'Vỏ nhôm nguyên khối mỏng nhẹ, âm thanh Bang & Olufsen đỉnh cao',   'laptop_hp_14.jpg'),
(19, 'Laptop Lenovo ThinkPad E14 i7',           'Máy tính',          'Chiếc', 17500000, 21990000, 15,  3, 'Độ tin cậy doanh nghiệp, bàn phím gõ êm ái hàng đầu thế giới',      'laptop_thinkpad_e14.jpg'),
(20, 'Máy tính để bàn HP ProTower Core i5',     'Máy tính',          'Bộ',    11200000, 13990000, 18,  3, 'Hiệu năng làm việc văn phòng mạnh mẽ, khả năng nâng cấp linh hoạt', 'pc_hp_protower.jpg'),

-- 6. Điện thoại
(21, 'iPhone 15 Pro 128GB',                     'Điện thoại',        'Chiếc', 21500000, 25490000, 40,  8, 'Khung vỏ Titan hàng không vũ trụ, chip Apple A17 Pro cực đỉnh',     'iphone_15_pro.jpg'),
(22, 'Samsung Galaxy S24 256GB',                'Điện thoại',        'Chiếc', 16000000, 19490000, 35,  6, 'Trí tuệ nhân tạo Galaxy AI đột phá, khung nhôm Armor Aluminum',     'samsung_s24.jpg'),
(23, 'OPPO Reno11 5G 256GB',                    'Điện thoại',        'Chiếc', 8200000,  10490000, 30,  5, 'Chuyên gia chân dung thần thái, sạc nhanh SuperVOOC 67W',          'oppo_reno11.jpg'),
(24, 'Xiaomi Redmi Note 13 128GB',              'Điện thoại',        'Chiếc', 3800000,  4890000,  50,  10,'Camera 108MP siêu nét, màn hình AMOLED 120Hz mượt mà',             'redmi_note13.jpg'),

-- 7. Máy tính bảng
(25, 'iPad 10.2 inch Wi-Fi 64GB',               'Máy tính bảng',     'Chiếc', 6900000,  8490000,  32,  6, 'Màn hình Retina sắc nét, hỗ trợ Apple Pencil và Smart Keyboard',    'ipad_102.jpg'),
(26, 'Samsung Galaxy Tab S9 FE 128GB',          'Máy tính bảng',     'Chiếc', 8400000,  10490000, 24,  4, 'Kháng nước chuẩn IP68, kèm sẵn bút S-Pen đa năng tiện lợi',         'tab_s9_fe.jpg'),
(27, 'Xiaomi Pad 6 128GB',                      'Máy tính bảng',     'Chiếc', 6800000,  8290000,  25,  5, 'Màn hình WQHD+ 144Hz siêu mượt, chip Snapdragon 870 mạnh mẽ',       'xiaomi_pad6.jpg'),

-- 8. Thiết bị nhà bếp
(28, 'Nồi cơm điện tử Tefal 1.8L',              'Thiết bị nhà bếp',  'Chiếc', 1200000,  1690000,  45,  10,'Lòng nồi niêu độc quyền 6 lớp, công nghệ nấu mâm nhiệt 3D chín đều', 'noicom_tefal_18.jpg'),
(29, 'Nồi chiên không dầu Philips 4.1L',        'Thiết bị nhà bếp',  'Chiếc', 1600000,  2190000,  40,  8, 'Công nghệ Rapid Air giảm đến 90% lượng dầu mỡ thừa có hại',        'noichien_philips.jpg'),
(30, 'Lò vi sóng có nướng Sharp 20L',           'Thiết bị nhà bếp',  'Chiếc', 1450000,  1890000,  30,  5, 'Dung tích 20L nhỏ gọn, kết hợp chức năng nướng giòn tiện dụng',    'lovisong_sharp.jpg'),
(31, 'Bếp từ đôi Kangaroo',                     'Thiết bị nhà bếp',  'Chiếc', 2900000,  3990000,  25,  5, 'Mặt kính Ceramic chịu lực chịu nhiệt, hẹn giờ nấu thông minh',      'beptu_kangaroo.jpg'),

-- 9. Thiết bị gia dụng
(32, 'Máy hút bụi cầm tay Philips',             'Thiết bị gia dụng', 'Chiếc', 2100000,  2790000,  35,  8, 'Động cơ PowerCyclone 7 hút lốc xoáy cực khỏe, pin dùng 40 phút',    'hutbui_philips.jpg'),
(33, 'Máy lọc nước RO Kangaroo 10 lõi',         'Thiết bị gia dụng', 'Chiếc', 3800000,  4990000,  20,  4, 'Màng RO Vortex tiết kiệm nước thải, bổ sung khoáng Hydrogen',      'locnuoc_kangaroo.jpg'),
(34, 'Quạt đứng Toshiba có điều khiển',         'Thiết bị gia dụng', 'Chiếc', 950000,   1350000,  50,  10,'Động cơ DC êm ái tiết kiệm điện, hẹn giờ bật tắt thông minh',      'quat_toshiba.jpg'),
(35, 'Máy lọc không khí Xiaomi Elite',          'Thiết bị gia dụng', 'Chiếc', 3200000,  4190000,  28,  5, 'Công nghệ UV-C LED diệt khuẩn 99.9%, lọc phấn hoa và bụi siêu mịn','lockhi_xiaomi.jpg'),

-- 10. Thiết bị âm thanh
(36, 'Loa Bluetooth JBL Charge 5',              'Thiết bị âm thanh', 'Chiếc', 2800000,  3690000,  40,  8, 'Âm thanh JBL Original Pro Sound sống động, chống nước bụi IP67',    'loa_jbl_charge5.jpg'),
(37, 'Loa vi tính Microlab 2.1',                'Thiết bị âm thanh', 'Bộ',    750000,   1090000,  55,  10,'Hệ thống âm thanh stereo mạnh mẽ, âm trầm ấm áp cuốn hút',         'loa_microlab_21.jpg'),
(38, 'Tai nghe Chống ồn Sony WH-1000XM5',       'Thiết bị âm thanh', 'Chiếc', 6200000,  7990000,  25,  5, 'Công nghệ chống ồn khử tạp âm hàng đầu thế giới, pin 30 giờ',      'tainghe_sony_xm5.jpg'),
(39, 'Amply karaoke Boston Audio',              'Thiết bị âm thanh', 'Chiếc', 4100000,  5390000,  18,  3, 'Bộ khuếch đại âm thanh chuyên nghiệp, chống hú rít hiệu quả',      'amply_boston.jpg'),

-- 11. Thiết bị văn phòng
(40, 'Máy in Laser đơn năng Canon LBP2900',     'Thiết bị văn phòng','Chiếc', 3100000,  3990000,  30,  5, 'Huyền thoại in ấn văn phòng siêu bền bỉ, tốc độ 12 trang/phút',     'mayin_canon_2900.jpg'),
(41, 'Máy scan HP ScanJet Pro 2600 f1',         'Thiết bị văn phòng','Chiếc', 5800000,  7490000,  15,  3, 'Khay nạp tài liệu tự động ADF 60 tờ, tốc độ quét 25 trang/phút',   'mayscan_hp_2600.jpg'),
(42, 'Máy chiếu Epson EB-E01 XGA',              'Thiết bị văn phòng','Chiếc', 7900000,  9990000,  16,  3, 'Công nghệ 3LCD cho màu sắc rực rỡ, độ sáng 3300 Ansi Lumens',       'maychieu_epson.jpg'),

-- 12. Phụ kiện điện tử
(43, 'Chuột không dây Logitech M331 Silent',    'Phụ kiện điện tử',  'Chiếc', 280000,   390000,   120, 20,'Nút bấm giảm 90% tiếng ồn click, thời lượng pin đến 24 tháng',     'chuot_logi_m331.jpg'),
(44, 'Bàn phím cơ DareU EK87 Tenkeyless',       'Phụ kiện điện tử',  'Chiếc', 420000,   590000,   90,  15,'D switch độ bền 50 triệu lần bấm, đèn nền LED rainbow bắt mắt',     'phim_dareu_ek87.jpg'),
(45, 'USB Kingston DataTraveler 64GB 3.2',      'Phụ kiện điện tử',  'Chiếc', 110000,   170000,   150, 30,'Tốc độ chuẩn USB 3.2 Gen 1 nhanh chóng, nắp xoay tiện lợi',         'usb_kingston_64.jpg'),
(46, 'Ổ cứng di động WD Elements 1TB 2.5',      'Phụ kiện điện tử',  'Chiếc', 1100000,  1490000,  60,  10,'Dung lượng lưu trữ 1TB an toàn, tương thích chuẩn kết nối USB 3.0', 'ocung_wd_1tb.jpg'),
(47, 'Cáp HDMI 2.1 Ugreen 8K 2m',               'Phụ kiện điện tử',  'Sợi',   180000,   260000,   100, 20,'Băng thông 48Gbps truyền tải hình ảnh 8K@60Hz mượt mà',             'cap_hdmi_ugreen.jpg'),
(48, 'Củ sạc nhanh Anker Nano Pro 30W Type-C',  'Phụ kiện điện tử',  'Củ',    260000,   390000,   110, 20,'Công nghệ sạc thông minh PowerIQ 3.0, kiểm soát nhiệt ActiveShield','sac_anker_30w.jpg');

-- 3. Cập nhật Hóa đơn bán tại quầy (InStoreSalesInvoice6) & Chi tiết
DELETE FROM tblInStoreSalesInvoiceDetail6;
DELETE FROM InStoreSalesInvoice6;

INSERT INTO InStoreSalesInvoice6 (id, saledate, totalamount, Salestaff6Member6id) VALUES
(101, '2026-10-02', 38760000, 7),
(102, '2026-10-06', 22040000, 7),
(103, '2026-10-11', 49760000, 7),
(104, '2026-10-15', 34260000, 7),
(105, '2026-10-19', 24670000, 7),
(106, '2026-10-24', 46350000, 7);

-- Chi tiết hóa đơn tại quầy
-- Hóa đơn 101: 1 Smart TV Samsung 55 (12,490,000) + 1 iPhone 15 Pro (25,490,000) + 2 Chuột Logitech M331 (390,000 x 2 = 780,000) = 38,760,000
INSERT INTO tblInStoreSalesInvoiceDetail6 (InStoreSalesInvoice6id, Product6id, quantity, unitprice) VALUES
(101, 1,  1, 12490000),
(101, 21, 1, 25490000),
(101, 43, 2, 390000);

-- Hóa đơn 102: 1 Tủ lạnh Samsung (6,290,000) + 1 Laptop Vivobook (15,490,000) + 1 Cáp HDMI Ugreen (260,000) = 22,040,000
INSERT INTO tblInStoreSalesInvoiceDetail6 (InStoreSalesInvoice6id, Product6id, quantity, unitprice) VALUES
(102, 5,  1, 6290000),
(102, 16, 1, 15490000),
(102, 47, 1, 260000);

-- Hóa đơn 103: 1 Tivi LG OLED 65 (34,990,000) + 1 Máy giặt LG 9kg (8,890,000) + 1 Loa JBL Charge 5 (3,690,000) + 1 Nồi chiên Philips (2,190,000) = 49,760,000
INSERT INTO tblInStoreSalesInvoiceDetail6 (InStoreSalesInvoice6id, Product6id, quantity, unitprice) VALUES
(103, 2,  1, 34990000),
(103, 9,  1, 8890000),
(103, 36, 1, 3690000),
(103, 29, 1, 2190000);

-- Hóa đơn 104: 1 iPhone 15 Pro (25,490,000) + 1 iPad 10.2 (8,490,000) + 1 Củ sạc Anker (280,000 giá ưu đãi) = 34,260,000
INSERT INTO tblInStoreSalesInvoiceDetail6 (InStoreSalesInvoice6id, Product6id, quantity, unitprice) VALUES
(104, 21, 1, 25490000),
(104, 25, 1, 8490000),
(104, 48, 1, 280000);

-- Hóa đơn 105: 1 Điều hòa Daikin (9,990,000) + 1 Điều hòa Panasonic (13,190,000) + 1 Ổ cứng WD 1TB (1,490,000) = 24,670,000
INSERT INTO tblInStoreSalesInvoiceDetail6 (InStoreSalesInvoice6id, Product6id, quantity, unitprice) VALUES
(105, 12, 1, 9990000),
(105, 13, 1, 13190000),
(105, 46, 1, 1490000);

-- Hóa đơn 106: 2 Laptop ASUS (15,490,000 x 2 = 30,980,000) + 2 Điều hòa Casper (5,490,000 x 2 = 10,980,000) + 1 Máy in Canon (3,990,000) + 1 Bàn phím DareU (400,000) = 46,350,000
INSERT INTO tblInStoreSalesInvoiceDetail6 (InStoreSalesInvoice6id, Product6id, quantity, unitprice) VALUES
(106, 16, 2, 15490000),
(106, 14, 2, 5490000),
(106, 40, 1, 3990000),
(106, 44, 1, 400000);


-- 4. Cập nhật Đơn hàng Online (tblOnlineOrder6, tblOnlineOrderDetail6, tblOnlineInvoice6)
DELETE FROM tblOnlineInvoice6;
DELETE FROM tblOnlineOrderDetail6;
DELETE FROM tblOnlineOrder6;

-- Đơn Online 201:
-- 1 Samsung S24 (19,490,000) + 1 Tab S9 FE (10,490,000) + 1 Tai nghe Sony XM5 (7,990,000)
-- Subtotal = 37,970,000, Ship = 50,000, Total = 38,020,000
INSERT INTO tblOnlineOrder6 (id, orderdate, deliveryaddress, status, shippingfee, subtotal, discount, totalamount, shippername, shipperphone, Salestaff6Member6id) VALUES
(201, '2026-10-04', 'Số 5 Lê Duẩn, Hoàn Kiếm, Hà Nội', 'Đã giao', 50000, 37970000, 0, 38020000, 'Lê Văn Tải', '0911223344', 7);

INSERT INTO tblOnlineOrderDetail6 (OnlineOrder6id, Product6id, quatity, unitprice) VALUES
(201, 22, 1, 19490000),
(201, 26, 1, 10490000),
(201, 38, 1, 7990000);

INSERT INTO tblOnlineInvoice6 (id, invoidate, status, totalamount, OnlineOrder6id) VALUES
(301, '2026-10-04', 'Đã thanh toán', 38020000, 201);


-- Đơn Online 202:
-- 2 Smart TV Samsung 55 (12,490,000 x 2 = 24,980,000) + 1 Máy lọc nước Kangaroo (4,990,000) + 1 Máy lọc khí Xiaomi (4,190,000)
-- Subtotal = 34,160,000, Giảm giá 500,000, Ship 100,000. Total = 33,760,000
INSERT INTO tblOnlineOrder6 (id, orderdate, deliveryaddress, status, shippingfee, subtotal, discount, totalamount, shippername, shipperphone, Salestaff6Member6id) VALUES
(202, '2026-10-13', '18 Phạm Hùng, Nam Từ Liêm, Hà Nội', 'Đã giao', 100000, 34160000, 500000, 33760000, 'Nguyễn Tuấn', '0922334455', 7);

INSERT INTO tblOnlineOrderDetail6 (OnlineOrder6id, Product6id, quatity, unitprice) VALUES
(202, 1,  2, 12490000),
(202, 33, 1, 4990000),
(202, 35, 1, 4190000);

INSERT INTO tblOnlineInvoice6 (id, invoidate, status, totalamount, OnlineOrder6id) VALUES
(302, '2026-10-13', 'Đã thanh toán', 33760000, 202);


-- Đơn Online 203:
-- 2 Laptop Dell Inspiron 15 (16,290,000 x 2 = 32,580,000) + 2 Chuột Logitech M331 (390,000 x 2 = 780,000) + 5 USB Kingston (170,000 x 5 = 850,000)
-- Subtotal = 34,210,000, Ship 0 (Freeship), Total = 34,210,000
INSERT INTO tblOnlineOrder6 (id, orderdate, deliveryaddress, status, shippingfee, subtotal, discount, totalamount, shippername, shipperphone, Salestaff6Member6id) VALUES
(203, '2026-10-18', '124 Hoàng Quốc Việt, Cầu Giấy, Hà Nội', 'Đã giao', 0, 34210000, 0, 34210000, 'Trần Long', '0933445566', 7);

INSERT INTO tblOnlineOrderDetail6 (OnlineOrder6id, Product6id, quatity, unitprice) VALUES
(203, 17, 2, 16290000),
(203, 43, 2, 390000),
(203, 45, 5, 170000);

INSERT INTO tblOnlineInvoice6 (id, invoidate, status, totalamount, OnlineOrder6id) VALUES
(303, '2026-10-18', 'Đã thanh toán', 34210000, 203);

SET FOREIGN_KEY_CHECKS = 1;

