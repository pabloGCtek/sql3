-- Sentencia Select 
--Obtener todos los registros y todos los campos de la tabla de productos
Select * from products;

-- Obtenerr una consulta con Productid, productname, supplierid, categoryId, UnistsinStock, UnitPrice
SELECT product_id, product_name, supplier_id, units_in_stock, unit_price FROM products;

--Crear una consulta para obtener el IdOrden, IdCustomer, Fecha de la orden de la tabla de ordenes.
SELECT order_id, customer_id, order_date FROM orders;

--Crear una consulta para obtener el OrderId, EmployeeId, Fecha de la orden.
SELECT order_id, employee_id, order_date FROM orders;

--Columnas calculadas 

--Obtener una consulta con Productid, productname y valor del inventario, valor inventrio (UnitsinStock * UnitPrice)
Select product_id, product_name, (units_in_stock * unit_price) as valor_inv from products;

-- Cuanto vale el punto de reorden 
Select (reorder_level * unit_price) as punto_reorden from products;

-- Mostrar una consulta con Productid, productname y precio, el nombre del producto debe estar en mayuscula 
Select product_id, UPPER(product_name), unit_price from products;

-- Mostrar una consulta con Productid, productname y precio, el nombre del producto debe contener unicamente 10 caracteres */
Select product_id, LEFT(product_name,10), unit_price from products;


--Obtener una consulta que muestre la longitud del nombre del producto
Select LENGTH(product_name) from products;

--Obtener una consulta de la tabla de productos que muestre el nombre en minúscula
Select LOWER(product_name) from products;

-- Mostrar una consulta con Productid, productname y precio, el nombre del producto debe contener unicamente 10 caracteres y se deben mostrar en mayúscula */
Select product_id, UPPER(LEFT(product_name,10)), unit_price from products;

--Filtros

--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais Obtener los clientes cuyo pais sea Spain
Select customer_id,company_name, country from customers where country='Spain';

--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais, Obtener los clientes cuyo pais comience con la letra U
Select customer_id,company_name, country from customers where LEFT(country,1) ='U';

--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais, Obtener los clientes cuyo pais comience con la letra U,S,A
Select customer_id,company_name, country from customers where LEFT(country,1) ='U' or LEFT(country,1) ='S' or LEFT(country,1) ='A'

--Obtener de la tabla de Productos las columnas productid, ProductName, UnitPrice cuyos precios esten entre 50 y 150
Select product_id,product_name, unit_price from products where unit_price BETWEEN 50 AND 150;

--Obtener de la tabla de Productos las columnas productid, ProductName, UnitPrice, UnitsInStock cuyas existencias esten entre 50 y 100
Select product_id,product_name, unit_price,units_in_stock from products where units_in_stock BETWEEN 50 AND 150;
--Obtener las columnas OrderId, CustomerId, employeeid de la tabla de ordenes cuyos empleados sean 1, 4, 9
Select order_id,customer_id, employee_id from orders where employee_id='4' or employee_id='1' or employee_id='9'

-- ORDENAR EL RESULTADO DE LA QUERY POR ALGUNA COLUMNA
--Obtener la información de la tabla de Products, Ordenarlos por Nombre del Producto de forma ascendente
SELECT  *  FROM products ORDER BY product_name ASC;

-- Obtener la información de la tabla de Products, Ordenarlos por Categoria de forma ascendente y por precio unitario de forma descendente
SELECT * FROM products ORDER BY category_id ASC, unit_price DESC;
-- Obtener la información de la tabla de Clientes, Customerid, CompanyName, city, country ordenar por pais, ciudad de forma ascendente
SELECT customer_id, company_name, country, city FROM customers ORDER BY country,city;

-- Obtener los productos productid, productname, categoryid, supplierid ordenar por categoryid y supplier únicamente mostrar aquellos cuyo precio esté entre 25 y 200
SELECT product_id,product_name, category_id, supplier_id from products WHERE unit_price BETWEEN 25 AND 200 ORDER BY category_id,supplier_id;

--Funciones agregación
--Cuantos productos hay en la tabla de productos
Select COUNT(*) from products; 

