DROP USER IF EXISTS 'guest_your_place_safed'@'localhost'; 
CREATE USER 'guest_your_place_safed'@'localhost' IDENTIFIED BY 'im a guest';
GRANT EXECUTE ON PROCEDURE your_place_safed.get_user_by_credentials TO 'guest_your_place_safed'@'localhost';
GRANT EXECUTE ON PROCEDURE your_place_safed.get_nav_active_with_imgs TO 'guest_your_place_safed'@'localhost';
GRANT EXECUTE ON PROCEDURE your_place_safed.get_services_active TO 'guest_your_place_safed'@'localhost';
GRANT EXECUTE ON PROCEDURE your_place_safed.get_services_by_discount_range TO 'guest_your_place_safed'@'localhost';
GRANT EXECUTE ON PROCEDURE your_place_safed.get_service_active_products TO 'guest_your_place_safed'@'localhost';
GRANT EXECUTE ON PROCEDURE your_place_safed.get_products_by_price_range TO 'guest_your_place_safed'@'localhost';
GRANT EXECUTE ON PROCEDURE your_place_safed.get_state_services TO 'guest_your_place_safed'@'localhost';
FLUSH PRIVILEGES;