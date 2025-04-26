import rutes from "./rute.json"
import apiRest from "./apiRest.json"
// Ruta local de tu servidor (XAMPP)
const BASE_URL = 'http://' + rutes.host + apiRest.Services;

export const getServices = async () => {
  try {
    const response = await fetch(BASE_URL);
    const data = await response.json();
    
    //  console.log(data);
    
    // Comprobamos si recibimos un array o un mensaje de error
    if (Array.isArray(data)) {
      return data;
    } else {
      console.warn('No se encontraron servicios:', data.message);
      return [];
    }
  } catch (error) {
    console.error('Error al obtener los servicios:', error);
    return [];
  }
};
