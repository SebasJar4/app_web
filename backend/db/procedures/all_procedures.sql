DELIMITER //

-- Agregar nav
CREATE PROCEDURE add_nav (
  IN p_nav_name VARCHAR(50),
  IN p_service_id INT,
  IN p_nav_description VARCHAR(300),
  IN p_state_objets_id INT,
  IN p_url VARCHAR(100),
  IN p_imgs_id INT,
  IN p_maker_user_id INT
)
BEGIN
  INSERT INTO nav (
    nav_name, service_id, nav_description, state_objets_id, url, imgs_id
  )
  VALUES (
    p_nav_name, p_service_id, p_nav_description, p_state_objets_id, p_url, p_imgs_id
  );

  INSERT INTO historial_nav (
    maker_user_id, changed_nav_id, type_change_id,
    historial_nav_date, historial_nav_description,
    old_nav_name, old_service_id, old_nav_description, old_state_objets_id,
    new_nav_name, new_service_id, new_nav_description, new_state_objets_id
  )
  VALUES (
    p_maker_user_id, LAST_INSERT_ID(), 1,
    NOW(), 'Creación de nav',
    NULL, NULL, NULL, NULL,
    p_nav_name, p_service_id, p_nav_description, p_state_objets_id
  );
END //

-- Editar nav
CREATE PROCEDURE edit_nav (
  IN p_nav_id INT,
  IN p_new_nav_name VARCHAR(50),
  IN p_new_service_id INT,
  IN p_new_nav_description VARCHAR(300),
  IN p_new_state_objets_id INT,
  IN p_new_url VARCHAR(100),
  IN p_new_imgs_id INT,
  IN p_maker_user_id INT
)
BEGIN
  DECLARE v_old_name VARCHAR(50);
  DECLARE v_old_service_id INT;
  DECLARE v_old_description VARCHAR(300);
  DECLARE v_old_state_id INT;

  SELECT nav_name, service_id, nav_description, state_objets_id
  INTO v_old_name, v_old_service_id, v_old_description, v_old_state_id
  FROM nav WHERE nav_id = p_nav_id;

  UPDATE nav
  SET nav_name = p_new_nav_name,
      service_id = p_new_service_id,
      nav_description = p_new_nav_description,
      state_objets_id = p_new_state_objets_id,
      url = p_new_url,
      imgs_id = p_new_imgs_id
  WHERE nav_id = p_nav_id;

  INSERT INTO historial_nav (
    maker_user_id, changed_nav_id, type_change_id,
    historial_nav_date, historial_nav_description,
    old_nav_name, old_service_id, old_nav_description, old_state_objets_id,
    new_nav_name, new_service_id, new_nav_description, new_state_objets_id
  )
  VALUES (
    p_maker_user_id, p_nav_id, 2,
    NOW(), 'Actualización de nav',
    v_old_name, v_old_service_id, v_old_description, v_old_state_id,
    p_new_nav_name, p_new_service_id, p_new_nav_description, p_new_state_objets_id
  );
END //

-- Eliminación lógica de nav
CREATE PROCEDURE delete_nav_logico (
  IN p_nav_id INT,
  IN p_maker_user_id INT
)
BEGIN
  DECLARE v_old_name VARCHAR(50);
  DECLARE v_old_service_id INT;
  DECLARE v_old_description VARCHAR(300);
  DECLARE v_old_state_id INT;

  SELECT nav_name, service_id, nav_description, state_objets_id
  INTO v_old_name, v_old_service_id, v_old_description, v_old_state_id
  FROM nav WHERE nav_id = p_nav_id;

  UPDATE nav
  SET state_objets_id = 4
  WHERE nav_id = p_nav_id;

  INSERT INTO historial_nav (
    maker_user_id, changed_nav_id, type_change_id,
    historial_nav_date, historial_nav_description,
    old_nav_name, old_service_id, old_nav_description, old_state_objets_id,
    new_nav_name, new_service_id, new_nav_description, new_state_objets_id
  )
  VALUES (
    p_maker_user_id, p_nav_id, 3,
    NOW(), 'Eliminación lógica de nav',
    v_old_name, v_old_service_id, v_old_description, v_old_state_id,
    v_old_name, v_old_service_id, v_old_description, 4
  );
