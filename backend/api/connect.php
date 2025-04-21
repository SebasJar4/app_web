<?php
final class DB
{
    private $conn;

    public function __construct() {
        $host = "localhost";
        $user = "guest_your_place_safed";
        $pass = "im a guest";
        $db   = "your_place_safed";
        try {
            //code...
            $this->conn = new mysqli($host, $user, $pass, $db);
        } catch (\Throwable $th) {
            //throw $th;
            echo "error";
            echo die("Error de conexión: " . $th);
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
