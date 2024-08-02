<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, GET");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


$host = 'localhost'; 
$dbname = 'petition';
$username = 'root'; 
$password = ''; 


$backupDir = 'E:/backup';


if (!file_exists($backupDir)) {
    mkdir($backupDir, 0777, true);
}


$backupFile = $backupDir . '/petition_database_backup_' . date('Y-m-d_H-i-s') . '.sql';


$command = "\"C:\\xampp\\mysql\\bin\\mysqldump.exe\" --host=\"$host\" --user=\"$username\" --password=\"$password\" \"$dbname\" > \"$backupFile\" 2>&1";
exec($command, $output, $result);

echo "Command: $command\n";
echo "Output: " . implode("\n", $output) . "\n";
echo "Result: $result\n";

if ($result === 0) {
    http_response_code(200);
    echo json_encode(array("message" => "Database backup completed successfully.", "backup_file" => $backupFile));
} else {
    http_response_code(500);
    echo json_encode(array("message" => "Error occurred during database backup."));
}
?>
