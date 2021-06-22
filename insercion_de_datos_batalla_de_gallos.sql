INSERT INTO plaza (id, nombre, ciudad, provincia) 
VALUES (1,'Rivadavia', 'Quilmes', 'Buenos Aires'), (2,'Miserere', 'Quilmes', 'Buenos Aires'), 
(3, 'Consti', 'San Miguel', 'Tucuman'), (4, 'De los enamorados', 'San Miguel', 'Tucuman'),
(5, 'Mailyn', 'Fcio Varela', 'Buenos Aires'), (6, 'del Chocolate', 'Fcio Varela', 'Buenos Aires'),
(7, 'Congreso', 'San Miguel', 'Tucuman'), (8, 'Yrigoyen', 'San Miguel', 'Tucuman'), 
(9, 'Maradona', 'San Miguel', 'Tucuman'), (10, 'Zubeldia', 'San Miguel', 'Tucuman'),
(11, 'de la Muni', 'Fcio Varela', 'Buenos Aires');

INSERT INTO competicion (id, nombre, fecha, hora, ciudad, predio, provincia) 
VALUES (1, 'Halabaluza', '2015-02-25', 17, 'CABA', 'Luna Parclk', 'Buenos Aires'), 
(2, 'El campito', '2021-03-01', 16, 'Quilmes', 'Metropolitano', 'Buenos Aires'),
(3, 'Rey del free', '2021-04-11', 11, 'Rosario', 'Colonial', 'Santa Fe'),
(4, 'El cordobes', '2019-12-01', 11, 'Rio Cuarto', 'Colonial', 'Cordoba'),
(5, 'Saltando el beat', '2019-12-01', 11, 'Lomas de Zamora', 'Colonial', 'Buenos Aires'),
(6, 'Mi otro yo', '2009-08-22', 15, 'Lanus', 'Malde', 'Buenos Aires'),
(7, 'Queridos Gallos', '2013-04-15', 20, 'Chascomus', 'Municipal', 'Buenos Aires'),
(8, 'FMS Jornada 1', '2014-06-16', 18, 'Chascomus', 'Municipal', 'Buenos Aires'),
(9, 'FMS Jornada 2', '2020-07-16', 18, 'Chascomus', 'Municipal', 'Buenos Aires'),
(10, 'FMS Jornada 3', '2020-08-16', 18, 'Chascomus', 'Municipal', 'Buenos Aires');

INSERT INTO competidor (id, sobrenombre, especialidad, es_mayor, plaza_id)
VALUES (1, 'Chester', 'Dobletempo', true, 1), (2, 'Kodigo', 'Dobletempo', true, 1), (3, 'Tata', 'Estructuras', true, 1), 
(4, 'Replik', 'Metricas', false, 2), (5, 'Casper', 'Metricas', false, 3), (6, 'ALB', 'Punchline', true, 3), (7, 'Ochoa', 'Flow', true, 3),
(8, 'Flanders', 'Flow', true, 3), 
(9, 'MKS', 'Barras', true, 10), (10, 'Stuart', 'Flow', false, 10),
(11,'Papo', 'Barras', true, 10), (12, 'SanChess', 'Barras', true, 10), (13, 'Lil pum', 'Barras', true, 10), 
(14, 'Jasin', 'Barras', false, 10), (15, 'lolo', 'Barras', false, 6), (16, 'John C', 'Metricas', false, 6), 
(17, 'Appa', 'Flow', true, 6), (18, 'Migli', 'Flow', false, 7), (19, 'Toppo', 'Flow', false, 5), 
(20, 'Jiren', 'Estructuras', true, 6), (21, 'Gokhu', 'Estructuras', true, 8), 
(22, 'Gaspy', 'Estructuras', true, 7), (23, 'Marley', 'Estructuras', false, 11), 
(24, 'Sizeluv', 'Flow', true, 11);

INSERT INTO tematica (id, duracion_en_segundos, nombre, descripcion) 
VALUES (1, 150, 'Easy Mode', 'rimar con una palabra mostrada cada 10 segundos'),
(2, 60, 'Hard Mode', 'rimar con una palabra mostrada cada 5 segundos'),
(3, 220, 'Objetos', 'rimar con objetos que estan dentro de una caja dada'),
(4, 77, 'Libre', 'rimar con el corazon'),
(5, 300, 'Dobletempo', 'se hacen rimas con un beat en dobletempo'),
(6, 78, 'Foto Tematica', 'hacer 4 rimas relacionadas con una imagen puesta'),
(7, 45, 'Personajes Contrapuestos', 'rimar interpretando ser un personaje dado');

