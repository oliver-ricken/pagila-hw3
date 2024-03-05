/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

WITH bacall_1 AS (
    SELECT DISTINCT first_name || ' ' || last_name AS "Actor Name"
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
 ),
bacall_2 AS (
    SELECT DISTINCT first_name || ' ' || last_name AS "Actor Name"
    FROM actor
    JOIN film_actor USING (actor_id)
    JOIN film USING (film_id)
    WHERE title IN (SELECT title FROM film WHERE film_id IN (SELECT film_id FROM bacall_1))
    AND actor_id NOT IN (
        SELECT actor_id
        FROM film_actor
        WHERE film_id IN (
            SELECT film_id
            FROM film_actor
            WHERE actor_id IN (
                SELECT actor_id
                FROM actor
                WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
           )
      )
  )

  AND first_name || ' ' || last_name <> 'RUSSELL BACALL'
)
SELECT "Actor Name" FROM bacall_2
ORDER BY "Actor Name";
