<?php
require("./autoload_require.php");

use function Utils\handle_error;
use Modules\ServiceProductsModule;

// Configuración de CORS
// Configuración de CORS
header("Access-Control-Allow-Origin: *"); // Cambia * por tu dominio en producción
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Content-Type: application/json");


// Manejo de solicitudes OPTIONS (preflight)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200); // Respuesta positiva para el preflight
    exit;
}

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    // Return a 405 Method Not Allowed response
    header("HTTP/1.1 405 Method Not Allowed");
    echo json_encode(["error" => "Method Not Allowed. Only POST requests are accepted."]);
    exit;
}

// Obtener los parámetros desde el cuerpo de la solicitud POST
try {
    // Get the raw POST data
    $input = file_get_contents("php://input");
    $data = json_decode($input, true);

    // Initialize parameters with default values
    $service_id = isset($data["service_id"]) ? (int) $data["service_id"] : 0;
    $state_id = isset($data["state_id"]) ? (int) $data["state_id"] : 0;
    $page_n = isset($data["page_n"]) ? (int) $data["page_n"] : 0;
    $pagination_n = isset($data["pagination_n"]) ? (int) $data["pagination_n"] : 10;

    // Validate parameters
    if ($service_id <= 0) {
        throw new Exception("The service_id provided is invalid or nonexistent. You need to send a valid id > 0.");
    }
    if ($state_id < 0) {
        throw new Exception("The state_id provided is invalid. It must be >= 0.");
    }
    if ($page_n < 0) {
        throw new Exception("The page_n provided is invalid. It must be >= 0.");
    }
    if ($pagination_n <= 0) {
        throw new Exception("The pagination_n provided is invalid. It must be > 0.");
    }
} catch (\Throwable $th) {
    $error = "Error in the ControllerImgs while obtaining parameters: \n\n";
    handle_error($error, $th);
    exit;
}

// Mostrar JSON
try {
    $model = new ServiceProductsModule();
    $result = $model->getServiceProducts($service_id, $state_id, $page_n, $pagination_n);
    
    // Return the result as JSON
    echo json_encode($result);
} catch (\Throwable $th) {
    $error = "Error in the endpoint related to JSON response";
    handle_error($error, $th);
}
