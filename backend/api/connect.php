<?php
final class DB
{
    private $conn;

    public function __construct() {
        $host = "localhost";
        $user = "root";
        $pass = "";
        $db   = "your_place_safed"; // <- Asegúrate de cambiar esto por el nombre real

        $this->conn = new mysqli($host, $user, $pass, $db);

        if ($this->conn->connect_error) {
            die("Error de conexión: " . $this->conn->connect_error);
        }
    }

    public function getConnection()  {
        return $this->conn;
    }

    public function close () {
      $this->conn->close();
    }
}
?>
