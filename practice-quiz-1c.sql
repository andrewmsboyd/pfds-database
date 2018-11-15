SELECT  full_name,
	COUNT(actor_id) AS appeared_in

	FROM

(SELECT CONCAT(a.first_name, ' ', a.last_name) AS full_name,
	a.actor_id,
	f.title,
	f.description,
	f.length

	FROM film f

	JOIN film_actor ON
		film_actor.film_id = f.film_id

	JOIN actor a ON
		a.actor_id = film_actor.actor_id

		) sub

	

	GROUP BY actor_id, full_name

ORDER BY appeared_in DESC