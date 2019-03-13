CREATE OR REPLACE FUNCTION find_all_activities_for_owner(nom_personne VARCHAR(500)) RETURNS SETOF activity AS $$
	SELECT activity.*
	FROM activity 
	JOIN "user"
	ON owner_id = "user".id
	WHERE username=nom_personne
$$ LANGUAGE SQL;