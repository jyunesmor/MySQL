DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

/* MOSTRAR NOMBRE DE PRODUCTOS */ /* EJERCICIO 2 a1*/
select nombre 
from producto;

/* MOSTRAR NOMBRE Y PRECIO DE PRODUCTOS */ /* EJERCICIO 2 a2*/
select nombre, precio
from producto;

/* MOSTRAR LISTADO DE PRODUCTOS */ /* EJERCICIO 2 a3*/
select * 
from producto;

/* MOSTRAR NOMBRE Y PRECIO DE TODOS LOS PRODUCTOS REDONDEANDOLO */ /* EJERCICIO 2 a4*/
select nombre, round(precio) as 'Precio'
from producto;

/* LISTAR CODIGO FABRICANTES QUE TIENEN PRODUCTOS SIN REPETIDOS */ /* EJERCICIO 2 a5*/
select codigo
from  fabricante;

/* LISTAR CODIGO FABRICANTES QUE TIENEN PRODUCTOS SIN REPETIDOS */ /* EJERCICIO 2 a6*/
select distinct codigo
from fabricante;

/* LISTAR NOMBRES DE FABRICANTES ORDENADOS ASCENDNETES */ /* EJERCICIO 2 a7*/
select distinct nombre
from fabricante
order by nombre;

/* LISTAR NOMBRES DE PRODUCTOS ORDENADOS POR NOMBRE, DESPUES POR PRECIO DESCENDENTE */ /* EJERCICIO 2 a8*/
select nombre, precio
from producto
order by nombre asc , precio desc; 

/* LISTAR CON 5 PRIMERAS FILAS LA TABLA FABRICANTES */ /* EJERCICIO 2 a9*/
select * 
from fabricante limit 5;

/* LISTAR NOMBRE Y PRECIO PRODUCTO MAS BARATO SOLO OREDER LIMIT */ /* EJERCICIO 2 a10*/
select nombre , precio
from producto
order by precio limit 1;

/* LISTAR NOMBRE Y PRECIO PRODUCTO MAS CARO SOLO ORDER LIMIT */ /* EJERCICIO 2 a11*/
select nombre, precio
from producto
order by precio desc
limit 1;

/* LISTAR NOMBRE DE PRODUCTOS MENOR O IGUAL A 120 */ /* EJERCICIO 2 a12*/
select nombre, precio
from producto
where precio <= 120; 

/* LISTAR PRODUCTOS QUE TENGAN PRECIO ENTRE 60 Y 200 USANDO BETWEEN */ /* EJERCICIO 2 a13*/
select *
from producto 
where precio between 60 and 200;

/* LISTAR PRODUCTOS DONDE CODIGO FABRICANTE SEA 1,3 O 5 USANDO IN */ /* EJERCICIO 2 a14*/
select * 
from producto
where codigo_fabricante in (1,3,5);

/* LISTAR PRODUCTOS QUE CONTENGAN LA CADENA PORTATIL */ /* EJERCICIO 2 a15*/
select *
from producto
where nombre like '%portátil%';

/* LISTAR PRODUCTOS NOMBRE Y COD DE PROD, NOMBRE Y COD FABRICANTE */ /* EJERCICIO MULTITABLA 1*/
select p.codigo as 'Codigo Producto', p.nombre as 'Nombre Producto', f.nombre as 'Nombre Fabricante', f.codigo as 'Codigo Fabricante'
from producto p
inner join fabricante f
on p.codigo_fabricante = f.codigo
order by  p.codigo;

/* LISTAR NOMBRE, PRECIO DEL PRODUCTO Y NOMBRE DE FABRICANTE DE TODOS LOS PROD. ORDENE POR NOMBRE DEL FABRICANTE ASC */ /* EJERCICIO MULTITABLA 2*/
select p.nombre as 'Nombre del Producto', p.precio as 'Precio del Producto' , f.nombre as 'Nombre del Fabricante'
from producto p
inner join fabricante f
on p.codigo_fabricante = f.codigo
order by f.nombre;

/* MOSTROR NOMBRE, PRECIO Y FABRICANTE DEL PRODUCTO MAS BARATO */ /* EJERCICIO MULTITABLA 3*/
select p.nombre as 'Nombre del Producto', p.precio as 'Precio del Producto' , f.nombre as 'Nombre del Fabricante'
from producto p
inner join fabricante f
on p.codigo_fabricante = f.codigo
order by p.precio limit 1;

/* LISTAR PRODUCTOS DE LA FABRICA LENOVO */ /* EJERCICIO MULTITABLA 4*/
select * 
from producto p
inner join fabricante f
on p.codigo_fabricante = f.codigo
where f.nombre = 'lenovo';

