/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */

SELECT 
    DISTINCT first_name || ' ' || last_name AS "Actor Name"
FROM actor
JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
WHERE title IN (
    SELECT title 
    FROM film
    JOIN film_actor USING (film_id)
    JOIN actor USING (actor_id)
    WHERE first_name || ' ' || last_name = 'RUSSELL BACALL'
)
EXCEPT
SELECT first_name || ' ' || last_name AS "Actor Name"
FROM actor
WHERE first_name || ' ' || last_name = 'RUSSELL BACALL'
ORDER BY "Actor Name";
