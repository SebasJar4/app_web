DELIMITER //

-- Agregar service_product
CREATE PROCEDURE add_service_product (
  IN p_imgs_id INT,
  IN p_service_id INT,
  IN p_products_id INT,
  IN p_state_objets_id INT
)
BEGIN
  INSERT INTO service_products (
    imgs_id, service_id, products_id, state_objets_id
  )
  VALUES (
    p_imgs_id, p_service_id, p_products_id, p_state_objets_id
  );
END //

-- Actualizar service_product
CREATE PROCEDURE update_service_product (
  IN p_service_product_id INT,
  IN p_imgs_id INT,
  IN p_service_id INT,
  IN p_products_id INT,
  IN p_state_objets_id INT
)
BEGIN
  UPDATE service_products
  SET
    imgs_id = p_imgs_id,
    service_id = p_service_id,
    products_id = p_products_id,
    state_objets_id = p_state_objets_id
  WHERE service_products_id = p_service_product_id;
END //

-- Eliminación lógica de service_product
CREATE PROCEDURE deactivate_service_product (
  IN p_service_product_id INT,
  IN p_maker_user_id INT
)
BEGIN
  DECLARE v_imgs_id INT;
  DECLARE v_service_id INT;
  DECLARE v_products_id INT;
  DECLARE v_state_id INT;

  -- Obtener datos actuales
  SELECT imgs_id, service_id, products_id, state_objets_id
  INTO v_imgs_id, v_service_id, v_products_id, v_state_id
  FROM service_products
  WHERE service_products_id = p_service_product_id;

  -- Desactivar
  UPDATE service_products
  SET state_objets_id = 4
  WHERE service_products_id = p_service_product_id;

  -- Insertar en historial
  INSERT INTO historial_service_products (
    maker_user_id, changed_service_products_id, type_change_id,
    historial_service_date, historial_service_description,
    old_imgs_id, old_service_id, old_products_id, old_state_objets_id,
    new_imgs_id, new_service_id, new_products_id, new_state_objets_id
  )
  VALUES (
    p_maker_user_id, p_service_product_id, 3,
    NOW(), 'Eliminación lógica de relación service-product',
    v_imgs_id, v_service_id, v_products_id, v_state_id,
    v_imgs_id, v_service_id, v_products_id, 4
  );
END //

-- Obtener todos los activos
CREATE PROCEDURE get_active_service_products ()
BEGIN
  SELECT *
  FROM service_products
  WHERE state_objets_id = 1;
END //

-- Buscar por ID
CREATE PROCEDURE get_service_product_by_id (
  IN p_service_product_id INT
)
BEGIN
  SELECT *
  FROM service_products
  WHERE service_products_id = p_service_product_id;
END //

-- Buscar por product_id + estado
CREATE PROCEDURE get_service_products_product_id_state (
  IN p_product_id INT,
  IN p_state_filter VARCHAR(10)
)
BEGIN
  IF p_state_filter = 'all' THEN
    BEGIN
      SELECT *
      FROM service_products
      WHERE products_id = p_product_id;
    END;
  ELSE
    BEGIN
      SELECT *
      FROM service_products
      WHERE products_id = p_product_id
        AND state_objets_id = CAST(p_state_filter AS UNSIGNED);
    END;
  END IF;
END //

-- Buscar por service_id + estado
CREATE PROCEDURE get_service_products_service_id_state (
  IN p_service_id INT,
  IN p_state_filter VARCHAR(10)
)
BEGIN
  IF p_state_filter = 'all' THEN
    BEGIN
      SELECT *
      FROM service_products
      WHERE service_id = p_service_id;
    END;
  ELSE
    BEGIN
      SELECT *
      FROM service_products
      WHERE service_id = p_service_id
        AND state_objets_id = CAST(p_state_filter AS UNSIGNED);
    END;
  END IF;
END //

DELIMITER ;
