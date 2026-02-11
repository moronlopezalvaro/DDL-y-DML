-- 1.- Crea una base de datos de nombre “hym_bd”.
DROP DATABASE IF EXISTS hym_bd; -- Depuramos la base de datos
CREATE DATABASE IF NOT EXISTS hym_bd; -- Creamos la base de datos

USE hym_bd; -- Usamos la base de datos que acabamos de crear

-- 2.- Crea las siguientes tablas teniendo en cuenta las restricciones indicadas y los tipos de datos de cada columna:
CREATE TABLE IF NOT EXISTS Usuario(				-- Creamos todas las tablas principales
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,	-- Creamos la clave primaria de tipo entero y auto incremento
    nombre VARCHAR(128),						-- Creamos un campo de texto con un limite de 128 caracteres
    apellidos VARCHAR(128),									
    email VARCHAR(64),
    fecha_nacimiento DATE,						-- Creamos un atributo de tipo fecha (el formato debe ser el formato americano: año/mes/dia)
    tipo_miembro VARCHAR(64),
    puntos_acumulados INT,
    fecha_registro DATE,
    fecha_ultima_visita DATE
);

CREATE TABLE IF NOT EXISTS Vale_descuento(
	id_vale INT AUTO_INCREMENT PRIMARY KEY,
	fecha_creacion DATE,
	fecha_caducidad DATE,
	usado BOOLEAN DEFAULT 0,					-- Creamos un atributo de tipo boolean (si = 1 / no = 0)
	id_usuario INT,
	FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
	); 

CREATE TABLE IF NOT EXISTS Direccion(
	id_direccion INT AUTO_INCREMENT PRIMARY KEY,
	calle VARCHAR(128),
	ciudad VARCHAR(64),
	codigo_postal INT,
	poblacion VARCHAR(128),
	direccion_favorita BOOLEAN DEFAULT 0,
	id_usuario INT,
	FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)		-- Creamos la clave foranea
);

CREATE TABLE IF NOT EXISTS Almacen_direccion(
	id_almacen INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(128),
	poblacion VARCHAR(128),
    calle VARCHAR(128),
	ciudad VARCHAR(64),
	codigo_postal INT,
	capacidad_total INT
);

