
-- Eliminación y creación de base de datos
DROP DATABASE IF EXISTS `your_place_safed`;
CREATE DATABASE IF NOT EXISTS `your_place_safed`;
USE `your_place_safed`;

-- Tablas base
CREATE TABLE `state_user` (
  `state_user_id` int AUTO_INCREMENT PRIMARY KEY,
  `state_user_name` varchar(20),
  `state_user_description` varchar(300)
);

CREATE TABLE `gender` (
  `gender_id` int AUTO_INCREMENT PRIMARY KEY,
  `gender_name` varchar(20),
  `gender_description` varchar(300)
);

CREATE TABLE `user` (
  `user_id` int AUTO_INCREMENT PRIMARY KEY,
  `user_name` varchar(30),
  `user_mail` varchar(100),
  `user_tel` varchar(10),
  `state_user_id` int,
  `gender_id` int
);

CREATE TABLE `type_change` (
  `type_change_id` int AUTO_INCREMENT PRIMARY KEY,
  `type_change_name` varchar(6),
  `type_change_description` varchar(300)
);

CREATE TABLE `user_historial` (
  `user_historial_id` int AUTO_INCREMENT PRIMARY KEY,
  `changed_user_id` int,
  `maker_user_id` int,
  `type_change_id` int,
  `user_historial_date` datetime,
  `user_historial_description` varchar(300),
  `old_user_name` varchar(30),
  `old_user_mail` varchar(100),
  `old_user_tel` varchar(10),
  `old_state_user_id` int,
  `old_gender_id` int,
  `new_user_name` varchar(30),
  `new_user_mail` varchar(100),
  `new_user_tel` varchar(10),
  `new_state_user_id` int,
  `new_gender_id` int
);

CREATE TABLE `state_objets` (
  `state_objets_id` int AUTO_INCREMENT PRIMARY KEY,
  `state_objets_name` varchar(20),
  `state_objets_description` varchar(300)
);

CREATE TABLE `imgs` (
  `imgs_id` int AUTO_INCREMENT PRIMARY KEY,
  `imgs_name` varchar(30),
  `imgs_url` varchar(200),
  `imgs_description` varchar(300),
  `state_objets_id` int
);

CREATE TABLE `service` (
  `servicie_id` int AUTO_INCREMENT PRIMARY KEY,
  `service_name` varchar(40),
  `service_description` varchar(300),
  `imgs_id` int,
  `service_descuento` int,
  `state_objets_id` int
);

CREATE TABLE `nav` (
  `nav_id` INT AUTO_INCREMENT PRIMARY KEY,
  `nav_name` VARCHAR(50),
  `url` VARCHAR(100),  -- nuevo campo
  `service_id` INT,
  `nav_description` VARCHAR(300),
  `state_objets_id` INT
);


CREATE TABLE `historial_nav` (
  `historial_nav_id` int AUTO_INCREMENT PRIMARY KEY,
  `maker_user_id` int,
  `changed_nav_id` int,
  `type_change_id` int,
  `historial_nav_date` datetime,
  `historial_nav_description` varchar(300),
  `new_nav_name` varchar(50),
  `new_service_id` int,
  `new_nav_description` varchar(300),
  `new_state_objets_id` int,
  `old_nav_name` varchar(50),
  `old_service_id` int,
  `old_nav_description` varchar(300),
  `old_state_objets_id` int
);

CREATE TABLE `historial_service` (
  `historial_service_id` int AUTO_INCREMENT PRIMARY KEY,
  `maker_user_id` int,
  `changed_service_id` int,
  `type_change_id` int,
  `historial_service_date` datetime,
  `historial_service_description` varchar(300),
  `new_service_name` varchar(40),
  `new_service_description` varchar(300),
  `new_imgs_id` int,
  `new_service_descuento` int,
  `new_state_objets_id` int,
  `old_service_name` varchar(40),
  `old_service_description` varchar(300),
  `old_imgs_id` int,
  `old_service_descuento` int,
  `old_state_objets_id` int
);

