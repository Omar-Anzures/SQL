/*
**Meta/Facebook (nivel difícil) Pregunta de entrevista de SQL: 
**Una tabla llamada "famoso" tiene dos columnas llamadas ID de usuario e ID de seguidor.
**Representa que cada ID de usuario tiene un ID de seguidor particular. 
**Estos ID de seguidores también son usuarios del hashtag #Facebook / hashtag #Meta. 
**Luego, encuentre el porcentaje famoso de cada usuario.
**Porcentaje famoso = número de seguidores que tiene un usuario / número total de usuarios en la plataforma.
*/

CREATE TABLE famous (user_id INT, follower_id INT);

INSERT INTO famous VALUES
(1, 2), (1, 3), (2, 4), (5, 1), (5, 3), 
(11, 7), (12, 8), (13, 5), (13, 10), 
(14, 12), (14, 3), (15, 14), (15, 13);

--solución
WITH distinct_users AS(
    SELECT user_id AS users FROM famous
    UNION
    SELECT follower_id as users FROM famous
),
follower_count AS
(
    SELECT user_id,COUNT(follower_id) followers
    FROM famous
    GROUP BY user_id
)

SELECT 
    f.user_id,
    (f.followers*100) / (SELECT COUNT(*) FROM distinct_users)as famous_percentage
FROM follower_count f
