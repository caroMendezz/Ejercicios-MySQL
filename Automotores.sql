DROP DATABASE IF EXISTS auto;
CREATE DATABASE auto;
USE auto;

CREATE TABLE auto(
	id_auto INT PRIMARY KEY,
    numero_chasis VARCHAR(25) not null,
    numero_motor VARCHAR(25) not null,
    marca VARCHAR(50) not null,
    modelo VARCHAR(50) not null,
    tipo VARCHAR(50) not null,
    color VARCHAR(50) not null,
    año_fabricacion YEAR not null,
    precio DECIMAL not null,
    estado ENUM('disponible','vendido','reservado') default 'disponible',
    fecha_registro TIMESTAMP default current_timestamp not null, -- Fecha y hora de registro
    fecha_vencimientoRegistro DATE not null,
    numero_cedulaVerde VARCHAR(50) not null,
    fechaEmision_cedulaVerde DATE not null,
    fecha_autorizacion DATE not null
    
);

CREATE TABLE motor(
	id_motor INT PRIMARY KEY,
    id_auto INT not null,
    tipo_motor varchar(50) not null,
    cilindrado decimal,
    potencia decimal,
    tipo_combustible ENUM('gasolina','diesel','electrico','hibrido') not null,
    foreign key (id_auto) references auto(id_auto)
    
);

CREATE TABLE transmision(
	id_transmision INT PRIMARY KEY,
    id_auto INT not null,
    tipo_transmision ENUM('manual','Automatica','CVT') not null,
    cant_velocidades INT not null, -- ej 6 marchas
    foreign key (id_auto) references auto(id_auto)
);

CREATE TABLE neumatico(
	id_neumatico int primary key,
    id_auto int not null,
    medida varchar(50), 
    tipo_neumatico varchar(50),
    marca_neumatico varchar(50),
    foreign key (id_auto) references auto(id_auto)
);

CREATE TABLE equipamiento(
	id_equipamiento int primary key,
    id_auto int not null,
    detalles_equipamiento text,
    foreign key (id_auto) references auto(id_auto)
);
CREATE TABLE seguridad(
	id_seguridad int primary key,
    id_auto int not null,
    airbags enum('frontales','laterales','cortina','todos') not null,
    frenos_anticlaveo bool not null,
    asistencia_conduccion text, -- ej: control de estabilidad, sensores de parqueo
    foreign key (id_auto) references auto(id_auto)
    
);

CREATE TABLE documentacion(
	id_documento int primary key,
    id_auto int not null,
    tipo_documento enum('cedula verde','cedula azul') not null,
    numero_documento varchar(50) not null,
    fecha_emision date not null,
    foreign key (id_auto) references auto(id_auto)
);

insert into auto(id_auto, numero_chasis , numero_motor, marca, modelo, tipo, color, año_fabricacion, 
precio,estado, fecha_vencimientoRegistro, numero_cedulaVerde, fechaEmision_cedulaVerde, fecha_autorizacion)
values(1,'CH1234567890','mot1234567890','toyota','corolla','sedan','rojo','2022',25000.00,'disponible',
'2026-05-10','CED12344','2022-05-10','2022-05-15');



INSERT INTO motor (id_motor, id_auto, tipo_motor, cilindrado, potencia, tipo_combustible)
VALUES (1, 1, '4 cilindros en línea', 1.8, 140, 'Gasolina');

INSERT INTO transmision (id_transmision, id_auto, tipo_transmision, cant_velocidades)
VALUES (1, 1, 'Automatica', 6);

INSERT INTO neumatico (id_neumatico, id_auto, medida, tipo_neumatico, marca_neumatico)
VALUES 
(1, 1, '205/55 R16', 'Verano', 'michelin');

INSERT INTO equipamiento (id_equipamiento, id_auto, detalles_equipamiento)
VALUES (1, 1, 'Asientos de cuero, sistema de navegacion, camara de reversa');

INSERT INTO seguridad (id_seguridad, id_auto, airbags, frenos_anticlaveo, asistencia_conduccion)
VALUES (1, 1, 'Frontales', true, 'Control de estabilidad, sensores de parqueo');

INSERT INTO documentacion (id_documento, id_auto, tipo_documento, numero_documento, fecha_emision)
VALUES (1, 1, 'Cedula verde', 'DOC123456', '2022-05-10');

SELECT a.id_auto, a.numero_chasis, a.numero_motor,a.marca, a.modelo, a.tipo,a.color, a.año_fabricacion,
a.precio, a.estado, m.tipo_motor, m.cilindrado, m.potencia, m.tipo_combustible, t.tipo_transmision,t.cant_velocidades,
n.medida as medida_neumatico, n.tipo_neumatico, n.marca_neumatico, e.detalles_equipamiento, s.airbags,
s.frenos_anticlaveo,s.asistencia_conduccion,d.tipo_documento,d.numero_documento,d.fecha_emision 
FROM auto a
LEFT JOIN motor m on a.id_auto =m.id_auto 
LEFT JOIN transmision t on a.id_auto = t.id_auto
LEFT JOIN neumatico n on a.id_auto = n.id_auto
LEFT JOIN equipamiento e on a.id_auto = e.id_auto
LEFT JOIN seguridad s on a.id_auto = s.id_auto
LEFT JOIN documentacion d on a.id_auto = d.id_auto;