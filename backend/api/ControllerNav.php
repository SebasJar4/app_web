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
        $stmt = $this->conn->prepare("CALL get_nav_by_state(?)");
        $state = 1;
        $stmt->bind_param("i", $state);
        $stmt->execute();
        $result = $stmt->get_result();

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
