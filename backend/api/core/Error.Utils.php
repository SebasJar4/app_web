<?php
namespace Utils;

function handle_error($msg, \Throwable $e) {
    error_log($msg . "\n" . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => $msg,
        "details" => $e->getMessage()
    ]);
}