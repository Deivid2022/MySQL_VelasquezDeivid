-- Active: 1718362591260@@172.16.101.155@3306@dia3
-- ########################################
-- #### DIA  # 3 - Consultas de tablas ####
-- ########################################

-- oficina - ciudad 
select codigo_oficina, ciudad 
from oficina;

-- Ciudad - Telefono - Oficina en españa
select ciudad, telefono 
from oficina 
where pais = 'España';

-- Nombre - Apellido - Email - de empleados cuyo jefe codigo = 7
select nombre, apellido1, email 
from empleado 
where codigo_jefe = 7;

-- Puesto - Nombre - Apellido1 - Apellido2 - email
select puesto, nombre, apellido1, apellido2, email 
from empleado 
where codigo_jefe is null;

-- Nombre - Apellidos - puesto empleados /= representates de ventas
select nombre, apellido1, apellido2, puesto 
from empleado 
where puesto != 'Representante Ventas';

-- Nombre clientes españoles
select nombre_cliente, pais 
from cliente 
where pais = 'Spain';

-- distintos estados que puede tener un pedido
select distinct estado 
from pedido;

-- codigo cliente que realizaron algun pago en el 2008
select distinct codigo_cliente 
from pago 
where year(fecha_pago) = 2008;

-- código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega 
from pedido 
where date(fecha_esperada) < date(fecha_entrega);

-- código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega 
from pedido 
where datediff(fecha_esperada, fecha_entrega) = 2;

-- pedidos que fueron en 2009
select codigo_pedido, codigo_cliente, fecha_pedido, estado, comentarios 
from pedido 
where year(fecha_pedido) = 2009;

-- pedidos que han sido  en el mes de enero de cualquier año
select codigo_pedido, codigo_cliente, fecha_pedido, estado, comentarios 
from pedido 
where date_format(fecha_pedido, "%m") = 01;

-- pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
select codigo_cliente, id_transaccion, fecha_pago, forma_pago, total 
from pago 
where year(fecha_pago) = 2008 and forma_pago = 'PayPal' order by id_transaccion DESC;

-- pago que aparecen en la tabla pago
select distinct forma_pago 
from pago;

-- productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock
select codigo_producto, nombre, gama, cantidad_en_stock, precio_venta 
from producto 
where gama = 'Ornamentales' and cantidad_en_stock > 100 order by precio_venta desc;

-- clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30
select codigo_cliente, nombre_cliente, ciudad, codigo_empleado_rep_ventas 
from cliente 
where ciudad = 'Madrid' and (codigo_empleado_rep_ventas = 11 or codigo_empleado_rep_ventas = 30);

-- ##############################
-- ### Consultas Multitablas; ###
-- ##############################

-- nombre de cada cliente y el nombre y apellido de su representante de ventas
select cliente.nombre_cliente as NombreCliente, empleado.nombre as NombreEmpleado, empleado.apellido1 as ApellidoEmpleado
from cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

-- nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas
select cliente.nombre_cliente as NombreCliente, empleado.nombre as NombreEmpleado
from pago
inner join cliente on pago.codigo_cliente = cliente.codigo_cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

-- nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select cliente.nombre_cliente as NombreCliente, empleado.nombre as NombreEmpleado, oficina.ciudad as CiudadOficina
from pago
inner join cliente on pago.codigo_cliente = cliente.codigo_cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
inner join oficina on empleado.codigo_oficina = oficina.codigo_oficina;

-- nombre de los clientes que  hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
select cliente.nombre_cliente as NombreCliente, empleado.nombre as NombreEmpleada, oficina.ciudad as CiudadOficina
from pago
inner join cliente on pago.codigo_cliente = cliente.codigo_cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
inner join oficina on empleado.codigo_oficina = oficina.codigo_oficina
where cliente.ciudad = 'Fuenlabrada';

-- nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select cliente.nombre_cliente as NombreCliente, empleado.nombre as NombreEmpleado, oficina.ciudad as CiudadOficina
from cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
inner join oficina on empleado.codigo_oficina = oficina.codigo_oficina;

-- nombre de los empleados junto con el nombre de sus jefes
select e.nombre AS NombreEmpleado, j.nombre AS NombreJefe
from empleado e
left join empleado j on e.codigo_jefe = j.codigo_empleado;

-- nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe
select empleado.nombre as NombreEmpleado, jefe.nombre as NombreJefe, jefe2.nombre as NombreJefe2
from empleado empleado
left join empleado jefe on empleado.codigo_jefe = jefe.codigo_empleado
left join empleado jefe2 on jefe.codigo_jefe = jefe2.codigo_empleado;

-- nombre de los clientes a los que no se les ha entregado a tiempo un pedido
select cliente.nombre_cliente
from cliente
inner join pedido on cliente.codigo_cliente = pedido.codigo_cliente
where date(pedido.fecha_esperada)<(pedido.fecha_entrega);

-- diferentes gamas de producto que ha comprado cada cliente
select cliente.codigo_cliente, cliente.nombre_cliente, gama_producto.gama
from cliente
join pedido ON cliente.codigo_cliente = pedido.codigo_cliente
join detalle_pedido ON pedido.codigo_pedido = detalle_pedido.codigo_pedido
join producto ON detalle_pedido.codigo_producto = producto.codigo_producto
join gama_producto ON producto.gama = gama_producto.gama
group by cliente.codigo_cliente, gama_producto.gama
order by cliente.codigo_cliente, gama_producto.gama;


-- Desarrollado por Deivid Velasquez Gutierres / TI: 1096701633