CREATE TABLE IF NOT EXISTS Categoria(
	id_categoria INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(64),
	descripcion VARCHAR(128),
	imagen VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS Producto(
	id_producto INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(16),
	descripcion VARCHAR(128),
	imagen VARCHAR(64),
	stock INT,
	precio FLOAT(20,6),							-- Creamos un atributo de tipo float para guardar numeros con decimales
    id_almacen INT,
	FOREIGN KEY (id_almacen) REFERENCES Almacen_direccion(id_almacen)
);

CREATE TABLE IF NOT EXISTS Producto_categoria(
	id_producto INT,
	id_categoria INT,
    PRIMARY KEY (id_producto,id_categoria),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

CREATE TABLE IF NOT EXISTS Compra(
	id_compra INT AUTO_INCREMENT PRIMARY KEY,
	forma_pago VARCHAR(64),
	fecha DATE,
	total_compra FLOAT(20,6),
	id_usuario INT,
	FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
	id_direccion INT, 
    FOREIGN KEY (id_direccion) REFERENCES Direccion(id_direccion)
); 

CREATE TABLE IF NOT EXISTS Linea_pedido(
	id_linea INT,
	precio_unidad FLOAT(20,6),
	cantidad INT,
	total_linea FLOAT(20,6),
    id_compra INT,
	FOREIGN KEY (id_compra) REFERENCES Compra(id_compra),
	id_producto INT, 
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- 3.- Cambia el nombre de la tabla “almacen_direccion” por “almacen.
ALTER TABLE Almacen_direccion RENAME TO Almacen;

-- 4.- En la tabla “producto” establece que el valor de la columna “stock” sea 0 por defecto.
ALTER TABLE Producto
MODIFY stock INT DEFAULT 0;						-- Con "alter table" nos situamos en la tabla que queremos hacer cambios y con "modify" cambiamos el atributo que sea

-- 5.- En la tabla “usuario” establece que el valor de la columna “email” no puede ser nulo.
ALTER TABLE Usuario
MODIFY email VARCHAR(64) NOT NULL;

-- 6.- Establece una restricción para que el valor de “cantidad” en la tabla “linea_pedido” siempre sea un valor mayor que 0.
ALTER TABLE Linea_pedido
MODIFY cantidad INT UNSIGNED CHECK (cantidad > 0);

-- 7.- Cambia el nombre de la columna “direccion_favorita” por “es_favorita” de la tabla “direccion”.
ALTER TABLE Direccion
CHANGE direccion_favorita es_favorita INT;		-- Con "alter table" nos situamos en la tabla que queremos hacer cambios y con "change" cambiamos el nombre de la columna que sea

-- 8.- En la tabla “producto” modifica el tipo de la columna “nombre” a VARCHAR de tamaño 64.
ALTER TABLE Producto
MODIFY nombre VARCHAR(64);

-- 9.- Añade la condición de clave primaria al atributo “id_linea” de la tabla “linea_pedido”. Pon además que sea auto incrementado.
ALTER TABLE Linea_pedido
MODIFY id_linea INT AUTO_INCREMENT PRIMARY KEY;

-- 10.- Elimina la columna “precio_unidad” de la tabla “linea_pedido”.
ALTER TABLE linea_pedido
DROP COLUMN precio_unidad;						-- Con "alter table" nos situamos en la tabla que queremos hacer cambios y con "drop" eliminamos la columna que sea

-- 11.- Añade una nueva columna en la tabla “categoria” de nombre “url” de tipo VARCHAR de tamaño 128.
ALTER TABLE Categoria
ADD url VARCHAR(128);							-- Con "alter table" nos situamos en la tabla que queremos hacer cambios y con "add" añadimos la columna que sea

-- Insertar datos en las tablas
INSERT INTO Usuario (id_usuario,nombre,apellidos,email,fecha_nacimiento,tipo_miembro,puntos_acumulados,fecha_registro,fecha_ultima_visita) VALUES
(1,'Sergio','Guillén Lara','glara@gmail.com','2001-09-12','miembro',200,'2021-01-18','2022-01-15'),
(2,'Carmen','Suárez Pérez','sperez@gmail.com','1995-05-05','miembro_plus',12,'2018-03-20','2021-12-30'),
(3,'Esther','Martín Gutiérrez','mguti@gmai.com','1965-02-20','miembro',340,'2015-06-06','2021-10-20');

INSERT INTO Vale_descuento (id_vale,fecha_creacion,fecha_caducidad,usado,id_usuario) VALUES
(1,'2022-01-14','2022-07-14',0,1),
(2,'2021-12-30','2022-06-30',0,2),
(3,'2021-05-12','2021-11-12',1,1);

INSERT INTO Direccion (id_direccion,calle,ciudad,codigo_postal,poblacion,es_favorita,id_usuario) VALUES
(1,'Calle Tetuán, 3','Sevilla',41001,'Alcalá de Guadaira',1,1),
(2,'Calle Genil nº 2 1ºC','Granada',48030,'Motril',0,2),
(3,'Avda Andalucía 4 Portal 2 3ºC','Zamora',52320,'Carrascal',1,2),
(4,'Calle Cervantes, nº1','Soria',16033,'Lubia',1,3);

INSERT INTO Almacen (id_almacen,nombre,poblacion,calle,ciudad,codigo_postal,capacidad_total) VALUES
(1,'Xiun Guan S.L.','Carmona','Polígono La Isla, Calle Filosofía, 3','Sevilla',41010,45000),
(2,'Warehouse 45','San Fernando','Calle Pinar 34','Cádiz',34500,12800),
(3,'Tu almacén S.L.','San Juan del Puerto','Calle Aplauso nº1','Huelva',28040,90000);

INSERT INTO Categoria (id_categoria,nombre,descripcion,imagen,url) VALUES
(1,'Pantalones','Pantalones de temporada','imagen-categoria1.jpg','https://hym.web/pantalones'),
(2,'Sudaderas','Las sudaderas que más abrigan del mercado','imagen-categoria2.jpg','https://hym.web/sudaderas'),
(3,'Calzado','Calzado de todo tipo para todo tipo de ocasiones','imagen-categoria3.jpg','https://hym.web/calzado');

INSERT INTO Producto (id_producto,nombre,descripcion,imagen,stock,precio,id_almacen) VALUES
(1,'Joggers cargo de nailon','Joggers cargo de nailon con cintura elástica con cordón de ajuste.','prod1-joggersA.jpg',45,15.95,2),
(2,'Zapatos Derby','Zapatos Derby con cordones abiertos. Forro y plantillas de lona. Tacón 2,5 cm.','prod2-derbyPrin.jpg',12,29.99,1),
(3,'Sudadera Relaxed Fit','Sudadera en peluche suave con bolsillo canguro y capucha con cordón de ajuste elástico.','prod3-sudRelax.jpg',4,24.99,3);

INSERT INTO Producto_categoria (id_producto,id_categoria) VALUES
(1,1),
(2,3),
(3,2);

INSERT INTO Compra (id_compra,forma_pago,fecha,total_compra,id_usuario,id_direccion) VALUES
(1,'Efectivo','21-05-12',45.94,2,3),
(2,'Tarjeta','20-10-09',59.98,2,2),
(3,'Tarjeta','21-01-29',29.99,1,1);

INSERT INTO Linea_pedido (id_linea,cantidad,total_linea,id_compra,id_producto) VALUES
(1,1,15.95,1,1),
(2,1,29.99,1,2),
(3,2,59.98,2,2),
(4,1,29.99,3,2);

-- 12.- En la tabla “usuario”, actualiza el valor del nombre a “Cristina” para el usuario que sea “miembro” y tenga más de 300 puntos acumulados.
UPDATE Usuario									-- Con "update" seleccionamos la tabla que queremos actualizar
SET nombre = 'Cristina'							-- Con "set" añadimos el valor que queremos añadir y donde
WHERE tipo_miembro = 'miembro' AND puntos_acumulados > 300;	-- Con "where" seleccionamos las condiciones que se tienen que cumplir para aplicar el valor que añadimos antes

-- 13.- En la tabla “vale_descuento”, establece como no usados todos los vales del usuario con id_usuario igual 1.
UPDATE Vale_descuento
SET usado = 0
WHERE id_usuario = 1;

-- 14.- En la tabla “direccion”, actualiza todos los datos de la dirección con id_direccion igual a 2. Usa los siguientes datos:
																																/*calle: Calle Sanitarios, 33
																																ciudad: Granada
																																Codigo_postal: 48210
																																Población: Almuñecar
																																es_favorita: 1
																																id_usuario: 2*/
UPDATE Direccion
SET calle = 'Calle Sanitarios, 33', ciudad = 'Granada', codigo_postal = 48210, poblacion = 'Almuñecar', es_favorita = 1, id_usuario = 2
WHERE id_direccion = 2;

-- 15.- En la tabla “direccion”, actualiza el valor es_favorita a 0 de la dirección cuyo id_usuario es 2 y la población no es “Almuñecar”.
UPDATE Direccion
SET es_favorita = 0
WHERE id_usuario = 2 AND poblacion != 'Almuñecar';

-- 16.- En la tabla “almacen”, actualiza la capacidad a 250000 del almacén cuya población empiece por “San” y su ciudad no sea “Huelva”.
UPDATE Almacen
SET capacidad_total = 250000
WHERE poblacion LIKE 'San%' AND ciudad != 'Huelva';	-- Con "like" añadimos la condicion de que esté la palabra buscada y con "%" indicamos si la palabra está al inicio/final/en medio

-- 17.- En la tabla “producto”, actualiza el stock sumando 11 al producto proporcionado por el almacén con ID 3.
UPDATE Producto
SET stock = stock + 11
WHERE id_almacen = 3;

-- 18.- En la tabla “compra”, actualiza la forma de pago a “Bizum” del pedido con id_usuario igual a 2 pero que la dirección no sea la de id 3.
UPDATE Compra
SET forma_pago = 'Bizum'
WHERE id_usuario = 2 AND  id_direccion != 3;

-- 19.- Actualiza el total de la línea a 31,9 y la cantidad a 2 de la línea de pedido cuyo ID sea 1.
UPDATE Linea_pedido
SET total_linea = 31.9, cantidad = 2
WHERE id_linea = 1;

-- 20.- Actualiza la descripción de la categoría cuyo nombre es “Pantalones”, y ponle el texto: “Pantalones de la nueva temporada primavera-verano”.
UPDATE Categoria
SET nombre = 'Pantalones de la nueva temporada primavera-verano'
WHERE nombre = 'Pantalones';