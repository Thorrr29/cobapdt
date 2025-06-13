<?php 
session_start();
include '../function/auth.php'; 
require_role('admin');

?>

<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>EduTrack - Admin Backup</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background: linear-gradient(135deg, rgb(116, 102, 236), rgb(126, 173, 204), rgb(209, 191, 209), #E96AE7, #796CFF);
      padding-top: 70px; /* Sesuaikan dengan tinggi navbar */
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    .main-content {
      flex-grow: 1;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .card {
      border-radius: 15px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.2);
      padding: 2rem;
      text-align: center;
      width: 300px;
    }

    .btn-backup {
      background: linear-gradient(90deg, #6a11cb, #2575fc);
      color: white;
      border: none;
      padding: 0.75rem 1.5rem;
      font-size: 1.1rem;
      border-radius: 8px;
      transition: background 0.3s ease;
      width: 100%;
    }

    .btn-backup:hover {
      background: linear-gradient(90deg, #2575fc, #6a11cb);
      color: white;
    }
    .navbar {
      background-color: rgba(0, 0, 0, 0.3) !important;
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
    }

    .navbar .nav-link,
    .navbar .navbar-brand {
      color: white !important;
    }
  </style>
</head>
<body>
  <nav class="navbar navbar-expand-lg fixed-top">
  <div class="container-fluid">
    <a class="navbar-brand" href="dashboard.php">EduTrack</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="#">Backup</a></li>
        <li class="nav-item"><a class="nav-link" href="../logout.php">Logout</a></li>
        
      </ul>
    </div>
  </div>
</nav>

<div class="container mt-5">
  <div style="height: 10px;"></div>
</div>

<div class="main-content">
  <div class="card">
    <h3 class="mb-4 text" style="color: #6a11cb;">Backup Data</h3>
    <a href="backup.php" class="btn-backup">Backup</a>
  </div>
</div>
 <footer class="text-center p-3" style="background-color: transparent; color: white; margin-top: auto;">
    <p class="mb-0">© 2025 EduTrack - Sistem Kursus Online</p>
  </footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
