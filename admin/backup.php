<?php
require_once __DIR__ . '/../config/db.php';

$date = date('Y-m-d_H-i-s');
$backupDir = __DIR__ . '/../storage';

$backupFile = $backupDir . "/backup_$date.sql";

$mysqldumpPath = 'C:\\laragon\\bin\\mysql\\mysql-5.7.39-winx64\\bin\\mysqldump.exe';
$command = "\"$mysqldumpPath\" -u " . $user . " " . $db . " > \"$backupFile\"";
exec($command);

$filename = basename($backupFile);

if (file_exists($backupFile)) {
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, rgb(116, 102, 236), rgb(126, 173, 204), rgb(209, 191, 209), #E96AE7, #796CFF);
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
                    <li class="nav-item"><a class="nav-link" href="index.php">Backup</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.php">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div style="height: 10px;"></div>
    </div>
    <div class="row justify-content-center" style="height: 100vh;">
        <div class="col-md-4">
            <h4 class="text-center mb-3">Backup Database</h4>
            <div class="alert alert-success">
                Backup database berhasil dibuat: <strong><?= htmlspecialchars($filename) ?></strong>
            </div>
            <div class="text-center">
              <a href="../storage/<?= htmlspecialchars($filename) ?>" class="btn btn-primary" download>Download Backup</a>
            </div>
            <hr />
            <p class="text-center">Kembali ke <a href="index.php">Halaman Admin</a></p>
        </div>
    </div>
    <footer class="text-center p-3" style="background-color: transparent; color: white;">
        <p class="mb-0">© 2025 EduTrack - Sistem Kursus Online</p>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<?php
} else {
    echo "Backup failed.\n";
}