CREATE TABLE `products` (
  `products_id` int AUTO_INCREMENT PRIMARY KEY,
  `producst_name` varchar(30),
  `imgs_id` int,
  `products_description` varchar(300),
  `products_precio` varchar(9),
  `state_objets_id` int
);

CREATE TABLE `service_products` (
  `service_products_id` int AUTO_INCREMENT PRIMARY KEY,
  `imgs_id` int,
  `service_id` int,
  `products_id` int,
  `state_objets_id` int
);

CREATE TABLE `historial_service_products` (
  `historial_service_id` int AUTO_INCREMENT PRIMARY KEY,
  `maker_user_id` int,
  `changed_service_products_id` int,
  `type_change_id` int,
  `historial_service_date` datetime,
  `historial_service_description` varchar(300),
  `new_imgs_id` int,
  `new_service_id` int,
  `new_products_id` int,
  `new_state_objets_id` int,
  `old_imgs_id` int,
  `old_service_id` int,
  `old_products_id` int,
  `old_state_objets_id` int
);

CREATE TABLE `historial_products` (
  `historial_products_id` int AUTO_INCREMENT PRIMARY KEY,
  `maker_user_id` int,
  `changed_historial_products_id` int,
  `type_change_id` int,
  `historial_products_date` datetime,
  `historial_products_description` varchar(300),
  `new_producst_name` varchar(30),
  `new_imgs_id` int,
  `new_products_description` varchar(300),
  `new_products_precio` varchar(9),
  `new_state_objets_id` int,
  `old_producst_name` varchar(30),
  `old_imgs_id` int,
  `old_products_description` varchar(300),
  `old_products_precio` varchar(9),
  `old_state_objets_id` int
);



ALTER TABLE `user` ADD FOREIGN KEY (`state_user_id`) REFERENCES `state_user` (`state_user_id`);

ALTER TABLE `user` ADD FOREIGN KEY (`gender_id`) REFERENCES `gender` (`gender_id`);

ALTER TABLE `user_historial` ADD FOREIGN KEY (`changed_user_id`) REFERENCES `user` (`user_id`);

ALTER TABLE `user_historial` ADD FOREIGN KEY (`maker_user_id`) REFERENCES `user` (`user_id`);

ALTER TABLE `user_historial` ADD FOREIGN KEY (`type_change_id`) REFERENCES `type_change` (`type_change_id`);

ALTER TABLE `user_historial` ADD FOREIGN KEY (`old_state_user_id`) REFERENCES `state_user` (`state_user_id`);

ALTER TABLE `user_historial` ADD FOREIGN KEY (`old_gender_id`) REFERENCES `gender` (`gender_id`);

ALTER TABLE `user_historial` ADD FOREIGN KEY (`new_state_user_id`) REFERENCES `state_user` (`state_user_id`);

ALTER TABLE `user_historial` ADD FOREIGN KEY (`new_gender_id`) REFERENCES `gender` (`gender_id`);

ALTER TABLE `service` ADD FOREIGN KEY (`imgs_id`) REFERENCES `imgs` (`imgs_id`);

ALTER TABLE `service` ADD FOREIGN KEY (`state_objets_id`) REFERENCES `state_objets` (`state_objets_id`);

ALTER TABLE `nav` ADD FOREIGN KEY (`service_id`) REFERENCES `service` (`servicie_id`);

ALTER TABLE `nav` ADD FOREIGN KEY (`state_objets_id`) REFERENCES `state_objets` (`state_objets_id`);

ALTER TABLE `imgs` ADD FOREIGN KEY (`state_objets_id`) REFERENCES `state_objets` (`state_objets_id`);

ALTER TABLE `historial_nav` ADD FOREIGN KEY (`maker_user_id`) REFERENCES `user` (`user_id`);

ALTER TABLE `historial_nav` ADD FOREIGN KEY (`changed_nav_id`) REFERENCES `nav` (`nav_id`);