/* LISTAR PRODUCTOS DEL FABRICANTE CRUCIAL CON PRECIO SUPERIOR A 200 */ /* EJERCICIO MULTITABLA 5*/
select *
from producto p 
inner join fabricante f
on p.codigo_fabricante = f.codigo
where f.nombre = 'crucial' &&  p.precio > 200;

/* LISTAR PRODUCTOS DEL FABRICANTE ASUS, HEWLETT-PACKARD USANDO IN */ /* EJERCICIO MULTITABLA 6*/
select *
from producto p
inner join fabricante f
on p.codigo_fabricante = f.codigo
where f.nombre in ( 'Asus', 'Hewlett-Packard');

/* LISTAR NOMBRE, PRECIO PRODUCTO, NOMBRE FABRICANTE CON PRECIO MAYOR O IGUAL A 180 ORDENADOS POR PRECIO DESC Y NOMBRE ASC */ /* EJERCICIO MULTITABLA 7*/
select p.nombre as 'Nombre del Producto', p.precio as 'Precio Producto', f.nombre as 'Nombre del Fabricante'
from producto p
inner join fabricante f
on p.codigo_fabricante = f.codigo
where p.precio >= 180 
order by p.precio desc, p.nombre asc;

                /*    --------------------------------------    LEFT JOIN Y RIGTH JOIN ------------------------------- */ 
                
/* LISTAR FABRICANTES JUNTO A LOS PRODUCTOS DE CADA UNO INCLUIDOS LO QUE NO TENGAN NINGUNO  */ /* EJERCICIO MULTITABLA 1*/
select *
from fabricante f
left join producto p
on f.codigo = p.codigo_fabricante;

/* LISTAR FABRICANTES CON NINGUN PRODUCTO ASOCIADO  */ /* EJERCICIO MULTITABLA 2*/
select *
from fabricante f
left join producto p
on f.codigo = p.codigo_fabricante
where p.codigo_fabricante is null; 

  /*    --------------------------------------  SUBCONSULTAS  /  WHERE   ------------------------------ */ 
/*  LISTADO PRODUCTOS LENOVO SIN INNER JOIN  */ /* EJERCICIO MULTITABLA 1*/  
  select *
  from producto
  where codigo_fabricante = (select codigo
                                              from fabricante 
                                              where nombre = 'lenovo');
                                              
/*  LISTADO PRODUCTOS QUE TIENEN EL MISMO PRECIO QUE EL MAS CARO DE LENOVO SIN INNER JOIN  */ /* EJERCICIO MULTITABLA 2*/                                             
select *
from producto
where precio = (select max(precio)
                            from producto
                            where codigo_fabricante = ( select codigo 
                                                                          from fabricante
                                                                          where nombre = 'Lenovo'));

/*  NOMBRE  DE PRODUCTO MAS CARO DE LENOVO SIN INNER JOIN  */ /* EJERCICIO MULTITABLA 3*/                       


/*  lLISTAR NOMBRE DE PRODUCTOS DEL FABRICANTE ASUS, CUYO PRECIO ES MAYOR A LA MEDIA DE LOS PRODUCTOS */ /* EJERCICIO MULTITABLA 4*/    
select *
from producto p
where p.precio > (select AVG(p.precio)
                          from producto, fabricante f
                          where f.nombre = 'Asus');

    /*    --------------------------------------  SUBCONSULTAS IN  / NOT IN   ------------------------------ */ 
    
  /*  NOMBRES DE FABRICANTES QUE TIENEN PRODUCTOS ASOCIADOS */ /* EJERCICIO MULTITABLA 1*/    
  select distinct fabricante.nombre
  from fabricante, producto
  where producto.codigo_fabricante IN (fabricante.codigo);
    
 /*  NOMBRES DE FABRICANTES QUE NO TIENEN PRODUCTOS ASOCIADOS */ /* EJERCICIO MULTITABLA 2*/    
  select distinct fabricante.nombre
  from fabricante, producto
  where producto.codigo_fabricante NOT IN (fabricante.codigo);
  
      /*    --------------------------------------  SUBCONSULTAS HAVING   ------------------------------ */ 
    
  /*  NOMBRES DE FABRICANTES QUE TIENEN  MISMA CANTIDAD DE  PRODUCTOS QUE LENOVO */ /* EJERCICIO MULTITABLA 1*/    

SELECT fabricante.nombre, COUNT(producto.codigo) as 'Cantidad de Productos'
FROM fabricante INNER JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.codigo
HAVING COUNT(producto.codigo) >= (
    SELECT COUNT(producto.codigo)
    FROM fabricante INNER JOIN producto
    ON fabricante.codigo = producto.codigo_fabricante
    WHERE fabricante.nombre = 'Lenovo');
  
  