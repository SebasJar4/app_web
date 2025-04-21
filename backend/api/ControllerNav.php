<?php
require_once "Controller.php";

class ControllerNav extends Controller
{
    public function getNav() : array {
        $query = "CALL get_nav_active_with_imgs();"; // era $this->conn, pero en tu Controller se llama $this->con
        $datos = $this->getAllRows( $query );
        return $datos;
    }

    public function mostrarJSON() : void {
        header('Content-Type: application/json');
        echo json_encode($this->getNav());
    }
}
?>