ALTER TABLE `historial_nav` ADD FOREIGN KEY (`type_change_id`) REFERENCES `type_change` (`type_change_id`);

ALTER TABLE `historial_nav` ADD FOREIGN KEY (`new_service_id`) REFERENCES `service` (`servicie_id`);

ALTER TABLE `historial_nav` ADD FOREIGN KEY (`new_state_objets_id`) REFERENCES `state_objets` (`state_objets_id`);

ALTER TABLE `historial_nav` ADD FOREIGN KEY (`old_service_id`) REFERENCES `service` (`servicie_id`);

ALTER TABLE `historial_nav` ADD FOREIGN KEY (`old_state_objets_id`) REFERENCES `state_objets` (`state_objets_id`);

ALTER TABLE `historial_service` ADD FOREIGN KEY (`maker_user_id`) REFERENCES `user` (`user_id`);

ALTER TABLE `historial_service` ADD FOREIGN KEY (`changed_service_id`) REFERENCES `service` (`servicie_id`);

ALTER TABLE `historial_service` ADD FOREIGN KEY (`type_change_id`) REFERENCES `type_change` (`type_change_id`);

ALTER TABLE `historial_service` ADD FOREIGN KEY (`new_imgs_id`) REFERENCES `imgs` (`imgs_id`);

ALTER TABLE `historial_service` ADD FOREIGN KEY (`old_imgs_id`) REFERENCES `imgs` (`imgs_id`);

ALTER TABLE `service_products` ADD FOREIGN KEY (`imgs_id`) REFERENCES `imgs` (`imgs_id`);

ALTER TABLE `service_products` ADD FOREIGN KEY (`service_id`) REFERENCES `service` (`servicie_id`);

ALTER TABLE `service_products` ADD FOREIGN KEY (`products_id`) REFERENCES `products` (`products_id`);

ALTER TABLE `service_products` ADD FOREIGN KEY (`state_objets_id`) REFERENCES `state_objets` (`state_objets_id`);

ALTER TABLE `historial_service_products` ADD FOREIGN KEY (`maker_user_id`) REFERENCES `user` (`user_id`);

ALTER TABLE `historial_service_products` ADD FOREIGN KEY (`changed_service_products_id`) REFERENCES `service_products` (`service_products_id`);

ALTER TABLE `historial_service_products` ADD FOREIGN KEY (`type_change_id`) REFERENCES `type_change` (`type_change_id`);

ALTER TABLE `historial_service_products` ADD FOREIGN KEY (`new_imgs_id`) REFERENCES `imgs` (`imgs_id`);

ALTER TABLE `historial_service_products` ADD FOREIGN KEY (`new_service_id`) REFERENCES `service` (`servicie_id`);

ALTER TABLE `historial_service_products` ADD FOREIGN KEY (`new_products_id`) REFERENCES `products` (`products_id`);

ALTER TABLE `historial_service_products` ADD FOREIGN KEY (`new_state_objets_id`) REFERENCES `state_objets` (`state_objets_id`);

ALTER TABLE `historial_service_products` ADD FOREIGN KEY (`old_imgs_id`) REFERENCES `imgs` (`imgs_id`);

ALTER TABLE `historial_service_products` ADD FOREIGN KEY (`old_service_id`) REFERENCES `service` (`servicie_id`);

ALTER TABLE `historial_service_products` ADD FOREIGN KEY (`old_products_id`) REFERENCES `products` (`products_id`);

ALTER TABLE `historial_service_products` ADD FOREIGN KEY (`old_state_objets_id`) REFERENCES `state_objets` (`state_objets_id`);

ALTER TABLE `products` ADD FOREIGN KEY (`imgs_id`) REFERENCES `imgs` (`imgs_id`);

ALTER TABLE `products` ADD FOREIGN KEY (`state_objets_id`) REFERENCES `state_objets` (`state_objets_id`);

