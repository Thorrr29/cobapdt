<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>EduTrack</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background: linear-gradient(135deg, rgb(116, 102, 236), rgb(126, 173, 204), rgb(209, 191, 209), #E96AE7, #796CFF);
      color: white;
      padding-top: 70px; 
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
        <li class="nav-item"><a class="nav-link" href="dashboard.php">Dashboard</a></li>
        <li class="nav-item">
          <a class="nav-link" href="payment_history.php">Riwayat Transaksi</a>
        </li>
        <li class="nav-item"><a class="nav-link" href="logout.php">Logout</a></li>
        
      </ul>
    </div>
  </div>
</nav>

<div class="container mt-5">
  <div style="height: 10px;"></div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
