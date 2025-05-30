use sakila;

SELECT 
  c.name AS category,
  COUNT(fc.film_id) AS num_films
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY num_films DESC;

-- Retrieve the store ID, city, and country for each store.
SELECT 
  s.store_id,
  ci.city,
  co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;


-- Calculate the total revenue generated by each store in dollars.
SELECT 
  s.store_id,
  ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment p
JOIN staff s ON p.staff_id = s.staff_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;




-- Determine the average running time of films for each category.
SELECT 
  c.name AS category,
AVG(f.length) AS avg_running_time
FROM film f
JOIN category c ON fc.category_id = c.category_id
JOIN film_category fc ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY avg_running_time DESC;







-- Bonus:

-- Identify the film categories with the longest average running time.
SELECT 
  c.name AS category,
  ROUND(AVG(f.length), 2) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;


-- Display the top 10 most frequently rented movies in descending order.
SELECT 
  f.title,
  COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 1;


SELECT 
  f.title, 
  i.store_id
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' 
  AND i.store_id = 1;


-- Provide a list of all distinct film titles, along with their availability status in the inventory.
-- Include a column indicating whether each title is 'Available' or 'NOT available.' Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."
SELECT 
  f.title,
  CASE 
    WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
    ELSE 'NOT available'
  END AS availability
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title;


