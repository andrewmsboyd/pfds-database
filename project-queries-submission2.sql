-- Slide 1: From which of our customers did we make the most profit over the lifetime of the company?


SELECT
	customer_id,
	customer_name,
	SUM(amount) AS total_paid

	FROM

	(SELECT
			r.customer_id,
			CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
			r.rental_id,
			p.amount

			FROM rental r

				JOIN payment p ON
					p.rental_id = r.rental_id

				JOIN customer c ON
					c.customer_id = r.customer_id

					) sub


	GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 10





-- Slide 2: In our history, what percentage of our rented titles were rated NC-17?


WITH rentals AS (
	SELECT
		r.rental_id,
		f.film_id,
		f.rating,
		CASE WHEN f.rating = 'NC-17' THEN 1 ELSE 0 END AS adult_film_bool

	FROM rental r

		JOIN inventory inv ON
			inv.inventory_id = r.inventory_id

		JOIN film f ON
			f.film_id = inv.film_id
),

	compared AS (
	SELECT 
		COUNT(*) as total_rentals,
		SUM(adult_film_bool) AS adult_rentals

		FROM rentals
)

SELECT
	*,
	CAST(SUM(adult_rentals) / SUM(total_rentals) * 100 AS DECIMAL(5,2)) AS adult_film_rent_percentage
	
	FROM compared

	GROUP BY 2,1





-- Slide 3: What were the total sales for the business as of May 1st, 2007?

SELECT
	s.picture,
	DATE_TRUNC('day', payment_date) as payment_day,
	payment_id,
	SUM(amount) over (ORDER BY payment_date) as running

	FROM payment

		JOIN staff s ON
			s.staff_id = payment.staff_id

WHERE payment_date <= '2007-05-01'

ORDER BY running DESC


-- Slide 4: Do we have any films in inventory that are rated G Horror? What are we charging for these?


SELECT
	f.title,
	f.release_year,
	f.rating,
	f.rental_rate,
	c.name

	FROM film f

		JOIN film_category fc ON
				fc.film_id = f.film_id

		JOIN category c ON
				c.category_id = fc.category_id

	WHERE f.rating = 'G' AND c.name = 'Horror'

	ORDER BY f.rental_rate DESC

