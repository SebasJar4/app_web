<?php
header("Access-Control-Allow-Origin: *");

$filename = $_GET['file'] ?? 'Products_imgs/default.png';
$filename = preg_replace('#\.\.[\\\/]#', '', $filename); // Evitar path traversal
$filename = ltrim($filename, '/');
$path = __DIR__ . "/../assets/" . $filename;

if (file_exists($path)) {
    $extension = strtolower(pathinfo($path, PATHINFO_EXTENSION));
    $mimeTypes = [
        'svg'  => 'image/svg+xml',
        'png'  => 'image/png',
        'jpg'  => 'image/jpeg',
        'jpeg' => 'image/jpeg',
        'gif'  => 'image/gif',
        'webp' => 'image/webp',
    ];
    $contentType = $mimeTypes[$extension] ?? 'application/octet-stream';

    header("Content-Type: $contentType");
    header("Cache-Control: public, max-age=86400");

    readfile($path);
} else {
    header("Content-Type: image/svg+xml");
    http_response_code(404);
    echo "<svg xmlns='http://www.w3.org/2000/svg' width='200' height='50'>
            <text x='10' y='25' fill='red'>404 Not Found</text>
          </svg>";
}
