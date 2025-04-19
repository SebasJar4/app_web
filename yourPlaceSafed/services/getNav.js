export const getNavs = async () => {
  try {
    console.log("→ Realizando fetch...");
    const response = await fetch("http://192.168.20.24/project_web/backend/api/getNav.php");

    console.log("→ Response status:", response.status);
    if (!response.ok) throw new Error("Error al obtener los navs");

    const data = await response.json();
    console.log("→ Datos recibidos:", data);

    return data;
  } catch (error) {
    console.error("Error en fetch:", error);
    return [];
  }
};
