export const getNavs = async () => {
    try {
      const response = await fetch("http://192.168.1.X/api/nav.php"); // Cambia la IP
      if (!response.ok) throw new Error("Error al obtener los navs");
  
      const data = await response.json();
      return data;
    } catch (error) {
      console.error("Error:", error);
      return [];
    }
  };
  