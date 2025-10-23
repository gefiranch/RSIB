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
