-- Se le proporciona una tabla de lanzamientos de productos por empresa por año. 
-- Escriba una consulta para contar la diferencia neta entre la cantidad de productos 
-- que las empresas lanzaron en 2020 y la cantidad de productos que las empresas lanzaron el año anterior.
-- Genere el nombre de las empresas y una diferencia neta de productos netos lanzados en 2020 en comparación con el año anterior.

CREATE TABLE car_launches(year int, company_name varchar(15), product_name varchar(30));

INSERT INTO car_launches VALUES(2019,'Toyota','Avalon'),
                                (2019,'Toyota','Camry'),
                                (2020,'Toyota','Corolla'),
                                (2019,'Honda','Accord'),
                                (2019,'Honda','Passport'),
                                (2019,'Honda','CR-V'),
                                (2020,'Honda','Pilot'),
                                (2019,'Honda','Civic'),
                                (2020,'Chevrolet','Trailblazer'),
                                (2020,'Chevrolet','Trax'),
                                (2019,'Chevrolet','Traverse'),
                                (2020,'Chevrolet','Blazer'),
                                (2019,'Ford','Figo'),
                                (2020,'Ford','Aspire'),
                                (2019,'Ford','Endeavour'),
                                (2020,'Jeep','Wrangler')


WITH count_product AS(

    SELECT 
            company_name,
            SUM(CASE WHEN year = 2020 THEN 1 ELSE 0 END) AS product_2020,
            SUM(CASE WHEN year = 2019 THEN 1 ELSE 0 END) AS product_2019
    FROM car_launches
    WHERE year IN (2020,2019)
    GROUP BY company_name
)

SELECT 
    company_name,
    (product_2020 - product_2019) difference_product
FROM count_product
ORDER BY difference_product DESC

