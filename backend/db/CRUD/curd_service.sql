DELIMITER //

-- Agregar servicio
CREATE PROCEDURE add_service (
  IN p_service_name VARCHAR(40),
  IN p_service_description VARCHAR(300),
  IN p_imgs_id INT,
  IN p_service_descuento INT,
  IN p_state_objets_id INT
)
BEGIN
  INSERT INTO service (
    service_name, service_description, imgs_id,
    service_descuento, state_objets_id
  )
  VALUES (
    p_service_name, p_service_description, p_imgs_id,
    p_service_descuento, p_state_objets_id
  );
END //

-- Obtener servicio por ID
CREATE PROCEDURE get_service_by_id (
  IN p_service_id INT
)
BEGIN
  SELECT * FROM service WHERE service_id = p_service_id;
END //

-- Actualizar servicio
CREATE PROCEDURE update_service (
  IN p_service_id INT,
  IN p_service_name VARCHAR(40),
  IN p_service_description VARCHAR(300),
  IN p_imgs_id INT,
  IN p_service_descuento INT,
  IN p_state_objets_id INT
)
BEGIN
  UPDATE service
  SET
    service_name = p_service_name,
    service_description = p_service_description,
    imgs_id = p_imgs_id,
    service_descuento = p_service_descuento,
    state_objets_id = p_state_objets_id
  WHERE service_id = p_service_id;
END //

-- Desactivar servicio (eliminación lógica)
CREATE PROCEDURE deactivate_service (
  IN p_service_id INT,
  IN p_maker_user_id INT
)
BEGIN
  DECLARE v_name VARCHAR(40);
  DECLARE v_desc VARCHAR(300);
  DECLARE v_imgs_id INT;
  DECLARE v_descuento INT;
  DECLARE v_state INT;

  -- Obtener datos actuales
  SELECT service_name, service_description, imgs_id, service_descuento, state_objets_id
  INTO v_name, v_desc, v_imgs_id, v_descuento, v_state
  FROM service
  WHERE service_id = p_service_id;

  -- Marcar como inactivo
  UPDATE service
  SET state_objets_id = 4
  WHERE service_id = p_service_id;

  -- Insertar en historial
  INSERT INTO historial_service (
    maker_user_id, changed_service_id, type_change_id,
    historial_service_date, historial_service_description,
    old_service_name, old_service_description, old_imgs_id, old_service_descuento, old_state_objets_id,
    new_service_name, new_service_description, new_imgs_id, new_service_descuento, new_state_objets_id
  )
  VALUES (
    p_maker_user_id, p_service_id, 3,
    NOW(), 'Eliminación lógica del servicio',
    v_name, v_desc, v_imgs_id, v_descuento, v_state,
    v_name, v_desc, v_imgs_id, v_descuento, 4
  );
END //

-- Obtener servicios activos
CREATE PROCEDURE get_active_services ()
BEGIN
  SELECT *
  FROM service
  WHERE state_objets_id = 1;
END //

-- Obtener servicios por estado (incluye 'all')
CREATE PROCEDURE get_state_services ( 
  IN p_state_objet VARCHAR(10) -- 'all' o un número
)
BEGIN
  IF p_state_objet = 'all' THEN
    SELECT * FROM service;
  ELSE
    SELECT * FROM service
    WHERE state_objets_id = CAST(p_state_objet AS UNSIGNED);
  END IF;
END //

-- Obtener servicio activo por ID
CREATE PROCEDURE get_active_service_by_id (
  IN p_service_id INT
)
BEGIN
  SELECT *
  FROM service
  WHERE service_id = p_service_id
    AND state_objets_id = 1;
END //

-- Obtener servicios por rango de descuento (solo activos)
CREATE PROCEDURE get_services_by_discount_range (
  IN p_min_discount INT,
  IN p_max_discount INT
)
BEGIN
  SELECT *
  FROM service
  WHERE service_descuento BETWEEN p_min_discount AND p_max_discount
    AND state_objets_id = 1;
END //

DELIMITER ;
