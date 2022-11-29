
/*             --------------------- Candado A --------------------         */
/* Posicion  2    Clave 14043 */
/* Teniendo el máximo de asistencias por partido, muestre cuantas veces se logró dicho máximo. */ 
SELECT  Asistencias_por_partido,
                COUNT(Asistencias_por_partido) AS 'Cantidad de veces realizadas'
from estadistica
WHERE Asistencias_por_partido = (SELECT MAX(Asistencias_por_partido)
                                                        FROM estadistica);

/* Muestre la suma total del peso de los jugadores, donde la conferencia sea Este y la posición sea 
centro o esté comprendida en otras posiciones. */
SELECT SUM(jugador.peso) AS 'Sumatoria de Puntos',
                equipo.conferencia AS 'Conferencia',
                jugador.posicion AS 'Posición'
from jugador
INNER JOIN equipo
ON jugador.nombre_equipo = equipo.nombre
WHERE lower(equipo.conferencia) = 'east' AND lower(jugador.posicion) LIKE '%c%';

/*             --------------------- Candado B --------------------         */
/* Posicion  3    Clave 3480 - 1740-
/*   Muestre la cantidad de jugadores que poseen más asistencias por partidos, que el numero de
jugadores que tiene el equipo Heat. */ 
SELECT COUNT(jugador.nombre)
FROM equipo
INNER JOIN jugador
ON equipo.nombre = jugador.nombre_equipo
JOIN estadistica
ON jugador.codigo = estadistica.jugador
WHERE  estadistica.Asistencias_por_partido > (SELECT COUNT(jugador.nombre_equipo)
                                                                          FROM jugador
                                                                          WHERE jugador.nombre_equipo = 'Heat') ;

/*  La clave será igual al conteo de partidos jugados durante las temporadas del año 1999.  */
SELECT  COUNT(partido.temporada)
FROM partido
WHERE  partido.temporada= 99;

/*             --------------------- Candado C --------------------         */
/* Posicion  1    Clave  631
/*  La posición del código será igual a la cantidad de jugadores que proceden de Michigan y forman
parte de equipos de la conferencia oeste.
Al resultado obtenido lo dividiremos por la cantidad de jugadores cuyo peso es mayor o igual a
195, y a eso le vamos a sumar 0.9945. */ 
SELECT COUNT(*) AS 'Cantidad Jugadores',
              jugador.procedencia,
              equipo.conferencia
from jugador
INNER JOIN equipo
ON jugador.nombre_equipo = equipo.nombre
WHERE jugador.procedencia = 'Michigan' AND equipo.conferencia = 'West'; /* Resultado 2*/

SELECT COUNT(*)  AS 'Cantidad Jugadores'
FROM jugador
WHERE jugador.peso >= 195; /* Resultado 362*/

/*  Para obtener el siguiente código deberás redondear hacia abajo el resultado que se devuelve de
sumar: el promedio de puntos por partido, el conteo de asistencias por partido, y la suma de
tapones por partido. Además, este resultado debe ser, donde la división sea central. */
SELECT equipo.nombre
FROM equipo
WHERE equipo.division = 'central';

SELECT round(AVG(estadistica.Puntos_por_partido) +
                COUNT(estadistica.Asistencias_por_partido) +
                SUM(estadistica.Tapones_por_partido))
FROM estadistica
INNER JOIN  jugador
ON estadistica.jugador = jugador.codigo
JOIN equipo
ON jugador.nombre_equipo = equipo.nombre
WHERE  equipo.division IN ('central');

/*             --------------------- Candado D --------------------         */
/* Posicion  4    Clave  191
/*  Muestre los tapones por partido del jugador Corey Maggette durante la temporada 00/01. Este
resultado debe ser redondeado. Nota: el resultado debe estar redondeado */ 
SELECT round(estadistica.Tapones_por_partido)
FROM estadistica
INNER JOIN jugador
ON estadistica.jugador = jugador.codigo
WHERE jugador.nombre = 'Corey Maggette' AND estadistica.temporada = '00/01';
 
  /*  Para obtener el siguiente código deberás redondear hacia abajo, la suma de puntos por partido
de todos los jugadores de procedencia argentina. */ 
SELECT Round(SUM(estadistica.Puntos_por_partido))
FROM estadistica
INNER JOIN jugador
ON estadistica.jugador = jugador.codigo
WHERE jugador.procedencia = 'Argentina'; 

