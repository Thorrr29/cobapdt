<?php
session_start();
include 'function/auth.php';
require_login();
include 'config/db.php';

$user_id = $_SESSION['user_id'];

// Ambil daftar kursus yang pernah diambil user beserta ID-nya
$stmt_courses = $pdo->prepare("
  SELECT DISTINCT c.id AS course_id, c.title
  FROM courses c
  JOIN enrollments e ON e.course_id = c.id
  WHERE e.user_id = ?
");
$stmt_courses->execute([$user_id]);
$courses = $stmt_courses->fetchAll(PDO::FETCH_ASSOC);

// Siapkan array untuk menyimpan total pembayaran per kursus
$course_totals = [];

foreach ($courses as $course) {
  $stmt_total = $pdo->prepare("SELECT TotalPaidByCourse(?, ?) AS total_paid");
  $stmt_total->execute([$user_id, $course['course_id']]);
  $total_paid = $stmt_total->fetch(PDO::FETCH_ASSOC)['total_paid'] ?? 0;
  $course_totals[] = [
    'title' => $course['title'],
    'total_paid' => $total_paid
  ];
}

// Panggil prosedur GetUserPayments untuk ambil riwayat pembayaran
$stmt = $pdo->prepare("CALL GetUserPayments(?)");
$stmt->execute([$user_id]);
$payments = $stmt->fetchAll(PDO::FETCH_ASSOC);

include 'template/header.php';
?>

<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>Riwayat Pembayaran</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(135deg, rgb(116, 102, 236), rgb(126, 173, 204), rgb(209, 191, 209), #E96AE7, #796CFF);
      padding-top: 70px;
      min-height: 100vh;
    }

    .table-container {
      background: white;
      padding: 2rem;
      border-radius: 16px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    }

    .card-course {
      background: white;
      padding: 1.5rem;
      border-radius: 12px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      margin-bottom: 1rem;
    }

    h2 {
      color: #333;
    }
  </style>
</head>
<body>
<div class="container">

  <div class="mt-4 mb-4">
    <h2 class="text-center text-white">Total Pembayaran per Kursus</h2>

    <?php if (count($course_totals) > 0): ?>
      <?php foreach ($course_totals as $ct): ?>
        <div class="card-course">
          <h5> Nominal Uang yang telah dikeluarkan untuk <?= htmlspecialchars($ct['title']) ?></h5>
          <p class="fw-bold text-success">Rp<?= number_format($ct['total_paid'], 0, ',', '.') ?></p>
        </div>
      <?php endforeach; ?>
    <?php else: ?>
      <div class="alert alert-warning text-center">Belum ada kursus yang diambil.</div>
    <?php endif; ?>
  </div>

  <div class="table-container">
    <h2 class="text-center mb-4">Riwayat Transaksi Pembayaran</h2>

    <?php if (count($payments) > 0): ?>
    <div class="table-responsive">
      <table class="table table-bordered table-striped">
        <thead class="table-dark">
          <tr>
            <th>No</th>
            <th>ID Pembayaran</th>
            <th>ID Enrollment</th>
            <th>Tanggal Pembayaran</th>
            <th>Jumlah (Rp)</th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($payments as $index => $pay): ?>
          <tr>
            <td><?= $index + 1 ?></td>
            <td><?= htmlspecialchars($pay['id']) ?></td>
            <td><?= htmlspecialchars($pay['enrollment_id']) ?></td>
            <td>
              <?php
                if (!empty($pay['paid_at'])) {
                  echo htmlspecialchars(date('d M Y, H:i', strtotime($pay['paid_at'])));
                } else {
                  echo '<span class="text-muted">Belum tersedia</span>';
                }
              ?>
            </td>
            <td>Rp<?= number_format($pay['amount'], 0, ',', '.') ?></td>
          </tr>
          <?php endforeach; ?>
        </tbody>
      </table>
    </div>
    <?php else: ?>
      <div class="alert alert-warning text-center">Belum ada transaksi pembayaran yang tercatat.</div>
    <?php endif; ?>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
<?php include 'template/footer.php'; ?>
</html>
