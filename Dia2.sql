-- #######################################
-- #### DIA  # 2 - Comandos Generales ####
-- #######################################

-- Comando general para revision de bases de datos creadas
show databases;

-- Crear base de datos
create database dia2;

-- Utilizar BBDD dia2
use dia2;

-- Crear tabla departamento
Create table departamento(
	id int auto_increment primary key,
    nombre varchar(50) not null
);

-- Crear tabla persona
create table persona(
	id int auto_increment primary key,
    nif varchar(9),
    nombre varchar(25) not null,
    apellido1 varchar(50) not null,
    apellido2 varchar(50),
    ciudad varchar(25) not null,
    direccion varchar(50) not null,
    telefono varchar(9),
    fecha_nacimiento date not null,
    sexo enum('H','M') not null,
    tipo enum('profesor','alumno') not null
);

-- Crear la tabla de profesor
create table profesor(
    id_profesor int primary key,
    id_departamento int not null,
    foreign key (id_profesor) references persona(id),
    foreign key (id_departamento) references departamento(id)
);

-- Crear tabla grado
create table grado(
	id int auto_increment primary key,
    nombre varchar(100) not null
);

-- Create tabla asignatura
create table asignatura(
	id int auto_increment primary key,
    nombre varchar(100) not null,
    creditor float not null,
    tipo enum('basica','obligatoria','optativa') not null,
    curso tinyint(3) not null,
    cuatrimestre tinyint(3) not null,
    id_profesor int,
    foreign key(id_profesor) references profesor(id_profesor),
    id_grado int not null,
    foreign key(id_grado) references grado(id)
);

-- Crear tabla curso_escolar
create table curso_escolar(
	id int auto_increment primary key,
	anyo_inicio year(4) not null,
    anyo_fin year(4) not null
);

-- Crear tabla alumno_se_matricula_asignatura
create table alumno_se_matricula_asignatura(
	id_alumno int primary key,
    id_asignatura int(10) not null,
    id_curso_escolar int(10) not null,
    foreign key(id_alumno) references persona(id),
    foreign key(id_asignatura) references asignatura(id),
    foreign key(id_curso_escolar) references curso_escolar(id)
);

show tables;
drop table curso_escolar;

-- Desarrollado por Deivid Velasquez Gutierres / TI: 1096701633