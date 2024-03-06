/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

SELECT customer_id, first_name, last_name FROM (
    SELECT c.customer_id, c.first_name, c.last_name, category.name AS category, r.rental_date
    FROM customer c
    LEFT JOIN LATERAL (
      SELECT rental_id, rental_date, inventory_id
      FROM rental
      WHERE customer_id = c.customer_id
      ORDER BY rental_date DESC
      LIMIT 5
    ) r ON true
JOIN inventory USING (inventory_id)
JOIN film USING (film_id)
JOIN film_category USING (film_id)
JOIN category USING (category_id)
) AS titles
GROUP BY first_name, last_name, customer_id
HAVING SUM(CASE WHEN category = 'Action' THEN 1 ELSE 0 END) >= 4
ORDER BY customer_id;
