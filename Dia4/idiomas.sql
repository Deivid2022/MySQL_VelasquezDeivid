-- Active: 1718282204439@@172.16.101.155@3306@dia4
create database dia4;

use dia4;

create table idioma(
    id int primary key,
    idioma VARCHAR(50)
);

create table pais(
    id int PRIMARY KEY,
    nombre VARCHAR(20),
    continente VARCHAR(50),
    poblacion int
);

create table ciudad(
    id int PRIMARY KEY,
    nombre VARCHAR(20),
    id_pais int,
    Foreign Key (id_pais) REFERENCES pais(id)
);

create table idioma_pais(
    id_idioma int,
    id_pais int,
    PRIMARY KEY (id_idioma, id_pais),
    es_oficial TINYINT(1),
    Foreign Key (id_idioma) REFERENCES idioma(id),
    Foreign Key (id_pais) REFERENCES pais(id)
);

INSERT INTO pais (id, nombre, continente, poblacion) VALUES 
(1, 'España', 'Europa', 47000000),
(2, 'México', 'América', 126000000),
(3, 'Japón', 'Asia', 126300000);

INSERT INTO ciudad (id, nombre, id_pais) VALUES 
(1, 'Madrid', 1),
(2, 'Barcelona', 1),
(3, 'Ciudad de México', 2),
(4, 'Guadalajara', 2),
(5, 'Tokio', 3),
(6, 'Osaka', 3);

INSERT INTO idioma (id, idioma) VALUES 
(1, 'Español'),
(2, 'Catalán'),
(3, 'Inglés'),
(4, 'Japonés');


INSERT INTO idioma_pais (id_idioma, id_pais, es_oficial) VALUES 
(1, 1, 1), -- Español es oficial en España
(2, 1, 1), -- Catalán es oficial en España
(1, 2, 1), -- Español es oficial en México
(4, 3, 1), -- Japonés es oficial en Japón
(3, 1, 0), -- Inglés no es oficial en España
(3, 2, 0), -- Inglés no es oficial en México
(3, 3, 0); -- Inglés no es oficial en Japón

-- ##### INSERCIONES ADICIONALES ####
INSERT INTO pais (id, nombre, continente, poblacion) VALUES 
(6, 'Italia', 'Europa', 60000000); -- Pais sin ciudades

INSERT INTO ciudad (id, nombre, id_pais) VALUES 
(11, 'Ciudad Desconocida', NULL); -- Ciudad sin país


-- Consultas multitablas

--Listar todos los pares de nombres de paises y sus ciudades correspondientes que estan relacionados en la BBDD (INNER JOIN).
SELECT pais.nombre as NombrePais, ciudad.nombre as NombreCiudad
from pais
inner join ciudad on pais.id = ciudad.id_pais;

-- Listar todas las ciudades con el nombre de su pais. Si alguna ciudad no tiene un pais asignado, aun aparecera en la lista con el NombrePias como NULL.
select pais.nombre as Pais, ciudad.nombre as Ciudad
from pais
left join ciudad on pais.id = ciudad.id_pais;

-- Mostrar todos los paises y, si tienen ciudades asociadas, estas se mostrarán junto al nombre del pais. Si no hay ciudades asociadas a un pais, el NombreCiudad aparecerá como NULL
select pais.nombre as Pais, ciudad.nombre as Ciudad
from pais
right join ciudad on ciudad.id_pais = pais.id;




-- Desarrollado por Deivid Velasquez Gutierres / TI: 1096701633