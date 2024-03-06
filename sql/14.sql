/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

WITH ranked_films AS (
    SELECT 
        c.category_id, c.name AS name,
        f.film_id, f.title,
        COUNT(*) AS "total rentals",
        RANK() OVER (PARTITION BY name ORDER BY COUNT(*) DESC, title DESC) AS rental_rank
    FROM category c
    JOIN film_category fc USING (category_id)
    JOIN film f USING (film_id)
    JOIN inventory i USING(film_id)
    JOIN rental r USING (inventory_id)
    GROUP BY c.category_id, c.name, f.film_id, f.title
)
SELECT name, title, "total rentals" FROM ranked_films
WHERE rental_rank <= 5
ORDER BY name, "total rentals" DESC, title;
