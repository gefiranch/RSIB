-- ====================================================
-- DATABASE: sistem_pos
-- Deskripsi: Struktur lengkap untuk Sistem POS
-- ====================================================

CREATE DATABASE IF NOT EXISTS sistem_pos;
USE sistem_pos;

-- ====================================================
-- 1. PEGAWAI (Login + Role)
-- ====================================================
CREATE TABLE pegawai (
  ID_pegawai INT AUTO_INCREMENT PRIMARY KEY,
  nama_pegawai VARCHAR(100) NOT NULL,
  role ENUM('admin', 'kasir') NOT NULL,
  kontak VARCHAR(20),
  username VARCHAR(50) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL
);

-- ====================================================
-- 2. SUPPLIER
-- ====================================================
CREATE TABLE supplier (
  ID_supplier INT AUTO_INCREMENT PRIMARY KEY,
  nama_supplier VARCHAR(100) NOT NULL,
  alamat TEXT,
  kontak VARCHAR(20)
);

-- ====================================================
-- 3. BAHAN BAKU
-- ====================================================
CREATE TABLE bahan_baku (
  ID_bahan INT AUTO_INCREMENT PRIMARY KEY,
  ID_supplier INT,
  nama_bahan VARCHAR(100) NOT NULL,
  satuan VARCHAR(50),
  jumlah_stok INT DEFAULT 0,
  batas_minimal INT DEFAULT 0,
  FOREIGN KEY (ID_supplier) REFERENCES supplier(ID_supplier)
    ON UPDATE CASCADE ON DELETE SET NULL
);

-- ====================================================
-- 4. MENU
-- ====================================================
CREATE TABLE menu (
  ID_menu INT AUTO_INCREMENT PRIMARY KEY,
  nama_menu VARCHAR(100) NOT NULL,
  harga DECIMAL(10,2) NOT NULL,
  kategori VARCHAR(50),
  status_menu ENUM('tersedia', 'habis') DEFAULT 'tersedia',
  deskripsi TEXT
);

