import rutes from "./rute.json"
import apiRest from "./apiRest.json"

// services/getNav.js
export const getNavs = async () => {
  try {
    const response = await fetch( 'http://' + rutes.host + apiRest.Nav );
    const json = await response.json();
    return json;
  } catch (error) {
    console.error("Error al obtener navs:", error);
    return [];
  }
};


export { rutes }