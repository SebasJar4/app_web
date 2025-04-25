import rutes from "./rute.json";
import apiRest from "./apiRest.json";
import showServiceProducts from "./showServiceProducts.json"; // Esto se mantiene si necesitas usar datos predeterminados.

const minMax = {
  service_id: [1, Infinity],
  state_id: [1, 4],
  page_n: [1, Infinity],
  pagination_n: [15, 100],
};

// Función de validación
function validateParameters(parameters) {
  const keys = Object.keys(minMax);

  for (const key of keys) {
    const [min, max] = minMax[key];
    const value = parameters[key];

    if (value === undefined || value < min || value > max) {
      throw new Error(
        `El valor de ${key} (${value}) está fuera de los límites permitidos. Debe estar entre ${min} y ${max}.`
      );
    }
  }
}

// Servicio getServiceProducts
export const getServiceProducts = async ( { service_id , page_n = null , pagination_n = null } ) => {
  try {
    // Construir el objeto JSON dinámicamente con valores de showServiceProducts
    const requestBody = {
      service_id,
      state_id: showServiceProducts.state_id,         // Uso de valores predeterminados de showServiceProducts
      page_n: page_n || 1 ,
      pagination_n: pagination_n || showServiceProducts.pagination_n, // Uso de valores predeterminados de showServiceProducts
    };

    // Validación del objeto creado
    validateParameters(requestBody);

    const response = await fetch(
      "http://" + rutes.host + apiRest.ServiceProducts,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(requestBody),
      }
    );

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
