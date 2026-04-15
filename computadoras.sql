DROP DATABASE IF EXISTS compu;
CREATE DATABASE compu;
USE compu;

CREATE TABLE procesador (
	id int primary key auto_increment,
    modelo varchar(100) not null,
    numeroSerie_procesador varchar(100) not null
);

CREATE TABLE computadora (
	id_computadora int auto_increment primary key,
    numeroSerie_compu varchar(100) not null,
    cantDiscos int not null,
    numeroSerie_disco varchar(100) not null,
    capacidadDisco int not null,
    tipoDisco varchar(20) not null,
    capacidadMemoria int(20) not null,
    tipoMemoria varchar(20) not null,
    idiomaTeclado varchar(20) not null,
    tipoTeclado varchar(50) not null,
    teclasRotas text,
    cantidadSO int not null,
    sistemaOperativo varchar(100) not null,
    numMac varchar (100) not null,
    id int not null,
    foreign key  (id) references procesador(id)
);


INSERT INTO procesador (modelo, numeroSerie_procesador)
VALUES ('Intel Celeron N4020 x64', 'BFEBFBFF000706A8');

insert into computadora(id_computadora, numeroSerie_compu, cantDiscos, numeroSerie_disco, capacidadDisco, tipoDisco, capacidadMemoria,
tipoMemoria, idiomaTeclado, tipoTeclado, teclasRotas, cantidadSO, sistemaOperativo, numMac, id)
values(20,'PSBA210102041321',1, 'HNSA214119Z 1709633', 128, 'SSD', 4, 'DDR4', 'ES', 'membrana', null, 1, 'Windows 10 Educacional', '04-56-E5-A1-F7-75', 1);