<?php
require_once '../config/db.php';
session_start();

$username = $_POST['username'];
$password = $_POST['password'];

$stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
$stmt->execute([$username]);
$user = $stmt->fetch();

if ($user && password_verify($password, $user['password'])) {
    // Simpan data user ke session
    $_SESSION['user_id'] = $user['id'];
    $_SESSION['username'] = $user['username'];
    $_SESSION['role'] = $user['role'];

    // Redirect ke dashboard
    header("Location: dashboard.php");
    exit();
} else {
    // Jika gagal login, kembali ke halaman login
    $error = urlencode("Username atau password salah.");
    header("Location: index.php?error=$error");
    exit();
}
