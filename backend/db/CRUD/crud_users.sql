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
