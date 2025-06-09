<?php
session_start();
include '../config/db.php';
include '../function/auth.php';

require_login();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $enrollment_id = $_POST['enrollment_id'];
    $amount = $_POST['amount'];

    try {
        $pdo->beginTransaction();

        // 1. Simpan pembayaran
        $stmt1 = $pdo->prepare("INSERT INTO payments (enrollment_id, amount) VALUES (?, ?)");
        $stmt1->execute([$enrollment_id, $amount]);

        // 2. Update status pendaftaran
        $stmt2 = $pdo->prepare("UPDATE enrollments SET status = 'paid' WHERE id = ?");
        $stmt2->execute([$enrollment_id]);

        $pdo->commit();
        $success = "Pembayaran berhasil untuk ID Pendaftaran $enrollment_id.";
    } catch (Exception $e) {
        $pdo->rollBack();
        $error = "Gagal memproses pembayaran: " . $e->getMessage();
    }
}

include '../template/header.php';
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h4>Pembayaran Kursus</h4>
<?php if (isset($success)): ?>
  <div class="alert alert-success"><?= $success ?></div>
<?php elseif (isset($error)): ?>
  <div class="alert alert-danger"><?= $error ?></div>
<?php endif; ?>
<form method="POST">
  <div class="mb-3">
    <label>ID Pendaftaran</label>
    <input name="enrollment_id" class="form-control" required>
  </div>
  <div class="mb-3">
    <label>Jumlah Pembayaran</label>
    <input name="amount" type="number" class="form-control" required>
  </div>
  <button class="btn btn-warning">Bayar</button>
</form>

<?php include '../template/footer.php'; ?>

</body>
</html>
