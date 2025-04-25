import rutes from "./rute.json";
import apiRest from "./apiRest.json";

// services/getServiceProducts.js
export const getServiceProducts = async () => {
  const json = {
    service_id: 1,
    state_id: 1,
    page_n: 3,
    pagination_n: 2
  };

  try {
    const response = await fetch('http://' + rutes.host + apiRest.ServiceProducts, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(json),
    });

    if (!response.ok) {
      throw new Error(`Error en la solicitud: ${response.status}`);
    }

    const data = await response.json();

    return data;
    
  } catch (error) {
    console.error("Error al obtener service products:", error);
    return [];
  }
};

export { rutes };
