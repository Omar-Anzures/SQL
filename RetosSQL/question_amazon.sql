/*Amazon (nivel difícil) Pregunta de entrevista con hashtag #SQL
**
**Dada una tabla 'sf_transactions' de compras por fecha, calcule el cambio porcentual
**de los ingresos mes a mes. El resultado debe incluir la fecha año-mes (AAAA-MM) y el
**cambio porcentual, redondeado al segundo punto decimal y ordenado desde el comienzo 
**del año hasta el final del año. La columna de cambio porcentual se completará a partir
**del segundo mes y se calculará como:
**((ingresos de este mes - ingresos del mes pasado) / ingresos del mes pasado)*100.
**
**
**/

/*explicacion
1. CTE MonthlyRevenue:
Agrega los ingresos totales de cada mes usando FORMAT para convertir la fecha created_at 
al formato AAAA-MM.

2. CTE RevenueChange:
Agrega una columna previous_revenue usando la función LAG, que recupera los ingresos totales 
del mes anterior para cada fila.

3. SELECT final:
Calcula el cambio porcentual como ((total_revenue - previous_revenue) / previous_revenue) * 100. 
La función ROUND garantiza que el porcentaje se redondee a dos decimales. La salida se ordena por año_mes 
para mostrar los datos cronológicamente.
*/

CREATE TABLE sf_transactions(id INT, created_at datetime, value INT, purchase_id INT);

SELECT *FROM sf_transactions;

INSERT INTO sf_transactions VALUES
(1, '2019-01-01 00:00:00',  172692, 43),
 (2,'2019-01-05 00:00:00',  177194, 36),
 (3, '2019-01-09 00:00:00',  109513, 30),
 (4, '2019-01-13 00:00:00',  164911, 30),
 (5, '2019-01-17 00:00:00',  198872, 39), 
 (6, '2019-01-21 00:00:00',  184853, 31),
 (7, '2019-01-25 00:00:00',  186817, 26), 
 (8, '2019-01-29 00:00:00',  137784, 22),
 (9, '2019-02-02 00:00:00',  140032, 25), 
 (10, '2019-02-06 00:00:00', 116948, 43), 
 (11, '2019-02-10 00:00:00', 162515, 25), 
 (12, '2019-02-14 00:00:00', 114256, 12), 
 (13, '2019-02-18 00:00:00', 197465, 48), 
 (14, '2019-02-22 00:00:00', 120741, 20), 
 (15, '2019-02-26 00:00:00', 100074, 49), 
 (16, '2019-03-02 00:00:00', 157548, 19), 
 (17, '2019-03-06 00:00:00', 105506, 16), 
 (18, '2019-03-10 00:00:00', 189351, 46), 
 (19, '2019-03-14 00:00:00', 191231, 29), 
 (20, '2019-03-18 00:00:00', 120575, 44), 
 (21, '2019-03-22 00:00:00', 151688, 47), 
 (22, '2019-03-26 00:00:00', 102327, 18), 
 (23, '2019-03-30 00:00:00', 156147, 25);

--SOLUCION
 WITH month_renueve AS(

    SELECT 
        FORMAT(created_at,'yyyy/MM')as year_month,
        SUM(value) as total_revenue
    FROM sf_transactions
    GROUP BY FORMAT(created_at,'yyyy/MM')
 ),

 renueve_change AS(
    SELECT 
        year_month,
        total_revenue,
        LAG(total_revenue) OVER (ORDER BY year_month) AS previous_revenue
    FROM month_renueve
 )

 SELECT 
    year_month,
    total_revenue,
    ROUND(
        CASE
            WHEN previous_revenue IS NULL THEN NULL
            ELSE (total_revenue - previous_revenue) / CAST(previous_revenue AS FLOAT) * 100
        END,2
    )AS porcentage_change
 FROM  renueve_change 
 ORDER BY year_month


