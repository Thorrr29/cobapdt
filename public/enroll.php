<?php
session_start();
require_once '../config/db.php';
require_once '../function/auth.php';

require_login(); // Panggil fungsi dari auth.php

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $course_id = $_POST['course_id'];
    $user_id = $_SESSION['user_id'];

    $stmt = $pdo->prepare("INSERT INTO enrollments (user_id, course_id) VALUES (?, ?)");
    if ($stmt->execute([$user_id, $course_id])) {
        $enrollment_id = $pdo->lastInsertId();
        $success = "Pendaftaran berhasil. ID Pendaftaran Anda: <strong>$enrollment_id</strong>";
    } else {
        $error = "Gagal mendaftar kursus.";
    }
}

include '../template/header.php';
?>

<div class="container mt-5">
    <h4>Daftar Kursus</h4>

    <?php if (isset($success)): ?>
        <div class="alert alert-success"><?= $success ?></div>
    <?php elseif (isset($error)): ?>
        <div class="alert alert-danger"><?= $error ?></div>
    <?php endif; ?>

    <form method="POST">
        <div class="mb-3">
            <label>ID Kursus</label>
            <input name="course_id" class="form-control" required>
        </div>
        <button class="btn btn-success">Daftar</button>
    </form>
</div>

<?php include '../template/footer.php'; ?>
