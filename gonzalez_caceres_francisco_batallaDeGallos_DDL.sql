/*1. Obtener el sobrenombre, id y el nombre de la plaza, de los competidores de plazas de la ciudad de Quilmes
en Buenos Aires.*/
SELECT c.sobrenombre, c.id, p.nombre
  FROM competidor c
  JOIN plaza p ON p.id = c.plaza_id
 WHERE p.ciudad = 'Quilmes'
   AND p.provincia = 'Buenos Aires';

/*2. Obtener el sobrenombre y el nombre de su plaza de los competidores que solo asistieron a una competencia.*/
SELECT sobrenombre, p.nombre AS nombre_plaza
  FROM competidor c
  JOIN rima r ON r.competidor_id = c.id
  JOIN plaza p on c.plaza_id = p.id
 GROUP BY sobrenombre, p.nombre
HAVING count(distinct competicion_id) = 1;

/*3. Obtener las competiciones donde todas sus temáticas duran más de 2 minutos.*/
SELECT c.nombre AS competicion
  FROM competicion c
  JOIN tematica_en_competicion tec ON c.id = tec.competicion_id
  JOIN tematica t ON t.id = tec.tematica_id
 GROUP BY c.id, tec.beat_autor, tec.beat_nombre, t.id
HAVING min(t.duracion_en_segundos) > 120;

/*4. Obtener el nombre y el promedio de duración de las temáticas utilizadas en las competiciones realizadas
en los predios llamados Colonial de Buenos Aires y de Córdoba.*/
SELECT t.nombre, avg(duracion_en_segundos) AS promedio_duracion
  FROM competicion c
  JOIN tematica_en_competicion tec ON c.id = tec.competicion_id
  JOIN tematica t ON tec.tematica_id = t.id
 WHERE c.predio = 'Colonial'
   AND c.provincia IN ('Cordoba','Buenos Aires')
 GROUP BY t.nombre;

/*5. Obtener los competidores registrados pero que aún no hayan competido.*/
--Asumo que me piden toda la informacion del competidor
SELECT *
  FROM competidor c
 WHERE c.id NOT IN (SELECT DISTINCT competidor_id FROM rima);

/*6. Obtener la mejor rima de cada competidor que no sea del mismo lugar en donde se realizó la competición,
ordenadas por valoración.*/
SELECT c.sobrenombre, max(r.valoracion) AS mejor_rima
  FROM rima r
  JOIN competidor c ON c.id = r.competidor_id
 GROUP BY r.competidor_id, c.sobrenombre
 ORDER BY MAX(r.valoracion);

/*7. Obtener la temática en competición de las rimas cuyos promedio en competición no superen el valor 6.4 .*/
SELECT t.*--r.competicion_id, r.tematica_id, avg(r.valoracion)
  FROM rima r
  JOIN tematica t ON r.tematica_id = t.id
 GROUP BY t.id, r.competicion_id, r.tematica_id
HAVING avg(r.valoracion) <= 6.4;

/*8. Obtener el autor del beat, el nombre del beat y el nombre de la competicion de aquellas competiciones en
donde el competidor no haya hecho rimas con valoración menor a 2.*/
SELECT tec.beat_autor, beat_nombre, comp.nombre AS nombre_competicion
  FROM tematica_en_competicion tec
NATURAL JOIN (SELECT c.sobrenombre AS beat_autor, r.competicion_id, r.tematica_id
                FROM rima r
                JOIN competidor c ON c.id = r.competidor_id
               GROUP BY c.sobrenombre, r.competicion_id, r.tematica_id
              HAVING min(valoracion) > 2) AS autor_en_competicion
  JOIN competicion comp on tec.competicion_id = comp.id;

/*9. Obtener una lista que muestre la cantidad de plazas por zona, ordenados descendentemente por la cantidad
pero ascendentemente por provincia y ciudad. Una zona se define por su ciudad y provincia. Se debe
visualizar la zona en el resultado.*/
SELECT count(*) AS cant_plazas, (ciudad, provincia) AS zona
  FROM plaza
 GROUP BY (ciudad, provincia)
 ORDER BY count(*) desc, (provincia, ciudad) asc;

/*10. Obtener una lista que muestre la cantidad de competidores por zona, ordenados descendentemente por
la cantidad y zona. Se debe contar a los competidores que hicieron al menos una rima. Se debe visualizar
la zona en el resultado.*/
SELECT count(*) AS cant_competidores, (p.ciudad, p.provincia) AS zona
  FROM competidor c
  JOIN plaza p ON c.plaza_id = p.id
 WHERE c.id IN (SELECT DISTINCT competidor_id  FROM rima)
 GROUP BY (p.ciudad, p.provincia);


