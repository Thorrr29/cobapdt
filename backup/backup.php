<?php
$dbname = 'edutrack';
$filename = 'backup_' . date('Y-m-d_H-i-s') . '.sql';
$command = "mysqldump -u root $dbname > backup/$filename";
system($command);
echo "Backup berhasil ke $filename";
?>