END //

-- Obtener nav por ID
CREATE PROCEDURE get_nav_by_id (
  IN p_nav_id INT
)
BEGIN
  SELECT * FROM nav WHERE nav_id = p_nav_id;
END //

-- Buscar nav por nombre (LIKE)
CREATE PROCEDURE get_nav_by_name (
  IN p_nav_name VARCHAR(50)
)
BEGIN
  SELECT * FROM nav WHERE nav_name LIKE CONCAT('%', p_nav_name, '%');
END //

-- Obtener navs por estado (con opción 'all')
CREATE PROCEDURE get_nav_by_state (
  IN p_state_objets_id VARCHAR(10)
)
BEGIN
  IF p_state_objets_id = 'all' THEN
    SELECT * FROM nav;
  ELSE
    SELECT * FROM nav WHERE state_objets_id = CAST(p_state_objets_id AS UNSIGNED);
  END IF;
END //


CREATE PROCEDURE get_nav_by_state_with_imgs (
  IN p_state_objets_id VARCHAR(10)
)
BEGIN
  IF p_state_objets_id = 'all' THEN
    SELECT 
      nav.*, 
      imgs.imgs_id, 
      imgs.imgs_name, 
      imgs.imgs_url
    FROM nav
    LEFT JOIN imgs ON nav.imgs_id = imgs.imgs_id;
  ELSE
    SELECT 
      nav.*, 
      imgs.imgs_id, 
      imgs.imgs_name, 
      imgs.imgs_url
    FROM nav
    LEFT JOIN imgs ON nav.imgs_id = imgs.imgs_id
    WHERE nav.state_objets_id = CAST(p_state_objets_id AS UNSIGNED);
  END IF;
END //

CREATE PROCEDURE get_nav_active_with_imgs ()
BEGIN
  SELECT 
    nav.*, 
    imgs.imgs_id, 
    imgs.imgs_name, 
    imgs.imgs_url
  FROM nav
  LEFT JOIN imgs ON nav.imgs_id = imgs.imgs_id
  WHERE nav.state_objets_id = 1;
END //

CREATE PROCEDURE add_product (
  IN p_producst_name VARCHAR(50),
  IN p_imgs_id INT,
  IN p_products_description VARCHAR(300),
  IN p_products_precio VARCHAR(9),
  IN p_state_objets_id INT,
  IN p_maker_user_id INT
)
BEGIN
  INSERT INTO products (producst_name, imgs_id, products_description, products_precio, state_objets_id)
  VALUES (p_producst_name, p_imgs_id, p_products_description, p_products_precio, p_state_objets_id);

  INSERT INTO historial_products (
    maker_user_id, changed_historial_products_id, type_change_id,
    historial_products_date, historial_products_description,
    old_producst_name, old_imgs_id, old_products_description, old_products_precio, old_state_objets_id,
    new_producst_name, new_imgs_id, new_products_description, new_products_precio, new_state_objets_id
  )
  VALUES (
    p_maker_user_id, LAST_INSERT_ID(), 1,
    NOW(), 'Creación de producto',
    NULL, NULL, NULL, NULL, NULL,
    p_producst_name, p_imgs_id, p_products_description, p_products_precio, p_state_objets_id
  );
END //

-- ----------------------------------------------------

