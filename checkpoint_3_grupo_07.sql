# Codigo de la camada 02
# Grupo 07
/*Integrantes
    - Jean Franco Tineo
	- Luis Angel Armuto Abarca
    - Carol Vélez Fernández
    - Griselda Alonso García
    - Luis David Jimenez Martinez
    - Adriana Geraldine Romero Sierra
*/

SHOW DATABASES;
USE el_descubierto;

#1. Resultado: 6 registros
select concat(cliente.id, ' ', cliente.apellido, ' ' ,cliente.nombre) AS Cliente, count(cliente_x_cuenta.cliente_id) AS CantidadDeCuentas
from cliente
inner join cliente_x_cuenta on cliente_x_cuenta.cliente_id = cliente.id
group by cliente.id
having count(cliente_x_cuenta.cliente_id)>=3
order by count(cliente_x_cuenta.cliente_id) asc;


#2. Resultado: 8 registros
select concat(cliente.id, ' ', upper(cliente.apellido), ' ' ,upper(cliente.nombre)) AS ClienteSinCuentabancaria
from cliente
left join cliente_x_cuenta on cliente_x_cuenta.cliente_id = cliente.id
where cliente_x_cuenta.cliente_id is null
group by cliente.id;


#3. Resultado: 3 registros  
 select cliente.id, cliente.apellido as apellido, cliente.nombre as nombre, prestamo.id as prestamo,
 sucursal.numero as sucursal , ciudad.nombre AS ciudad, pais.nombre AS pais from cliente
 inner join cliente_x_prestamo on cliente_x_prestamo.cliente_id = cliente.id
 inner join prestamo on cliente_x_prestamo.prestamo_id = prestamo.id
 inner join sucursal on sucursal.numero = prestamo.sucursal_numero
 inner join ciudad on sucursal.Ciudad_id = ciudad.id
 inner join pais on pais.id = ciudad.pais_id
 where ciudad.id = 14;
 
 
#4. Resultado. 5 registros
SELECT cl.apellido, cl.nombre, cu.numero, ct.tipo
FROM cliente cl
JOIN cliente_x_cuenta cc
	ON cc.cliente_id = cl.id
JOIN cuenta cu
	ON cc.cuenta_numero = cu.numero
JOIN cuenta_tipo ct
	ON ct.id = cu.cuenta_tipo_id
WHERE ct.tipo = 'CAJA DE AHORRO' AND cl.apellido LIKE '_e%';


#5. Resultado: 20 registros
select pais.nombre as Pais, count(cliente.id) as CantidadClientes from pais
left join ciudad on pais.id = ciudad.pais_id 
left join cliente on ciudad.id = cliente.ciudad_id
group by pais.nombre
order by count(cliente.id) DESC;


#6 Resultado: 9 registros
select cliente.id, concat(cliente.apellido, ' ' ,cliente.nombre) AS Cliente, count(prestamo.id) as CantidadPrestamos, sum(prestamo.importe) AS 'importe total' from cliente
join cliente_x_prestamo on cliente_x_prestamo.cliente_id = cliente.id
join prestamo on prestamo.id = cliente_x_prestamo.prestamo_id
where MONTH(prestamo.fecha_otorgado) = 8
group by cliente.id;


#7 Resultado: totalimporte 105462.36, cuotas 3 // 1 registro
select prestamo.id, sum(prestamo.importe) as TotalAporte, count(pago.cuota_nro) as TotalCuotas from prestamo
inner join pago on prestamo.id = pago.prestamo_id
where prestamo.id = 40;


#8 Resultado: 10517.85 // 1 registro
select prestamo.id, prestamo.importe - sum(pago.importe) as ImporteFaltante from prestamo
left join pago on prestamo.id = pago.prestamo_id
where prestamo.id = 45;


-- 9. // 6 registros
SELECT cl.id AS 'numero de cliente', cl.apellido, cl.nombre, pr.id AS 'numero de prestamo'
FROM sucursal su
JOIN prestamo pr
	ON su.numero = pr.sucursal_numero
JOIN cliente_x_prestamo cp
	ON cp.prestamo_id = pr.id
JOIN cliente cl
	ON cp.cliente_id = cl.id
WHERE su.numero = 4;


-- 10. // 47 registros
SELECT
    id AS numero_prestamo,
    CASE
        WHEN cantidad_cuota = 0 THEN 'Ninguna cuota paga'
        WHEN cantidad_cuota = 1 THEN '1 cuota paga'
        ELSE CONCAT(cantidad_cuota, ' cuotas pagas')
    END AS estado_cuotas
FROM
    prestamo;


-- 11. // 60 registros
SELECT
    CONCAT(IFNULL(apellido, '-Sin asignación-'), ' ', IFNULL(LEFT(nombre, 1), '-')) AS "Empleado",
    CONCAT(IFNULL(numero, '-Sin asignación-'), ' - ', IFNULL(tipo, '-Sin asignación-')) AS "Cuenta"
FROM
    empleado
LEFT JOIN
    cuenta ON ejecutivo_cuenta = empleado.legajo
LEFT JOIN
     cuenta_tipo ON cuenta.cuenta_tipo_id = cuenta_tipo.id;


-- 12. // 64 registros
SELECT cl.apellido, cl.nombre, cl.domicilio, cl.email , cl.telefono_movil, cu.numero, ct.tipo
FROM cliente cl
JOIN cliente_x_cuenta cc
	ON cc.cliente_id = cl.id
JOIN cuenta cu
	ON cc.cuenta_numero = cu.numero
JOIN cuenta_tipo ct
	ON cu.cuenta_tipo_id = ct.id;


-- 13. // 6 registros
SELECT cl.apellido, cl.nombre, ci.nombre AS ciudad, ci.codigo_postal, p.nombre AS pais
FROM cliente cl
JOIN ciudad ci 
	ON ci.id = cl.ciudad_id
