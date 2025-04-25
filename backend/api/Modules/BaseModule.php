<?php
namespace Modules;

use Connect\DB;
use Exception; // Corregido el nombre de la clase Exception

abstract class BaseModule
{
    protected $con;
    private $db;

    public function __construct() {
        $this->db = new DB();
        $this->con = $this->db->getConnection();
    }

    // Ejecutar y devolver todos los resultados como array asociativo
    protected function getAllRows(string $query, array $params = []): array {
        $stmt = $this->con->prepare($query);
        if ($stmt === false) {
            throw new Exception("Error al preparar la consulta: " . $this->con->error);
        }

        if (!empty($params)) {
            $this->bindParams($stmt, $params);
        }

        $stmt->execute();
        $result = $stmt->get_result();

        $rows = [];
        while ($row = $result->fetch_assoc()) {
            $rows[] = $row;
        }

        return $rows;
    }

    // Ejecutar y devolver una sola fila
    protected function getSingleRow(string $query, array $params = []): ?array {
        $stmt = $this->con->prepare($query);
        if ($stmt === false) {
            throw new Exception("Error al preparar la consulta: " . $this->con->error);
        }

        if (!empty($params)) {
            $this->bindParams($stmt, $params);
        }

        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc() ?: null; // Devuelve null si no hay resultados
    }

    // Ejecutar sin retornar resultados (INSERT, UPDATE, DELETE)
    protected function executeQuery(string $query, array $params = []): bool {
        $stmt = $this->con->prepare($query);
        if ($stmt === false) {
            throw new Exception("Error al preparar la consulta: " . $this->con->error);
        }

        if (!empty($params)) {
            $this->bindParams($stmt, $params);
        }

        return $stmt->execute();
    }

    // Función para enlazar parámetros dinámicamente
    private function bindParams($stmt, $params): void {
        $types = '';
        $bindValues = [];

        foreach ($params as $param) {
            if (is_int($param)) {
                $types .= 'i';
            } elseif (is_double($param)) {
                $types .= 'd';
            } else {
                $types .= 's';
            }
            $bindValues[] = $param;
        }

        $stmt->bind_param($types, ...$bindValues);
    }

    public function getJson(array $arr_fetched): string {
        return json_encode($arr_fetched);
    }

    public function mostrarJSON_without_encode(array $arr_fetched): void {
        $this->mostrarJSON_encoded($this->getJson($arr_fetched));
    }

    public function mostrarJSON_encoded(string $json): void {
        header('Content-Type: application/json');
        echo $json;
    }

    public function close(): void {
        $this->db->close(); // Cierra la conexión
    }
}

?>