--de la tabla de productos Sumar las cantidades en existencia 
Select SUM(units_in_stock) from products;

--Promedio de los precios de la tabla de productos
Select AVG(unit_price) from products;



--Ordenar
--Obtener los datos de productos ordenados descendentemente por precio unitario de la categoría 1
Select * from products WHERE category_id='1' ORDER BY unit_price;

--Obtener los datos de los clientes(Customers) ordenados descendentemente por nombre(CompanyName) que se encuentren en la ciudad(city) de barcelona, Lisboa
Select * from customers WHERE city = 'Barcelona' or city = 'Lisboa'  ORDER BY company_name DESC;

--Obtener los datos de las ordenes, ordenados descendentemente por la fecha de la orden cuyo cliente(CustomerId) sea ALFKI
Select * from orders WHERE customer_id = 'ALFKI'  ORDER BY order_date DESC;

--Obtener los datos del detalle de ordenes, ordenados ascendentemente por precio cuyo producto sea 1, 5 o 20
Select * from order_details WHERE product_id = '1' or product_id = '4' or product_id = '20' ORDER BY unit_price ASC;

--Obtener los datos de las ordenes ordenados ascendentemente por la fecha de la orden cuyo empleado sea 2 o 4
Select * from orders WHERE employee_id = '2' or employee_id = '4' ORDER BY order_date ASC;

--Obtener los productos cuyo precio están entre 30 y 60 ordenado por nombre
Select * from products WHERE unit_price BETWEEN 30 AND 60 ORDER BY product_name ASC;

--funciones de agrupación
--OBTENER EL MAXIMO, MINIMO Y PROMEDIO DE PRECIO UNITARIO DE LA TABLA DE PRODUCTOS UTILIZANDO ALIAS
SELECT unit_price AS price, MIN(unit_price), MAX(unit_price), AVG(unit_price) FROM products GROUP BY price;





--Agrupacion
--Numero de productos por categoría
Select SUM(units_in_stock) FROM products GROUP by category_id;
 	
--Obtener el precio promedio por proveedor de la tabla de productos
Select AVG(unit_price) FROM products GROUP by supplier_id;

--Obtener la suma de inventario (UnitsInStock) por SupplierID De la tabla de productos (Products)
Select SUM(units_in_stock) FROM products GROUP by supplier_id;

--Contar las ordenes por cliente de la tabla de orders
Select COUNT(order_id) FROM orders GROUP by customer_id;

--Contar las ordenes por empleado de la tabla de ordenes unicamente del empleado 1,3,5,6
Select COUNT(order_id) FROM orders WHERE employee_id = '1' or employee_id = '3' or employee_id = '5' or employee_id = '6'  GROUP by employee_id;

--Obtener la suma del envío (freight) por cliente
SELECT SUM(freight) from orders group by customer_id;

--De la tabla de ordenes únicamente de los registros cuya ShipCity sea Madrid, Sevilla, Barcelona, Lisboa, London Ordenado por el campo de suma del envío


--obtener el precio promedio de los productos por categoria sin contar con los productos descontinuados (Discontinued)
Select category_id, AVG(unit_price) FROM products WHERE discontinued =0 GROUP BY category_id;

--Obtener la cantidad de productos por categoria,  aquellos cuyo precio se encuentre entre 10 y 60 que tengan más de 12 productos


--OBTENER LA SUMA DE LAS UNIDADES EN EXISTENCIA (UnitsInStock) POR CATEGORIA, Y TOMANDO EN CUENTA UNICAMENTE LOS PRODUCTOS CUYO PROVEEDOR (SupplierID) SEA IGUAL A 17, 19, 16.
SELECT category_id, SUM(units_in_stock) from products WHERE supplier_id IN (17,19,16;

--cuya categoria tenga menos de 100 unidades ordenado por unidades
SELECT category_id, SUM(units_in_stock) as “unidades” from products WHERE supplier_id IN(17,19,16) GROUP BY category_id HAVING SUM(units_in_stock) < 200 ORDER BY unidades;

