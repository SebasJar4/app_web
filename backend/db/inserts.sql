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
