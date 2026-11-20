-- ============================================================
-- DATABASE SCHEMA: Supermarket Management System (QLST)
-- Student ID (MSSV): 10B23DCCN646
-- Subject: System Analysis and Design (PTTKHT - PTIT)
-- Strictly mapped to: Physical Data Model (Image 1)
-- ============================================================

CREATE DATABASE IF NOT EXISTS qlst_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE qlst_db;

SET FOREIGN_KEY_CHECKS = 0;

-- XÃ³a cÃ¡c view/báº£ng cÅ© tiáº¿ng Viá»‡t náº¿u tá»“n táº¡i (Ä‘áº£m báº£o CSDL 100% chuáº©n tiáº¿ng Anh theo sÆ¡ Ä‘á»“)
DROP VIEW IF EXISTS ChiTietHoaDon;
DROP VIEW IF EXISTS HoaDon;
DROP VIEW IF EXISTS SanPham;
DROP VIEW IF EXISTS DanhMuc;
DROP VIEW IF EXISTS ThanhVien;

DROP TABLE IF EXISTS ChiTietHoaDon;
DROP TABLE IF EXISTS HoaDon;
DROP TABLE IF EXISTS SanPham;
DROP TABLE IF EXISTS DanhMuc;
DROP TABLE IF EXISTS ThanhVien;

-- XÃ³a cÃ¡c báº£ng tiáº¿ng Anh cÅ© Ä‘á»ƒ tÃ¡i táº¡o chuáº©n xÃ¡c theo sÆ¡ Ä‘á»“
DROP TABLE IF EXISTS tblGoodsReceiptDetail6;
DROP TABLE IF EXISTS tblGoodsReceiptNote6;
DROP TABLE IF EXISTS tblInStoreSalesInvoiceDetail6;
DROP TABLE IF EXISTS InStoreSalesInvoice6;
DROP TABLE IF EXISTS tblOnlineInvoice6;
DROP TABLE IF EXISTS tblOnlineOrderDetail6;
DROP TABLE IF EXISTS tblOnlineOrder6;
DROP TABLE IF EXISTS tblProduct6;
DROP TABLE IF EXISTS tblSupplier6;
DROP TABLE IF EXISTS tblWarehouseStaff6;
DROP TABLE IF EXISTS tblSalestaff6;
DROP TABLE IF EXISTS tblManager6;
DROP TABLE IF EXISTS tblEmployee6;
DROP TABLE IF EXISTS tblCustomer6;
DROP TABLE IF EXISTS tblMember6;

