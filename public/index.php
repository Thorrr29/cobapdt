<?php
session_start();
if (isset($_SESSION['user_id'])) {
    header("Location: dashboard.php");
    exit();
}
include '../template/header.php';
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="row justify-content-center">
    <div class="col-md-4">
        <h4 class="text-center mb-3">Login ke EduTrack</h4>
        <?php if (isset($_GET['error'])): ?>
            <div class="alert alert-danger"><?= htmlspecialchars($_GET['error']) ?></div>
        <?php endif; ?>
        <form method="POST" action="login.php">
            <div class="mb-3">
                <label>Username</label>
                <input name="username" class="form-control" required>
            </div>
            <div class="mb-3">
                <label>Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <button class="btn btn-primary w-100">Login</button>
        </form>
        <hr>
        <p class="text-center">Belum punya akun? <a href="register.php">Daftar di sini</a></p>
    </div>
</div>


</body>
</html>
<?php include '../template/footer.php'; ?>
