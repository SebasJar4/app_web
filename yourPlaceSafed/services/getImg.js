// services/getNav.js

import rutes from "./rute.json";
import apiRest from "./apiRest.json";

const getImg = (imgPath) => {
  if (!imgPath) return null;
  console.log( imgPath)
  const cleanPath = imgPath.startsWith("/") ? imgPath : "/" + imgPath;
  let fullUrl = `http://${rutes.host}${apiRest.Imgs}?file=${cleanPath}`;

  return {
    fullUrl,
    isSvg: fullUrl.endsWith(".svg"),
  };
};

const getImgById = async ( id = 1 ) => {
  
  try {
  
    const url = 'http://' + rutes.host + apiRest.Img_id + "?id=" + id;
  
    console.log("#####3Fetch Imgid " + url );
  
    const response = await fetch( url );
    
    const json = await response.json();

    return json;
  
  } catch (error) {
    
    console.error("Error al obtener el id:", error);
    return [];
  
  }
}

export { rutes , getImg , getImgById };
