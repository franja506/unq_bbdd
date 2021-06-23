/*1. Obtener el sobrenombre, id y el nombre de la plaza, de los competidores de plazas de la ciudad de Quilmes
en Buenos Aires.*/
SELECT c.sobrenombre, c.id, p.nombre
  FROM competidor c
  JOIN plaza p ON p.id = c.plaza_id
 WHERE p.ciudad = 'Quilmes'
   AND p.provincia = 'Buenos Aires';

/*2. Obtener el sobrenombre y el nombre de su plaza de los competidores que solo asistieron a una competencia.*/
SELECT sobrenombre, p.nombre
  FROM competidor c
  JOIN rima r ON r.competidor_id = c.id
  JOIN plaza p on c.plaza_id = p.id
 GROUP BY sobrenombre, p.nombre
HAVING count(distinct competicion_id) = 1;

/*3. Obtener las competiciones donde todas sus temáticas duran más de 2 minutos.*/

/*4. Obtener el nombre y el promedio de duración de las temáticas utilizadas en las competiciones realizadas
en los predios llamados Colonial de Buenos Aires y de Córdoba.*/
SELECT t.nombre, avg(duracion_en_segundos) AS duracion
  FROM competicion c
  JOIN tematica_en_competicion tec on c.id = tec.competicion_id
  JOIN tematica t on tec.tematica_id = t.id
 WHERE c.predio = 'Colonial'
   AND c.provincia in ('Cordoba','Buenos Aires')
 GROUP BY t.nombre;

/*5. Obtener los competidores registrados pero que aún no hayan competido.*/
SELECT *
  FROM competidor c
 WHERE c.id NOT IN (SELECT DISTINCT competidor_id FROM rima);

/*6. Obtener la mejor rima de cada competidor que no sea del mismo lugar en donde se realizó la competición,
ordenadas por valoración.*/

/*7. Obtener la temática en competición de las rimas cuyos promedio en competición no superen el valor 6.4 .*/

/*8. Obtener el autor del beat, el nombre del beat y el nombre de la competicion de aquellas competiciones en
donde el competidor no haya hecho rimas con valoración menor a 2.*/

/*9. Obtener una lista que muestre la cantidad de plazas por zona, ordenados descendentemente por la cantidad
pero ascendentemente por provincia y ciudad. Una zona se define por su ciudad y provincia. Se debe
visualizar la zona en el resultado.*/

/*10. Obtener una lista que muestre la cantidad de competidores por zona, ordenados descendentemente por
la cantidad y zona. Se debe contar a los competidores que hicieron al menos una rima. Se debe visualizar
la zona en el resultado.*/

/*11. Obtener un listado que muestre, de cada plaza, el promedio de valoración de las rimas, la máxima valoración
y la mínima de los competidores de esa plaza.*/

/*12. Obtener de las últimas 10 rimas registradas, el sobrenombre del competidor, la valoración de la rima, el
nombre del beat, el nombre del autor del beat y el nombre de la plaza del competidor.*/

/*13. En la tabla de competidor conocemos su PK, pero es necesario impedir que pueda repetirse el sobrenombre
entre distintos competidores. Explique cómo lo haría e impleméntelo.*/

/*14. Cree una vista(view) de los competidores cuyo promedio histórico de rimas en competiciones de Buenos
Aires es mayor a 7, participaron en más de 3 competencias, tienen al menos 4 rimas con puntaje
perfecto(10) y compitieron antes del 2015 o después del 2020.*/

/*15. Cree un índice de las competiciones por nombre y fecha para mejorar la velocidad de las consultas.*/

/*16. Obtener los nombres de los beats y su autor en donde el sobrenombre de un competidor que haya hecho
rimas en ese beat y el nombre del autor del beat sean el mismo.*/

/*17. Obtener la competición y el competidor campeón de la misma. Un competidor es campeón al ser el que
más puntos obtuvo en una competición.*/