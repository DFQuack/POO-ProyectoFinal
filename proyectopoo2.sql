--
-- Base de datos: proyectopoo2
--
CREATE DATABASE multiworks;
USE multiworks;
--
-- Tablas
--
CREATE TABLE cliente (
    id smallint PRIMARY KEY AUTO_INCREMENT,
    dui char(10),
    nombre varchar(100) NOT NULL,
    tipo_persona varchar(10) NOT NULL,
    telefono char(9) NOT NULL,
    email varchar(100) NOT NULL,
    direccion varchar(200) NOT NULL,
    estado boolean NOT NULL DEFAULT 1,
    creado_por varchar(50) NOT NULL DEFAULT CURRENT_USER,
    fecha_creacion datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    fecha_inactivacion datetime DEFAULT NULL
);

CREATE TABLE empleado (
    carnet char(8) PRIMARY KEY,
    dui char(10),
    nombre varchar(100) NOT NULL,
    tipo_persona varchar(10) NOT NULL,
    telefono char(9) NOT NULL,
    email varchar(50) NOT NULL,
    direccion varchar(200) NOT NULL,
    tipo_contratacion varchar(20) NOT NULL,
    estado boolean NOT NULL DEFAULT 1,
    creado_por varchar(50) NOT NULL DEFAULT CURRENT_USER,
    fecha_creacion datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    fecha_inactivacion datetime DEFAULT NULL
);

