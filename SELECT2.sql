--distinct

-- Se quiere saber a qué paises se les vende usar la tabla de clientes
SELECT DISTINCT country from customers;
-- Se quiere saber a qué ciudades se les vende usar la tabla de clientes
SELECT DISTINCT city from customers;
-- Se quiere saber a qué ciudades se les ha enviado una orden
SELECT DISTINCT ship_city from orders;
--Se quiere saber a qué ciudades se les vende en el pais USA usar la tabla de clientes
SELECT DISTINCT city from customers where country = 'USA';
--Agrupacion

-- Se quiere saber a qué paises se les vende usar la tabla de clientes nota hacerla usando group by
SELECT country from customers GROUP BY country;
--Cuantos clientes hay por pais
SELECT count(customer_id) from customers GROUP BY country;

--Cuantos clientes hay por ciudad en el pais USA
SELECT count(customer_id) from customers where country = 'USA' GROUP BY city ;
--Cuantos productos hay por proveedor de la categoria 1
SELECT count(product_id) from products where category_id = '1';

--Filtro con having

-- Cuales son los proveedores que nos surten más de 1 producto, mostrar el proveedor mostrar la cantidad de productos
SELECT supplier_id, COUNT(product_id) from products GROUP BY supplier_id HAVING COUNT(product_id) >1 ;
-- Cuales son los proveedores que nos surten más de 1 producto, mostrar el proveedor mostrar la cantidad de productos, pero únicamente de la categoria 1
SELECT supplier_id, COUNT(product_id) from products  WHERE category_id = 1 GROUP BY supplier_id  HAVING COUNT(product_id) >1 ;

--CONTAR LAS ORDENES POR EMPLEADO DE LOS PAISES USA, CANADA, SPAIN (ShipCountry) MOSTRAR UNICAMENTE LOS EMPLEADOS CUYO CONTADOR DE ORDENES SEA MAYOR A 20
SELECT employee_id, count(order_id) FROM orders where ship_country IN('USA','Canada','Spain') GROUP BY employee_id HAVING COUNT(order_id) >20;
--OBTENER EL PRECIO PROMEDIO DE LOS PRODUCTOS POR PROVEEDOR UNICAMENTE DE AQUELLOS CUYO PROMEDIO SEA MAYOR A 20
SELECT supplier_id, AVG(unit_price) from products GROUP BY supplier_id HAVING AVG(unit_price) >20;
--OBTENER LA SUMA DE LAS UNIDADES EN EXISTENCIA (UnitsInStock) POR CATEGORIA, Y TOMANDO EN CUENTA UNICAMENTE LOS PRODUCTOS CUYO PROVEEDOR (SupplierID) SEA IGUAL A 17, 19, 16 DICIONALMENTE CUYA SUMA POR CATEGORIA SEA MAYOR A 300--
SELECT category_id, SUM(units_in_stock) from products where supplier_id IN(17,19,16) GROUP BY category_id HAVING SUM(units_in_stock) >300;
--CONTAR LAS ORDENES POR EMPLEADO DE LOS PAISES (ShipCountry) SA, CANADA, SPAIN cuYO CONTADOR SEA MAYOR A 25
SELECT count(order_id) from orders where ship_country = 'USA' or ship_country = 'Canada' or ship_country = 'Spain' HAVING count(order_id) > 25;
----OBTENER LAS VENTAS (Quantity * UnitPrice) AGRUPADAS POR PRODUCTO (Orders details) Y CUYA SUMA DE VENTAS SEA MAYOR A 50.000
Select (units_in_stock * unit_price) from products GROUP BY product_id HAVING (units_in_stock * unit_price) > 50.000;

--Mas de una tabla 

--OBTENER EL NUMERO DE ORDEN, EL ID EMPLEADO, NOMBRE Y APELLIDO DE LAS TABLAS DE ORDENES Y EMPLEADOS
SELECT order_id, orders.employee_id, CONCAT(first_name,last_name) from orders INNER JOIN employees ON employees.employee_id = orders.employee_id;
--OBTENER EL PRODUCTID, PRODUCTNAME, SUPPLIERID, COMPANYNAME DE LAS TABLAS DE PRODUCTOS Y PROVEEDORES (SUPPLIERS)
SELECT product_id, product_name, products.supplier_id, company_name from products inner join suppliers ON products.supplier_id = suppliers.supplier_id;
--OBTENER LOS DATOS DEL DETALLE DE ORDENES CON EL NOMBRE DEL PRODUCTO DE LAS TABLAS DE DETALLE DE ORDENES Y DE PRODUCTOS
SELECT * from order_details inner join products on products.product_id = order_details.product_id;
--OBTENER DE LAS ORDENES EL ID, SHIPPERID, NOMBRE DE LA COMPAÑÍA DE ENVIO (SHIPPERS)
SELECT order_id, shipper_id, company_name from orders inner join shippers on orders.ship_via= shippers.shipper_id;
--Obtener el número de orden, país de envío (shipCountry) y el nombre del empleado de la tabla ordenes y empleados Queremos que salga el Nombre y Apellido del Empleado en una sola columna.
SELECT order_id, ship_country, first_name from orders inner join employees on orders.employee_id = employees.employee_id;

--Combinando la mayoría de conceptos
 
--CONTAR EL NUMERO DE ORDENES POR EMPLEADO OBTENIENDO EL ID EMPLEADO Y EL NOMBRE COMPLETO DE LAS TABLAS DE ORDENES Y DE EMPLEADOS join y group by / columna calculada
SELECT count(order_id), employees.employee_id, CONCAT(first_name, ' ',last_name) as e_name from employees inner join orders on employees.employee_id = orders.employee_id GROUP BY employees.employee_id;
--OBTENER LA SUMA DE LA CANTIDAD VENDIDA Y EL PRECIO PROMEDIO POR NOMBRE DE PRODUCTO DE LA TABLA DE ORDERS DETAILS Y PRODUCTS
SELECT products.product_name, SUM(order_details.quantity * order_details.unit_price) as ventas, avg(order_details.unit_price) avgprice
FROM products inner join order_details on products.product_id = order_details.product_id GROUP BY  products.product_name;
--OBTENER LAS VENTAS (UNITPRICE * QUANTITY) POR CLIENTE DE LAS TABLAS ORDER DETAILS, ORDERS
Select orders.customer_id, SUM(order_details.quantity * order_details.unit_price) as ventas
FROM orders inner join order_details on order_details.order_id = orders.order_id GROUP BY orders.customer_id;
--OBTENER LAS VENTAS (UNITPRICE * QUANTITY) POR EMPLEADO MOSTRANDO EL APELLIDO (LASTNAME)DE LAS TABLAS EMPLEADOS, ORDENES, DETALLE DE ORDENES
Select employees.last_name,SUM(order_details.quantity * order_details.unit_price) as ventas
from orders inner join employees on employees.employee_id = orders.employee_id
inner join order_details on order_details.order_id = orders.order_id group by employees.last_name