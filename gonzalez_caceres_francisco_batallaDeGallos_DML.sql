/*(a) Genere una base de datos en el motor PostgreSQL cuyo nombre sea tp_su_apellido. No desapruebe
por literalidad. Describa los pasos que tuvo que llevar a cabo para lograrlo. Guarde las sentencias
que usó para la creación de las tablas en el archivo sql.*/
--Yo lo hice a traves de un ide. Los pasos que seguí son los siguientes:
--Nos conectamos a la base a traves del usuario postgresql y la clave que generamos al instalar el motor,
--y lo apuntamos al localhost con el puerto por defecto que viene asignado(5432). Abrimos una consola y ejecutamos
--el siguiente script
CREATE DATABASE tp_gonzalez_caceres;
--Esto crea una base de datos a partir de la cual crearemos todos los objetos que necesitemos para la realizacion del TP
--Puede crearse un shema para encapsular el dominio del TP, pero por fines practicos no lo hice.
--El siguiente script se podría utilizar para tal fin -> CREATE SHEMA batalla_de_gallos;


/*(b) Escriba las queries para crear las tablas y estructuras de acuerdo a lo descripto más arriba. El puntaje de
las rimas por defecto debe ser 2 y la duración de la temática debe ser por default de 30 segundos.
(c) Identifique todas las claves foráneas que correspondan y escriba las queries para crearlas.
(d) Ejecute las queries de modo tal que todas estas estructuras sean creadas en la base de datos creada en el
punto a.*/
CREATE TABLE plaza (
    id serial PRIMARY KEY,
    nombre varchar(30) NOT NULL,
    ciudad varchar(50) NOT NULL,
    provincia varchar(50) NOT NULL
);

CREATE TABLE competicion (
    id serial PRIMARY KEY,
    nombre varchar(50) NOT NULL,
    fecha timestamp NOT NULL,
    hora integer NOT NULL,
    ciudad varchar(50) NOT NULL,
    predio varchar(50) NOT NULL,
    provincia varchar(30) NOT NULL
);

CREATE TABLE competidor (
    id serial PRIMARY KEY,
    sobrenombre varchar(30) NOT NULL,
    especialidad varchar(20) NOT NULL,
    es_mayor boolean NOT NULL,
    plaza_id integer NOT NULL,

    CONSTRAINT fk_plaza
      FOREIGN KEY(plaza_id) 
	    REFERENCES plaza(id)
);

CREATE TABLE tematica (
    id serial PRIMARY KEY,
    duracion_en_segundos integer DEFAULT 30,
    nombre varchar(50) NOT NULL,
    descripcion varchar(255) NOT NULL
);

CREATE TABLE tematica_en_competicion (
    beat_autor varchar(50) NOT NULL,
    beat_nombre varchar(50) NOT NULL,
    competicion_id integer NOT NULL,
    tematica_id integer NOT NULL,

    PRIMARY KEY (beat_autor, beat_nombre),
    CONSTRAINT fk_competicion
        FOREIGN KEY(competicion_id)
            REFERENCES competicion(id),
    CONSTRAINT fk_tematica
        FOREIGN KEY(tematica_id)
            REFERENCES tematica(id)
);

CREATE TABLE rima (
    valoracion int DEFAULT 2,
    patron integer,
    competidor_id integer NOT NULL,
    competicion_id integer NOT NULL,
    tematica_id integer NOT NULL,

    PRIMARY KEY (patron, competidor_id, competicion_id, tematica_id),
    CONSTRAINT fk_competidor
        FOREIGN KEY(competidor_id)
            REFERENCES competidor(id),
    CONSTRAINT fk_competicion
        FOREIGN KEY(competicion_id)
            REFERENCES competicion(id),
    CONSTRAINT fk_tematica
        FOREIGN KEY(tematica_id)
            REFERENCES tematica(id)
);

/*(e) Inserte en la base los datos brindados en el archivo datos_batalla_de_gallos.sql. Describa los
pasos que tuvo que llevar a cabo para lograrlo, qué metodo usó.*/

--Yo realice una ejecución del archivo a traves del IDE, pero se podría hacer con siguiente comando:
--psql "nombre de la base" <"path adsoluto del archivo" -U "nombre usuario".
--Como el archivo de insercion poseia atributos no descriptos en el modelo se tuvo que hacer una alter
--table para poder insertar los mismos.
ALTER TABLE rima ADD COLUMN fecha_registro date;

/*(f) Limite el atributo patron a un maximo de 4 y el atributo valoracion a un maximo de 10 en la tabla
rima.*/
ALTER TABLE rima ADD CONSTRAINT patron_valoracion_check
    CHECK (patron <= 4 AND valoracion <= 10);

/*(g) Realice la inserción de datos de forma tal que exista una rima de la temática 4x4 en una competición
hecha en el predio del Luna Park por un competidor de sobrenombre Wolf oriundo de una plaza de
Bernal, y que dicha rima esté valorada con 7. Dichas queries deben estar en el entregable.*/
--Estas queries deberian estar en el archivo de DDL pero para mantener un orden las dejo acá
DO $$
BEGIN
    INSERT INTO tematica(id, nombre, descripcion)
    VALUES (8,'4x4','Todo terreno');

    INSERT INTO plaza (id, nombre, ciudad, provincia)
    VALUES (12,'Del Maestro', 'Bernal', 'Buenos Aires');

    INSERT INTO competidor(id, sobrenombre, plaza_id,especialidad, es_mayor)
    VALUES (25,'Wolf', 12, 'Rapear con Querys', false);

    INSERT INTO rima (valoracion, patron, competidor_id, competicion_id, tematica_id, fecha_registro)
    VALUES (7,1,25,1,8,'2021-03-01');
END$$;