JOIN pais p
	ON p.id = ci.pais_id
WHERE ci.nombre IN ("Las Heras - Mendoza", "Viña del Mar - Valparaíso", "Córdoba - Córdoba", "Monroe - Buenos Aires");
    

-- 14. // 4 registros
SELECT cl.email, cl.telefono_movil, p.fecha_otorgado, p.importe, p.cantidad_cuota, s.numero AS 'numero de sucursal'
FROM cliente cl
JOIN cliente_x_prestamo cp
	ON cp.cliente_id = cl.id
JOIN prestamo p
	ON cp.prestamo_id = p.id
JOIN sucursal s
	ON s.numero = p.sucursal_numero
WHERE p.fecha_otorgado BETWEEN '2021-08-15' AND '2021-09-05'
ORDER BY p.fecha_otorgado;


-- 15. // 21 registros
SELECT e.email AS 'email empleado', s.numero AS 'numero de sucursal', c.nombre AS ciudad
FROM empleado e
JOIN sucursal s
	ON s.numero = e.sucursal_numero
JOIN ciudad c
	ON c.id = s.Ciudad_id
WHERE c.nombre <> 'Monroe - Buenos Aires' AND (YEAR(e.alta_contrato_laboral) BETWEEN 2016 AND 2018)
ORDER BY e.alta_contrato_laboral;


-- 16. // 3 registros
SELECT cu.numero, COUNT(cl.id) AS titulares
FROM cuenta cu
JOIN cliente_x_cuenta cc
	ON cc.cuenta_numero = cu.numero
JOIN cliente cl
	ON cc.cliente_id = cl.id
GROUP BY cu.numero
HAVING COUNT(cl.id) > 1;


-- 17. // 1 registro
SELECT p.id AS 'numero de pago ', HOUR(p.fecha) AS 'hora de pago' , p.importe, pa.nombre AS pais
FROM pago p
JOIN prestamo pr
	ON p.prestamo_id = pr.id
JOIN sucursal s
	ON pr.sucursal_numero = s.numero
JOIN ciudad c
	ON s.Ciudad_id = c.id
JOIN pais pa
	ON c.pais_id = pa.id
WHERE pa.nombre = 'Chile'
ORDER BY p.importe DESC
LIMIT 1
OFFSET 1;


-- 18. // 20 registros
SELECT c.apellido, c.nombre, c.email
FROM cliente c
LEFT JOIN cliente_x_prestamo cp
	ON cp.cliente_id = c.id
LEFT JOIN prestamo p
	ON cp.prestamo_id = p.id
WHERE p.id IS NULL;


-- 19. // 1 registro
SELECT cl.email, pr.id, pr.fecha_otorgado, pr.importe, pr.cantidad_cuota, DATE_ADD(pr.fecha_otorgado, INTERVAL pr.cantidad_cuota MONTH) AS 'ultimo pago'
FROM prestamo pr
JOIN cliente_x_prestamo cc
	ON cc.prestamo_id = pr.id
JOIN cliente cl
	ON cc.cliente_id = cl.id
WHERE pr.id = 30;


-- 20. // 15 registros
SELECT p.nombre AS pais, ci.nombre AS ciudad, COUNT(cu.numero) AS 'cantidad de cuentas'
FROM cuenta cu
JOIN cuenta_tipo ct
	ON ct.id = cu.cuenta_tipo_id
JOIN sucursal su
	ON cu.sucursal_numero = su.numero
JOIN ciudad ci
	ON ci.id = su.Ciudad_id
JOIN pais p
	ON ci.pais_id = p.id
GROUP BY ci.nombre, p.nombre
HAVING COUNT(cu.numero) BETWEEN 2 AND 4
ORDER BY p.nombre, ci.nombre;


-- 21. // 9 registros
SELECT cl.nombre, cl.apellido, cu.numero
FROM cliente cl
JOIN cliente_x_cuenta cc
	ON cc.cliente_id = cl.id
JOIN cuenta cu
	ON cc.cuenta_numero = cu.numero
JOIN cuenta_tipo ct
	ON cu.cuenta_tipo_id = ct.id
WHERE ct.tipo = 'CAJA DE AHORRO' AND cu.saldo > 15000;


-- 22. // 21 registros
SELECT su.numero, COUNT(cl.id), AVG(cu.saldo)
FROM sucursal su
JOIN cuenta cu
	ON su.numero = cu.sucursal_numero
JOIN cliente_x_cuenta cc
	ON cc.cuenta_numero = cu.numero
JOIN cliente cl
	ON cc.cliente_id = cl.id
GROUP BY su.numero;


-- 23. // 7 registros
SELECT cl.apellido, cl.nombre, cu.saldo, cu.descubierto_otorgado
FROM cliente cl
JOIN cliente_x_cuenta cc
	ON cc.cliente_id = cl.id
JOIN cuenta cu
	ON cc.cuenta_numero = cu.numero
WHERE cu.saldo < 0 AND descubierto_otorgado > 0;


-- 24. // 37 registros
SELECT cl.apellido, cl.nombre, MAX(ha.acceso) AS 'ultimo acceso'
FROM cliente cl
JOIN historial_acceso ha
	ON ha.cliente_id = cl.id
JOIN cuenta cu
	ON ha.cuenta_numero = cu.numero
GROUP BY cl.apellido, cl.nombre;


-- 25. // 50 registros
SELECT e.apellido, e.nombre , COUNT(cu.numero)
FROM empleado e
LEFT JOIN cuenta cu
	ON cu.ejecutivo_cuenta = e.legajo
GROUP BY e.apellido, e.nombre
ORDER BY e.apellido, e.nombre;










