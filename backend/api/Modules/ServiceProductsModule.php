<?php
namespace Modules;

use Exception;

use function Utils\handle_error;

class ServiceProductsModule extends BaseModule
{
    /**
     * IN @param p_service_id       @type INT,
     * IN @param p_state_filter     @type VARCHAR(10),
     * IN @param page_n            @type INT,     -- Parámetro para el inicio de la paginación
     * IN @param pagination_number  @type INT      -- Parámetro para el número de registros a devolver
     */
    public function getServiceProducts(int $service_id = 0, int $state_id = 0, int $page_n_pagination = 0, int $n_items = 0): array {
        try {
            // Validar parámetros
            $this->validateParameters($service_id, $state_id, $page_n_pagination, $n_items);

            // Preparar la consulta
            $query = "CALL get_service_products_service_id_state(?,?,?,?);";
            $datos = $this->getAllRows($query, [$service_id, $state_id, $page_n_pagination, $n_items]);
            return $datos;

        } catch (\Throwable $th) {
            $err = "Error in the in parameters if function getServiceProducts: " . $th->getMessage();
            handle_error($err, $th);
            return []; // Retornar un array vacío en caso de error
        }
    }

    /**
     * Validar los parámetros de entrada
     */
    private function validateParameters(int $service_id, int $state_id, int $page_n_pagination, int $n_items): void {
        if ($service_id <= 0) {
            throw new Exception("Error Processing Request, invalid service ID");
        }
        if ($state_id < 0) { // Permitir 0 para 'all'
            throw new Exception("Error Processing Request, invalid state ID");
        }
        if ($page_n_pagination < 0) {
            throw new Exception("Error Processing Request, invalid pagination start index");
        }
        if ($n_items <= 0) {
            throw new Exception("Error Processing Request, invalid number of items");
        }
    }
}
?>