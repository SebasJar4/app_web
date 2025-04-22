<?php
// Habilitar CORS
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

// El resto del código
require_once "ControllerNav.php";
$navController = new ControllerNav();
$navController->mostrarJSON();
$navController->close();

?>