CREATE PROCEDURE edit_product (
  IN p_products_id INT,
  IN p_new_producst_name VARCHAR(50),
  IN p_new_imgs_id INT,
  IN p_new_products_description VARCHAR(300),
  IN p_new_products_precio VARCHAR(9),
  IN p_new_state_objets_id INT,
  IN p_maker_user_id INT
)
BEGIN
  DECLARE v_old_name VARCHAR(30);
  DECLARE v_old_imgs_id INT;
  DECLARE v_old_description VARCHAR(300);
  DECLARE v_old_precio VARCHAR(9);
  DECLARE v_old_state_id INT;

  SELECT producst_name, imgs_id, products_description, products_precio, state_objets_id
  INTO v_old_name, v_old_imgs_id, v_old_description, v_old_precio, v_old_state_id
  FROM products WHERE products_id = p_products_id;

  UPDATE products
  SET producst_name = p_new_producst_name,
      imgs_id = p_new_imgs_id,
      products_description = p_new_products_description,
      products_precio = p_new_products_precio,
      state_objets_id = p_new_state_objets_id
  WHERE products_id = p_products_id;

  INSERT INTO historial_products (
    maker_user_id, changed_historial_products_id, type_change_id,
    historial_products_date, historial_products_description,
    old_producst_name, old_imgs_id, old_products_description, old_products_precio, old_state_objets_id,
    new_producst_name, new_imgs_id, new_products_description, new_products_precio, new_state_objets_id
  )
  VALUES (
    p_maker_user_id, p_products_id, 2,
    NOW(), 'Actualización de producto',
    v_old_name, v_old_imgs_id, v_old_description, v_old_precio, v_old_state_id,
    p_new_producst_name, p_new_imgs_id, p_new_products_description, p_new_products_precio, p_new_state_objets_id
  );
END //

-- ----------------------------------------------------

CREATE PROCEDURE delete_product_logico (
  IN p_products_id INT,
  IN p_maker_user_id INT
)
BEGIN
  DECLARE v_old_name VARCHAR(30);
  DECLARE v_old_imgs_id INT;
  DECLARE v_old_description VARCHAR(300);
  DECLARE v_old_precio VARCHAR(9);
  DECLARE v_old_state_id INT;

  SELECT producst_name, imgs_id, products_description, products_precio, state_objets_id
  INTO v_old_name, v_old_imgs_id, v_old_description, v_old_precio, v_old_state_id
  FROM products WHERE products_id = p_products_id;

  UPDATE products SET state_objets_id = 4 WHERE products_id = p_products_id;

  INSERT INTO historial_products (
    maker_user_id, changed_historial_products_id, type_change_id,
    historial_products_date, historial_products_description,
    old_producst_name, old_imgs_id, old_products_description, old_products_precio, old_state_objets_id,
    new_producst_name, new_imgs_id, new_products_description, new_products_precio, new_state_objets_id
  )
  VALUES (
    p_maker_user_id, p_products_id, 3,
    NOW(), 'Eliminación lógica de producto',
    v_old_name, v_old_imgs_id, v_old_description, v_old_precio, v_old_state_id,
    v_old_name, v_old_imgs_id, v_old_description, v_old_precio, 4
  );
END //

-- ----------------------------------------------------

CREATE PROCEDURE get_product_by_id (
  IN p_products_id INT
)
BEGIN
  SELECT * FROM products WHERE products_id = p_products_id;
END //

-- ----------------------------------------------------

CREATE PROCEDURE get_product_by_name (
  IN p_producst_name VARCHAR(50)
)
BEGIN
  SELECT * FROM products
  WHERE producst_name LIKE CONCAT('%', p_producst_name, '%');
END //

-- ----------------------------------------------------

CREATE PROCEDURE get_product_by_state (
  IN p_state_objets_id VARCHAR(10) -- permite 'all'
)
BEGIN
  IF p_state_objets_id = 'all' THEN
    SELECT * FROM products;
  ELSE
    SELECT * FROM products
    WHERE state_objets_id = CAST(p_state_objets_id AS UNSIGNED);
  END IF;
END //

CREATE PROCEDURE get_products_by_price_range (
  IN p_min_price DECIMAL(9,2),
  IN p_max_price DECIMAL(9,2)
)
BEGIN
  SELECT * FROM products
  WHERE state_objets_id = 1 AND CAST(products_precio AS DECIMAL(9,2)) BETWEEN p_min_price AND p_max_price
  ORDER BY CAST(products_precio AS DECIMAL(9,2));
END //


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
CREATE PROCEDURE get_service_active_products ()
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


