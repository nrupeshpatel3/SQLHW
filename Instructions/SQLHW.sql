##1a##
USE sakila;
SELECT first_name, last_name FROM actor;
SELECT * FROM actor;

##1b##
SELECT CONCAT(first_name, ' ', last_name) AS ActorName FROM actor;

##2a##
SELECT actor_id, first_name, last_name FROM actor WHERE first_name  = 'Joe';

##2b##
SELECT actor_id, first_name, last_name FROM actor WHERE first_name  LIKE  '%GEN%';

##2c##
SELECT actor_id, first_name, last_name FROM actor WHERE first_name  LIKE  '%LI%'  ORDER BY last_name;

##2d##
SELECT * FROM country WHERE country IN ('Afghanistan', 'Bangladesh','China');

##3a##
ALTER TABLE actor
ADD description BLOB;
SELECT * FROM actor;

##3b##
ALTER TABLE actor
DROP COLUMN description;
SELECT * FROM actor;

##4a##
SELECT DISTINCT(last_name), COUNT(last_name) FROM actor GROUP BY last_name;

##4b##
SELECT DISTINCT(last_name), COUNT(last_name) FROM actor GROUP BY last_name HAVING COUNT(last_name)>1;

##4c##
UPDATE actor
SET first_name='HARPO' WHERE actor_id=172;
SELECT * FROM actor WHERE actor_id=172;

##4d##
UPDATE actor
SET first_name='GROUCHO' WHERE actor_id=172;
SELECT * FROM actor WHERE actor_id=172;

##5a##
SHOW CREATE TABLE address;

##6a##
SELECT * FROM staff;
SELECT * FROM address;
SELECT staff.first_name, staff.last_name, address.address, address.district, address.city_id, address.postal_code 
FROM staff JOIN address 
WHERE address.address_id=staff.address_id;

##6b##
SELECT * FROM staff;
SELECT * FROM payment;
SELECT staff.first_name, staff.last_name, SUM(payment.amount) FROM staff JOIN payment 
WHERE staff.staff_id=payment.staff_id
AND payment.payment_date>'2005-08-01' AND payment.payment_date<'2005-08-31'
GROUP BY payment.staff_id;

##6c##
SELECT * FROM film;
SELECT * FROM film_actor;
SELECT film.title, film.film_id , COUNT(film_actor.actor_id) 
FROM film JOIN film_actor  ON film.film_id=film_actor.film_id GROUP BY film_actor.film_id;

##6d##
SELECT * FROM inventory;
SELECT * FROM film;
SELECT COUNT(inventory_id) FROM inventory WHERE film_id IN(SELECT film_id FROM film WHERE title ='Hunchback Impossible');

##6e##
SELECT * FROM customer;
SELECT * FROM payment;
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS TOTAL_AMOUNT_PAID FROM customer  
JOIN payment  ON customer.customer_id=payment.customer_id GROUP BY payment.customer_id 
ORDER BY customer.last_name;

##7a##
SELECT * FROM film WHERE title LIKE 'K%' or  title LIKE 'Q%';

##7b##
SELECT * FROM film WHERE title='Alone Trip';
SELECT first_name, last_name FROM actor WHERE actor_id IN 
(SELECT actor_id FROM film_actor WHERE film_id IN
(SELECT film_id FROM film WHERE title='Alone Trip'));

##7c##
SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;
SELECT customer.first_name, customer.last_name, customer.email , address.district, country.country
FROM customer 
INNER JOIN address  ON  customer.address_id =address.address_id 
INNER JOIN city  ON address.city_id=city.city_id 
INNER JOIN country  ON city.country_id = country.country_id 
WHERE country='Canada';

##7d##
SELECT * FROM film_category;
SELECT * FROM category;
SELECT * FROM film;

SELECT * FROM film WHERE film_id IN 
(SELECT film_id  FROM film_category WHERE category_id IN 
(SELECT category_id FROM category WHERE NAME='Family'));

##7e##
SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;
SELECT film.title ,COUNT(rental.inventory_id) AS Total_rental 
FROM film 
INNER JOIN inventory   ON  film.film_id=inventory.film_id
INNER JOIN  rental  ON inventory.inventory_id =rental.inventory_id 
GROUP BY inventory.film_id ORDER BY  COUNT(rental.inventory_id) DESC;

##7f##
SELECT * FROM store;
SELECT * FROM payment;
SELECT SUM(amount) , staff_id  AS Store_id FROM payment GROUP  BY staff_id;

##7g##
SELECT * FROM store;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;
SELECT store.store_id, city.city,country.country FROM store 
JOIN address  ON store.address_id=address.address_id 
JOIN city  ON address.city_id= city.city_id
JOIN country  ON city.country_id=country.country_id;

##7h##
SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM inventory;
SELECT * FROM rental;
SELECT * FROM payment;
SELECT category.name, SUM(payment.amount) AS Total_earnings FROM category 
JOIN film_category  ON category.category_id=film_category.category_id
JOIN inventory ON film_category.film_id=inventory.film_id
JOIN rental  ON inventory.inventory_id= rental.inventory_id 
JOIN payment  ON rental.rental_id =payment.rental_id 
GROUP BY film_category.category_id ORDER BY Total_earnings DESC
LIMIT 5;

##8a##
SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM inventory;
SELECT * FROM rental;
SELECT * FROM payment;

CREATE VIEW gross_revenue AS
SELECT category.name, SUM(payment.amount) AS Total_earnings FROM category  
JOIN film_category  ON category.category_id=film_category.category_id
JOIN inventory  ON film_category.film_id=inventory.film_id
JOIN rental  ON inventory.inventory_id= rental.inventory_id 
JOIN payment  ON rental.rental_id =payment.rental_id 
GROUP BY film_category.category_id ORDER BY Total_earnings DESC
LIMIT 5;

##8b##
SELECT * FROM gross_revenue;

##8c##
DROP VIEW gross_revenue;
SELECT * FROM gross_revenue;