<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Proteksi: kalau belum login, balik ke login
if (!isset($_SESSION['user'])) {
    header('Location: ../auth/login.php');
    exit;
}

// (opsional) Kalau role-nya bukan admin, arahkan ke kasir
if ($_SESSION['user']['role'] !== 'admin') {
    header('Location: kasir.php');
    exit;
}
?>

<h2>Selamat datang, <?= $_SESSION['user']['nama_pegawai']; ?>!</h2>
<p>Role: <?= ucfirst($_SESSION['user']['role']); ?></p>
<a href="../../index.php?controller=auth&action=logout">Logout</a>


