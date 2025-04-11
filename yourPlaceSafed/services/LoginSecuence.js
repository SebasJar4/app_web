function isAPhoneNumber(input) {
    const phone = input.toString().replace(/\D/g, ""); // elimina espacios, guiones, etc.
  
    const isLandline = /^60\d{8}$/.test(phone);
    if (isLandline) {
      alert("El número de teléfono no puede ser fijo");
      return false;
    }
  
    const isMobile = /^3\d{9}$/.test(phone);
    if (!isMobile) {
      alert("El número de teléfono debe ser móvil...");
    }
  
    return isMobile;
  }
  
  export async function validateData({ credential, password }) {
    if (!credential || !password) {
      alert("Por favor completa todos los campos");
      return false;
    }
  
    // Si es un número, valida si es teléfono móvil
    const isNumeric = /^\d+$/.test(credential);
    if (isNumeric && !isAPhoneNumber(credential)) {
      return false;
    }
  
    try {
      const response = await fetch("http://localhost/project_web/backend/api/login.php", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          credential,
          password,
        }),
      });
  
      const data = await response.json();
  
      if (data.success) {
        alert(`Bienvenido, ${data.user?.name || credential}`);
        return true;
      } else {
        alert(data.message || "Credenciales inválidas");
        return false;
      }
    } catch (error) {
      console.error("Error en la conexión:", error);
      alert("No se pudo conectar con el servidor");
      return false;
    }
  }
  