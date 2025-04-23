- Genders
INSERT INTO gender (gender_id, gender_name, gender_description) VALUES
(1, 'Masculino', 'Hombre'),
(2, 'Femenino', 'Mujer'),
(3, 'Otro', 'Otro género'),
(4, 'Prefiero no decirlo', 'No desea especificar');

-- State User
INSERT INTO state_user (state_user_id, state_user_name, state_user_description) VALUES
(1, 'Activo', 'Usuario activo'),
(2, 'Inactivo', 'Usuario inactivo'),
(3, 'Por confirmar', 'Pendiente de validación'),
(4, 'Eliminado', 'Cuenta eliminada');

-- Type of changes
INSERT INTO type_change (type_change_id, type_change_name, type_change_description) VALUES
(1, 'CREATE', 'Creación de registro'),
(2, 'UPDATE', 'Edición de registro'),
(3, 'DELETE', 'Se eliminará el registro (en realidad solo quedará inactivo)');

INSERT INTO state_objets (state_objets_id, state_objets_name, state_objets_description) VALUES
(1, 'activo', 'Elemento activo y visible para el sistema'),
(2, 'inactivo', 'Elemento inactivo, no se muestra en el sistema pero no ha sido eliminado'),
(3, 'por confirmar', 'Elemento en estado pendiente de confirmación o revisión'),
(4, 'eliminado', 'Elemento marcado como eliminado, pero no borrado físicamente');

CALL add_user(
  "admin",
  "sebas.jara.mon1@gmail.com",
  "3054102953",
  3,
  1,
  NULL
);

CALL add_imgs(
   "Home_icon",
   "/assets/icons/Home.svg",
   "Icono que se pondrá en el nav para denotar el home",
   1
);

CALL add_imgs(
   "Services_icon",
   "/assets/icons/Services.svg",
   "Icono que se pondrá en el nav para denotar los Services",
   1
);

CALL add_nav (
  "Home",
  NULL,
  "Interfaz/pestaña donde todos los usuarios entran de primeras para ofrecer mis servicios",
  1,
  "Home",
  1,
  1
);

CALL add_nav (
  "Services",
  NULL,
  "Interfaz donde vamos a poner nuestras categorías de servicios",
  1,
  "Services",
  2,
  1
);

CALL add_imgs (
   "camera_1",
   "/assets/Producst_imgs/camera1.webp",
   "Camara bonita",
   1
);

CALL add_imgs (
   "camera_2",
   "/assets/Producst_imgs/camera2.avif",
   "Camara bonita",
   1
);

CALL add_imgs (
   "camera_3",
   "/assets/Producst_imgs/camera3.png",
   "Camara bonita",
   1
);

CALL add_imgs (
   "camera_4",
   "/assets/Producst_imgs/camera4.png",
   "Camara bonita",
   1
);

CALL add_imgs (
   "camera + sensor de movimiento",
   "/assets/Producst_imgs/Sensor_movimiento.jpg",
   "Camara bonita",
   1
);

CALL add_product (
  "camara 360 grados",
  3,
  "Camara que gira en 360 deg ideal para cubrir zonas de amplio espacio",
  "30000",
  1,
  1
);

CALL add_product (
  "camara tipo cabeza 180 deg",
  4,
  "Camara ideal para cuartos no muy grandes y que no tienen una tn amplia cobertura",
  "22000",
  1,
  1
);

CALL add_product (
  "camara tipo cabeza 180 deg",
  5,
  "Camara ideal para cuartos no muy grandes y que no tienen una tn amplia cobertura",
  "22000",
  1,
  1
);

CALL add_product (
  "Camara 360 deg :D",
  6,
  "Camara de alta calidad ideal para cuartos no muy grandes y que no tienen una tn amplia cobertura esta bonita :D",
  "45000",
  1,
  1
);

CALL add_product (
  "Camara 180 + sensor de proximidad :3",
  7,
  "Camara de alta calidad ideal para cuartos no muy grandes y que no tienen una tn amplia cobertura esta bonita :D",
  "50000",
  1,
  1
);

CALL add_service (
  "Sistemas de monitoreo",
  "Se ofrece el servicio de instalación en su vivienda, empresa, recinto, tienda, etc... la instalación de cámaras y sensores",
  7,
  10,
  1
);

CALL add_service_product (
  NULL,
  1,
  1,
  1
);

CALL add_service_product (
  NULL,
  1,
  2,
  1
);

CALL add_service_product (
  NULL,
  1,
  3,
  1
);

CALL add_service_product (
  NULL,
  1,
  4,
  1
);

CALL add_service_product (
  NULL,
  1,
  5,
  1
);