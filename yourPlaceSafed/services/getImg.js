// services/getNav.js

import rutes from "./rute.json";
import apiRest from "./apiRest.json";

export const getImg = (imgPath) => {
  if (!imgPath) return null;
  
  const cleanPath = imgPath.startsWith("/") ? imgPath : "/" + imgPath;
  let fullUrl = `http://${rutes.host}${apiRest.Imgs}?file=${cleanPath}`;

  return {
    fullUrl,
    isSvg: fullUrl.endsWith(".svg"),
  };
};

export { rutes };
