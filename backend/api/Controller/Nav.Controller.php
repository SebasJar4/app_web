<?php

require("./autoload_require.php");

use Modules\NavModule;

header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");


$navController = new NavModule();
$navController->mostrarJSON_without_encode( $navController->getNav() );
$navController->close();

?>