CREATE TABLE cotizacion (
    id mediumint PRIMARY KEY AUTO_INCREMENT,
    id_cliente smallint,
    num_horas smallint DEFAULT 0,
    fecha_inicio date,
    fecha_fin date,
    estado varchar(20) NOT NULL,
    costo_asignaciones decimal(10,2) NOT NULL,
    costos_adicionales decimal(10,2) NOT NULL,
    costo_total decimal(10,2) NOT NULL,
    CONSTRAINT fk_cot_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE asignacion (
    id mediumint PRIMARY KEY AUTO_INCREMENT,
    id_cotizacion mediumint,
    titulo varchar(50) NOT NULL,
    carnet_empleado char(8),
    area varchar(50) NOT NULL,
    tiempo_inicio datetime,
    tiempo_fin datetime,
    costo_hora decimal(10,2) NOT NULL,
    num_horas smallint NOT NULL,
    costo_base decimal(10,2) NOT NULL,
    incremento_extra tinyint NOT NULL,
    costo_total decimal(10,2) NOT NULL,
    CONSTRAINT fk_asig_cotizacion FOREIGN KEY (id_cotizacion) REFERENCES cotizacion(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_asig_empleado FOREIGN KEY (carnet_empleado) REFERENCES empleado(carnet) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE subtarea (
    id mediumint PRIMARY KEY AUTO_INCREMENT,
    id_asignacion mediumint,
    nombre varchar(50) NOT NULL,
    descripcion varchar(200) NOT NULL,
    CONSTRAINT fk_subt_asignacion FOREIGN KEY (id_asignacion) REFERENCES asignacion(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE usuarios (
    id tinyint PRIMARY KEY AUTO_INCREMENT,
    username varchar(50) UNIQUE NOT NULL,
    email varchar(100) NOT NULL,
    password varchar(50) NOT NULL,
    estado boolean NOT NULL DEFAULT 1,
    creado_por varchar(100) NOT NULL DEFAULT CURRENT_USER,
    fecha_creacion datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    fecha_inactivacion datetime DEFAULT NULL
);
--
-- Inserción de datos iniciales
--
INSERT INTO cliente (dui, nombre, tipo_persona, telefono, email, direccion)
VALUES
    ('76255764-1', 'David Noah Miro Betancor', 'Natural', '7473-2840', 'david.miro61@gmail.com', 'Ps Gral Escalón No 3991, San Salvador'),
    (null, 'Empresa Real S.A. de C.V', 'Jurídica', '2189-7115', 'empresa.real@empresareal.com', '2da Calle Oriente y 3ra Avenida Sur, Santa tecla, La Libertad');

INSERT INTO empleado (carnet, dui, nombre, tipo_persona, telefono, email, direccion, tipo_contratacion)
VALUES
    ('OM315032', '07428794-8', 'Álvaro Fermín Ochoa Méndez', 'Natural', '7927-0438', 'fermin.ochoa38@outlook.com', 'Resid Los Elíseos No 15-A, San Salvador', 'Permanente'),
    ('GS914331', '55913765-7', 'Florencia Candela Gilabert Sevillano', 'Natural', '7474-4968', 'candela.gilabert90@gmail.com', 'Bo El Calvario Av Los Cañales No 1-20, Juayúa, Sonsonate', 'Permanente'),
    ('CI416536', null, 'Compañía Irreal Inc.', 'Jurídica', '2655-0664', 'businesss@irreal.com', 'Avenida El Rosario Sur y Bulevar del Ejército, Centro Comercial Plaza Soyapango, Soyapango, San Salvador', 'Por horas');

INSERT INTO cotizacion (id_cliente, num_horas, fecha_inicio, fecha_fin, estado, costo_asignaciones, costos_adicionales, costo_total)
VALUES
    (1, 56, '2025-05-01', '2025-05-08', 'Finalizada', 616, 1500, 2116),
    (2, 200, '2025-05-20', '2025-06-06', 'En proceso', 1200, 2000, 3200);

INSERT INTO asignacion (id_cotizacion, titulo, carnet_empleado, area, tiempo_inicio, tiempo_fin, costo_hora, num_horas, costo_base, incremento_extra, costo_total)
VALUES
    (1, 'Implementación de cableado estructurado', 'OM315032', 'Redes de comunicación', '2025-05-01 08:00:00', '2025-05-05 17:00:00', 10, 40, 400, 10, 440),
    (1, 'Configuración red interna', 'OM315032', 'Redes de comunicación', '2025-05-06 08:00:00', '2025-05-08 17:00:00', 10, 16, 160, 10, 176),
    (2, 'Labor de mecánica', 'CI416536', 'Mecánica', '2025-05-20 07:00:00', '2025-06-06 16:00:00', 30, 200, 6000, 5, 6300);

INSERT INTO subtarea (id_asignacion, nombre, descripcion)
VALUES
    (2, 'Subneteo de la red par la IP v4 x.x.x.x /x', 'Se deberá realizar el Subneteo de la red para tener la capacidad de aislar la siguiente cantidad de subgrupos de redes: comercial, gerencia, IT, bodega.'),
    (2, 'Implementar las subredes IP v4', 'Realizar las configuraciones pertinentes para tener listas de las siguientes subredes: comercial, gerencia, IT, bodega.'),
    (2, 'Implementación de configuración de red IP v6', 'Deberá realizar una implementación dentro de la red, para que sea compatible con IP v6 para la dirección x:x:x:x:x'),
    (1, 'Subtarea 1 de la implementación de cableado estructurado', 'Descripción de la subtarea 1 de la implementación de cableado estructurado'),
    (1, 'Subtarea 2 de la implementación de cableado estructurado', 'Descripción de la subtarea 2 de la implementación de cableado estructurado'),
    (3, 'Subtarea 1 de la labor de mecánica', 'Descripción de la subtarea 1 de la labor de mecánica'),
    (3, 'Subtarea 2 de la labor de mecánica', 'Descripción de la subtarea 2 de la labor de mecánica');
--
-- Procedimientos
--
DELIMITER $$

-- Para usuarios
CREATE PROCEDURE sp_create_usuario (IN p_username VARCHAR(50), IN p_email VARCHAR(100), IN p_password VARCHAR(50))
BEGIN
    INSERT INTO usuarios (username, email, password)
    VALUES (p_username, p_email, p_password);
END $$

CREATE PROCEDURE sp_delete_usuario (IN p_id INT)
BEGIN
    DELETE FROM usuarios WHERE id = p_id;
END $$

CREATE PROCEDURE sp_get_usuarios
BEGIN
    SELECT id, username, email, estado, creado_por, fecha_creacion, fecha_actualizacion, fecha_inactivacion FROM usuarios;
END $$

CREATE PROCEDURE sp_read_usuario_by_email (IN p_email VARCHAR(100))   BEGIN
    SELECT * FROM usuarios WHERE email = p_email;
END $$

CREATE PROCEDURE sp_read_usuario_by_id (IN p_id INT)   BEGIN
    SELECT * FROM usuarios WHERE id = p_id;
END $$

CREATE PROCEDURE sp_read_usuario_by_username (IN p_username VARCHAR(50))   BEGIN
    SELECT * FROM usuarios WHERE username = p_username;
END $$

CREATE PROCEDURE sp_update_usuario (IN p_id INT, IN p_username VARCHAR(50), IN p_email VARCHAR(100), IN p_password VARCHAR(255))   BEGIN
    UPDATE usuarios 
    SET 
        username = p_username,
        password = p_password,
        email = p_email
    WHERE id = p_id;
END $$

CREATE PROCEDURE sp_verify_login (IN p_username VARCHAR(50), IN p_password VARCHAR(255))   BEGIN
    SELECT id, username, email FROM usuarios 
    WHERE username = p_username AND password = p_password;
END $$

-- Para clientes
CREATE PROCEDURE sp_create_cliente (
    IN p_dui char(10),
    IN p_nombre varchar(100),
    IN p_tipo_persona varchar(10),
    IN p_telefono varchar(9),
    IN p_email varchar(100),
    IN p_direccion VARCHAR(200)
)
BEGIN
    INSERT INTO cliente (dui, nombre, tipo_persona, telefono, email, direccion)
    VALUES (p_dui, p_nombre, p_tipo_persona, p_telefono, p_email, p_direccion);
END $$

CREATE PROCEDURE sp_read_cliente_by_id (IN p_id INT)
BEGIN
    SELECT * FROM usuarios WHERE id = p_id;
END $$

CREATE PROCEDURE sp_get_clientes
BEGIN
    SELECT * FROM cliente;
END $$

CREATE PROCEDURE sp_update_cliente (
    IN p_id int,
    IN p_dui char(10),
    IN p_nombre varchar(100),
    IN p_tipo_persona varchar(10),
    IN p_telefono varchar(9),
    IN p_email varchar(100),
    IN p_direccion varchar(200),
    IN p_estado boolean
)
BEGIN
    UPDATE cliente
    SET
        dui = p_dui,
        nombre = p_nombre,
        tipo_persona = p_tipo_persona,
        telefono = p_telefono,
        email = p_email,
        direccion = p_direccion,
        estado = p_estado
    WHERE id = p_id;
END $$

CREATE PROCEDURE sp_delete_cliente (IN p_id INT)
BEGIN
    DELETE FROM cliente WHERE id = p_id;
END $$

-- Para empleados
CREATE PROCEDURE sp_create_empleado (
    IN p_carnet char(8),
    IN p_dui char(10),
    IN p_nombre varchar(100),
    IN p_tipo_persona varchar(10),
    IN p_telefono char(9),
    IN p_email varchar(50),
    IN p_direccion varchar(200),
    IN p_tipo_contratacion varchar(20)
)
BEGIN
    INSERT INTO empleado (carnet, dui, nombre, tipo_persona, telefono, email, direccion, tipo_contratacion)
    VALUES (p_carnet, p_dui, p_nombre, p_tipo_persona, p_telefono, p_email, p_direccion, p_tipo_contratacion);
END $$

CREATE PROCEDURE sp_read_empleado_by_id (IN p_carnet INT)
BEGIN
    SELECT * FROM empleado WHERE carnet = p_carnet;
END $$

CREATE PROCEDURE sp_read_all_empleados ()
BEGIN
    SELECT * FROM empleado;
END $$

CREATE PROCEDURE sp_update_empleado (
    IN p_carnet char(8),
    IN p_dui char(10),
    IN p_nombre varchar(100),
    IN p_tipo_persona varchar(10),
    IN p_telefono char(9),
    IN p_email varchar(50),
    IN p_direccion varchar(200),
    IN p_tipo_contratacion varchar(20),
    IN p_estado boolean
)
BEGIN
    UPDATE empleado 
    SET
        dui = p_dui,
        nombre = p_nombre,
        tipo_persona = p_tipo_persona,
        telefono = p_telefono,
        email = p_email,
        direccion = p_direccion,
        tipo_contratacion = p_tipo_contratacion,
        estado = p_estado
    WHERE carnet = p_carnet;
END $$

CREATE PROCEDURE sp_delete_empleado (IN p_carnet INT)
BEGIN
    DELETE FROM empleado WHERE carnet = p_carnet;
END $$

-- Para cotizaciones
CREATE PROCEDURE sp_create_cotizacion (
    IN p_id_cliente smallint,
    IN p_num_horas smallint,
    IN p_fecha_inicio date,
    IN p_fecha_fin date,
    IN p_estado varchar(20),
    IN p_costo_asignaciones decimal(10,2),
    IN p_costos_adicionales decimal(10,2),
    IN p_costo_total decimal(10,2)
)
BEGIN
    INSERT INTO cotizacion (id_cliente, num_horas, fecha_inicio, fecha_fin, estado, costo_asignaciones, costos_adicionales, costo_total)
    VALUES (p_id_cliente, p_num_horas, p_fecha_inicio, p_fecha_fin, p_estado, p_costo_asignaciones, p_costos_adicionales, p_costo_total);
END $$

CREATE PROCEDURE sp_read_cotizacion_by_id (IN p_id INT)
BEGIN
    SELECT * FROM cotizacion WHERE id = p_id;
END $$

CREATE PROCEDURE sp_get_cotizaciones
BEGIN
    SELECT * FROM cotizacion;
END $$

CREATE PROCEDURE sp_update_cotizacion (
    IN p_id mediumint,
    IN p_id_cliente smallint,
    IN p_num_horas smallint,
    IN p_fecha_inicio date,
    IN p_fecha_fin date,
    IN p_estado varchar(20),
    IN p_costo_asignaciones decimal(10,2),
    IN p_costos_adicionales decimal(10,2),
    IN p_costo_total decimal(10,2)
)
BEGIN
    UPDATE cotizacion 
    SET
        id_cliente = p_id_cliente,
        num_horas = p_num_horas,
        fecha_inicio = p_fecha_inicio,
        fecha_fin = p_fecha_fin,
        estado = p_estado,
        costo_asignaciones = p_costo_asignaciones,
        costos_adicionales = p_costos_adicionales,
        costo_total = p_costo_total
    WHERE id = p_id;
END $$

CREATE PROCEDURE sp_delete_cotizacion (IN p_id INT)
BEGIN
    DELETE FROM cotizacion WHERE id = p_id;
END $$

-- Para asignaciones
CREATE PROCEDURE sp_create_asignacion (
    IN p_id_cotizacion mediumint,
    IN p_titulo varchar(50),
    IN p_carnet_empleado char(8),
    IN p_area varchar(50),
    IN p_tiempo_inicio datetime,
    IN p_tiempo_fin datetime,
    IN p_costo_hora decimal(10,2),
    IN p_num_horas smallint,
    IN p_costo_base decimal(10,2),
    IN p_incremento_extra tinyint,
    IN p_costo_total decimal(10,2)
)
BEGIN
    INSERT INTO asignacion (id_cotizacion, titulo, carnet_empleado, area, tiempo_inicio, tiempo_fin, costo_hora, num_horas, costo_base, incremento_extra, costo_total)
    VALUES (p_id_cotizacion, p_titulo, p_carnet_empleado, p_area, p_tiempo_inicio, p_tiempo_fin, p_costo_hora, p_num_horas, p_costo_base, p_incremento_extra, p_costo_total);
END $$

CREATE PROCEDURE sp_read_asignacion_by_id (IN p_id INT)
BEGIN
    SELECT * FROM asignacion WHERE id = p_id;
END $$

CREATE PROCEDURE sp_get_asignaciones ()
BEGIN
    SELECT * FROM asignacion;
END $$

CREATE PROCEDURE sp_update_asignacion(
    IN p_id mediumint,
    IN p_id_cotizacion mediumint,
    IN p_titulo varchar(50),
    IN p_carnet_empleado char(8),
    IN p_area varchar(50),
    IN p_tiempo_inicio datetime,
    IN p_tiempo_fin datetime,
    IN p_costo_hora decimal(10, 2),
    IN p_num_horas smallint,
    IN p_costo_base decimal(10, 2),
    IN p_incremento_extra tinyint,
    IN p_costo_total decimal(10, 2)
)
BEGIN
    UPDATE asignacion 
    SET
        id_cotizacion = p_id_cotizacion,
        titulo = p_titulo,
        carnet_empleado = p_carnet_empleado,
        area = p_area,
        tiempo_inicio = p_tiempo_inicio,
        tiempo_fin = p_tiempo_fin,
        costo_hora = p_costo_hora,
        num_horas = p_num_horas,
        costo_base = p_costo_base,
        incremento_extra = p_incremento_extra,
        costo_total = p_costo_total
    WHERE id = p_id;
END $$

CREATE PROCEDURE sp_delete_asignacion (IN p_id INT)
BEGIN
    DELETE FROM asignacion WHERE id = p_id;
END $$

-- Para subtareas
CREATE PROCEDURE sp_create_subtarea (
    IN p_id_asignacion mediumint,
    IN p_nombre varchar(50),
    IN p_descripcion varchar(200)
)
BEGIN
    INSERT INTO subtarea (id_asignacion, nombre, descripcion)
    VALUES (p_id_asignacion, p_nombre, p_descripcion);
END $$

CREATE PROCEDURE sp_update_subtarea (
    IN p_id mediumint,
    IN p_id_asignacion mediumint,
    IN p_nombre varchar(50),
    IN p_descripcion varchar(200)
)
BEGIN
    UPDATE subtarea
    SET
        id_asignacion = p_id_asignacion,
        nombre = p_nombre,
        descripcion = p_descripcion
    WHERE id = p_id;
END $$

CREATE PROCEDURE sp_delete_subtarea (IN p_id INT)
BEGIN
    DELETE FROM subtarea WHERE id = p_id;
END $$

DELIMITER ;
