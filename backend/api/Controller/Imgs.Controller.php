<?php


require("./autoload_require.php");
use Modules\ImgsModule;
use function Utils\handle_error;

header("Access-Control-Allow-Headers: Content-Type");

// Obtener el ID
try {
    
    $id = isset($_GET["id"]) ? (int) $_GET["id"] : 0;
    if ($id <= 0) {
        $error = "GET ID no valido:      ";
        new Exception("The id proporcionated is invalid or inexistend... You need send valid id > 0");
    }

} catch (\Throwable $th) {
    
    $error = "Error en el ControllerImgs al obtener el id (method GET): \n\n";
    handle_error($error, $th);

}

// Mostrar JSON
try {
    $model = new ImgsModule();
    $result = $model->get_img_by_id($id);
    $result["imgs_url"];
    
} catch (\Throwable $th) {
    $error = "Error del endPoint relacionado con el json";
    handle_error($error, $th);
}