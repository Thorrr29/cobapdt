<?php
require_once __DIR__ . '/../config/db.php';

$date = date('Y-m-d_H-i-s');
$backupDir = __DIR__ . '/../storage';

if (!is_dir($backupDir)) {
    mkdir($backupDir, 0755, true);
}

$backupFile = $backupDir . "/backup_$date.sql";

$mysqldumpPath = 'C:\\laragon\\bin\\mysql\\mysql-5.7.39-winx64\\bin\\mysqldump.exe';
$command = "\"$mysqldumpPath\" -u " . $user . " " . $db . " > \"$backupFile\" 2>&1";

exec($command, $output, $return_var);

$logFile = __DIR__ . '/../storage/backup_log.txt';
$logEntry = date('Y-m-d H:i:s') . " - Backup ";

if ($return_var === 0 && file_exists($backupFile)) {
    $logEntry .= "successful: $backupFile\n";
} else {
    $logEntry .= "failed. Output: " . implode("\n", $output) . "\n";
}

file_put_contents($logFile, $logEntry, FILE_APPEND);
?>

