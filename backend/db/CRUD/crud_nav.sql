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

DELIMITER ;

DELIMITER //

CREATE PROCEDURE get_nav_by_state_with_img (
  IN p_state_objets_id VARCHAR(10)
)
BEGIN
  IF p_state_objets_id = 'all' THEN
    SELECT 
      nav.*, 
      img.img_id, 
      img.img_name, 
      img.img_url
    FROM nav
    LEFT JOIN img ON nav.img_id = img.img_id;
  ELSE
    SELECT 
      nav.*, 
      img.img_id, 
      img.img_name, 
      img.img_url
    FROM nav
    LEFT JOIN img ON nav.img_id = img.img_id
    WHERE nav.state_objets_id = CAST(p_state_objets_id AS UNSIGNED);
  END IF;
END //

DELIMITER ;