ALTER TABLE `historial_products` ADD FOREIGN KEY (`maker_user_id`) REFERENCES `user` (`user_id`);

ALTER TABLE `historial_products` ADD FOREIGN KEY (`changed_historial_products_id`) REFERENCES `products` (`products_id`);

ALTER TABLE `historial_products` ADD FOREIGN KEY (`type_change_id`) REFERENCES `type_change` (`type_change_id`);

ALTER TABLE `historial_products` ADD FOREIGN KEY (`new_imgs_id`) REFERENCES `imgs` (`imgs_id`);

ALTER TABLE `historial_products` ADD FOREIGN KEY (`new_state_objets_id`) REFERENCES `state_objets` (`state_objets_id`);

ALTER TABLE `historial_products` ADD FOREIGN KEY (`old_imgs_id`) REFERENCES `imgs` (`imgs_id`);

ALTER TABLE `historial_products` ADD FOREIGN KEY (`old_state_objets_id`) REFERENCES `state_objets` (`state_objets_id`);




DELIMITER //

-- Agregar nav
CREATE PROCEDURE add_nav (
  IN p_nav_name VARCHAR(50),
  IN p_service_id INT,
  IN p_nav_description VARCHAR(300),
  IN p_state_objets_id INT,
  IN p_url VARCHAR(100),
  IN p_maker_user_id INT
)
BEGIN
  INSERT INTO nav (
    nav_name, service_id, nav_description, state_objets_id, url
  )
  VALUES (
    p_nav_name, p_service_id, p_nav_description, p_state_objets_id, p_url
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


DELIMITER //
-- Editar nav
CREATE PROCEDURE edit_nav (
  IN p_nav_id INT,
  IN p_new_nav_name VARCHAR(50),
  IN p_new_service_id INT,
  IN p_new_nav_description VARCHAR(300),
  IN p_new_state_objets_id INT,
  IN p_new_url VARCHAR(100),
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
      url = p_new_url
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
  SELECT *
  FROM nav
  WHERE nav_id = p_nav_id;
END //

-- Buscar nav por nombre (like)
CREATE PROCEDURE get_nav_by_name (
  IN p_nav_name VARCHAR(50)
)
BEGIN
  SELECT *
  FROM nav
  WHERE nav_name LIKE CONCAT('%', p_nav_name, '%');
END //

-- Obtener navs por estado (con opción 'all')
CREATE PROCEDURE get_nav_by_state (
  IN p_state_objets_id VARCHAR(10) -- puede ser 'all'
)
BEGIN
  IF p_state_objets_id = 'all' THEN
    SELECT * FROM nav;
  ELSE
    SELECT *
    FROM nav
    WHERE state_objets_id = CAST(p_state_objets_id AS UNSIGNED);
  END IF;
END //

DELIMITER ;




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
DELIMITER //

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

-- Login (por correo y contraseña)
CREATE PROCEDURE get_user_by_credentials (
  IN p_user_mail VARCHAR(100),
  IN p_user_password VARCHAR(100)
)
BEGIN
  SELECT *
  FROM user
  WHERE user_mail = p_user_mail
    AND user_password = p_user_password
    AND state_user_id = 1;
END //

-- Buscar por contraseña
CREATE PROCEDURE get_user_by_password (
  IN p_user_password VARCHAR(100)
)
BEGIN
  SELECT *
  FROM user
  WHERE user_password = p_user_password
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

DELIMITER ;

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

-- Genders
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

call add_user(
  "admin",
  "sebas.jara.mon1@gmail.com",
  "3054102953",
  3,
  1,
  NULL
);

call add_nav (
  "Home",
  NULL,
  "Interfaz/penstaña donde todos los usuarios entran de primeras para ofrecer mis servicios",
  1,
  "Home",
  1
);

call add_nav (
  "Services",
  NULL,
  "Interfaz donde vamos a poner nuestras categorias de servicios",
  1,
  "Services",
  1
);