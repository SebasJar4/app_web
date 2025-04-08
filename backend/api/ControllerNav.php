<?php
require_once "connect.php";

class ControllerNav
{
    private $conn;

    public function __construct() {
        $db = new DB();
        $this->conn = $db->getConnection();
    }

    public function getNav() {
        $query = "call  get_nav_by_state("+1+")";
        $result = $this->conn->query($query);

        $datos = [];

        while ($row = $result->fetch_assoc()) {
            $datos[] = $row;
        }

        return $datos;
    }

    public function mostrarJSON() {
        header('Content-Type: application/json');
        echo json_encode($this->getNav());
    }
}

?>
