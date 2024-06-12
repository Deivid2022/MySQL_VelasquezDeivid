-- ########################################
-- #### DIA  # 3 - Consultas de tablas ####
-- ########################################

-- oficina - ciudad 
select codigo_oficina, ciudad from oficina;

-- Ciudad - Telefono - Oficina en españa
select ciudad, telefono from oficina where pais = 'España';

-- Nombre - Apellido - Email - de empleados cuyo jefe codigo = 7
select nombre, apellido1, email from empleado where codigo_jefe = 7;

-- Puesto - Nombre - Apellido1 - Apellido2 - email
select puesto, nombre, apellido1, apellido2, email from empleado where codigo_jefe is null;

-- Nombre - Apellidos - puesto empleados /= representates de ventas
select nombre, apellido1, apellido2, puesto from empleado where puesto != 'Representante Ventas';

-- Nombre clientes españoles
select nombre_cliente, pais from cliente where pais = 'Spain';

-- distintos estados que puede tener un pedido
select distinct estado from pedido;

-- codigo cliente que realizaron algun pago en el 2008
select distinct codigo_cliente from pago where year(fecha_pago) = 2008;

-- código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido where date(fecha_esperada) < date(fecha_entrega);

-- código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido where datediff(fecha_esperada, fecha_entrega) = 2;

-- pedidos que fueron en 2009
select codigo_pedido, codigo_cliente, fecha_pedido, estado, comentarios from pedido where year(fecha_pedido) = 2009;

-- pedidos que han sido  en el mes de enero de cualquier año
select codigo_pedido, codigo_cliente, fecha_pedido, estado, comentarios from pedido where date_format(fecha_pedido, "%m") = 01;

-- pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
select codigo_cliente, id_transaccion, fecha_pago, forma_pago, total from pago where year(fecha_pago) = 2008 and forma_pago = 'PayPal' order by id_transaccion DESC;

-- pago que aparecen en la tabla pago
select distinct forma_pago from pago;

-- productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock
select codigo_producto, nombre, gama, cantidad_en_stock, precio_venta from producto where gama = 'Ornamentales' and cantidad_en_stock > 100 order by precio_venta desc;

-- clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30
select codigo_cliente, nombre_cliente, ciudad, codigo_empleado_rep_ventas from cliente where ciudad = 'Madrid' and (codigo_empleado_rep_ventas = 11 or codigo_empleado_rep_ventas = 30);


-- Desarrollado por Deivid Velasquez Gutierres / TI: 1096701633