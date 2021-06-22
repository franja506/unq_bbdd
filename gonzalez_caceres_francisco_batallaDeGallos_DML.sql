--pg_ctl.exe restart -D  "C:\Program Files\PostgreSQL\9.6\data"
CREATE DATABASE tp_gonzalez_caceres;

--CREATE SCHEMA batalla_de_gallos;

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

ALTER TABLE rima ADD COLUMN fecha_registro date;