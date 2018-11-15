SELECT CONCAT(a.first_name, ' ', a.last_name) AS full_name,
	f.title,
	f.description,
	f.length

	FROM film f

	JOIN film_actor ON
		film_actor.film_id = f.film_id

	JOIN actor a ON
		a.actor_id = film_actor.actor_id