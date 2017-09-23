-- 1a.
SELECT first_name, last_name
FROM actor;

-- 1b.
SELECT UPPER(CONCAT(first_name, ' ', last_name))
AS "ACTOR NAME"
FROM actor;

-- 2a.
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'JOE';

-- 2b.
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name iLIKE '%GEN%';

-- 2c.
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name iLIKE '%LI%'
ORDER BY last_name, first_name;

-- 2d.
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a.
ALTER TABLE actor ADD COLUMN middle_name VARCHAR(25);

-- 3b.
ALTER TABLE actor ALTER COLUMN middle_name TYPE text;

-- 3c.
ALTER TABLE actor DROP COLUMN middle_name;

-- 4a.
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name;

-- 4b.
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

-- 4c.
UPDATE actor
SET first_name = 'HARPO', last_name = 'WILLIAMS'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

-- 4d.
UPDATE actor
SET first_name = (
CASE
WHEN first_name iLike 'HARPO' AND last_name = 'WILLIAMS'
THEN 'GROUCHO'
WHEN first_name iLike 'GROUCHO' AND last_name = 'WILLIAMS'
THEN 'MUCHO GROUCHO'
ELSE first_name
END);

-- 6a.
SELECT s.first_name, s.last_name, a.address
FROM staff s
JOIN address a
ON s.address_id = a.address_id;

-- 6b.
SELECT s.first_name, s.last_name, SUM(p.amount)
FROM staff s
JOIN payment p
ON s.staff_id = p.staff_id
GROUP BY s.first_name, s.last_name, p.staff_id;

-- 6c.
SELECT f.title, COUNT(fa.actor_id) AS Num_of_Actor
FROM film f
INNER JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY f.title, fa.film_id;

-- 6d.
SELECT f.title, COUNT(i.film_id) AS Num_of_Hunchback
FROM film f
RIGHT JOIN inventory i
ON f.film_id = i.film_id
WHERE f.title iLIKE 'Hunchback Impossible'
GROUP BY f.title, i.film_id;

-- 6e.
SELECT c.first_name, c.last_name, SUM(p.amount)
FROM customer c
RIGHT JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name, p.customer_id
ORDER BY c.last_name;

-- 7a.
SELECT f.title
FROM film f
JOIN language l
ON f.language_id = l.language_id
WHERE f.title iLIKE 'K%' AND l.language_id = 1 
OR f.title iLIKE 'Q%' AND l.language_id = 1;

-- 7b.
SELECT AT.first_name, AT.last_name
FROM
(SELECT f.title, a.first_name, a.last_name
FROM film f
RIGHT JOIN film_actor fa
ON f.film_id = fa.film_id
JOIN actor a
ON fa.actor_id = a.actor_id) AT
WHERE AT.title iLIKE 'Alone Trip';

-- 7c.
SELECT cu.first_name, cu.last_name, cu.email
FROM customer cu
JOIN address a
ON cu.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id
JOIN country co
ON co.country_id = c.country_id
WHERE co.country iLIKE 'Canada';

-- 7d.
SELECT f.title
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
WHERE c.name iLIKE 'Family';

-- 7e.
SELECT f.title, COUNT(r.rental_id)
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY COUNT(r.rental_id) DESC;

-- 7f.
SELECT s.store_id, SUM(p.amount)
FROM payment p
JOIN staff stf
ON p.staff_id = stf.staff_id
JOIN store s
ON s.store_id = stf.store_id
GROUP BY s.store_id;

-- 7g.
SELECT s.store_id, c.city, co.country
FROM staff s
JOIN address a
ON s.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id
JOIN country co
ON co.country_id = c.country_id;

-- 7h.
SELECT c.name, SUM(p.amount)
FROM payment p
JOIN rental r
ON p.rental_id = r.rental_id
JOIN inventory i 
ON r.inventory_id = i.inventory_id
JOIN film_category fc
ON fc.film_id = i.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.name, c.category_id
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 8a.
CREATE OR REPLACE VIEW top_5_gross_genre AS
SELECT c.name, SUM(p.amount)
FROM payment p
JOIN rental r
ON p.rental_id = r.rental_id
JOIN inventory i 
ON r.inventory_id = i.inventory_id
JOIN film_category fc
ON fc.film_id = i.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.name, c.category_id
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 8b.
SELECT *
FROM top_5_gross_genre;

-- 8c.
DROP VIEW top_5_gross_genre;