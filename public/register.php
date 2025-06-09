<?php
require_once '../config/db.php';

$error = $success = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];
    $confirm = $_POST['confirm'];

    if ($password !== $confirm) {
        $error = "Konfirmasi password tidak cocok.";
    } else {
        $stmt = $pdo->prepare("SELECT id FROM users WHERE username = ?");
        $stmt->execute([$username]);
        if ($stmt->fetch()) {
            $error = "Username sudah terdaftar.";
        } else {
            $hashed = password_hash($password, PASSWORD_BCRYPT);
            $insert = $pdo->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
            if ($insert->execute([$username, $hashed])) {
                // Gunakan GET agar UI bisa tampil tanpa POST ulang
                header("Location: register.php?success=1");
                exit();
            } else {
                $error = "Gagal menyimpan data.";
            }
        }
    }
}

// jika berhasil redirect, tampilkan pesan
if (isset($_GET['success'])) {
    $success = "Registrasi berhasil. Silakan login.";
}

include '../template/header.php';
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Document</title>
</head>
<body>
    <div class="row justify-content-center">
    <div class="col-md-5">
        <h4 class="text-center mb-3">Daftar Akun Baru</h4>
        <?php if ($error): ?>
            <div class="alert alert-danger"><?= $error ?></div>
        <?php elseif ($success): ?>
            <div class="alert alert-success"><?= $success ?></div>
        <?php endif; ?>
        <form method="POST">
            <div class="mb-3">
                <label>Username</label>
                <input name="username" class="form-control" required>
            </div>
            <div class="mb-3">
                <label>Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <div class="mb-3">
                <label>Konfirmasi Password</label>
                <input type="password" name="confirm" class="form-control" required>
            </div>
            <button class="btn btn-success w-100">Daftar</button>
        </form>
        <hr>
        <p class="text-center">Sudah punya akun? <a href="index.php">Login di sini</a></p>
    </div>
</div>

<?php include '../template/footer.php'; ?>
</body>
</html>

