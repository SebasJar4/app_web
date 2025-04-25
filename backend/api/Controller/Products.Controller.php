<?php

use Modules\ProductsModules;

require("./autoload_require.php");


use function Utils\handle_error;

header("Access-Control-Allow-Origin: *");

// Mostrar json
try {
  
  $model = new ProductsModules();
  $result = $model->getProducts();
  $model->mostrarJSON_without_encode( $result );

} catch (\Throwable $th) {
  $error = "Error del endPoint relacionado con el json";
  handle_error( $error , $th );
}