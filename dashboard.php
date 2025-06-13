<?php 
session_start();
include 'function/auth.php'; 
require_role('student');

// Include DB connection (using PDO)
include 'config/db.php';

// Fetch course with ID 1
$course_id = 2424;
$stmt = $pdo->prepare("SELECT * FROM courses WHERE id = ?");
$stmt->execute([$course_id]);
$course = $stmt->fetch(PDO::FETCH_ASSOC);

include 'template/header.php';
?>


<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>EduTrack - Dashboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Bootstrap 5 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background: linear-gradient(135deg, rgb(116, 102, 236), rgb(126, 173, 204), rgb(209, 191, 209), #E96AE7, #796CFF);
      padding-top: 70px; /* Sesuaikan dengan tinggi navbar */
    }

    .card {
      border-radius: 15px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.2);
      position: relative;
      overflow: hidden;
      transition: all 0.3s ease;
    }

    .card-title {
      font-weight: bold;
    }

    
    .btn-gradient-toggle {
      background: linear-gradient(90deg, #6a11cb, #2575fc);
      color: white;
      border: none;
    }

    .btn-gradient-enroll {
      background: linear-gradient(90deg, #43e97b, #38f9d7);
      color: white;
      border: none;
    }

    .dropdown-content-wrapper {
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.4s ease, padding 0.4s ease, margin-top 0.4s ease;
  background: rgba(126, 173, 204, 0.3);
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  padding: 0 1.5rem;
  margin-top: 0; /* saat tertutup, tanpa jarak */
}

.dropdown-container.show .dropdown-content-wrapper {
  max-height: 500px;
  padding: 1.5rem;
  margin-top: 1rem; /* tambahkan jarak saat terbuka */
}


  </style>
</head>
<body>
<div class="container">
  <h3 class="text-center text-white">Selamat datang di EduTrack</h3>
  <p class="lead text-center text-white">Silakan lihat kursus yang tersedia di bawah ini.</p>

  <div class="row justify-content-center mt-4">
    <div class="col-md-6">
      <div class="card p-3">
        <img src="src/ai.jpg" class="card-img-top" alt="AI">
        <div class="card-body">
        <?php if ($course): ?>
        <h5 class="card-title"><?= htmlspecialchars($course['title']) ?></h5>
        <p class="card-text">Belajar dasar-dasar <?= htmlspecialchars($course['title']) ?> dengan proyek nyata.</p>
      <?php else: ?>
        <h5 class="card-title text-danger">Kursus tidak ditemukan</h5>
      <?php endif; ?>


          <div class="dropdown-container">
            <button class="btn btn-gradient-toggle w-100" onclick="toggleDropdown(this)">
              Selengkapnya
            </button>
            <div class="dropdown-content-wrapper">
            <p>
            <strong>ID KURSUS PAKET 1 BULAN : <?= htmlspecialchars($course_id) ?></strong>
            </p>
              <p class="mt-3">Kursus <strong>Artificial Intelligence (AI)</strong> ini dirancang untuk pemula yang ingin memahami konsep dasar dan praktik langsung pengembangan sistem cerdas. Selama <strong>1 bulan</strong>, peserta akan mempelajari:</p>
              <ul>
  <li>Pengenalan AI dan aplikasinya di dunia nyata</li>
  <li>Dasar-dasar <strong>Machine Learning</strong> dan <strong>Deep Learning</strong></li>
  <li>Implementasi proyek nyata menggunakan Python, seperti chatbot dan sistem rekomendasi</li>
  <li>Praktik langsung dengan dataset dan analisis prediktif</li>
</ul>
<p>
  💰 <strong>Biaya kursus:</strong> Rp50.000 / bulan<br>
  ⏳ <strong>Durasi:</strong> 1 bulan (dapat diperpanjang jika dibutuhkan)<br>
  📅 <strong>Waktu fleksibel:</strong> Belajar kapan saja secara online
</p>
<a href="enroll.php?course_id=24244" class="btn btn-gradient-toggle w-100">Daftar Sekarang</a>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</div>
    
<script>
  function toggleDropdown(button) {
    const container = button.closest('.dropdown-container');
    container.classList.toggle('show');
  }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
<?php include 'template/footer.php'; ?>
</html>
