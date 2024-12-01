/*
*Estás analizando un conjunto de datos de una red social en Google. 
*Tu tarea es encontrar amigos en común entre dos usuarios, Karl y Hans.
*Solo hay un usuario llamado Karl y otro llamado Hans en el conjunto de datos.
*El resultado debe contener las columnas 'user_id' y 'user_name'.
*/

CREATE TABLE users(user_id INT, user_name varchar(30));
INSERT INTO users VALUES (1, 'Karl'),
                         (2, 'Hans'), 
                         (3, 'Emma'), 
                         (4, 'Emma'), 
                         (5, 'Mike'), 
                         (6, 'Lucas'), 
                         (7, 'Sarah'), 
                         (8, 'Lucas'),
                         (9, 'Anna'),
                         (10, 'John');

CREATE TABLE friends(user_id INT, friend_id INT);
INSERT INTO friends VALUES (1,3),(1,5),(2,3),(2,4),(3,1),(3,2),(3,6),(4,7),(5,8),(6,9),(7,10),(8,6),(9,10),(10,7),(10,9);

WITH karl_friends AS(
    SELECT friend_id
    FROM friends
    WHERE user_id = (SELECT user_id FROM users WHERE user_name = 'Karl')
),

hans_friends AS(
    SELECT friend_id
    FROM friends
    WHERE user_id = (SELECT user_id FROM users WHERE user_name = 'Hans')
)

SELECT u.user_id,u.user_name
FROM users u 
INNER JOIN karl_friends k 
    ON u.user_id = K.friend_id
INNER JOIN hans_friends h 
    ON u.user_id = h.friend_id