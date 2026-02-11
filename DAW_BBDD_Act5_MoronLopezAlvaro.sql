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