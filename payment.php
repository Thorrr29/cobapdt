<?php
session_start();
require_once 'config/db.php';
require_once 'function/auth.php';

require_login();

$enrollment_id = $_GET['enrollment_id'] ?? $_POST['enrollment_id'] ?? '';
$submitted = $_SERVER['REQUEST_METHOD'] === 'POST';
$user_id = $_SESSION['user_id'];


$stmt_check = $pdo->prepare("SELECT COUNT(*) FROM payments WHERE enrollment_id = ?");
$stmt_check->execute([$enrollment_id]);
$already_paid = $stmt_check->fetchColumn() > 0;

// Ambil course_id dari enrollment (masih dipakai karena bisa jadi dipakai trigger di database)
$stmt_course = $pdo->prepare("SELECT course_id FROM enrollments WHERE id = ?");
$stmt_course->execute([$enrollment_id]);
$course_id = $stmt_course->fetchColumn();

if ($already_paid) {
    // Ambil nominal terakhir yang dibayarkan
    $stmt_amount = $pdo->prepare("SELECT amount FROM payments WHERE enrollment_id = ? ORDER BY paid_at DESC LIMIT 1");
    $stmt_amount->execute([$enrollment_id]);
    $last_paid = $stmt_amount->fetchColumn();

    // Ambil status
    $stmt_status = $pdo->prepare("SELECT status FROM enrollments WHERE id = ?");
    $stmt_status->execute([$enrollment_id]);
    $status = $stmt_status->fetchColumn();
    $status_display = ($status === 'paid') ? 'Sudah Dibayar' : ucfirst($status);

    $success = "Anda sudah membayar kursus ini sebesar <strong>Rp" . number_format($last_paid, 0, ',', '.') . "</strong>.<br>Status pendaftaran Anda: <strong>$status_display</strong>";
}

if ($submitted && !$already_paid) {
    $amount = (int) $_POST['amount'];

    if ($amount > 50000) {
        $error = "Nominal melebihi limit (maksimum Rp50.000).";
    } elseif ($amount < 50000) {
        $error = "Pembayaran gagal karena nominal kurang dari Rp50.000.";
    } else {
        try {
            $pdo->beginTransaction();

        
            $stmt1 = $pdo->prepare("INSERT INTO payments (enrollment_id, amount) VALUES (?, ?)");
            $stmt1->execute([$enrollment_id, $amount]);

            $stmt_check = $pdo->prepare("SELECT COUNT(*) FROM payments WHERE enrollment_id = ?");
            $stmt_check->execute([$enrollment_id]);
            $already_paid = $stmt_check->fetchColumn() > 0;

            $pdo->commit();

            $stmt3 = $pdo->prepare("SELECT status FROM enrollments WHERE id = ?");
            $stmt3->execute([$enrollment_id]);
            $status = $stmt3->fetchColumn();
            $status_display = ($status === 'paid') ? 'Sudah Dibayar' : ucfirst($status);


            $success = "Pembayaran berhasil! Anda membayar sebesar <strong>Rp" 
            . number_format($amount, 0, ',', '.') .
             "</strong>.<br>Status pendaftaran Anda: <strong>$status_display</strong>";
        } catch (Exception $e) {
            $pdo->rollBack();
            $error = "Gagal memproses pembayaran: " . $e->getMessage();
        }
    }
}

include 'template/header.php';
?>

<!-- HTML Part -->
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>EduTrack - Pembayaran</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
      body {
        background: linear-gradient(135deg, rgb(116, 102, 236), rgb(126, 173, 204), rgb(209, 191, 209), #E96AE7, #796CFF);
        padding-top: 70px; 
        height: 100vh;
      }
      .custom-gradient-btn {
  background: linear-gradient(90deg, #6a11cb, #2575fc);
  color: white;
  border: none;
  padding: 0.75rem;
  font-weight: bold;
  border-radius: 8px;
  transition: 0.3s;
}

.custom-gradient-btn:hover {
  filter: brightness(1.1);
}
  </style>
</head>
<body class="bg-light py-5">
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-6 bg-white p-4 rounded shadow-sm">
      <h4 class="mb-3">Pembayaran</h4>

      <?php if (isset($success)): ?>
          <div class="alert alert-success"><?= $success ?></div>
      <?php elseif (isset($error)): ?>
          <div class="alert alert-danger"><?= $error ?></div>
      <?php endif; ?>

      <?php if (!$already_paid): ?>
      <form method="POST">
          <input type="hidden" name="enrollment_id" value="<?= htmlspecialchars($enrollment_id) ?>">
          <div class="mb-3">
              <label for="amount" class="form-label">Jumlah Pembayaran</label>
              <input type="number" name="amount" id="amount" class="form-control" placeholder="50000" required>
          </div>
          <button type="submit" class="btn custom-gradient-btn w-100">Kirim Pembayaran</button>
      </form>
      <?php else: ?>
      <div class="alert alert-info">Form pembayaran telah dinonaktifkan karena Anda sudah membayar kursus ini.</div>
      <?php endif; ?>

    </div>
  </div>
</div>
</body>
</html>
