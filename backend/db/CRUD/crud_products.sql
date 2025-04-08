DELIMITER //

CREATE PROCEDURE add_product (
  IN p_producst_name VARCHAR(30),
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
  IN p_new_producst_name VARCHAR(30),
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
  IN p_producst_name VARCHAR(30)
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

DELIMITER ;

-----                                 ----------------------------------------------

DELIMITER //

CREATE PROCEDURE get_products_by_price_range (
  IN p_min_price DECIMAL(9,2),
  IN p_max_price DECIMAL(9,2)
)
BEGIN
  SELECT * FROM products
  WHERE CAST(products_precio AS DECIMAL(9,2)) BETWEEN p_min_price AND p_max_price
  ORDER BY CAST(products_precio AS DECIMAL(9,2));
END //

DELIMITER ;
