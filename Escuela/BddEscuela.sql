DROP DATABASE IF exists escuela;
CREATE DATABASE escuela;
use escuela;
CREATE TABLE alumno(
	id_alumno int Primary key not null,
	nombre varchar(50) not null,
	apellido1 varchar(100) not null,
	apellido2 varchar(100),
	edad int not null,
	sexo varchar(100) not null
);
CREATE TABLE materia(
	id_materia int primary key not null,
	nombre varchar(100) not null,
	año_escolar int not null
);
CREATE TABLE materias_cursadas(
	id_materiasCursadas int primary key not null,
	id_alumno int,
	id_materia int,
	año int not null,
	nota_final int not null,
	estado bool not null, -- True si aprobo, False si desaprobó
	foreign key (id_alumno) references alumno(id_alumno),
	foreign key (id_materia) references materia(id_materia)
);
Insert into alumno(id_alumno,nombre,apellido1,apellido2,edad,sexo) values (1, "Carolina","Mendez",null,17,"Femenino");
insert into materia(id_materia, nombre,año_escolar) values(01, "Matematicas", 3);
insert into materia(id_materia, nombre,año_escolar) values(02, "Organización de las computadoras", 4);
insert into materias_cursadas(id_materiasCursadas, id_alumno, id_materia, año, nota_final,
estado) values(1, 1 ,01, 2023, 4, FALSE);
insert into materias_cursadas(id_materiasCursadas, id_alumno, id_materia, año, nota_final, estado) values(2, 1 ,02, 2024, 7, TRUE);

SELECT * FROM materias_cursadas JOIN alumno ON materias_cursadas.id_alumno =
alumno.id_alumno JOIN materia ON materias_cursadas.id_materia = materia.id_materia;