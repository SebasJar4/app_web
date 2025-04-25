<?php

namespace Modules;

use Exception;

use function Utils\handle_error;

final class ImgsModule extends BaseModule
{
    /**
     * Obtiene imágenes por ID.
     *
     * @param int $id ID de la imagen a obtener.
     * @return array Datos de la imagen.
     * @throws Exception Si hay un error al ejecutar la consulta.
     */
    public function get_img_by_id(int $id) {
        // Validar que el ID sea un entero positivo
        if ($id <= 0) {
            throw new Exception("El ID debe ser un número entero positivo. El id proporcionado es:" . $id);
        }

        $query = "CALL get_imgs_by_id(?);";
        
        try {
            return $this->getSingleRow($query, [$id]);
            
        } catch (\Throwable $e) {
            $error = "Error al obtener la imagen por ID";
            handle_error( $error , $e );
        }
    }

    public function getFImgFiile($param): void {
        if (is_int($param)) {
        } elseif (is_string($param)) {
          
        } else {
            handle_error("Parámetro inválido para getFImgFiile", new \Exception("Se esperaba int o string."));
        }
    }
    
}
?>