<?php
session_start();
include 'config/db.php';
include 'function/auth.php';

require_login();

$enrollment_id = $_GET['enrollment_id'] ?? $_POST['enrollment_id'] ?? '';
$submitted = $_SERVER['REQUEST_METHOD'] === 'POST';

if ($submitted) {
    $amount = (int) $_POST['amount'];

    if ($amount > 50000) {
        $error = "Nominal melebihi limit (maksimum Rp50.000).";
    } elseif ($amount < 50000) {
        $error = "Pembayaran gagal karena nominal kurang dari Rp50.000.";
    } else {
        try {
            $pdo->beginTransaction();

            // Simpan pembayaran
            $stmt1 = $pdo->prepare("INSERT INTO payments (enrollment_id, amount) VALUES (?, ?)");
            $stmt1->execute([$enrollment_id, $amount]);

            // Update status pendaftaran
            $stmt2 = $pdo->prepare("UPDATE enrollments SET status = 'paid' WHERE id = ?");
            $stmt2->execute([$enrollment_id]);

            $pdo->commit();
            $success = "Pembayaran berhasil untuk ID Pembayaran <strong>$enrollment_id</strong>.";
        } catch (Exception $e) {
            $pdo->rollBack();
            $error = "Gagal memproses pembayaran: " . $e->getMessage();
        }
    }
}

include 'template/header.php';
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Pembayaran Kursus</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
    html, body {
        height: auto;
        min-height: 100vh;
        margin: 0;
        padding: 0;
        background: linear-gradient(135deg, #7466ec, #7eadcc, #d1bfd1, #e96ae7, #796cff);
    }

    body {
        display: flex;
        flex-direction: column;
    }

    main {
        flex-grow: 1;
        padding-top: 3rem;
        padding-bottom: 3rem;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .payment-box {
        background-color: rgba(255,255,255,0.95);
        padding: 2rem;
        border-radius: 15px;
        max-width: 500px;
        width: 100%;
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    }

    .btn-pay {
        background: linear-gradient(135deg, #7466ec, #38f9d7);
        color: white;
        font-weight: bold;
        border: none;
        width: 100%;
        padding: 0.75rem;
        border-radius: 8px;
    }

    .btn-pay:hover {
        filter: brightness(1.1);
    }
</style>

</head>
<body>

<main>
    <div class="payment-box">
        <h4>Pembayaran Kursus</h4>

        <?php if (isset($success)): ?>
            <div class="alert alert-success"><?= $success ?></div>
        <?php elseif (isset($error)): ?>
            <div class="alert alert-danger"><?= $error ?></div>
        <?php endif; ?>

        <form method="POST">
            <div class="mb-3">
                <label class="form-label">ID Pembayaran</label>
                <input type="text" name="enrollment_id" class="form-control" value="<?= htmlspecialchars($enrollment_id) ?>" readonly required>
            </div>

            <div class="mb-3">
                <label class="form-label">Jumlah Pembayaran (Rp)</label>
                <input type="number" name="amount" class="form-control" placeholder="Contoh: 50000" required>
            </div>

            <button type="submit" class="btn btn-pay">Konfirmasi Pembayaran</button>
        </form>
    </div>
</main>

<?php include 'template/footer.php'; ?>
</body>
</html>