/*11. Obtener un listado que muestre, de cada plaza, el promedio de valoración de las rimas, la máxima valoración
y la mínima de los competidores de esa plaza.*/
SELECT p.nombre AS plaza, avg(r.valoracion) AS promedio_valoracion, max(r.valoracion) AS maxima_valorarion, min(r.valoracion) AS minima_valoracion
  FROM rima r
  JOIN competidor c ON c.id = r.competidor_id
  JOIN plaza p ON p.id = c.plaza_id
 GROUP BY p.id;

/*12. Obtener de las últimas 10 rimas registradas, el sobrenombre del competidor, la valoración de la rima, el
nombre del beat, el nombre del autor del beat y el nombre de la plaza del competidor.*/
SELECT c.sobrenombre AS sobrenombre_competidor, r.valoracion AS valoracion_rima, tec.beat_nombre AS beat_nombre, tec.beat_autor AS beat_autor, p.nombre AS nombre_plaza
  FROM rima r
  JOIN tematica_en_competicion tec ON r.competicion_id = tec.competicion_id AND r.tematica_id = tec.tematica_id
  JOIN competidor c ON c.id = r.competidor_id
  JOIN plaza p ON p.id = c.plaza_id
 ORDER BY r.fecha_registro DESC
 LIMIT 10;

/*13. En la tabla de competidor conocemos su PK, pero es necesario impedir que pueda repetirse el sobrenombre
entre distintos competidores. Explique cómo lo haría e impleméntelo.*/
--Aplicaría una restriccion para que el atributo sobrenombre sea unico. Este punto debería estar en el archivo
--de DML pero para un mejor orden lo dejo acá.
ALTER TABLE competidor
  ADD CONSTRAINT sobrenombre_unique UNIQUE (sobrenombre);

/*14. Cree una vista(view) de los competidores cuyo promedio histórico de rimas en competiciones de Buenos
Aires es mayor a 7, participaron en más de 3 competencias, tienen al menos 4 rimas con puntaje
perfecto(10) y compitieron antes del 2015 o después del 2020.*/
CREATE VIEW competidor_view AS
    SELECT c1.*
      FROM competidor c1
      JOIN rima r1 ON r1.competidor_id = c1.id
      JOIN competicion on r1.competicion_id = competicion.id
     WHERE competicion.provincia = 'Buenos Aires'
     GROUP BY c1.id
    HAVING AVG(r1.valoracion) > 7
INTERSECT
    SELECT c2.*
      FROM competidor c2
      JOIN rima r2 ON r2.competidor_id = c2.id
     GROUP BY c2.id
    HAVING count(distinct r2.competicion_id) > 3
INTERSECT
    SELECT c3.*
      FROM competidor c3
      JOIN rima r3 ON r3.competidor_id = c3.id
     WHERE r3.valoracion = 10
     GROUP BY c3.id
    HAVING count(*) >= 4
INTERSECT
SELECT c4.*
  FROM competidor c4
  JOIN rima r4 ON r4.competidor_id = c4.id
 WHERE EXTRACT(YEAR FROM r4.fecha_registro) < 2015
    OR EXTRACT(YEAR FROM r4.fecha_registro) > 2020;

/*15. Cree un índice de las competiciones por nombre y fecha para mejorar la velocidad de las consultas.*/
--Este punto debería estar en el archivo de DML pero para un mejor orden lo dejo acá.
CREATE INDEX idx_competicion_nombre_fecha on competicion(nombre,fecha);

/*16. Obtener los nombres de los beats y su autor en donde el sobrenombre de un competidor que haya hecho
rimas en ese beat y el nombre del autor del beat sean el mismo.*/
SELECT distinct tec.beat_nombre, tec.beat_autor
  FROM rima r
  JOIN tematica_en_competicion tec ON r.competicion_id = tec.competicion_id AND r.tematica_id = tec.tematica_id
  JOIN competidor c ON c.id = r.competidor_id
 WHERE tec.beat_autor = c.sobrenombre;

/*17. Obtener la competición y el competidor campeón de la misma. Un competidor es campeón al ser el que
más puntos obtuvo en una competición.*/
SELECT c.nombre AS competicion, comp.sobrenombre AS campeon
  FROM (SELECT competidor_id, competicion_id, rank() OVER (PARTITION BY competicion_id ORDER BY SUM(r.valoracion) DESC) AS rank
          FROM rima r
         GROUP BY r.competidor_id, r.competicion_id) AS rima_agrupada
  JOIN competicion c ON c.id = rima_agrupada.competicion_id
  JOIN competidor comp ON comp.id = rima_agrupada.competidor_id
 WHERE rima_agrupada.rank = 1;