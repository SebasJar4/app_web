-- Tablas base
CREATE TABLE `state_user` (
  `state_user_id` INT AUTO_INCREMENT PRIMARY KEY,
  `state_user_name` VARCHAR(20),
  `state_user_description` VARCHAR(300)
);

CREATE TABLE `gender` (
  `gender_id` INT AUTO_INCREMENT PRIMARY KEY,
  `gender_name` VARCHAR(20),
  `gender_description` VARCHAR(300)
);

CREATE TABLE `user` (
  `user_id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_name` VARCHAR(30),
  `user_mail` VARCHAR(100),
  `user_tel` VARCHAR(10),
  `user_password` VARCHAR(60),
  `state_user_id` INT,
  `gender_id` INT
);

CREATE TABLE `type_change` (
  `type_change_id` INT AUTO_INCREMENT PRIMARY KEY,
  `type_change_name` VARCHAR(6),
  `type_change_description` VARCHAR(300)
);

CREATE TABLE `user_historial` (
  `user_historial_id` INT AUTO_INCREMENT PRIMARY KEY,
  `changed_user_id` INT,
  `maker_user_id` INT,
  `type_change_id` INT,
  `user_historial_date` DATETIME,
  `user_historial_description` VARCHAR(300),
  `old_user_name` VARCHAR(30),
  `old_user_mail` VARCHAR(100),
  `old_user_tel` VARCHAR(10),
  `old_state_user_id` INT,
  `old_gender_id` INT,
  `new_user_name` VARCHAR(30),
  `new_user_mail` VARCHAR(100),
  `new_user_tel` VARCHAR(10),
  `new_state_user_id` INT,
  `new_gender_id` INT
);

CREATE TABLE `state_objets` (
  `state_objets_id` INT AUTO_INCREMENT PRIMARY KEY,
  `state_objets_name` VARCHAR(20),
  `state_objets_description` VARCHAR(300)
);

CREATE TABLE `imgs` (
  `imgs_id` INT AUTO_INCREMENT PRIMARY KEY,
  `imgs_name` VARCHAR(30),
  `imgs_url` VARCHAR(200),
  `imgs_description` VARCHAR(300),
  `state_objets_id` INT
);

CREATE TABLE `service` (
  `servicie_id` INT AUTO_INCREMENT PRIMARY KEY,
  `service_name` VARCHAR(40),
  `service_description` VARCHAR(300),
  `imgs_id` INT,
  `service_descuento` INT,
  `state_objets_id` INT
);

CREATE TABLE `nav` (
  `nav_id` INT AUTO_INCREMENT PRIMARY KEY,
  `nav_name` VARCHAR(50),
  `service_id` INT,
  `nav_description` VARCHAR(300),
  `state_objets_id` INT,
  `url` VARCHAR(100),
  `imgs_id` INT,

  CONSTRAINT fk_imgs_id FOREIGN KEY (`imgs_id`) REFERENCES `imgs`(`imgs_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `historial_nav` (
  `historial_nav_id` INT AUTO_INCREMENT PRIMARY KEY,
  `maker_user_id` INT,
  `changed_nav_id` INT,
  `type_change_id` INT,
  `historial_nav_date` DATETIME,
  `historial_nav_description` VARCHAR(300),
  `new_nav_name` VARCHAR(50),
  `new_service_id` INT,
  `new_nav_description` VARCHAR(300),
  `new_state_objets_id` INT,
  `old_nav_name` VARCHAR(50),
  `old_service_id` INT,
  `old_nav_description` VARCHAR(300),
  `old_state_objets_id` INT
);

CREATE TABLE `historial_service` (
  `historial_service_id` INT AUTO_INCREMENT PRIMARY KEY,
  `maker_user_id` INT,
  `changed_service_id` INT,
  `type_change_id` INT,
  `historial_service_date` DATETIME,
  `historial_service_description` VARCHAR(300),
  `new_service_name` VARCHAR(40),
  `new_service_description` VARCHAR(300),
  `new_imgs_id` INT,
  `new_service_descuento` INT,
  `new_state_objets_id` INT,
  `old_service_name` VARCHAR(40),
  `old_service_description` VARCHAR(300),
  `old_imgs_id` INT,
  `old_service_descuento` INT,
  `old_state_objets_id` INT
);

CREATE TABLE `products` (
  `products_id` INT AUTO_INCREMENT PRIMARY KEY,
  `producst_name` VARCHAR(50),
  `imgs_id` INT,
  `products_description` VARCHAR(300),
  `products_precio` VARCHAR(9),
  `state_objets_id` INT
);

CREATE TABLE `service_products` (
  `service_products_id` INT AUTO_INCREMENT PRIMARY KEY,
  `imgs_id` INT,
  `service_id` INT,
  `products_id` INT,
  `state_objets_id` INT
);

CREATE TABLE `historial_service_products` (
  `historial_service_id` INT AUTO_INCREMENT PRIMARY KEY,
  `maker_user_id` INT,
  `changed_service_products_id` INT,
  `type_change_id` INT,
  `historial_service_date` DATETIME,
  `historial_service_description` VARCHAR(300),
  `new_imgs_id` INT,
  `new_service_id` INT,
  `new_products_id` INT,
  `new_state_objets_id` INT,
  `old_imgs_id` INT,
  `old_service_id` INT,
  `old_products_id` INT,
  `old_state_objets_id` INT
);

CREATE TABLE `historial_products` (
  `historial_products_id` INT AUTO_INCREMENT PRIMARY KEY,
  `maker_user_id` INT,
  `changed_historial_products_id` INT,
  `type_change_id` INT,
  `historial_products_date` DATETIME,
  `historial_products_description` VARCHAR(300),
  `new_producst_name` VARCHAR(50),
  `new_imgs_id` INT,
  `new_products_description` VARCHAR(300),
  `new_products_precio` VARCHAR(9),
  `new_state_objets_id` INT,
  `old_producst_name` VARCHAR(50),
  `old_imgs_id` INT,
  `old_products_description` VARCHAR(300),
  `old_products_precio` VARCHAR(9),
  `old_state_objets_id` INT
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