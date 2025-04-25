<?php
namespace Modules;

use PDO;
use Exception;

final class UserModule extends BaseModule
{
    private $table = "users";

    /**
     * Registra un nuevo usuario.
     *
     * @param string $username Nombre de usuario.
     * @param string $password Contraseña del usuario.
     * @param string|null $email Correo electrónico del usuario (opcional).
     * @return array Resultado de la operación.
     * @throws Exception Si hay un error al registrar el usuario.
     */
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

    /**
     * Inicia sesión de un usuario.
     *
     * @param string $username Nombre de usuario.
     * @param string $password Contraseña del usuario.
     * @return array Resultado de la operación.
     */
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

    /**
     * Verifica si un usuario existe.
     *
     * @param string $username Nombre de usuario.
     * @return bool Verdadero si el usuario existe, falso en caso contrario.
     */
    public function userExists($username) {
        $stmt = $this->con->prepare("SELECT COUNT(*) FROM {$this->table} WHERE username = ?");
        $stmt->execute([$username]);
        return $stmt->fetchColumn() > 0; // Corregido el nombre de la función
    }

    /**
     * Obtiene un usuario por su ID.
     *
     * @param int $id ID del usuario.
     * @return array|null Datos del usuario o null si no se encuentra.
     */
    public function getUser_ById($id) {
        $stmt = $this->con->prepare("SELECT id, username, email FROM {$this->table} WHERE id = ?");
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
?>