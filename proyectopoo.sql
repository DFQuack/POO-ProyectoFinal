-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-05-2025 a las 06:22:14
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyectopoo`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT 'Nombre de usuario único',
  `password` varchar(255) NOT NULL COMMENT 'Contraseña hasheada',
  `email` varchar(100) NOT NULL COMMENT 'Email del usuario',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Fecha de creación',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Fecha de última actualización',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_username` (`username`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de usuarios del sistema';

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `password`, `email`, `created_at`, `updated_at`) VALUES
(1, 'Kevin12', '$2a$10$UwgAUY2Vy6ohMrZXg0ZIVe58ixTMeK08VQLugCVFP6zvxWWjELpW.', '12345', '2025-05-16 03:58:03', '2025-05-16 03:58:03');

-- --------------------------------------------------------

--
-- Procedimientos CRUD para la tabla usuarios
--

DELIMITER //

-- Procedimiento para crear un nuevo usuario
CREATE PROCEDURE `sp_create_usuario`(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_email VARCHAR(100)
)
BEGIN
    INSERT INTO usuarios (username, password, email)
    VALUES (p_username, p_password, p_email);
    
    SELECT LAST_INSERT_ID() AS new_id;
END //

-- Procedimiento para leer un usuario por ID
CREATE PROCEDURE `sp_read_usuario_by_id`(
    IN p_id INT
)
BEGIN
    SELECT * FROM usuarios WHERE id = p_id;
END //

-- Procedimiento para leer un usuario por username
CREATE PROCEDURE `sp_read_usuario_by_username`(
    IN p_username VARCHAR(50)
)
BEGIN
    SELECT * FROM usuarios WHERE username = p_username;
END //

-- Procedimiento para leer un usuario por email
CREATE PROCEDURE `sp_read_usuario_by_email`(
    IN p_email VARCHAR(100)
)
BEGIN
    SELECT * FROM usuarios WHERE email = p_email;
END //

-- Procedimiento para leer todos los usuarios
CREATE PROCEDURE `sp_read_all_usuarios`()
BEGIN
    SELECT id, username, email, created_at, updated_at FROM usuarios;
END //

-- Procedimiento para actualizar un usuario
CREATE PROCEDURE `sp_update_usuario`(
    IN p_id INT,
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_email VARCHAR(100)
)
BEGIN
    UPDATE usuarios 
    SET 
        username = p_username,
        password = p_password,
        email = p_email
    WHERE id = p_id;
    
    SELECT ROW_COUNT() AS affected_rows;
END //

-- Procedimiento para eliminar un usuario
CREATE PROCEDURE `sp_delete_usuario`(
    IN p_id INT
)
BEGIN
    DELETE FROM usuarios WHERE id = p_id;
    SELECT ROW_COUNT() AS affected_rows;
END //

-- Procedimiento para verificar credenciales de login
CREATE PROCEDURE `sp_verify_login`(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255)
)
BEGIN
    SELECT id, username, email FROM usuarios 
    WHERE username = p_username AND password = p_password;
END //

DELIMITER ;

-- --------------------------------------------------------

--
-- Ejemplos de uso de los procedimientos almacenados
--

-- Crear un nuevo usuario
CALL sp_create_usuario('MariaG', '$2a$10$nuevohasheado', 'maria@example.com');

-- Leer usuario por ID
CALL sp_read_usuario_by_id(1);

-- Leer usuario por username
CALL sp_read_usuario_by_username('Kevin12');

-- Leer usuario por email
CALL sp_read_usuario_by_email('12345');

-- Leer todos los usuarios
CALL sp_read_all_usuarios();

-- Actualizar un usuario
CALL sp_update_usuario(1, 'Kevin12_updated', '$2a$10$nuevohasheado', 'nuevo@email.com');

-- Eliminar un usuario
CALL sp_delete_usuario(2);

-- Verificar credenciales de login
CALL sp_verify_login('Kevin12', '$2a$10$UwgAUY2Vy6ohMrZXg0ZIVe58ixTMeK08VQLugCVFP6zvxWWjELpW.');

-- --------------------------------------------------------

--
-- Triggers para la tabla usuarios
--

DELIMITER //

-- Trigger para registrar antes de insertar
CREATE TRIGGER `before_usuario_insert`
BEFORE INSERT ON `usuarios`
FOR EACH ROW
BEGIN
    -- Puedes agregar validaciones aquí
    IF NEW.username = '' OR NEW.password = '' OR NEW.email = '' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Username, password y email son campos requeridos';
    END IF;
END //

-- Trigger para registrar después de insertar
CREATE TRIGGER `after_usuario_insert`
AFTER INSERT ON `usuarios`
FOR EACH ROW
BEGIN
    -- Puedes agregar lógica de auditoría aquí
    INSERT INTO auditoria_usuarios (accion, usuario_id, detalle)
    VALUES ('INSERT', NEW.id, CONCAT('Nuevo usuario creado: ', NEW.username));
END //

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabla de auditoría para usuarios (opcional)
--

CREATE TABLE IF NOT EXISTS `auditoria_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accion` varchar(20) NOT NULL COMMENT 'Tipo de acción (INSERT, UPDATE, DELETE)',
  `usuario_id` int(11) NOT NULL COMMENT 'ID del usuario afectado',
  `detalle` text DEFAULT NULL COMMENT 'Detalles de la acción',
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Fecha de la acción',
  PRIMARY KEY (`id`),
  KEY `idx_usuario_id` (`usuario_id`),
  KEY `idx_fecha` (`fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Auditoría de cambios en usuarios';

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
