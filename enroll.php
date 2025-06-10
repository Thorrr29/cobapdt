<?php
session_start();
require_once 'config/db.php';
require_once 'function/auth.php';

require_login();
$course_id = $_POST['course_id'] ?? $_GET['course_id'] ?? ''; // ini aman untuk awal

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $user_id = $_SESSION['user_id'];
    $course_id = $_POST['course_id'];
    $name = $_POST['name'];
    $no_hp = $_POST['no_hp'];

    $stmt = $pdo->prepare("INSERT INTO enrollments (user_id, course_id, name, no_hp) VALUES (?, ?, ?, ?)");
    if ($stmt->execute([$user_id, $course_id, $name, $no_hp])) {
        $enrollment_id = $pdo->lastInsertId();
        header("Location: payment.php?enrollment_id=$enrollment_id");
        exit;
    } else {
        $error = "Gagal mendaftar kursus.";
    }
}



include 'template/header.php';
?>

<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>EduTrack - Daftar Kursus</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      display: flex;
      flex-direction: column;
    }

    body {
      background: linear-gradient(135deg, rgb(116, 102, 236), rgb(126, 173, 204), rgb(209, 191, 209), #E96AE7, #796CFF);
    }

    main {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      padding: 2rem;
    }

    footer {
      background-color: transparent;
      text-align: center;
      padding: 1rem 0;
      color: white;
    }

    .form-container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 15px;
      padding: 2rem;
      width: 100%;
      max-width: 500px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    }

    .form-container h4 {
      margin-bottom: 1.5rem;
    }

    .custom-gradient-btn {
  background: linear-gradient(135deg, rgb(116, 102, 236), rgb(126, 173, 204), rgb(209, 191, 209), #E96AE7, #796CFF);
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
<body>

<main>
  <div class="form-container">
    <h4>Daftar Kursus</h4>

    <?php if (isset($success)): ?>
        <div class="alert alert-success"><?= $success ?></div>
    <?php elseif (isset($error)): ?>
        <div class="alert alert-danger"><?= $error ?></div>
    <?php endif; ?>

    <form method="POST">
      <div class="mb-3">
        <label for="course_id" class="form-label">ID Kursus</label>
       <input id="course_id" name="course_id" class="form-control" value="<?= htmlspecialchars($course_id) ?>" readonly required>
      </div>
      <div class="mb-3">
        <label for="name" class="form-label">Nama</label>
        <input id="name" name="name" class="form-control" required>
      </div>
      <div class="mb-3">
        <label for="no_hp" class="form-label">Nomor Telfon</label>
        <input id="no_hp" name="no_hp" class="form-control" required>
      </div>
      <button type="submit" class="btn custom-gradient-btn w-100">Bayar Sekarang</button>
    </form>
  </div>
</main>

<?php include 'template/footer.php'; ?>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
