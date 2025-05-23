-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-05-2025 a las 22:51:31
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
-- Base de datos: `proyectopoo2`
--

DELIMITER $$
--
-- Procedimientos
--

-- Usuario Procedures
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_usuario` (IN `p_username` VARCHAR(50), IN `p_password` VARCHAR(255), IN `p_email` VARCHAR(100))   BEGIN
    INSERT INTO usuarios (username, password, email)
    VALUES (p_username, p_password, p_email);
    
    SELECT LAST_INSERT_ID() AS new_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_usuario` (IN `p_id` INT)   BEGIN
    DELETE FROM usuarios WHERE id = p_id;
    SELECT ROW_COUNT() AS affected_rows;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_read_all_usuarios` ()   BEGIN
    SELECT id, username, email, created_at, updated_at FROM usuarios;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_read_usuario_by_email` (IN `p_email` VARCHAR(100))   BEGIN
    SELECT * FROM usuarios WHERE email = p_email;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_read_usuario_by_id` (IN `p_id` INT)   BEGIN
    SELECT * FROM usuarios WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_read_usuario_by_username` (IN `p_username` VARCHAR(50))   BEGIN
    SELECT * FROM usuarios WHERE username = p_username;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_usuario` (IN `p_id` INT, IN `p_username` VARCHAR(50), IN `p_password` VARCHAR(255), IN `p_email` VARCHAR(100))   BEGIN
    UPDATE usuarios 
    SET 
        username = p_username,
        password = p_password,
        email = p_email
    WHERE id = p_id;
    
    SELECT ROW_COUNT() AS affected_rows;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_verify_login` (IN `p_username` VARCHAR(50), IN `p_password` VARCHAR(255))   BEGIN
    SELECT id, username, email FROM usuarios 
    WHERE username = p_username AND password = p_password;
END$$

-- Persona Procedures
CREATE PROCEDURE `sp_create_persona` (
    IN `p_nombre` VARCHAR(100),
    IN `p_documento` VARCHAR(20),
    IN `p_telefono` VARCHAR(20),
    IN `p_direccion` VARCHAR(200)
)
BEGIN
    INSERT INTO persona (nombre, documento, telefono, direccion)
    VALUES (p_nombre, p_documento, p_telefono, p_direccion);
    
    SELECT LAST_INSERT_ID() AS new_id;
END$$

CREATE PROCEDURE `sp_read_persona_by_id` (IN `p_id` INT)
BEGIN
    SELECT * FROM persona WHERE id = p_id;
END$$

CREATE PROCEDURE `sp_read_all_personas` ()
BEGIN
    SELECT * FROM persona;
END$$

CREATE PROCEDURE `sp_update_persona` (
    IN `p_id` INT,
    IN `p_nombre` VARCHAR(100),
    IN `p_documento` VARCHAR(20),
    IN `p_telefono` VARCHAR(20),
    IN `p_direccion` VARCHAR(200)
)
BEGIN
    UPDATE persona 
    SET 
        nombre = p_nombre,
        documento = p_documento,
        telefono = p_telefono,
        direccion = p_direccion
    WHERE id = p_id;
    
    SELECT ROW_COUNT() AS affected_rows;
END$$

CREATE PROCEDURE `sp_delete_persona` (IN `p_id` INT)
BEGIN
    DELETE FROM persona WHERE id = p_id;
    SELECT ROW_COUNT() AS affected_rows;
END$$

-- Empleado Procedures
CREATE PROCEDURE `sp_create_empleado` (
    IN `p_persona_id` INT,
    IN `p_tipo_contratacion` VARCHAR(50),
    IN `p_creado_por` VARCHAR(100)
)
BEGIN
    INSERT INTO empleado (persona_id, tipo_contratacion, estado, creado_por, fecha_creacion, fecha_actualizacion)
    VALUES (p_persona_id, p_tipo_contratacion, 1, p_creado_por, CURDATE(), CURDATE());
    
    SELECT LAST_INSERT_ID() AS new_id;
END$$

CREATE PROCEDURE `sp_read_empleado_by_id` (IN `p_id` INT)
BEGIN
    SELECT e.*, p.nombre, p.documento, p.telefono, p.direccion 
    FROM empleado e
    JOIN persona p ON e.persona_id = p.id
    WHERE e.id = p_id;
END$$

