/*Populate tables*/
INSERT INTO clientes (id, nombre, apellido, email, create_at, foto) VALUES('1', 'Andres', 'Guzman', 'profesor@bolsadeideas.com', '2017-08-28', '');
INSERT INTO clientes (id, nombre, apellido, email, create_at, foto) VALUES('2', 'Jhon', 'Doe', 'jhon.doe@gmail.com', '2017-08-28', '');
INSERT INTO clientes (id, nombre, apellido, email, create_at, foto) VALUES('3', 'Carlos', 'Mora', 'carmor_014@hotmail.com', '2017-08-28', '');


/*Populate tables*/
INSERT INTO productos (nombre,precio, create_at) VALUES('Panasonic Pantalla LCD', 259990, NOW());
INSERT INTO productos (nombre,precio, create_at) VALUES('Sony Camara digital DSC-W320B', 123490, NOW());
INSERT INTO productos (nombre,precio, create_at) VALUES('Apple iPod shuffle', 1499990, NOW());
INSERT INTO productos (nombre,precio, create_at) VALUES('Zony Notebook Z110', 37990, NOW());
INSERT INTO productos (nombre,precio, create_at) VALUES('Hewlett Packard Multifuncional F2280', 69990, NOW());
INSERT INTO productos (nombre,precio, create_at) VALUES('Bianchi Bicicleta Aro 26', 69990, NOW());
INSERT INTO productos (nombre,precio, create_at) VALUES('Mica Comoda 5 Cajones', 299990, NOW());

/*Creamos algunas facturas*/
INSERT INTO facturas (descripcion, observacion, cliente_id, create_at) VALUES('factura equipos de oficina', null, 1, NOW());
INSERT INTO facturas_items (cantidad, factura_id, producto_id) VALUES(1, 1, 1);
INSERT INTO facturas_items (cantidad, factura_id, producto_id) VALUES(2, 1, 4);
INSERT INTO facturas_items (cantidad, factura_id, producto_id) VALUES(1, 1, 5);
INSERT INTO facturas_items (cantidad, factura_id, producto_id) VALUES(1, 1, 7);

INSERT INTO facturas (descripcion, observacion, cliente_id, create_at) VALUES('factura bicicleta', 'Alguna anotacion importante', 1, NOW());
INSERT INTO facturas_items (cantidad, factura_id, producto_id) VALUES(3, 2, 6);

/*Creamos algunos usuarios con sus role*/
INSERT INTO users (username, password, enabled) VALUES('andres', '$2a$10$yiWE8PefvnNuzsHeCRU3DOcI1MrivvIp4Nzm3Dw2TptUU0mX7Wwrq', 1);
INSERT INTO users (username, password, enabled) VALUES('admin', '$2a$10$6/6vF.9m.JFaK1u8hSGJceP73my5SFcHmkj/q6k41Gj1zI57tlgXK', 1);

INSERT INTO authorities (user_id, authority) VALUES(1, 'ROLE_USER');
INSERT INTO authorities (user_id, authority) VALUES(2, 'ROLE_USER');
INSERT INTO authorities (user_id, authority) VALUES(2, 'ROLE_ADMIN');
