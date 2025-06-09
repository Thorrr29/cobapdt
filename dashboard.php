<?php 
session_start();
include 'function/auth.php'; 
include 'template/header.php'; 
require_login()
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
    <h3>Selamat datang di EduTrack</h3>
<p class="lead">Silakan gunakan menu di atas untuk mengakses fitur pendaftaran, pembayaran, dan laporan Anda.</p>

<div class="row mt-4">
  <div class="col-md-6">
    <a href="enroll.php" class="btn btn-success w-100">Daftar Kursus</a>
  </div>
  <div class="col-md-6">
    <a href="payment.php" class="btn btn-warning w-100">Pembayaran</a>
  </div>
</div>

<?php include 'template/footer.php'; ?>
</body>
</html>

