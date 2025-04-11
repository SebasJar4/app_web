<?php
require_once("connect.php");

abstract class Controller 
{
    protected $con;
    private $db;

    public function __construct() {
        $this->db = new DB();
        $this->con = $this->db->getConnection();
    }

    // Ejecutar y devolver todos los resultados como array asociativo
    protected function getAllRows($query, $params = []) {
        $stmt = $this->con->prepare($query);
        if ($stmt === false) {
            die("Error al preparar la consulta: " . $this->con->error);
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
    protected function getSingleRow($query, $params = []) {
        $stmt = $this->con->prepare($query);
        if ($stmt === false) {
            die("Error al preparar la consulta: " . $this->con->error);
        }

        if (!empty($params)) {
            $this->bindParams($stmt, $params);
        }

        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc();
    }

    // Ejecutar sin retornar resultados (INSERT, UPDATE, DELETE)
    protected function executeQuery($query, $params = []) {
        $stmt = $this->con->prepare($query);
        if ($stmt === false) {
            die("Error al preparar la consulta: " . $this->con->error);
        }

        if (!empty($params)) {
            $this->bindParams($stmt, $params);
        }

        return $stmt->execute();
    }

    // Función para enlazar parámetros dinámicamente
    private function bindParams($stmt, $params) {
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
}
