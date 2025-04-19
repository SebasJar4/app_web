<?php

require_once("connect.php");
require_once("Controller.php");

final class ControllerUser extends Controller
{
    private $table = "users";

    public function register($username, $password, $email = null) {
        if ($this->userExists($username)) {
            return ["success" => false, "message" => "El usuario ya existe."];
        }

        $hashedPassword = password_hash($password, PASSWORD_BCRYPT);

        $stmt = $this->con->prepare("INSERT INTO {$this->table} (username, password, email) VALUES (?, ?, ?)");
        $result = $stmt->execute([$username, $hashedPassword, $email]);

        if ($result) {
            return ["success" => true, "message" => "Usuario registrado exitosamente."];
        } else {
            return ["success" => false, "message" => "Error al registrar usuario."];
        }
    }

    public function login($username, $password) {
        $stmt = $this->con->prepare("SELECT * FROM {$this->table} WHERE username = ?");
        $stmt->execute([$username]);

        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user && password_verify($password, $user['password'])) {
            return ["success" => true, "user" => $user];
        } else {
            return ["success" => false, "message" => "Credenciales inválidas."];
        }
    }

    public function userExists($username) {
        $stmt = $this->con->prepare("SELECT COUNT(*) FROM {$this->table} WHERE username = ?");
        $stmt->execute([$username]);
        return $stmt->fetchColumn() > 0;
    }

    public function getUserById($id) {
        $stmt = $this->con->prepare("SELECT id, username, email FROM {$this->table} WHERE id = ?");
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
