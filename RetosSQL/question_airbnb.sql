/*
Pregunta de entrevista de Airbnb (nivel medio)

Encuentre la cantidad total de camas disponibles por nacionalidad de los anfitriones.
Imprima la nacionalidad junto con la cantidad total correspondiente de camas disponibles.
Ordene los registros por la cantidad total de camas disponibles en orden descendente.
*/

CREATE TABLE airbnb_apartments(
    host_id int,
    partment_id varchar(5),
    apartment_type varchar(10),
    n_beds int,
    n_bedrooms int,
    country varchar(20),
    city varchar(20));
    
INSERT INTO airbnb_apartments VALUES(0,'A1','Room',1,1,'USA','NewYork'),
                                    (0,'A2','Room',1,1,'USA','NewJersey'),
                                    (0,'A3','Room',1,1,'USA','NewJersey'),
                                    (1,'A4','Apartment',2,1,'USA','Houston'),
                                    (1,'A5','Apartment',2,1,'USA','LasVegas'),
                                    (3,'A7','Penthouse',3,3,'China','Tianjin'),
                                    (3,'A8','Penthouse',5,5,'China','Beijing'),
                                    (4,'A9','Apartment',2,1,'Mali','Bamako'),
                                    (5,'A10','Room',3,1,'Mali','Segou')

CREATE TABLE airbnb_hosts(
    host_id int,
    nationality  varchar(15),
    gender varchar(5),
    age int);

INSERT INTO airbnb_hosts  VALUES(0,'USA','M',28),
                                (1,'USA','F',29),
                                (2,'China','F',31),
                                (3,'China','M',24),
                                (4,'Mali','M',30),
                                (5,'Mali','F',30);

SELECT 
    h.nationality,
    SUM(a.n_beds) AS total_beds
FROM airbnb_apartments a
JOIN airbnb_hosts h 
    ON a.host_id = h.host_id
GROUP BY h.nationality
ORDER BY total_beds DESC


