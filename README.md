# Usando DDL y DML, sigue las siguientes indicaciones para crear una nueva base de datos

# 1.- Crea una base de datos de nombre “hym_bd”.

# 2.- Crea las siguientes tablas teniendo en cuenta las restricciones indicadas y los tipos de datos de cada columna:
Tabla usuario
id_usuario - tipo entero, clave primaria, auto incrementado.
nombre - tipo texto tamaño 128.
apellidos - tipo texto tamaño 128.
email - tipo texto tamaño 64.
fecha_nacimiento - tipo fecha.
tipo_miembro - tipo texto tamaño 64.
puntos_acumulados - tipo entero.
fecha_registro - tipo fecha.
fecha_ultima_visita - tipo fecha.
Tabla vale_descuento
id_vale - tipo entero, clave primaria, auto incrementado.
fecha_creacion - tipo fecha.
fecha_caducidad - tipo fecha.
usado - tipo booleano, valor por defecto 0.
id_usuario - tipo entero, clave ajena del campo id_usuario de la tabla usuario.

Tabla direccion
id_direccion - tipo entero, clave primaria, auto incrementado.
calle - tipo texto tamaño 128.
ciudad - tipo texto tamaño 64.
codigo_postal - tipo entero.
poblacion - tipo texto tamaño 128.
direccion_favorita - tipo booleano, valor por defecto 0.
id_usuario - tipo entero, clave ajena del campo id_usuario de la tabla usuario.

Tabla almacen_direccion
id_almacen - tipo entero, clave primaria, auto incrementado.
nombre - tipo texto tamaño 128.
poblacion - tipo texto tamaño 128.
calle - tipo texto tamaño 128.
ciudad - tipo texto tamaño 64.
codigo_postal - tipo entero.
capacidad_total - tipo entero.

Tabla categoria
id_categoria - tipo entero, clave primaria, auto incrementado.
nombre - tipo texto tamaño 64.
descripcion - tipo texto tamaño 128.
imagen - tipo texto tamaño 64.

Tabla producto
id_producto - tipo entero, clave primaria, auto incrementado.
nombre - tipo texto tamaño 16.
descripcion - tipo texto tamaño 128.
imagen - tipo texto tamaño 64.
stock - tipo entero.
precio - tipo float, tamaño 20 con 6 decimales.
id_almacen - tipo entero, clave ajena del campo id_almacen de la tabla
almacen_direccion.

Tabla producto_categoria
id_producto - tipo entero, clave primaria y clave ajena del campo id_producto de la tabla
producto.
id_categoria - tipo entero, clave primaria y clave ajena del campo id_categoria de la tabla
categoria.

Tabla compra
id_compra - tipo entero, clave primaria, auto incrementado.
forma_pago - tipo texto tamaño 64.
fecha - tipo fecha.
total_compra - tipo float, tamaño 20 con 6 decimales.
id_usuario - tipo entero, clave ajena del campo id_usuario de la tabla usuario.
id_direccion - tipo entero, clave ajena del campo id_direccion de la tabla direccion.

Tabla linea_pedido
id_linea - tipo entero.
precio_unidad - tipo float, tamaño 20 con 6 decimales.
cantidad - tipo entero.
total_linea - tipo float, tamaño 20 con 6 decimales.
id_compra - tipo entero, clave ajena del campo id_compra de la tabla compra.
id_producto - tipo entero, clave ajena del campo id_producto de la tabla producto.

Realiza las siguientes modificaciones sobre las tablas creadas en el punto anterior:

# 3.- Cambia el nombre de la tabla “almacen_direccion” por “almacen.

# 4.- En la tabla “producto” establece que el valor de la columna “stock” sea 0 por defecto.

# 5.- En la tabla “usuario” establece que el valor de la columna “email” no puede ser nulo.

# 6.- Establece una restricción para que el valor de “cantidad” en la tabla “linea_pedido” siempre sea un valor mayor que 0.

# 7.- Cambia el nombre de la columna “direccion_favorita” por “es_favorita” de la tabla “direccion”.

# 8.- En la tabla “producto” modifica el tipo de la columna “nombre” a VARCHAR de tamaño 64.

# 9.- Añade la condición de clave primaria al atributo “id_linea” de la tabla “linea_pedido”. Pon además que sea auto incrementado.

# 10.- Elimina la columna “precio_unidad” de la tabla “linea_pedido”.

# 11.- Añade una nueva columna en la tabla “categoria” de nombre “url” de tipo VARCHAR de tamaño 128.

# 12.- En la tabla “usuario”, actualiza el valor del nombre a “Cristina” para el usuario que sea “miembro” y tenga más de 300 puntos acumulados.

# 13.- En la tabla “vale_descuento”, establece como no usados todos los vales del usuario con id_usuario igual 1.

# 14.- En la tabla “direccion”, actualiza todos los datos de la dirección con id_direccion igual a 2. 
Usa los siguientes datos:
calle: Calle Sanitarios, 33
ciudad: Granada
Codigo_postal: 48210
Población: Almuñecar
es_favorita: 1
id_usuario: 2

# 15.- En la tabla “direccion”, actualiza el valor es_favorita a 0 de la dirección cuyo id_usuario es 2 y la población no es “Almuñecar”.

# 16.- En la tabla “almacen”, actualiza la capacidad a 250000 del almacén cuya población empiece por “San” y su ciudad no sea “Huelva”.

# 17.- En la tabla “producto”, actualiza el stock sumando 11 al producto proporcionado por el almacén con ID 3.

# 18.- En la tabla “compra”, actualiza la forma de pago a “Bizum” del pedido con id_usuario igual a 2 pero que la dirección no sea la de id 3.

# 19.- Actualiza el total de la línea a 31,9 y la cantidad a 2 de la línea de pedido cuyo ID sea 1.

# 20.- Actualiza la descripción de la categoría cuyo nombre es “Pantalones”, y ponle el texto: “Pantalones de la nueva temporada primavera-verano”.

# 21.- Elimina de la tabla “producto_categoria” el registro que relaciona al producto 3 con la categoría 2.

# 22.- Elimina de la tabla “linea_pedido” el registro que tenga un precio total mayor de 30 €.

# 23.- Elimina de la tabla “categoria” el registro que contenga la palabra “mercado” en la descripción.

# 24.- Elimina de la tabla “vale_descuento” todos los vales que no sean del usuario con ID 1.
