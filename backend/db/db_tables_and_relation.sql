
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
  `service_id` INT,
  `nav_description` VARCHAR(300),
  `state_objets_id` INT,
  `url` VARCHAR(100),
  `imgs_id` INT,  -- Clave foránea que apunta a una imagen

  CONSTRAINT fk_imgs_id FOREIGN KEY (`imgs_id`) REFERENCES `imgs`(`imgs_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE=InnoDB;



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
  `old_new_service_id` int,
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

ALTER TABLE `historial_nav` ADD FOREIGN KEY (`old_new_service_id`) REFERENCES `service` (`servicie_id`);

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