-- Agregar usuario si no existe
CREATE PROCEDURE add_user (
  IN p_user_name VARCHAR(30),
  IN p_user_mail VARCHAR(100),
  IN p_user_tel VARCHAR(10),
  IN p_state_user_id INT,
  IN p_gender_id INT,
  IN p_maker_user_id INT
)
BEGIN
  DECLARE v_user_id INT;

  IF NOT EXISTS (SELECT 1 FROM user WHERE user_mail = p_user_mail) THEN
    INSERT INTO user (
      user_name, user_mail, user_tel, state_user_id, gender_id
    )
    VALUES (
      p_user_name, p_user_mail, p_user_tel, p_state_user_id, p_gender_id
    );

    SET v_user_id = LAST_INSERT_ID();

    INSERT INTO user_historial (
      changed_user_id, maker_user_id, type_change_id,
      user_historial_date, user_historial_description,
      old_user_name, old_user_mail, old_user_tel, old_state_user_id, old_gender_id,
      new_user_name, new_user_mail, new_user_tel, new_state_user_id, new_gender_id
    )
    VALUES (
      v_user_id, p_maker_user_id, 1,
      NOW(), 'Creación de usuario',
      NULL, NULL, NULL, NULL, NULL,
      p_user_name, p_user_mail, p_user_tel, p_state_user_id, p_gender_id
    );
  END IF;
END //

-- Actualizar estado de usuario
CREATE PROCEDURE update_user_state (
  IN p_user_id INT,
  IN p_new_state_user_id INT,
  IN p_maker_user_id INT
)
BEGIN
  DECLARE v_old_state_user_id INT;
  DECLARE v_user_name VARCHAR(30);
  DECLARE v_user_mail VARCHAR(100);
  DECLARE v_user_tel VARCHAR(10);
  DECLARE v_gender_id INT;

  SELECT user_name, user_mail, user_tel, gender_id, state_user_id
  INTO v_user_name, v_user_mail, v_user_tel, v_gender_id, v_old_state_user_id
  FROM user
  WHERE user_id = p_user_id;

  UPDATE user
  SET state_user_id = p_new_state_user_id
  WHERE user_id = p_user_id;

  INSERT INTO user_historial (
    changed_user_id, maker_user_id, type_change_id,
    user_historial_date, user_historial_description,
    old_user_name, old_user_mail, old_user_tel, old_state_user_id, old_gender_id,
    new_user_name, new_user_mail, new_user_tel, new_state_user_id, new_gender_id
  )
  VALUES (
    p_user_id, p_maker_user_id, 3,
    NOW(), 'Cambio de estado del usuario',
    v_user_name, v_user_mail, v_user_tel, v_old_state_user_id, v_gender_id,
    v_user_name, v_user_mail, v_user_tel, p_new_state_user_id, v_gender_id
  );
END //

-- Editar usuario completo
CREATE PROCEDURE edit_user (
  IN p_user_id INT,
  IN p_new_user_name VARCHAR(30),
  IN p_new_user_mail VARCHAR(100),
  IN p_new_user_tel VARCHAR(10),
  IN p_new_state_user_id INT,
  IN p_new_gender_id INT,
  IN p_maker_user_id INT
)
BEGIN
  DECLARE v_old_name VARCHAR(30);
  DECLARE v_old_mail VARCHAR(100);
  DECLARE v_old_tel VARCHAR(10);
  DECLARE v_old_state INT;
  DECLARE v_old_gender INT;

  SELECT user_name, user_mail, user_tel, state_user_id, gender_id
  INTO v_old_name, v_old_mail, v_old_tel, v_old_state, v_old_gender
  FROM user WHERE user_id = p_user_id;

  UPDATE user
  SET user_name = p_new_user_name,
      user_mail = p_new_user_mail,
      user_tel = p_new_user_tel,
      state_user_id = p_new_state_user_id,
      gender_id = p_new_gender_id
  WHERE user_id = p_user_id;

  INSERT INTO user_historial (
    changed_user_id, maker_user_id, type_change_id,
    user_historial_date, user_historial_description,
    old_user_name, old_user_mail, old_user_tel, old_state_user_id, old_gender_id,
    new_user_name, new_user_mail, new_user_tel, new_state_user_id, new_gender_id
  )
  VALUES (
    p_user_id, p_maker_user_id, 2,
    NOW(), 'Edición de usuario',
    v_old_name, v_old_mail, v_old_tel, v_old_state, v_old_gender,
    p_new_user_name, p_new_user_mail, p_new_user_tel, p_new_state_user_id, p_new_gender_id
  );