INSERT INTO tematica_en_competicion (beat_autor, beat_nombre, competicion_id, tematica_id) 
VALUES ('Replik','Go go go', 1, 1), ('Athenea', 'My world', 3, 1), ('Athenea', 'Goals', 2, 3),
('Belse', 'Gains', 4, 2), ('Belse', 'Another', 4, 3), ('Belse', 'Yesterday', 4, 1),
('Turtle', 'Power', 5, 1), ('Turtle', 'Sometimes', 5, 3), ('Thomas', 'Hello', 5, 2),
('Zeno', 'Solo Leveling', 6, 4), ('Zeno', 'Underarmor', 7, 5), ('Belzegubb', 'Dale', 7, 7),
('GiP', 'My Own', 7, 6), ('Gaspy', 'Checkmate', 8, 5), ('Marley', 'Checkout', 9, 7), 
('Sizeluv', 'Streaming House', 10, 5);



INSERT INTO rima (valoracion, patron, competidor_id, competicion_id, tematica_id, fecha_registro) 
VALUES (8, 1, 4, 1, 1, '2021-03-01'), 
	   (7, 2, 4, 1, 1, '2021-12-01'), 
	   (9, 3, 4, 1, 1, '2021-04-01'), 
	   (8, 4, 4, 1, 1, '2021-09-01'),
	   (9, 1, 1, 1, 1, '2020-12-01'), 
	   (5, 2, 1, 1, 1, '2021-02-01'), 
	   (6, 3, 1, 1, 1, '2021-01-01'), 
	   (3, 4, 1, 1, 1, '2021-01-01'),
	   (6, 1, 3, 3, 3, '2021-08-01'), 
	   (7, 2, 3, 3, 3, '2021-12-20'), 
	   (4, 3, 3, 3, 3, '2021-03-15'), 
	   (8, 4, 3, 3, 3, '2021-04-21'),
	   (4, 1, 2, 3, 3, '2021-05-11'), 
	   (5, 2, 2, 3, 3, '2021-03-01'), 
	   (10, 3, 2, 3, 3, '2021-03-01'), 
	   (3, 4, 2, 3, 3, '2021-03-01'),
(4, 1, 8, 5, 2, '2021-03-01'), (5, 2, 8, 5, 2, '2021-03-01'), (5, 3, 8, 5, 2, '2021-03-01'), (6, 4, 8, 5, 2, '2021-03-01'),
(3, 1, 8, 5, 1, '2021-03-01'), (5, 2, 8, 5, 1, '2021-03-01'), (5, 3, 8, 5, 1, '2021-03-01'), (7, 4, 8, 5, 1, '2021-03-01'),
(8, 1, 8, 5, 3, '2021-03-01'), (9, 2, 8, 5, 3, '2021-03-01'), (9, 3, 8, 5, 3, '2021-03-01'), (10, 4, 8, 5, 3, '2021-03-01'),
(7, 1, 9, 6, 4, '2021-03-01'), (7, 1, 10, 6, 4, '2021-03-01'), (7, 1, 11, 6, 4, '2021-03-01'), (7,1, 16, 6, 4, '2021-03-01'), (9, 1, 20, 6, 4, '2021-03-01'),
(7, 1, 9, 7, 5, '2021-03-01'), (7, 1, 10, 7, 5, '2021-03-01'), (7, 1, 11, 7, 5, '2021-03-01'), (7,1, 16, 7, 5, '2021-03-01'), (7, 1, 20, 7, 5, '2021-03-01'),
(9, 1, 20, 7, 6, '2021-03-01'), (8, 1, 20, 7, 7, '2021-03-01'),
(10, 1, 19, 8, 5, '2021-03-01'), (10, 2, 19, 8, 5, '2021-03-01'), (10, 3, 19, 8, 5, '2021-03-01'), (10, 4, 19, 8, 5, '2021-03-01'),
(9, 1, 19, 9, 7, '2021-03-01'), (8, 2, 19, 9, 7, '2021-03-01'), (6, 3, 19, 9, 7, '2021-03-01'), (10, 4, 19, 9, 7, '2021-03-01'),
(8, 1, 19, 10, 5, '2021-03-01'), (8, 2, 19, 10, 5, '2021-03-01'), (8, 3, 19, 10, 5, '2021-03-01'), (8, 4, 19, 10, 5, '2021-03-01'),
(9, 1, 21, 8, 5, '2021-03-01'), (9, 2, 21, 8, 5, '2021-03-01'), (7, 3, 21, 8, 5, '2021-03-01'), (8, 4, 21, 8, 5, '2021-03-01'),
(10, 1, 21, 9, 7, '2021-03-01'), (10, 2, 21, 9, 7, '2021-03-01'), (10, 3, 21, 9, 7, '2021-03-01'), (10, 4, 21, 9, 7, '2021-03-01'),
(8, 1, 21, 10, 5, '2021-03-01'), (10, 2, 21, 10, 5, '2021-03-01'), (10, 3, 21, 10, 5, '2021-03-01'), (10, 4, 21, 10, 5, '2021-03-01'),
(5, 1, 22, 8, 5, '2021-03-01'), (7, 1, 23, 9, 7, '2021-03-01'), (6, 1, 24, 10, 5, '2021-03-01');
