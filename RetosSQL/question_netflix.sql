-- Encuentra el género de la persona con la mayor cantidad de premios Óscar.
-- Si hay más de una persona con la misma cantidad de premios Óscar, devuelve la 
-- primera en orden alfabético según su nombre. Usa los nombres como claves al unir las tablas.

CREATE TABLE nominee_information(
    name varchar(20), 
    amg_person_id varchar(10),
    top_genre varchar(10), 
    birthday datetime, 
    id int
);

INSERT INTO nominee_information VALUES('Jennifer Lawrence','P562566','Drama','1990-08-15',755),
                                        ('Jonah Hill','P418718','Comedy','1983-12-20',747),
                                        ('Anne Hathaway', 'P292630','Drama', '1982-11-12',744),
                                        ('Jennifer Hudson','P454405','Drama', '1981-09-12',742),
                                        ('Rinko Kikuchi', 'P475244','Drama', '1981-01-06', 739);

CREATE TABLE oscar_nominees(
    year int, 
    category varchar(30), 
    nominee varchar(20), 
    movie varchar(30), 
    winner int, 
    id int
);

INSERT INTO oscar_nominees VALUES(2008,'actress in a leading role','Anne Hathaway','Rachel Getting Married',0,77),
                                    (2012,'actress in a supporting role','Anne HathawayLes','Mis_rables',1,78),
                                    (2006,'actress in a supporting role','Jennifer Hudson','Dreamgirls',1,711),
                                    (2010,'actress in a leading role','Jennifer Lawrence','Winters Bone',1,717),
                                    (2012,'actress in a leading role','Jennifer Lawrence','Silver Linings Playbook',1,718),
                                    (2011,'actor in a supporting role','Jonah Hill','Moneyball',0,799),
                                    (2006,'actress in a supporting role','Rinko Kikuchi','Babel',0,1253);

INSERT INTO oscar_nominees VALUES (2009,'Mejor peli','Jennifer Hudson','Peli de prueba',1,111)

-- Encuentra el género de la persona con la mayor cantidad de premios Óscar.
-- Si hay más de una persona con la misma cantidad de premios Óscar, devuelve la 
-- primera en orden alfabético según su nombre. Usa los nombres como claves al unir las tablas.


WITH winner_list AS(
SELECT n.name,n.top_genre,SUM(o.winner) AS premios
FROM nominee_information n 
JOIN oscar_nominees o 
    ON n.name = o.nominee
GROUP BY n.name,n.top_genre
)

SELECT TOP 1 name, top_genre
FROM  (
    SELECT name, premios,top_genre, RANK() OVER (ORDER BY premios DESC) AS ranking
    FROM winner_list
) AS ranked_list
WHERE ranking = 1
ORDER BY name ASC