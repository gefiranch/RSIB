<?php
require_once __DIR__ . '/../Core/Controller.php';
require_once __DIR__ . '/../Models/User.php';

class AuthController extends Controller
{
    public function __construct()
    {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }
    }

    public function login()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $username = $_POST['username'];
            $password = $_POST['password'];

            $userModel = new User();
            $user = $userModel->getUserByUsername($username);

            if ($user && $password === $user['password']) {
                $_SESSION['user'] = $user;

                // Arahkan berdasarkan role
                if ($user['role'] === 'admin') {
                    header('Location: ../SistemPOS/Views/dashboard/admin.php');
                } else {
                    header('Location: ../SistemPOS/Views/dashboard/kasir.php');
                }
                exit;
            } else {
                $data['error'] = "Username atau password salah.";
                $this->view('auth/login', $data);
            }
        } else {
            $this->view('auth/login');
        }
    }

    public function logout()
    {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }

        session_unset();
        session_destroy();

        // arahkan langsung ke halaman login
        header('Location: ../Views/auth/login.php');
        exit;
    }
}