CREATE PROCEDURE `sp_read_all_empleados` ()
BEGIN
    SELECT e.*, p.nombre, p.documento, p.telefono, p.direccion 
    FROM empleado e
    JOIN persona p ON e.persona_id = p.id;
END$$

CREATE PROCEDURE `sp_update_empleado` (
    IN `p_id` INT,
    IN `p_tipo_contratacion` VARCHAR(50),
    IN `p_estado` TINYINT(1)
)
BEGIN
    UPDATE empleado 
    SET 
        tipo_contratacion = p_tipo_contratacion,
        estado = p_estado,
        fecha_actualizacion = CURDATE()
    WHERE id = p_id;
    
    SELECT ROW_COUNT() AS affected_rows;
END$$

CREATE PROCEDURE `sp_delete_empleado` (IN `p_id` INT)
BEGIN
    DELETE FROM empleado WHERE id = p_id;
    SELECT ROW_COUNT() AS affected_rows;
END$$

-- Cotizacion Procedures
CREATE PROCEDURE `sp_create_cotizacion` (
    IN `p_cantidad_horas_proyecto` INT,
    IN `p_fecha_inicio` DATE,
    IN `p_fecha_fin` DATE,
    IN `p_costo_asignaciones` DECIMAL(10,2),
    IN `p_costos_adicionales` DECIMAL(10,2),
    IN `p_total` DECIMAL(10,2),
    IN `p_estado` VARCHAR(50),
    IN `p_cliente_id` INT
)
BEGIN
    INSERT INTO cotizacion (cantidad_horas_proyecto, fecha_inicio, fecha_fin, costo_asignaciones, costos_adicionales, total, estado, cliente_id)
    VALUES (p_cantidad_horas_proyecto, p_fecha_inicio, p_fecha_fin, p_costo_asignaciones, p_costos_adicionales, p_total, p_estado, p_cliente_id);
    
    SELECT LAST_INSERT_ID() AS new_id;
END$$

CREATE PROCEDURE `sp_read_cotizacion_by_id` (IN `p_id` INT)
BEGIN
    SELECT c.*, u.username AS cliente_username, u.email AS cliente_email
    FROM cotizacion c
    JOIN usuarios u ON c.cliente_id = u.id
    WHERE c.id = p_id;
END$$

CREATE PROCEDURE `sp_read_all_cotizaciones` ()
BEGIN
    SELECT c.*, u.username AS cliente_username, u.email AS cliente_email
    FROM cotizacion c
    JOIN usuarios u ON c.cliente_id = u.id;
END$$

CREATE PROCEDURE `sp_update_cotizacion` (
    IN `p_id` INT,
    IN `p_cantidad_horas_proyecto` INT,
    IN `p_fecha_inicio` DATE,
    IN `p_fecha_fin` DATE,
    IN `p_costo_asignaciones` DECIMAL(10,2),
    IN `p_costos_adicionales` DECIMAL(10,2),
    IN `p_total` DECIMAL(10,2),
    IN `p_estado` VARCHAR(50)
)
BEGIN
    UPDATE cotizacion 
    SET 
        cantidad_horas_proyecto = p_cantidad_horas_proyecto,
        fecha_inicio = p_fecha_inicio,
        fecha_fin = p_fecha_fin,
        costo_asignaciones = p_costo_asignaciones,
        costos_adicionales = p_costos_adicionales,
        total = p_total,
        estado = p_estado
    WHERE id = p_id;
    
    SELECT ROW_COUNT() AS affected_rows;
END$$

CREATE PROCEDURE `sp_delete_cotizacion` (IN `p_id` INT)
BEGIN
    DELETE FROM cotizacion WHERE id = p_id;
    SELECT ROW_COUNT() AS affected_rows;
END$$

-- Asignacion Procedures
CREATE PROCEDURE `sp_create_asignacion` (
    IN `p_titulo_actividad` VARCHAR(100),
    IN `p_fecha_hora_inicio` DATETIME,
    IN `p_fecha_hora_fin` DATETIME,
    IN `p_cantidad_horas` INT,
    IN `p_costo_base` DECIMAL(10,2),
    IN `p_incremento_extra` DECIMAL(10,2),
    IN `p_total` DECIMAL(10,2),
    IN `p_cotizacion_id` INT,
    IN `p_empleado_id` INT
)
BEGIN
    INSERT INTO asignacion (titulo_actividad, fecha_hora_inicio, fecha_hora_fin, cantidad_horas, costo_base, incremento_extra, total, cotizacion_id, empleado_id)
    VALUES (p_titulo_actividad, p_fecha_hora_inicio, p_fecha_hora_fin, p_cantidad_horas, p_costo_base, p_incremento_extra, p_total, p_cotizacion_id, p_empleado_id);
    
    SELECT LAST_INSERT_ID() AS new_id;
