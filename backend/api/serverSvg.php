<?php
// Permitir el acceso desde cualquier origen
header("Access-Control-Allow-Origin: *");

// Obtener el archivo solicitado
$filename = $_GET['file'] ?? '/Producst_imgs/defauld.png';
$path = __DIR__ . "/assets" . $filename;

// Verificar si el archivo existe
if (file_exists($path)) {
    // Obtener la extensión del archivo
    $extension = strtolower(pathinfo($path, PATHINFO_EXTENSION));

    // Determinar el tipo de contenido según la extensión
    $mimeTypes = [
        'svg'  => 'image/svg+xml',
        'png'  => 'image/png',
        'jpg'  => 'image/jpeg',
        'jpeg' => 'image/jpeg',
        'gif'  => 'image/gif',
        'webp' => 'image/webp',
    ];

    $contentType = $mimeTypes[$extension] ?? 'application/octet-stream';

    // print_r($contentType);

    // Enviar el tipo de contenido
    header("Content-Type: $contentType");

    // Enviar el archivo
    readfile($path);

} else {
    // Si no se encuentra el archivo, devolver un SVG simple de error
    header("Content-Type: image/svg+xml");
    http_response_code(404);
    echo "<svg xmlns='http://www.w3.org/2000/svg' width='200' height='50'>
            <text x='10' y='25' fill='red'>404 Not Found</text>
          </svg>";
}