END //




-- Eliminación lógica de usuario (estado = 4)
CREATE PROCEDURE delete_user_logico (
  IN p_user_id INT,
  IN p_maker_user_id INT
)
BEGIN
  DECLARE v_old_name VARCHAR(30);
  DECLARE v_old_mail VARCHAR(100);
  DECLARE v_old_tel VARCHAR(10);
  DECLARE v_old_state INT;
  DECLARE v_old_gender INT;

  SELECT user_name, user_mail, user_tel, state_user_id, gender_id
  INTO v_old_name, v_old_mail, v_old_tel, v_old_state, v_old_gender
  FROM user
  WHERE user_id = p_user_id;

  UPDATE user
  SET state_user_id = 4
  WHERE user_id = p_user_id;

  INSERT INTO user_historial (
    changed_user_id, maker_user_id, type_change_id,
    user_historial_date, user_historial_description,
    old_user_name, old_user_mail, old_user_tel, old_state_user_id, old_gender_id,
    new_user_name, new_user_mail, new_user_tel, new_state_user_id, new_gender_id
  )
  VALUES (
    p_user_id, p_maker_user_id, 3,
    NOW(), 'Eliminación lógica de usuario',
    v_old_name, v_old_mail, v_old_tel, v_old_state, v_old_gender,
    v_old_name, v_old_mail, v_old_tel, 4, v_old_gender
  );
END //

-- Login (por correo, numero o nicname y contraseña)

CREATE PROCEDURE get_user_by_credentials (
  IN p_user_identifier VARCHAR(100),  -- Cambiamos el nombre del parámetro
  IN p_user_password VARCHAR(60)
)
BEGIN
  SELECT user.user_name , user.user_mail , user.user_tel, user.state_user_id
  FROM user
  WHERE (user_mail = p_user_identifier OR user_tel = p_user_identifier OR user_name = p_user_identifier)
    AND user_password = p_user_password
    AND state_user_id = 1;
END //

-- Paginado de usuarios
CREATE PROCEDURE get_users_paginated (
  IN p_start_user_id INT
)
BEGIN
  SELECT *
  FROM user
  WHERE user_id >= p_start_user_id
    AND state_user_id = 1
  ORDER BY user_id
  LIMIT 50;
END //


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
  SELECT * FROM service WHERE servicie_id = p_service_id;
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
  WHERE servicie_id = p_service_id;
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
  WHERE servicie_id = p_service_id;

  -- Marcar como inactivo
  UPDATE service
  SET state_objets_id = 4
  WHERE servicie_id = p_service_id;

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

CREATE PROCEDURE get_services_active ()
BEGIN
  SELECT 
    s.servicie_id,
    s.service_name,
    s.service_description,
    s.service_descuento,
    i.imgs_id,
    i.imgs_name,
    i.imgs_url
  FROM service s
  INNER JOIN imgs i ON s.imgs_id = i.imgs_id
  WHERE s.state_objets_id = 1 AND i.state_objets_id = 1;
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
  WHERE servicie_id = p_service_id
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


CREATE PROCEDURE add_imgs (
  IN p_imgs_name VARCHAR(30),
  IN p_imgs_url VARCHAR(200),
  IN p_imgs_description VARCHAR(300),
  IN p_state_objets_id INT
)
BEGIN
  INSERT INTO imgs (
    imgs_name, imgs_url, imgs_description, state_objets_id
  ) VALUES (
    p_imgs_name, p_imgs_url, p_imgs_description, p_state_objets_id
  );
END //

DELIMITER ;