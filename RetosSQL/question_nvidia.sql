
-- Calcula el número de transacciones realizadas para cada producto.
-- Genera el nombre del producto junto con el número correspondiente de transacciones y 
-- registros de pedidos por ID de producto en orden ascendente. 
-- Puedes ignorar los productos sin transacciones.

-- 🔍 Al resolver esto, aprenderás a usar la join con agrupación. ¡Pruébalo y comparte el resultado! 👇

CREATE TABLE excel_sql_inventory_data (
    product_id INT,product_name VARCHAR(50),
    product_type VARCHAR(50),unit VARCHAR(20),
    price_unit FLOAT,
    wholesale FLOAT,
    current_inventory INT);

INSERT INTO excel_sql_inventory_data (product_id, product_name, product_type, unit, price_unit, wholesale, current_inventory) 
VALUES(1, 'strawberry', 'produce', 'lb', 3.28, 1.77, 13),
        (2, 'apple_fuji', 'produce', 'lb', 1.44, 0.43, 2),
        (3, 'orange', 'produce', 'lb', 1.02, 0.37, 2),
        (4, 'clementines', 'produce', 'lb', 1.19, 0.44, 44),
        (5, 'blood_orange', 'produce', 'lb', 3.86, 1.66, 19);

CREATE TABLE excel_sql_transaction_data (transaction_id INT PRIMARY KEY,time DATETIME,product_id INT);

INSERT INTO excel_sql_transaction_data (transaction_id, time, product_id) 
VALUES(153, '2016-01-06 08:57:52', 1),
(91, '2016-01-07 12:17:27', 1),
(31, '2016-01-05 13:19:25', 1),
(24, '2016-01-03 10:47:44', 3),
(4, '2016-01-06 17:57:42', 3),
(163, '2016-01-03 10:11:22', 3),
(92, '2016-01-08 12:03:20', 2),
(32, '2016-01-04 19:37:14', 4),
(253, '2016-01-06 14:15:20', 5),
(118, '2016-01-06 14:27:33', 5);


SELECT 
    i.product_name,
    COUNT(t.transaction_id) AS count_transaction
FROM excel_sql_inventory_data i 
    JOIN excel_sql_transaction_data t 
        ON i.product_id = t.product_id
GROUP BY i.product_id,i.product_name
ORDER BY i.product_id ASC


