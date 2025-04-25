<?php

require("./autoload_require.php");

use Modules\ServicesModule;

use function Utils\handle_error;

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");


if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

try {

    $module = new ServicesModule();
    $services = $module->getActiveServices();
    $module->mostrarJSON_without_encode( $services );

} catch (\Throwable $e ) {

    $error = "Error al obtener los servicios en el controller";
    handle_error( $error , $e );
    
}