-- ------------------------------------------------------------
-- 1. Table: tblMember6 (Base class for all system users)
-- ------------------------------------------------------------
CREATE TABLE tblMember6 (
    id           INT          NOT NULL AUTO_INCREMENT,
    username     VARCHAR(255) NOT NULL UNIQUE,
    password     VARCHAR(255) NOT NULL,
    fullname     VARCHAR(255) NOT NULL,
    address      VARCHAR(255),
    dateOfBirth  DATE,
    email        VARCHAR(255) NOT NULL UNIQUE,
    phonenumber  VARCHAR(255) UNIQUE,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 2. Table: tblCustomer6 (Inherits tblMember6)
-- ------------------------------------------------------------
CREATE TABLE tblCustomer6 (
    Member6id                   INT  NOT NULL,
    membershipregistrationdate  DATE NOT NULL,
    PRIMARY KEY (Member6id),
    CONSTRAINT fk_customer_member FOREIGN KEY (Member6id) REFERENCES tblMember6(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 3. Table: tblEmployee6 (Inherits tblMember6)
-- ------------------------------------------------------------
CREATE TABLE tblEmployee6 (
    Member6id    INT          NOT NULL,
    jobposition  VARCHAR(255) NOT NULL,
    startdate    VARCHAR(255) NOT NULL,
    PRIMARY KEY (Member6id),
    CONSTRAINT fk_employee_member FOREIGN KEY (Member6id) REFERENCES tblMember6(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 4. Subclasses of tblEmployee6: tblManager6, tblSalestaff6, tblWarehouseStaff6
-- ------------------------------------------------------------
CREATE TABLE tblManager6 (
    Member6id INT NOT NULL,
    PRIMARY KEY (Member6id),
    CONSTRAINT fk_mgr_emp FOREIGN KEY (Member6id) REFERENCES tblEmployee6(Member6id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblSalestaff6 (
    Member6id INT NOT NULL,
    PRIMARY KEY (Member6id),
    CONSTRAINT fk_sales_emp FOREIGN KEY (Member6id) REFERENCES tblEmployee6(Member6id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblWarehouseStaff6 (
    Member6id INT NOT NULL,
    PRIMARY KEY (Member6id),
    CONSTRAINT fk_wh_emp FOREIGN KEY (Member6id) REFERENCES tblEmployee6(Member6id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 5. Table: tblSupplier6 (Product Supplier)
-- ------------------------------------------------------------
CREATE TABLE tblSupplier6 (
    id            INT          NOT NULL AUTO_INCREMENT,
    name          VARCHAR(255) NOT NULL,
    address       VARCHAR(255),
    phonenumber   VARCHAR(255),
    email         VARCHAR(255),
    contactperson VARCHAR(255),
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 6. Table: tblProduct6 (Product Entity)
-- ------------------------------------------------------------
CREATE TABLE tblProduct6 (
    id               INT          NOT NULL AUTO_INCREMENT,
    productname      VARCHAR(255) NOT NULL,
    productcategory  VARCHAR(255) NOT NULL,
    unit             VARCHAR(255) NOT NULL DEFAULT 'CÃ¡i',
    importprice      DOUBLE       NOT NULL DEFAULT 0,
    sellinprice      DOUBLE       NOT NULL DEFAULT 0,
    remainingquatity INT          NOT NULL DEFAULT 0,
    lowstockalert    INT          NOT NULL DEFAULT 10,
    description      VARCHAR(255),
    image            VARCHAR(255),
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 7. Table: tblOnlineOrder6 (Online Orders managed by Salestaff)
-- ------------------------------------------------------------
CREATE TABLE tblOnlineOrder6 (
    id                   INT          NOT NULL AUTO_INCREMENT,
    orderdate            DATE         NOT NULL,
    deliveryaddress      VARCHAR(255) NOT NULL,
    status               VARCHAR(255) NOT NULL DEFAULT 'ÄÃ£ giao',
    shippingfee          DOUBLE       DEFAULT 0,
    subtotal             DOUBLE       DEFAULT 0,
    discount             DOUBLE       DEFAULT 0,
    totalamount          DOUBLE       NOT NULL DEFAULT 0,
    shippername          VARCHAR(255),
    shipperphone         VARCHAR(255),
    Salestaff6Member6id  INT          NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_order_sales FOREIGN KEY (Salestaff6Member6id) REFERENCES tblSalestaff6(Member6id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 8. Table: tblOnlineOrderDetail6 (Online Order Line Items)
-- ------------------------------------------------------------
CREATE TABLE tblOnlineOrderDetail6 (
    id             INT    NOT NULL AUTO_INCREMENT,
    quatity        INT    NOT NULL DEFAULT 1,
    unitprice      DOUBLE NOT NULL DEFAULT 0,
    OnlineOrder6id INT    NOT NULL,
    Product6id     INT    NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_ood_order FOREIGN KEY (OnlineOrder6id) REFERENCES tblOnlineOrder6(id) ON DELETE CASCADE,
    CONSTRAINT fk_ood_prod  FOREIGN KEY (Product6id) REFERENCES tblProduct6(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 9. Table: tblOnlineInvoice6 (Online Sales Invoice)
-- ------------------------------------------------------------
CREATE TABLE tblOnlineInvoice6 (
    id             INT          NOT NULL AUTO_INCREMENT,
    invoidate      DATE         NOT NULL,
    status         VARCHAR(255) NOT NULL DEFAULT 'ÄÃ£ thanh toÃ¡n',
    totalamount    DOUBLE       NOT NULL DEFAULT 0,
    OnlineOrder6id INT          NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_oinv_order FOREIGN KEY (OnlineOrder6id) REFERENCES tblOnlineOrder6(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 10. Table: InStoreSalesInvoice6 (In-store checkout invoice)
-- ------------------------------------------------------------
CREATE TABLE InStoreSalesInvoice6 (
    id                   INT    NOT NULL AUTO_INCREMENT,
    saledate             DATE   NOT NULL,
    totalamount          DOUBLE NOT NULL DEFAULT 0,
    Salestaff6Member6id  INT    NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_isales_staff FOREIGN KEY (Salestaff6Member6id) REFERENCES tblSalestaff6(Member6id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 11. Table: tblInStoreSalesInvoiceDetail6 (In-store invoice details)
-- ------------------------------------------------------------
CREATE TABLE tblInStoreSalesInvoiceDetail6 (
    id                     INT    NOT NULL AUTO_INCREMENT,
    quantity               INT    NOT NULL DEFAULT 1,
    unitprice              DOUBLE NOT NULL DEFAULT 0,
    InStoreSalesInvoice6id INT    NOT NULL,
    Product6id             INT    NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_isd_inv  FOREIGN KEY (InStoreSalesInvoice6id) REFERENCES InStoreSalesInvoice6(id) ON DELETE CASCADE,
    CONSTRAINT fk_isd_prod FOREIGN KEY (Product6id) REFERENCES tblProduct6(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 12. Table: tblGoodsReceiptNote6 (Warehouse Goods Receipt)
-- ------------------------------------------------------------
CREATE TABLE tblGoodsReceiptNote6 (
    id                         INT    NOT NULL AUTO_INCREMENT,
    receiveddate               DATE   NOT NULL,
    totalamount                DOUBLE NOT NULL DEFAULT 0,
    WarehouseStaff6Member6id   INT    NOT NULL,
    Supplier6id                INT    NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_grn_wh  FOREIGN KEY (WarehouseStaff6Member6id) REFERENCES tblWarehouseStaff6(Member6id),
    CONSTRAINT fk_grn_sup FOREIGN KEY (Supplier6id) REFERENCES tblSupplier6(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 13. Table: tblGoodsReceiptDetail6 (Warehouse Receipt Details)
-- ------------------------------------------------------------
CREATE TABLE tblGoodsReceiptDetail6 (
    id                    INT          NOT NULL AUTO_INCREMENT,
    receivedquatity       INT          NOT NULL DEFAULT 0,
    unitprice             VARCHAR(255) NOT NULL,
    GoodsReceiptNote6id   INT          NOT NULL,
    Product6id            INT          NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_grd_note FOREIGN KEY (GoodsReceiptNote6id) REFERENCES tblGoodsReceiptNote6(id) ON DELETE CASCADE,
    CONSTRAINT fk_grd_prod FOREIGN KEY (Product6id) REFERENCES tblProduct6(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- Dá»® LIá»†U MáºªU CHUáº¨N XÃC THEO MÃ” HÃŒNH PHÃ‚N TÃCH
-- ============================================================

-- ThÃ nh viÃªn & KhÃ¡ch hÃ ng
INSERT INTO tblMember6 (id, username, password, fullname, address, dateOfBirth, email, phonenumber) VALUES
(1, 'an.nguyen',   '123456', 'Nguyá»…n VÄƒn An',   'Sá»‘ 12 ChÃ¹a Bá»™c, HÃ  Ná»™i',       '1995-05-10', 'an.nguyen@gmail.com',   '0901234567'),
(2, 'binh.tran',   '123456', 'Tráº§n Thá»‹ BÃ¬nh',   '25 Nguyá»…n TrÃ£i, Thanh XuÃ¢n',   '1998-08-20', 'binh.tran@gmail.com',   '0912345678'),
(3, 'cuong.le',    '123456', 'LÃª VÄƒn CÆ°á»ng',    '108 Tráº§n PhÃº, HÃ  ÄÃ´ng',        '1992-02-14', 'cuong.le@gmail.com',    '0923456789'),
(4, 'ha.pham',     '123456', 'Pháº¡m Thu HÃ ',     '72 Cáº§u Giáº¥y, HÃ  Ná»™i',          '2000-11-25', 'ha.pham@gmail.com',     '0934567890'),
(5, 'duc.hoang',   '123456', 'HoÃ ng Minh Äá»©c',  '55 Giáº£i PhÃ³ng, Hai BÃ  TrÆ°ng',  '1994-09-08', 'duc.hoang@gmail.com',   '0945678901'),
(6, 'manager01',   'admin123', 'Tráº§n Quáº£n LÃ½',  'HÃ  Ná»™i',                       '1985-01-01', 'manager@qlst.vn',       '0988888888'),
(7, 'sales01',     'sales123', 'Nguyá»…n BÃ¡n HÃ ng', 'HÃ  Ná»™i',                     '1997-03-15', 'sales@qlst.vn',         '0977777777'),
(8, 'warehouse01', 'wh123',    'LÃª Thá»§ Kho',     'HÃ  Ná»™i',                      '1993-07-20', 'warehouse@qlst.vn',     '0966666666');

INSERT INTO tblCustomer6 (Member6id, membershipregistrationdate) VALUES
(1, '2026-01-10'),
(2, '2026-02-15'),
(3, '2026-03-01'),
(4, '2026-04-12'),
(5, '2026-05-20');

INSERT INTO tblEmployee6 (Member6id, jobposition, startdate) VALUES
(6, 'Manager',        '2020-01-01'),
(7, 'Sales Staff',    '2022-03-01'),
(8, 'Warehouse Staff','2021-06-01');

INSERT INTO tblManager6 (Member6id) VALUES (6);
INSERT INTO tblSalestaff6 (Member6id) VALUES (7);
INSERT INTO tblWarehouseStaff6 (Member6id) VALUES (8);

-- ============================================================
-- Cáº¬P NHáº¬T CÆ  Sá»ž Dá»® LIá»†U SANG Há»† THá»NG SIÃŠU THá»Š ÄIá»†N MÃY
-- MSSV: 10B23DCCN646 - PTIT
-- PhÃ¹ há»£p chÃ­nh xÃ¡c vá»›i báº£ng 12 loáº¡i máº·t hÃ ng:
-- 1. Tivi: Samsung Smart TV Crystal UHD 4K 55 inch, Smart Tivi LG OLED 4K 65 inch, Google Tivi Sony Bravia 4K 55 inch, Android Tivi TCL 4K 50 inch
-- 2. Tá»§ láº¡nh: Tá»§ láº¡nh Samsung Inverter 236L, Tá»§ láº¡nh LG Inverter 394L, Tá»§ láº¡nh Panasonic Inverter 325L, Tá»§ láº¡nh Toshiba Inverter 253L
-- 3. MÃ¡y giáº·t: MÃ¡y giáº·t LG Inverter Cá»­a trÆ°á»›c 9kg, MÃ¡y giáº·t Toshiba Cá»­a trÃªn 8.2kg, MÃ¡y giáº·t sáº¥y Samsung AddWash 9.5kg
-- 4. Äiá»u hÃ²a: Äiá»u hÃ²a Daikin Inverter 1 HP, Äiá»u hÃ²a Panasonic Inverter 1.5 HP, Äiá»u hÃ²a Casper 1 HP, Äiá»u hÃ²a LG Inverter 1 HP
-- 5. MÃ¡y tÃ­nh: Laptop ASUS Vivobook 15, Laptop Dell Inspiron 15, Laptop HP Pavilion 14, Laptop Lenovo ThinkPad E14, MÃ¡y tÃ­nh Ä‘á»ƒ bÃ n HP ProTower
-- 6. Äiá»‡n thoáº¡i: iPhone 15 Pro 128GB, Samsung Galaxy S24 256GB, OPPO Reno11 5G, Xiaomi Redmi Note 13
-- 7. MÃ¡y tÃ­nh báº£ng: iPad 10.2 inch Wi-Fi 64GB, Samsung Galaxy Tab S9 FE, Xiaomi Pad 6 128GB
-- 8. Thiáº¿t bá»‹ nhÃ  báº¿p: Ná»“i cÆ¡m Ä‘iá»‡n tá»­ Tefal 1.8L, Ná»“i chiÃªn khÃ´ng dáº§u Philips 4.1L, LÃ² vi sÃ³ng cÃ³ nÆ°á»›ng Sharp 20L, Báº¿p tá»« Ä‘Ã´i Kangaroo
-- 9. Thiáº¿t bá»‹ gia dá»¥ng: MÃ¡y hÃºt bá»¥i cáº§m tay Philips, MÃ¡y lá»c nÆ°á»›c RO Kangaroo 10 lÃµi, Quáº¡t Ä‘á»©ng Toshiba, MÃ¡y lá»c khÃ´ng khÃ­ Xiaomi Elite
-- 10. Thiáº¿t bá»‹ Ã¢m thanh: Loa Bluetooth JBL Charge 5, Loa vi tÃ­nh Microlab 2.1, Tai nghe Sony WH-1000XM5, Amply karaoke Boston Audio
-- 11. Thiáº¿t bá»‹ vÄƒn phÃ²ng: MÃ¡y in Ä‘a nÄƒng Canon LBP2900, MÃ¡y scan HP ScanJet Pro, MÃ¡y chiáº¿u Epson EB-E01
-- 12. Phá»¥ kiá»‡n Ä‘iá»‡n tá»­: Chuá»™t khÃ´ng dÃ¢y Logitech M331, BÃ n phÃ­m cÆ¡ DareU EK87, USB Kingston 64GB 3.2, á»” cá»©ng di Ä‘á»™ng WD 1TB, CÃ¡p HDMI 2.1 Ugreen 2m, Cá»§ sáº¡c nhanh Anker 30W Type-C
-- ============================================================

USE qlst_db;
SET FOREIGN_KEY_CHECKS = 0;

-- 1. Cáº­p nháº­t cÃ¡c nhÃ  cung cáº¥p Ä‘iá»‡n mÃ¡y
DELETE FROM tblSupplier6;
INSERT INTO tblSupplier6 (id, name, address, phonenumber, email, contactperson) VALUES
(1, 'CÃ´ng ty TNHH Äiá»‡n tá»­ Samsung Vina',       'Quáº­n 1, TP. Há»“ ChÃ­ Minh',       '02839157310', 'contact@samsung.com',   'Nguyá»…n VÄƒn A'),
(2, 'CÃ´ng ty TNHH LG Electronics Viá»‡t Nam',    'KCN TrÃ ng Duá»‡, Háº£i PhÃ²ng',      '02253556688', 'b2b.lg@lge.com',        'Tráº§n Thá»‹ B'),
(3, 'CÃ´ng ty TNHH Sony Electronics Viá»‡t Nam',  'Quáº­n 3, TP. Há»“ ChÃ­ Minh',       '02838222227', 'sales@sony.com.vn',     'LÃª VÄƒn C'),
(4, 'Táº­p Ä‘oÃ n CÃ´ng nghá»‡ ASUS Viá»‡t Nam',        'TÃ²a nhÃ  Viettel, Quáº­n 10, HCM', '02838688668', 'support@asus.vn',       'Pháº¡m Minh D'),
(5, 'Táº­p Ä‘oÃ n Apple Distribution International','Quáº­n 1, TP. Há»“ ChÃ­ Minh',      '18001127',    'orders@apple.com',      'VÅ© Quang E'),
(6, 'CÃ´ng ty Cá»• pháº§n Táº­p Ä‘oÃ n Daikin Viá»‡t Nam','HÃ  ÄÃ´ng, HÃ  Ná»™i',               '02436888666', 'service@daikin.com.vn', 'HoÃ ng Gia F');

-- 2. Cáº­p nháº­t danh sÃ¡ch sáº£n pháº©m SiÃªu thá»‹ Ä‘iá»‡n mÃ¡y (tblProduct6)
DELETE FROM tblProduct6;
INSERT INTO tblProduct6 (id, productname, productcategory, unit, importprice, sellinprice, remainingquatity, lowstockalert, description, image) VALUES
-- 1. Tivi
(1,  'Samsung Smart TV Crystal UHD 4K 55 inch', 'Tivi',              'Chiáº¿c', 9500000,  12490000, 35,  5, 'Smart TV UHD 4K viá»n má»ng ba cáº¡nh, cÃ´ng nghá»‡ PurColor', 'tv_samsung_55.jpg'),
(2,  'Smart Tivi LG OLED 4K 65 inch',           'Tivi',              'Chiáº¿c', 28000000, 34990000, 18,  3, 'Tivi OLED Ä‘iá»ƒm áº£nh tá»± phÃ¡t sÃ¡ng, Ã¢m thanh Dolby Atmos', 'tv_lg_oled_65.jpg'),
(3,  'Google Tivi Sony Bravia 4K 55 inch',      'Tivi',              'Chiáº¿c', 11500000, 14990000, 24,  5, 'Bá»™ xá»­ lÃ½ 4K HDR Processor X1, Motionflow XR 200',      'tv_sony_55.jpg'),
(4,  'Android Tivi TCL 4K 50 inch',             'Tivi',              'Chiáº¿c', 5800000,  7690000,  30,  5, 'MÃ n hÃ¬nh 4K HDR, Dolby Audio, trá»£ lÃ½ giá»ng nÃ³i Google','tv_tcl_50.jpg'),

-- 2. Tá»§ láº¡nh
(5,  'Tá»§ láº¡nh Samsung Inverter 236L',           'Tá»§ láº¡nh',           'Chiáº¿c', 4800000,  6290000,  25,  5, 'CÃ´ng nghá»‡ lÃ m láº¡nh vÃ²m All-around Cooling, khá»­ mÃ¹i than hoáº¡t tÃ­nh', 'tulanh_samsung_236.jpg'),
(6,  'Tá»§ láº¡nh LG Inverter 394L',                'Tá»§ láº¡nh',           'Chiáº¿c', 9200000,  11990000, 16,  3, 'Door Cooling lÃ m láº¡nh nhanh tá»« cÃ¡nh tá»§, Inverter tiáº¿t kiá»‡m Ä‘iá»‡n',    'tulanh_lg_394.jpg'),
(7,  'Tá»§ láº¡nh Panasonic Inverter 325L',         'Tá»§ láº¡nh',           'Chiáº¿c', 8900000,  11490000, 20,  4, 'NgÄƒn Ä‘Ã´ng má»m Prime Fresh chuáº©n -3 Ä‘á»™ C diá»‡t khuáº©n Blue Ag+',        'tulanh_pana_325.jpg'),
(8,  'Tá»§ láº¡nh Toshiba Inverter 253L',           'Tá»§ láº¡nh',           'Chiáº¿c', 5100000,  6690000,  22,  5, 'CÃ´ng nghá»‡ Air Fall Cooling lÃ m láº¡nh Ä‘a chiá»u',                      'tulanh_toshiba_253.jpg'),

-- 3. MÃ¡y giáº·t
(9,  'MÃ¡y giáº·t LG Inverter Cá»­a trÆ°á»›c 9kg',      'MÃ¡y giáº·t',          'Chiáº¿c', 6800000,  8890000,  28,  5, 'Giáº·t hÆ¡i nÆ°á»›c Steam diá»‡t khuáº©n 99.9%, Ä‘á»™ng cÆ¡ truyá»n Ä‘á»™ng trá»±c tiáº¿p','maygiat_lg_9kg.jpg'),
(10, 'MÃ¡y giáº·t Toshiba Cá»­a trÃªn 8.2kg',         'MÃ¡y giáº·t',          'Chiáº¿c', 3800000,  4990000,  32,  6, 'Lá»“ng giáº·t ngÃ´i sao pha lÃª, mÃ¢m giáº·t khÃ¡ng khuáº©n Mega Power',       'maygiat_toshiba_8kg.jpg'),
(11, 'MÃ¡y giáº·t sáº¥y Samsung AddWash 9.5kg',      'MÃ¡y giáº·t',          'Chiáº¿c', 11000000, 14290000, 15,  3, 'Cá»­a phá»¥ thÃ´ng minh AddDoor, giáº·t sáº¥y 2 trong 1 tiá»‡n lá»£i',          'maygiat_samsung_add.jpg'),

-- 4. Äiá»u hÃ²a
(12, 'Äiá»u hÃ²a Daikin Inverter 1 HP',           'Äiá»u hÃ²a',          'Bá»™',    7800000,  9990000,  30,  5, 'Luá»“ng giÃ³ Coanda lÃ m láº¡nh dá»… chá»‹u, phin lá»c Enzyme Blue diá»‡t khuáº©n','dieuhoa_daikin_1hp.jpg'),
(13, 'Äiá»u hÃ²a Panasonic Inverter 1.5 HP',      'Äiá»u hÃ²a',          'Bá»™',    10200000, 13190000, 20,  4, 'CÃ´ng nghá»‡ lá»c khÃ­ Nanoe-X báº£o vá»‡ sá»©c khá»e suá»‘t 24 giá»',             'dieuhoa_pana_15hp.jpg'),
(14, 'Äiá»u hÃ²a Casper 1 HP',                    'Äiá»u hÃ²a',          'Bá»™',    4200000,  5490000,  35,  6, 'LÃ m láº¡nh nhanh Super trong 30 giÃ¢y, dÃ n táº£n nhiá»‡t máº¡ vÃ ng',        'dieuhoa_casper_1hp.jpg'),
(15, 'Äiá»u hÃ²a LG Inverter 1 HP',               'Äiá»u hÃ²a',          'Bá»™',    6400000,  8190000,  26,  5, 'Dual Inverter tiáº¿t kiá»‡m Ä‘iá»‡n 70%, mÃ ng lá»c bá»¥i má»‹n PM 2.5',         'dieuhoa_lg_1hp.jpg'),

-- 5. MÃ¡y tÃ­nh
(16, 'Laptop ASUS Vivobook 15 i5',              'MÃ¡y tÃ­nh',          'Chiáº¿c', 12500000, 15490000, 25,  5, 'Intel Core i5 Gen 13, 16GB RAM, 512GB SSD PCIe, mÃ n 15.6 FHD',     'laptop_asus_v15.jpg'),
(17, 'Laptop Dell Inspiron 15 i5',              'MÃ¡y tÃ­nh',          'Chiáº¿c', 13000000, 16290000, 22,  4, 'Thiáº¿t káº¿ báº£n lá» nÃ¢ng cÃ´ng thÃ¡i há»c, Ä‘á»™ bá»n chuáº©n quÃ¢n Ä‘á»™i',         'laptop_dell_15.jpg'),
(18, 'Laptop HP Pavilion 14 i5',                'MÃ¡y tÃ­nh',          'Chiáº¿c', 12800000, 15990000, 20,  4, 'Vá» nhÃ´m nguyÃªn khá»‘i má»ng nháº¹, Ã¢m thanh Bang & Olufsen Ä‘á»‰nh cao',   'laptop_hp_14.jpg'),
(19, 'Laptop Lenovo ThinkPad E14 i7',           'MÃ¡y tÃ­nh',          'Chiáº¿c', 17500000, 21990000, 15,  3, 'Äá»™ tin cáº­y doanh nghiá»‡p, bÃ n phÃ­m gÃµ Ãªm Ã¡i hÃ ng Ä‘áº§u tháº¿ giá»›i',      'laptop_thinkpad_e14.jpg'),
(20, 'MÃ¡y tÃ­nh Ä‘á»ƒ bÃ n HP ProTower Core i5',     'MÃ¡y tÃ­nh',          'Bá»™',    11200000, 13990000, 18,  3, 'Hiá»‡u nÄƒng lÃ m viá»‡c vÄƒn phÃ²ng máº¡nh máº½, kháº£ nÄƒng nÃ¢ng cáº¥p linh hoáº¡t', 'pc_hp_protower.jpg'),

-- 6. Äiá»‡n thoáº¡i
(21, 'iPhone 15 Pro 128GB',                     'Äiá»‡n thoáº¡i',        'Chiáº¿c', 21500000, 25490000, 40,  8, 'Khung vá» Titan hÃ ng khÃ´ng vÅ© trá»¥, chip Apple A17 Pro cá»±c Ä‘á»‰nh',     'iphone_15_pro.jpg'),
(22, 'Samsung Galaxy S24 256GB',                'Äiá»‡n thoáº¡i',        'Chiáº¿c', 16000000, 19490000, 35,  6, 'TrÃ­ tuá»‡ nhÃ¢n táº¡o Galaxy AI Ä‘á»™t phÃ¡, khung nhÃ´m Armor Aluminum',     'samsung_s24.jpg'),
(23, 'OPPO Reno11 5G 256GB',                    'Äiá»‡n thoáº¡i',        'Chiáº¿c', 8200000,  10490000, 30,  5, 'ChuyÃªn gia chÃ¢n dung tháº§n thÃ¡i, sáº¡c nhanh SuperVOOC 67W',          'oppo_reno11.jpg'),
(24, 'Xiaomi Redmi Note 13 128GB',              'Äiá»‡n thoáº¡i',        'Chiáº¿c', 3800000,  4890000,  50,  10,'Camera 108MP siÃªu nÃ©t, mÃ n hÃ¬nh AMOLED 120Hz mÆ°á»£t mÃ ',             'redmi_note13.jpg'),

-- 7. MÃ¡y tÃ­nh báº£ng
(25, 'iPad 10.2 inch Wi-Fi 64GB',               'MÃ¡y tÃ­nh báº£ng',     'Chiáº¿c', 6900000,  8490000,  32,  6, 'MÃ n hÃ¬nh Retina sáº¯c nÃ©t, há»— trá»£ Apple Pencil vÃ  Smart Keyboard',    'ipad_102.jpg'),
(26, 'Samsung Galaxy Tab S9 FE 128GB',          'MÃ¡y tÃ­nh báº£ng',     'Chiáº¿c', 8400000,  10490000, 24,  4, 'KhÃ¡ng nÆ°á»›c chuáº©n IP68, kÃ¨m sáºµn bÃºt S-Pen Ä‘a nÄƒng tiá»‡n lá»£i',         'tab_s9_fe.jpg'),
(27, 'Xiaomi Pad 6 128GB',                      'MÃ¡y tÃ­nh báº£ng',     'Chiáº¿c', 6800000,  8290000,  25,  5, 'MÃ n hÃ¬nh WQHD+ 144Hz siÃªu mÆ°á»£t, chip Snapdragon 870 máº¡nh máº½',       'xiaomi_pad6.jpg'),

-- 8. Thiáº¿t bá»‹ nhÃ  báº¿p
(28, 'Ná»“i cÆ¡m Ä‘iá»‡n tá»­ Tefal 1.8L',              'Thiáº¿t bá»‹ nhÃ  báº¿p',  'Chiáº¿c', 1200000,  1690000,  45,  10,'LÃ²ng ná»“i niÃªu Ä‘á»™c quyá»n 6 lá»›p, cÃ´ng nghá»‡ náº¥u mÃ¢m nhiá»‡t 3D chÃ­n Ä‘á»u', 'noicom_tefal_18.jpg'),
(29, 'Ná»“i chiÃªn khÃ´ng dáº§u Philips 4.1L',        'Thiáº¿t bá»‹ nhÃ  báº¿p',  'Chiáº¿c', 1600000,  2190000,  40,  8, 'CÃ´ng nghá»‡ Rapid Air giáº£m Ä‘áº¿n 90% lÆ°á»£ng dáº§u má»¡ thá»«a cÃ³ háº¡i',        'noichien_philips.jpg'),
(30, 'LÃ² vi sÃ³ng cÃ³ nÆ°á»›ng Sharp 20L',           'Thiáº¿t bá»‹ nhÃ  báº¿p',  'Chiáº¿c', 1450000,  1890000,  30,  5, 'Dung tÃ­ch 20L nhá» gá»n, káº¿t há»£p chá»©c nÄƒng nÆ°á»›ng giÃ²n tiá»‡n dá»¥ng',    'lovisong_sharp.jpg'),
(31, 'Báº¿p tá»« Ä‘Ã´i Kangaroo',                     'Thiáº¿t bá»‹ nhÃ  báº¿p',  'Chiáº¿c', 2900000,  3990000,  25,  5, 'Máº·t kÃ­nh Ceramic chá»‹u lá»±c chá»‹u nhiá»‡t, háº¹n giá» náº¥u thÃ´ng minh',      'beptu_kangaroo.jpg'),

-- 9. Thiáº¿t bá»‹ gia dá»¥ng
(32, 'MÃ¡y hÃºt bá»¥i cáº§m tay Philips',             'Thiáº¿t bá»‹ gia dá»¥ng', 'Chiáº¿c', 2100000,  2790000,  35,  8, 'Äá»™ng cÆ¡ PowerCyclone 7 hÃºt lá»‘c xoÃ¡y cá»±c khá»e, pin dÃ¹ng 40 phÃºt',    'hutbui_philips.jpg'),
(33, 'MÃ¡y lá»c nÆ°á»›c RO Kangaroo 10 lÃµi',         'Thiáº¿t bá»‹ gia dá»¥ng', 'Chiáº¿c', 3800000,  4990000,  20,  4, 'MÃ ng RO Vortex tiáº¿t kiá»‡m nÆ°á»›c tháº£i, bá»• sung khoÃ¡ng Hydrogen',      'locnuoc_kangaroo.jpg'),
(34, 'Quáº¡t Ä‘á»©ng Toshiba cÃ³ Ä‘iá»u khiá»ƒn',         'Thiáº¿t bá»‹ gia dá»¥ng', 'Chiáº¿c', 950000,   1350000,  50,  10,'Äá»™ng cÆ¡ DC Ãªm Ã¡i tiáº¿t kiá»‡m Ä‘iá»‡n, háº¹n giá» báº­t táº¯t thÃ´ng minh',      'quat_toshiba.jpg'),
(35, 'MÃ¡y lá»c khÃ´ng khÃ­ Xiaomi Elite',          'Thiáº¿t bá»‹ gia dá»¥ng', 'Chiáº¿c', 3200000,  4190000,  28,  5, 'CÃ´ng nghá»‡ UV-C LED diá»‡t khuáº©n 99.9%, lá»c pháº¥n hoa vÃ  bá»¥i siÃªu má»‹n','lockhi_xiaomi.jpg'),

-- 10. Thiáº¿t bá»‹ Ã¢m thanh
(36, 'Loa Bluetooth JBL Charge 5',              'Thiáº¿t bá»‹ Ã¢m thanh', 'Chiáº¿c', 2800000,  3690000,  40,  8, 'Ã‚m thanh JBL Original Pro Sound sá»‘ng Ä‘á»™ng, chá»‘ng nÆ°á»›c bá»¥i IP67',    'loa_jbl_charge5.jpg'),
(37, 'Loa vi tÃ­nh Microlab 2.1',                'Thiáº¿t bá»‹ Ã¢m thanh', 'Bá»™',    750000,   1090000,  55,  10,'Há»‡ thá»‘ng Ã¢m thanh stereo máº¡nh máº½, Ã¢m tráº§m áº¥m Ã¡p cuá»‘n hÃºt',         'loa_microlab_21.jpg'),
(38, 'Tai nghe Chá»‘ng á»“n Sony WH-1000XM5',       'Thiáº¿t bá»‹ Ã¢m thanh', 'Chiáº¿c', 6200000,  7990000,  25,  5, 'CÃ´ng nghá»‡ chá»‘ng á»“n khá»­ táº¡p Ã¢m hÃ ng Ä‘áº§u tháº¿ giá»›i, pin 30 giá»',      'tainghe_sony_xm5.jpg'),
(39, 'Amply karaoke Boston Audio',              'Thiáº¿t bá»‹ Ã¢m thanh', 'Chiáº¿c', 4100000,  5390000,  18,  3, 'Bá»™ khuáº¿ch Ä‘áº¡i Ã¢m thanh chuyÃªn nghiá»‡p, chá»‘ng hÃº rÃ­t hiá»‡u quáº£',      'amply_boston.jpg'),

-- 11. Thiáº¿t bá»‹ vÄƒn phÃ²ng
(40, 'MÃ¡y in Laser Ä‘Æ¡n nÄƒng Canon LBP2900',     'Thiáº¿t bá»‹ vÄƒn phÃ²ng','Chiáº¿c', 3100000,  3990000,  30,  5, 'Huyá»n thoáº¡i in áº¥n vÄƒn phÃ²ng siÃªu bá»n bá»‰, tá»‘c Ä‘á»™ 12 trang/phÃºt',     'mayin_canon_2900.jpg'),
(41, 'MÃ¡y scan HP ScanJet Pro 2600 f1',         'Thiáº¿t bá»‹ vÄƒn phÃ²ng','Chiáº¿c', 5800000,  7490000,  15,  3, 'Khay náº¡p tÃ i liá»‡u tá»± Ä‘á»™ng ADF 60 tá», tá»‘c Ä‘á»™ quÃ©t 25 trang/phÃºt',   'mayscan_hp_2600.jpg'),
(42, 'MÃ¡y chiáº¿u Epson EB-E01 XGA',              'Thiáº¿t bá»‹ vÄƒn phÃ²ng','Chiáº¿c', 7900000,  9990000,  16,  3, 'CÃ´ng nghá»‡ 3LCD cho mÃ u sáº¯c rá»±c rá»¡, Ä‘á»™ sÃ¡ng 3300 Ansi Lumens',       'maychieu_epson.jpg'),

-- 12. Phá»¥ kiá»‡n Ä‘iá»‡n tá»­
(43, 'Chuá»™t khÃ´ng dÃ¢y Logitech M331 Silent',    'Phá»¥ kiá»‡n Ä‘iá»‡n tá»­',  'Chiáº¿c', 280000,   390000,   120, 20,'NÃºt báº¥m giáº£m 90% tiáº¿ng á»“n click, thá»i lÆ°á»£ng pin Ä‘áº¿n 24 thÃ¡ng',     'chuot_logi_m331.jpg'),
(44, 'BÃ n phÃ­m cÆ¡ DareU EK87 Tenkeyless',       'Phá»¥ kiá»‡n Ä‘iá»‡n tá»­',  'Chiáº¿c', 420000,   590000,   90,  15,'D switch Ä‘á»™ bá»n 50 triá»‡u láº§n báº¥m, Ä‘Ã¨n ná»n LED rainbow báº¯t máº¯t',     'phim_dareu_ek87.jpg'),
(45, 'USB Kingston DataTraveler 64GB 3.2',      'Phá»¥ kiá»‡n Ä‘iá»‡n tá»­',  'Chiáº¿c', 110000,   170000,   150, 30,'Tá»‘c Ä‘á»™ chuáº©n USB 3.2 Gen 1 nhanh chÃ³ng, náº¯p xoay tiá»‡n lá»£i',         'usb_kingston_64.jpg'),
(46, 'á»” cá»©ng di Ä‘á»™ng WD Elements 1TB 2.5',      'Phá»¥ kiá»‡n Ä‘iá»‡n tá»­',  'Chiáº¿c', 1100000,  1490000,  60,  10,'Dung lÆ°á»£ng lÆ°u trá»¯ 1TB an toÃ n, tÆ°Æ¡ng thÃ­ch chuáº©n káº¿t ná»‘i USB 3.0', 'ocung_wd_1tb.jpg'),
(47, 'CÃ¡p HDMI 2.1 Ugreen 8K 2m',               'Phá»¥ kiá»‡n Ä‘iá»‡n tá»­',  'Sá»£i',   180000,   260000,   100, 20,'BÄƒng thÃ´ng 48Gbps truyá»n táº£i hÃ¬nh áº£nh 8K@60Hz mÆ°á»£t mÃ ',             'cap_hdmi_ugreen.jpg'),
(48, 'Cá»§ sáº¡c nhanh Anker Nano Pro 30W Type-C',  'Phá»¥ kiá»‡n Ä‘iá»‡n tá»­',  'Cá»§',    260000,   390000,   110, 20,'CÃ´ng nghá»‡ sáº¡c thÃ´ng minh PowerIQ 3.0, kiá»ƒm soÃ¡t nhiá»‡t ActiveShield','sac_anker_30w.jpg');

-- 3. Cáº­p nháº­t HÃ³a Ä‘Æ¡n bÃ¡n táº¡i quáº§y (InStoreSalesInvoice6) & Chi tiáº¿t
INSERT INTO InStoreSalesInvoice6 (id, saledate, totalamount, Salestaff6Member6id) VALUES
-- ThÃ¡ng 09/2026
(101, '2026-09-02', 38370000, 7),
(102, '2026-09-08', 21780000, 7),
(103, '2026-09-15', 53470000, 7),
(104, '2026-09-20', 16980000, 7),
(105, '2026-09-25', 47280000, 7),
(106, '2026-09-28', 28980000, 7),

-- ThÃ¡ng 10/2026 (Ká»³ thá»‘ng kÃª trá»ng tÃ¢m)
(107, '2026-10-02', 43760000, 7),
(108, '2026-10-05', 25480000, 7),
(109, '2026-10-07', 31970000, 7),
(110, '2026-10-10', 58460000, 7),
(111, '2026-10-12', 19890000, 7),
(112, '2026-10-15', 64960000, 7),
(113, '2026-10-18', 35970000, 7),
(114, '2026-10-20', 27690000, 7),
(115, '2026-10-22', 41280000, 7),
(116, '2026-10-25', 52380000, 7),
(117, '2026-10-28', 18450000, 7),
(118, '2026-10-30', 46890000, 7);

-- CHI TIáº¾T HÃ“A ÄÆ N Táº I QUáº¦Y (tblInStoreSalesInvoiceDetail6)
INSERT INTO tblInStoreSalesInvoiceDetail6 (InStoreSalesInvoice6id, Product6id, quantity, unitprice) VALUES
-- HÄ 101 (02/09/2026): TV Samsung 55 + iPhone 15 Pro + Cá»§ sáº¡c Anker
(101, 1,  1, 12490000),
(101, 21, 1, 25490000),
(101, 48, 1, 390000),

-- HÄ 102 (08/09/2026): Laptop ASUS + Chuá»™t Logitech x2
(102, 16, 1, 15490000),
(102, 43, 2, 390000),
(102, 12, 1, 5510000), -- Äiá»u hÃ²a giÃ¡ KM 5,510,000 -> 21,780,000

-- HÄ 103 (15/09/2026): Tivi LG OLED 65 + Loa JBL Charge 5 + Ná»“i chiÃªn Philips
(103, 2,  1, 34990000),
(103, 36, 4, 3690000), -- 14,760,000
(103, 29, 1, 2190000),
(103, 44, 2, 590000),  -- BÃ n phÃ­m DareU 1,180,000 -> (34990000 + 14760000 + 2190000 + 1180000 = 53120000 + KM)
(103, 45, 2, 175000),

-- HÄ 104 (20/09/2026): Laptop HP + USB Kingston x3 + CÃ¡p HDMI
(104, 18, 1, 15990000),
(104, 45, 3, 170000),
(104, 47, 1, 480000),

-- HÄ 105 (25/09/2026): 2 MÃ¡y giáº·t LG + 1 MÃ¡y hÃºt bá»¥i Philips + 2 Quáº¡t Toshiba
(105, 9,  3, 8890000), -- 26,670,000
(105, 32, 2, 2790000), -- 5,580,000
(105, 34, 11, 1366363),

-- HÄ 106 (28/09/2026): iPad 10.2 + iPhone 15 Pro (deal)
(106, 25, 1, 8490000),
(106, 22, 1, 19490000),
(106, 43, 2, 500000),

-- ===== THÃNG 10/2026 =====
-- HÄ 107 (02/10/2026): TV Samsung 55 + iPhone 15 Pro + 5 Chuá»™t Logitech
(107, 1,  1, 12490000),
(107, 21, 1, 25490000),
(107, 43, 5, 390000),
(107, 45, 5, 170000),
(107, 48, 10, 298000),

-- HÄ 108 (05/10/2026): Tá»§ láº¡nh Samsung + Äiá»u hÃ²a Panasonic
(108, 5,  1, 6290000),
(108, 13, 1, 13190000),
(108, 28, 2, 1690000),
(108, 47, 10, 262000),

-- HÄ 109 (07/10/2026): TV Sony Bravia 55 + Amply Boston Audio
(109, 3,  1, 14990000),
(109, 39, 1, 5390000),
(109, 37, 3, 1090000),
(109, 38, 1, 7990000),
(109, 44, 1, 330000),

-- HÄ 110 (10/10/2026): Laptop ThinkPad E14 + MÃ¡y chiáº¿u Epson + Loa Microlab
(110, 19, 1, 21990000),
(110, 42, 2, 9990000), -- 19,980,000
(110, 40, 3, 3990000), -- 11,970,000
(110, 46, 3, 1490000), -- 4,470,000
(110, 43, 14, 380000),

-- HÄ 111 (12/10/2026): Samsung Galaxy S24
(111, 22, 1, 19490000),
(111, 48, 1, 400000),

-- HÄ 112 (15/10/2026): 2 iPhone 15 Pro + 1 TV Samsung 55
(112, 21, 2, 25490000), -- 50,980,000
(112, 1,  1, 12490000),
(112, 46, 1, 1490000),

-- HÄ 113 (18/10/2026): MÃ¡y giáº·t sáº¥y Samsung + MÃ¡y lá»c nÆ°á»›c Kangaroo + Báº¿p tá»« Kangaroo
(113, 11, 1, 14290000),
(113, 33, 2, 4990000),  -- 9,980,000
(113, 31, 2, 3990000),  -- 7,980,000
(113, 30, 2, 1860000),

-- HÄ 114 (20/10/2026): OPPO Reno11 + Tai nghe Sony XM5 + Loa JBL
(114, 23, 1, 10490000),
(114, 38, 1, 7990000),
(114, 36, 2, 3690000),
(114, 43, 4, 390000),
(114, 45, 5, 170000),
(114, 47, 3, 260000),

-- HÄ 115 (22/10/2026): 2 Laptop Dell Inspiron + Chuá»™t Logitech
(115, 17, 2, 16290000), -- 32,580,000
(115, 41, 1, 7490000),  -- MÃ¡y scan HP
(115, 43, 3, 390000),
(115, 44, 1, 400000),

-- HÄ 116 (25/10/2026): TV LG OLED 65 + Äiá»u hÃ²a Daikin
(116, 2,  1, 34990000),
(116, 12, 1, 9990000),
(116, 35, 1, 4190000),
(116, 32, 1, 2790000),
(116, 48, 1, 420000),

-- HÄ 117 (28/10/2026): Tá»§ láº¡nh Panasonic + Ná»“i chiÃªn Philips
(117, 7,  1, 11490000),
(117, 29, 2, 2190000),
(117, 28, 1, 1690000),
(117, 45, 5, 178000),

-- HÄ 118 (30/10/2026): PC Ä‘á»ƒ bÃ n HP ProTower + Laptop ASUS + Loa Microlab
(118, 20, 2, 13990000), -- 27,980,000
(118, 16, 1, 15490000),
(118, 37, 2, 1090000),
(118, 43, 3, 390000),
(118, 46, 1, 110000);


-- ============================================================
-- PHáº¦N 2: ÄÆ N HÃ€NG VÃ€ HÃ“A ÄÆ N ONLINE (tblOnlineOrder6 & tblOnlineInvoice6)
-- Bao gá»“m 12 Ä‘Æ¡n hÃ ng/hÃ³a Ä‘Æ¡n Online tá»« 03/09/2026 Ä‘áº¿n 31/10/2026
-- ============================================================

INSERT INTO tblOnlineOrder6 (id, orderdate, deliveryaddress, status, shippingfee, subtotal, discount, totalamount, shippername, shipperphone, Salestaff6Member6id) VALUES
-- ThÃ¡ng 09/2026
(201, '2026-09-04', 'Sá»‘ 5 LÃª Duáº©n, HoÃ n Kiáº¿m, HÃ  Ná»™i', 'ÄÃ£ giao', 50000, 37970000, 0, 38020000, 'LÃª VÄƒn Táº£i', '0911223344', 7),
(202, '2026-09-12', '18 Pháº¡m HÃ¹ng, Nam Tá»« LiÃªm, HÃ  Ná»™i', 'ÄÃ£ giao', 100000, 29980000, 500000, 29580000, 'Nguyá»…n Tuáº¥n', '0922334455', 7),
(203, '2026-09-22', '124 HoÃ ng Quá»‘c Viá»‡t, Cáº§u Giáº¥y, HÃ  Ná»™i', 'ÄÃ£ giao', 0, 25890000, 0, 25890000, 'Tráº§n Long', '0933445566', 7),

-- ThÃ¡ng 10/2026
(204, '2026-10-03', '72 BÃ  Triá»‡u, Hai BÃ  TrÆ°ng, HÃ  Ná»™i', 'ÄÃ£ giao', 0, 50980000, 1000000, 49980000, 'LÃª VÄƒn Táº£i', '0911223344', 7),
(205, '2026-10-06', 'Khu Ä‘Ã´ thá»‹ Vinhomes Smart City, TÃ¢y Má»—', 'ÄÃ£ giao', 100000, 34160000, 500000, 33760000, 'Nguyá»…n Tuáº¥n', '0922334455', 7),
(206, '2026-10-09', 'Sá»‘ 98 XuÃ¢n Thá»§y, Cáº§u Giáº¥y, HÃ  Ná»™i', 'ÄÃ£ giao', 0, 19490000, 0, 19490000, 'Tráº§n Long', '0933445566', 7),
(207, '2026-10-13', 'Sá»‘ 10 Nguyá»…n TrÃ£i, Thanh XuÃ¢n, HÃ  Ná»™i', 'ÄÃ£ giao', 50000, 32580000, 0, 32630000, 'LÃª VÄƒn Táº£i', '0911223344', 7),
(208, '2026-10-16', 'Sá»‘ 250 Kim MÃ£, Ba ÄÃ¬nh, HÃ  Ná»™i', 'ÄÃ£ giao', 0, 16980000, 0, 16980000, 'Nguyá»…n Tuáº¥n', '0922334455', 7),
(209, '2026-10-19', 'TÃ²a nhÃ  Landmark 72, Má»… TrÃ¬, HÃ  Ná»™i', 'ÄÃ£ giao', 50000, 43980000, 1000000, 43030000, 'Tráº§n Long', '0933445566', 7),
(210, '2026-10-23', 'Sá»‘ 15 Quang Trung, HÃ  ÄÃ´ng, HÃ  Ná»™i', 'ÄÃ£ giao', 50000, 23780000, 0, 23830000, 'LÃª VÄƒn Táº£i', '0911223344', 7),
(211, '2026-10-26', 'Sá»‘ 88 Giáº£i PhÃ³ng, Äá»‘ng Äa, HÃ  Ná»™i', 'ÄÃ£ giao', 0, 15490000, 0, 15490000, 'Nguyá»…n Tuáº¥n', '0922334455', 7),
(212, '2026-10-29', 'Sá»‘ 36 Nguyá»…n Há»¯u Thá», HoÃ ng Mai, HÃ  Ná»™i', 'ÄÃ£ giao', 50000, 38160000, 0, 38210000, 'Tráº§n Long', '0933445566', 7);

-- CHI TIáº¾T ÄÆ N HÃ€NG ONLINE (tblOnlineOrderDetail6)
INSERT INTO tblOnlineOrderDetail6 (OnlineOrder6id, Product6id, quatity, unitprice) VALUES
-- ÄÆ¡n 201: Samsung S24 + Tab S9 FE + Tai nghe Sony XM5
(201, 22, 1, 19490000),
(201, 26, 1, 10490000),
(201, 38, 1, 7990000),

-- ÄÆ¡n 202: 2 Äiá»u hÃ²a Daikin 1HP + 1 MÃ¡y lá»c khÃ­ Xiaomi
(202, 12, 2, 9990000), -- 19,980,000
(202, 35, 1, 4190000),
(202, 33, 1, 4990000), -- MÃ¡y lá»c nÆ°á»›c Kangaroo 4,990,000 -> 29,160,000 + phá»¥ kiá»‡n
(202, 47, 3, 260000),
(202, 48, 1, 40000) ,

-- ÄÆ¡n 203: 1 iPhone 15 Pro + Cá»§ sáº¡c Anker
(203, 21, 1, 25490000),
(203, 48, 1, 400000),

-- ÄÆ¡n 204: 2 iPhone 15 Pro
(204, 21, 2, 25490000),

-- ÄÆ¡n 205: 2 TV Samsung 55 + MÃ¡y lá»c nÆ°á»›c + MÃ¡y lá»c khÃ­
(205, 1,  2, 12490000), -- 24,980,000
(205, 33, 1, 4990000),
(205, 35, 1, 4190000),

-- ÄÆ¡n 206: 1 Samsung S24
(206, 22, 1, 19490000),

-- ÄÆ¡n 207: 2 Laptop Dell Inspiron
(207, 17, 2, 16290000),

-- ÄÆ¡n 208: 2 iPad 10.2
(208, 25, 2, 8490000),

-- ÄÆ¡n 209: 1 TV LG OLED 65 + 1 MÃ¡y giáº·t LG 9kg
(209, 2,  1, 34990000),
(209, 9,  1, 8890000),
(209, 43, 1, 100000),

-- ÄÆ¡n 210: 2 Tá»§ láº¡nh LG Inverter 394L
(210, 6,  2, 11890000),

-- ÄÆ¡n 211: 1 Laptop ASUS Vivobook 15
(211, 16, 1, 15490000),

-- ÄÆ¡n 212: 1 TV Sony Bravia 55 + 1 Äiá»u hÃ²a Panasonic + 1 Loa JBL Charge 5 + 5 CÃ¡p HDMI
(212, 3,  1, 14990000),
(212, 13, 1, 13190000),
(212, 36, 2, 3690000), -- 7,380,000
(212, 47, 10, 260000);

-- HÃ“A ÄÆ N ONLINE (tblOnlineInvoice6)
INSERT INTO tblOnlineInvoice6 (id, invoidate, status, totalamount, OnlineOrder6id) VALUES
(301, '2026-09-04', 'ÄÃ£ thanh toÃ¡n', 38020000, 201),
(302, '2026-09-12', 'ÄÃ£ thanh toÃ¡n', 29580000, 202),
(303, '2026-09-22', 'ÄÃ£ thanh toÃ¡n', 25890000, 203),
(304, '2026-10-03', 'ÄÃ£ thanh toÃ¡n', 49980000, 204),
(305, '2026-10-06', 'ÄÃ£ thanh toÃ¡n', 33760000, 205),
(306, '2026-10-09', 'ÄÃ£ thanh toÃ¡n', 19490000, 206),
(307, '2026-10-13', 'ÄÃ£ thanh toÃ¡n', 32630000, 207),
(308, '2026-10-16', 'ÄÃ£ thanh toÃ¡n', 16980000, 208),
(309, '2026-10-19', 'ÄÃ£ thanh toÃ¡n', 43030000, 209),
(310, '2026-10-23', 'ÄÃ£ thanh toÃ¡n', 23830000, 210),
(311, '2026-10-26', 'ÄÃ£ thanh toÃ¡n', 15490000, 211),
(312, '2026-10-29', 'ÄÃ£ thanh toÃ¡n', 38210000, 212);

SET FOREIGN_KEY_CHECKS = 1;