-- ====================================================
-- 5. KOMPOSISI MENU
-- ====================================================
CREATE TABLE komposisi_menu (
  ID_komposisi INT AUTO_INCREMENT PRIMARY KEY,
  ID_menu INT NOT NULL,
  ID_bahan INT NOT NULL,
  jumlah_bahan DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (ID_menu) REFERENCES menu(ID_menu)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (ID_bahan) REFERENCES bahan_baku(ID_bahan)
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- ====================================================
-- 6. TRANSAKSI PENJUALAN
-- ====================================================
CREATE TABLE transaksi_penjualan (
  ID_transaksi INT AUTO_INCREMENT PRIMARY KEY,
  ID_pegawai INT NOT NULL,
  tanggal_transaksi DATETIME DEFAULT CURRENT_TIMESTAMP,
  total_harga DECIMAL(10,2) DEFAULT 0,
  FOREIGN KEY (ID_pegawai) REFERENCES pegawai(ID_pegawai)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ====================================================
-- 7. DETAIL TRANSAKSI
-- ====================================================
CREATE TABLE detail_transaksi (
  ID_detail_transaksi INT AUTO_INCREMENT PRIMARY KEY,
  ID_transaksi INT NOT NULL,
  ID_menu INT NOT NULL,
  jumlah_pesanan INT NOT NULL,
  subtotal DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (ID_transaksi) REFERENCES transaksi_penjualan(ID_transaksi)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (ID_menu) REFERENCES menu(ID_menu)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ====================================================
-- 8. NOTIFIKASI
-- ====================================================
CREATE TABLE notifikasi (
  ID_notifikasi INT AUTO_INCREMENT PRIMARY KEY,
  ID_bahan INT NOT NULL,
  tanggal DATETIME DEFAULT CURRENT_TIMESTAMP,
  status ENUM('belum', 'terbaca') DEFAULT 'belum',
  pesan_notifikasi TEXT,
  FOREIGN KEY (ID_bahan) REFERENCES bahan_baku(ID_bahan)
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- ====================================================
-- 9. LAPORAN
-- ====================================================
CREATE TABLE laporan (
  ID_laporan INT AUTO_INCREMENT PRIMARY KEY,
  periode VARCHAR(50),
  total_penjualan DECIMAL(12,2) DEFAULT 0,
  total_penggunaan_bahan DECIMAL(12,2) DEFAULT 0,
  tanggal_dibuat DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ====================================================
-- INSERT DATA AWAL (Admin & Kasir)
-- ====================================================

INSERT INTO pegawai (nama_pegawai, role, kontak, username, password)
VALUES 
('Admin Utama', 'admin', '081234567890', 'admin', 
'$2y$10$w9F6bz5k8R4aI8KZyPQ3JeuRrB7M12lE1nqFSLbgVh7xHYkVGRdEe'), -- password: admin123
('Kasir 1', 'kasir', '082345678901', 'kasir', 
'$2y$10$FbJwZrJ2Nf2M9hDp/95cAOpwF0vD2dx9GLtZ9LqcvvU6hTHbE7.WS'); -- password: kasir123

-- ====================================================
-- DATA DUMMY UNTUK SISTEM_POS
-- ====================================================

-- SUPPLIER
INSERT INTO supplier (nama_supplier, alamat, kontak) VALUES
('PT Sumber Makmur', 'Jl. Raya Industri No.12, Bandung', '081233445566'),
('CV Segar Jaya', 'Jl. Melati No.5, Jakarta Selatan', '082144556677'),
('PT Indo Bahan', 'Jl. Mawar No.8, Surabaya', '083355667788');

-- BAHAN BAKU
INSERT INTO bahan_baku (ID_supplier, nama_bahan, satuan, jumlah_stok, batas_minimal) VALUES
(1, 'Kopi Bubuk', 'gram', 5000, 1000),
(2, 'Susu Cair', 'liter', 100, 20),
(3, 'Gula Pasir', 'kg', 50, 10);

-- MENU
INSERT INTO menu (nama_menu, harga, kategori, status_menu, deskripsi) VALUES
('Kopi Hitam', 15000, 'Minuman', 'tersedia', 'Kopi hitam panas tanpa gula'),
('Cappuccino', 20000, 'Minuman', 'tersedia', 'Kopi dengan susu dan foam lembut'),
('Es Kopi Susu', 18000, 'Minuman', 'tersedia', 'Kopi susu dingin dengan gula aren');

-- KOMPOSISI MENU
INSERT INTO komposisi_menu (ID_menu, ID_bahan, jumlah_bahan) VALUES
(1, 1, 10.00),
(2, 1, 8.00),
(2, 2, 0.20),
(3, 1, 8.00),
(3, 2, 0.25),
(3, 3, 0.10);

-- TRANSAKSI PENJUALAN
INSERT INTO transaksi_penjualan (ID_pegawai, tanggal_transaksi, total_harga) VALUES
(2, NOW(), 35000),
(2, NOW(), 20000),
(2, NOW(), 18000);

-- DETAIL TRANSAKSI
INSERT INTO detail_transaksi (ID_transaksi, ID_menu, jumlah_pesanan, subtotal) VALUES
(1, 1, 1, 15000),
(1, 3, 1, 20000),
(2, 2, 1, 20000),
(3, 3, 1, 18000);

-- NOTIFIKASI (contoh stok menipis)
INSERT INTO notifikasi (ID_bahan, status, pesan_notifikasi) VALUES
(1, 'belum', 'Stok kopi bubuk hampir habis!'),
(2, 'belum', 'Susu cair tersisa sedikit, segera pesan lagi!'),
(3, 'terbaca', 'Gula pasir aman.');

-- LAPORAN
INSERT INTO laporan (periode, total_penjualan, total_penggunaan_bahan) VALUES
('Oktober 2025', 73000.00, 50.45),
('September 2025', 120000.00, 90.80),
('Agustus 2025', 90000.00, 70.20);
