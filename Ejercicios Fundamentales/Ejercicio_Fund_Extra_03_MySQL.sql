/* 1. Mostrar el nombre de todos los pokemon. */
SELECT pokemon.nombre
FROM pokemon;

/* 2. Mostrar los pokemon que pesen menos de 10k. */
SELECT *
FROM pokemon
WHERE pokemon.peso < 10
ORDER BY pokemon.peso DESC;

/* 3. Mostrar los pokemon de tipo agua. */
SELECT  pokemon.nombre AS 'Nombre del Pokemon', tipo.nombre AS 'Tipo de Pokemon'
FROM pokemon
INNER JOIN pokemon_tipo
ON pokemon.numero_pokedex = pokemon_tipo.numero_pokedex
JOIN tipo 
ON pokemon_tipo.id_tipo = tipo.id_tipo
WHERE tipo.nombre = 'Agua';

/* 4. Mostrar los pokemon de tipo agua, fuego o tierra ordenados por tipo. */ 
SELECT  pokemon.nombre AS 'Nombre del Pokemon', tipo.nombre AS 'Tipo de Pokemon'
FROM pokemon
INNER JOIN pokemon_tipo
ON pokemon.numero_pokedex = pokemon_tipo.numero_pokedex
INNER JOIN tipo 
ON pokemon_tipo.id_tipo = tipo.id_tipo
WHERE tipo.nombre IN ('Agua','Tierra','Fuego')
ORDER BY tipo.nombre;

/*  Mostrar los pokemon que son de tipo fuego y volador. */ 
SELECT  pokemon.nombre AS 'Nombre del Pokemon', tipo.nombre AS 'Tipo de Pokemon'
FROM pokemon
INNER JOIN pokemon_tipo
ON pokemon.numero_pokedex = pokemon_tipo.numero_pokedex
INNER JOIN tipo 
ON pokemon_tipo.id_tipo = tipo.id_tipo
WHERE tipo.nombre IN ('Fuego','Volador')
ORDER BY tipo.nombre;

/* 6. Mostrar los pokemon con una estadística base de ps mayor que 200. */ 
SELECT  pokemon.numero_pokedex, pokemon.nombre, estadisticas_base.ps
FROM pokemon
LEFT JOIN estadisticas_base
ON pokemon.numero_pokedex = estadisticas_base.numero_pokedex
WHERE estadisticas_base.ps > 200;

/* 7. Mostrar los datos (nombre, peso, altura) de la prevolución de Arbok. */
SELECT p.nombre, p.altura, p.peso
FROM pokemon p, evoluciona_de ev
WHERE p.numero_pokedex = ev.pokemon_origen
AND ev.pokemon_evolucionado = (SELECT numero_pokedex 
                                                        FROM pokemon 
                                                        WHERE LOWER(nombre) = 'arbok');
                                                        
/*  8. Mostrar aquellos pokemon que evolucionan por intercambio. */ 
SELECT pokemon.numero_pokedex, pokemon.nombre, tipo_evolucion.tipo_evolucion AS 'Forma de Evolucion' 
FROM pokemon
INNER JOIN pokemon_forma_evolucion
ON pokemon.numero_pokedex = pokemon_forma_evolucion.numero_pokedex
JOIN forma_evolucion
ON pokemon_forma_evolucion.id_forma_evolucion = forma_evolucion.id_forma_evolucion
JOIN tipo_evolucion
ON forma_evolucion.tipo_evolucion  = tipo_evolucion.id_tipo_evolucion
WHERE tipo_evolucion.tipo_evolucion = 'Intercambio';                 

/*  9. Mostrar el nombre del movimiento con más prioridad. */
SELECT DISTINCT movimiento.nombre
FROM pokemon
INNER JOIN pokemon_movimiento_forma
ON pokemon.numero_pokedex = pokemon_movimiento_forma.numero_pokedex
JOIN movimiento
ON pokemon_movimiento_forma.id_movimiento = movimiento.id_movimiento
WHERE movimiento.prioridad = (SELECT MAX(movimiento.prioridad) FROM movimiento);                     

/*  10. Mostrar el pokemon más pesado. */
SELECT pokemon.nombre, pokemon.peso                   
FROM pokemon
WHERE pokemon.peso = (SELECT MAX(pokemon.peso) FROM pokemon);

/* 11. Mostrar el nombre y tipo del ataque con más potencia. */ 
SELECT  movimiento.nombre,
                tipo.nombre,
                movimiento.potencia
FROM movimiento
INNER JOIN tipo
ON movimiento.id_tipo = tipo.id_tipo
ORDER BY movimiento.potencia DESC LIMIT 1; 

/* 12. Mostrar el número de movimientos de cada tipo. */
SELECT  tipo.nombre, 
                COUNT(tipo.nombre) AS 'Cantidad de Movimientos'
FROM tipo
INNER JOIN movimiento
ON tipo.id_tipo = movimiento.id_tipo
GROUP BY tipo.id_tipo; 

/* 13. Mostrar todos los movimientos que puedan envenenar. */ 
SELECT movimiento.nombre,
                movimiento.descripcion
FROM movimiento
WHERE movimiento.descripcion LIKE '%envenenar%';

/* 14. Mostrar todos los movimientos que causan daño, ordenados alfabéticamente por nombre. */ 
SELECT movimiento.nombre,
                movimiento.descripcion
FROM movimiento
WHERE movimiento.descripcion LIKE '%daño%'
ORDER BY movimiento.nombre ASC;

/*  15. Mostrar todos los movimientos que aprende pikachu.  */
SELECT DISTINCT pokemon.nombre,
                                  movimiento.nombre,
                                  movimiento.descripcion,
                                  movimiento.precision_mov
FROM pokemon 
INNER JOIN pokemon_movimiento_forma
ON pokemon.numero_pokedex = pokemon_movimiento_forma.numero_pokedex
JOIN movimiento
ON pokemon_movimiento_forma.id_movimiento = movimiento.id_movimiento
WHERE lower(pokemon.nombre) = 'pikachu' ;

/* 16. Mostrar todos los movimientos que aprende pikachu por MT (tipo de aprendizaje). */
SELECT DISTINCT movimiento.nombre
FROM movimiento
INNER JOIN pokemon_movimiento_forma
ON movimiento.id_movimiento = pokemon_movimiento_forma.id_movimiento
JOIN pokemon
ON pokemon_movimiento_forma.numero_pokedex = pokemon.numero_pokedex
JOIN forma_aprendizaje
ON pokemon_movimiento_forma.id_forma_aprendizaje = forma_aprendizaje.id_forma_aprendizaje
JOIN tipo_forma_aprendizaje
ON forma_aprendizaje.id_tipo_aprendizaje = tipo_forma_aprendizaje.id_tipo_aprendizaje
WHERE lower(pokemon.nombre) = 'pikachu' 
AND  lower(tipo_forma_aprendizaje.tipo_aprendizaje) = 'mt';

/*  17. Mostrar todos los movimientos de tipo normal que aprende pikachu por nivel. */ 