END$$

CREATE PROCEDURE `sp_read_asignacion_by_id` (IN `p_id` INT)
BEGIN
    SELECT a.*, e.persona_id, p.nombre AS empleado_nombre, c.cliente_id, u.username AS cliente_username
    FROM asignacion a
    JOIN empleado e ON a.empleado_id = e.id
    JOIN persona p ON e.persona_id = p.id
    JOIN cotizacion c ON a.cotizacion_id = c.id
    JOIN usuarios u ON c.cliente_id = u.id
    WHERE a.id = p_id;
END$$

CREATE PROCEDURE `sp_read_all_asignaciones` ()
BEGIN
    SELECT a.*, e.persona_id, p.nombre AS empleado_nombre, c.cliente_id, u.username AS cliente_username
    FROM asignacion a
    JOIN empleado e ON a.empleado_id = e.id
    JOIN persona p ON e.persona_id = p.id
    JOIN cotizacion c ON a.cotizacion_id = c.id
    JOIN usuarios u ON c.cliente_id = u.id;
END$$

CREATE PROCEDURE `sp_update_asignacion` (
    IN `p_id` INT,
    IN `p_titulo_actividad` VARCHAR(100),
    IN `p_fecha_hora_inicio` DATETIME,
    IN `p_fecha_hora_fin` DATETIME,
    IN `p_cantidad_horas` INT,
    IN `p_costo_base` DECIMAL(10,2),
    IN `p_incremento_extra` DECIMAL(10,2),
    IN `p_total` DECIMAL(10,2))
BEGIN
    UPDATE asignacion 
    SET 
        titulo_actividad = p_titulo_actividad,
        fecha_hora_inicio = p_fecha_hora_inicio,
        fecha_hora_fin = p_fecha_hora_fin,
        cantidad_horas = p_cantidad_horas,
        costo_base = p_costo_base,
        incremento_extra = p_incremento_extra,
        total = p_total
    WHERE id = p_id;
    
    SELECT ROW_COUNT() AS affected_rows;
END$$

CREATE PROCEDURE `sp_delete_asignacion` (IN `p_id` INT)
BEGIN
    DELETE FROM asignacion WHERE id = p_id;
    SELECT ROW_COUNT() AS affected_rows;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignacion`
--

CREATE TABLE `asignacion` (
  `id` int(11) NOT NULL,
  `titulo_actividad` varchar(100) DEFAULT NULL,
  `fecha_hora_inicio` datetime DEFAULT NULL,
  `fecha_hora_fin` datetime DEFAULT NULL,
  `cantidad_horas` int(11) DEFAULT NULL,
  `costo_base` decimal(10,2) DEFAULT NULL,
  `incremento_extra` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `cotizacion_id` int(11) DEFAULT NULL,
  `empleado_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion`
--

CREATE TABLE `cotizacion` (
  `id` int(11) NOT NULL,
  `cantidad_horas_proyecto` int(11) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `costo_asignaciones` decimal(10,2) DEFAULT NULL,
  `costos_adicionales` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `cliente_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id` int(11) NOT NULL,
  `persona_id` int(11) NOT NULL,
  `tipo_contratacion` varchar(50) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT 1,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  `fecha_inactivacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `documento` varchar(20) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `persona_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `estado` tinyint(1) DEFAULT 1,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  `fecha_inactivacion` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asignacion`
--
ALTER TABLE `asignacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cotizacion_id` (`cotizacion_id`),
  ADD KEY `empleado_id` (`empleado_id`);

--
-- Indices de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id`),
  ADD KEY `persona_id` (`persona_id`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `documento` (`documento`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `persona_id` (`persona_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asignacion`
--
ALTER TABLE `asignacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignacion`
--
ALTER TABLE `asignacion`
  ADD CONSTRAINT `asignacion_ibfk_1` FOREIGN KEY (`cotizacion_id`) REFERENCES `cotizacion` (`id`),
  ADD CONSTRAINT `asignacion_ibfk_2` FOREIGN KEY (`empleado_id`) REFERENCES `empleado` (`id`);

--
-- Filtros para la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD CONSTRAINT `cotizacion_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
