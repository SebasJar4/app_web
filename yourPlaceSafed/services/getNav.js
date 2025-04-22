import rutes from "./rute.json"
// services/getNav.js
export const getNavs = async () => {
  try {
    const response = await fetch('http://'+ rutes.host +'/getNav.php');
    const json = await response.json();
    return json;
  } catch (error) {
    console.error("Error al obtener navs:", error);
    return [];
  }
};


export { rutes }