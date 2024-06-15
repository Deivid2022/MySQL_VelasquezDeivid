-- Active: 1718423209898@@127.0.0.1@3306@dia3
-- ###########################################
-- #### DIA  # 5 - Claver y Restricciones ####
-- ###########################################


use dia3;

-- clientes que no han realizado ningún pago

select cliente.codigo_cliente, cliente.nombre_cliente
from cliente
where cliente.codigo_cliente not in (select pago.codigo_cliente from pago);

-- clientes que no han realizado ningún pedido

select cliente.codigo_cliente, cliente.nombre_cliente
from cliente
where cliente.codigo_cliente not in (select pedido.codigo_cliente from pedido);

-- clientes que no han realizado ningún pedido ni pago

select cliente.codigo_cliente, cliente.nombre_cliente
from cliente
where cliente.codigo_cliente not in ( select pedido.codigo_cliente from pedido)
and cliente.codigo_cliente not in ( select pago.codigo_cliente from pago);

-- empleados que no tienen un cliente asociado.

select empleado.codigo_empleado, empleado.nombre
from empleado
left join cliente on empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
where cliente.codigo_empleado_rep_ventas is null;

-- empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.

select empleado.codigo_empleado, empleado.nombre as NombreEmpleado, oficina.codigo_oficina, oficina.ciudad, oficina.pais, oficina.region, oficina.telefono
from empleado
left join cliente on empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
inner join oficina on empleado.codigo_oficina = oficina.codigo_oficina
where cliente.codigo_empleado_rep_ventas is null order by empleado.codigo_empleado ASC;

-- productos que nunca han aparecido en un pedido.
select producto.codigo_producto, producto.nombre AS NombreProducto
from producto
left join detalle_pedido ON producto.codigo_producto = detalle_pedido.codigo_producto
where detalle_pedido.codigo_producto is null;

-- productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.

select producto.codigo_producto, producto.nombre AS NombreProducto, producto.descripcion as DescripcionProducto, gama_producto.imagen
from producto
left join detalle_pedido ON producto.codigo_producto = detalle_pedido.codigo_producto
inner join gama_producto on producto.gama = gama_producto.gama
where detalle_pedido.codigo_producto is null;

-- oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún 
-- cliente que haya realizado la compra de algún producto de la gama Frutales.

select DISTINCT oficina.codigo_oficina, oficina.ciudad, oficina.pais, oficina.region, oficina.telefono
from oficina
where oficina.codigo_oficina not in (
    select DISTINCT oficina.codigo_oficina
    from oficina
    join empleado on oficina.codigo_oficina = empleado.codigo_oficina
    join cliente on empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
    join pedido on cliente.codigo_cliente = pedido.codigo_cliente
    join detalle_pedido on pedido.codigo_pedido = detalle_pedido.codigo_pedido
    join producto on detalle_pedido.codigo_producto = producto.codigo_producto
    
    where producto.gama = 'Frutales'
);

-- clientes que han realizado algún pedido pero no han realizado ningún pago.

select distinct cliente.codigo_cliente, cliente.nombre_cliente
from cliente
inner join pedido on cliente.codigo_cliente = pedido.codigo_cliente
left join pago on cliente.codigo_cliente = pago.codigo_cliente
where pago.codigo_cliente is null;

