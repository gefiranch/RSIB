<?php
class DashboardController extends Controller {
    public function admin() {
        if ($_SESSION['user']['role'] !== 'admin') {
            header('Location: ../auth/login');
            exit;
        }
        $this->view('dashboard/admin');
    }

    public function kasir() {
        if ($_SESSION['user']['role'] !== 'kasir') {
            header('Location: ../auth/login');
            exit;
        }
        $this->view('dashboard/kasir');
    }
}
?>
