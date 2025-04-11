<?php
header("Content-Type: application/json");
require_once("ControllerUser.php");

$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? null;

$controller = new ControllerUser();

// Obtener cuerpo de la solicitud (JSON)
$input = json_decode(file_get_contents("php://input"), true);

switch ($method) {
    case 'POST':
        if ($action === 'register') {
            if (!isset($input['username']) || !isset($input['password'])) {
                http_response_code(400);
                echo json_encode(["success" => false, "message" => "Faltan campos"]);
                exit;
            }

            $response = $controller->register($input['username'], $input['password']);
            echo json_encode($response);
        } elseif ($action === 'login') {
            if (!isset($input['username']) || !isset($input['password'])) {
                http_response_code(400);
                echo json_encode(["success" => false, "message" => "Faltan campos"]);
                exit;
            }

            $response = $controller->login($input['username'], $input['password']);
            echo json_encode($response);
        } else {
            http_response_code(404);
            echo json_encode(["success" => false, "message" => "Acción no encontrada"]);
        }
        break;

    case 'GET':
        if ($action === 'getUser' && isset($_GET['id'])) {
            $user = $controller->getUserById((int)$_GET['id']);
            if ($user) {
                echo json_encode($user);
            } else {
                http_response_code(404);
                echo json_encode(["success" => false, "message" => "Usuario no encontrado"]);
            }
        } else {
            http_response_code(400);
            echo json_encode(["success" => false, "message" => "Parámetros inválidos"]);
        }
        break;

    default:
        http_response_code(405);
        echo json_encode(["success" => false, "message" => "Método no permitido"]);
        break;
}
