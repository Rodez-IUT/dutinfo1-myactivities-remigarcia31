CREATE OR REPLACE FUNCTION get_default_owner() RETURNS "user" AS $$
DECLARE
	defaultOwner "user"%ROWTYPE;
	defaultOwnerUsername varchar(500) := 'Default Owner';
BEGIN
	SELECT *
	INTO defaultOwner
	FROM "user"
	WHERE username = defaultOwnerUsername;
	
	IF FOUND THEN
		RETURN defaultOwner;
	ELSE
		INSERT INTO "user" (id, username)
		VALUES (1, 'Default Owner');
		SELECT *
		INTO defaultOwner
		FROM "user"
		WHERE username = defaultOwnerUsername;
		RETURN defaultOwner;
	END IF;
END;

$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION fix_activities_without_owner() RETURNS SETOF activity AS $$
DECLARE

	
BEGIN

	UPDATE activity
	SET owner_id = (SELECT id FROM "user" WHERE username = 'Default Owner')
	WHERE owner_id IS NULL;
	
	RETURN QUERY SELECT * FROM activity WHERE owner_id = (SELECT id FROM "user" WHERE username = 'Default Owner') ;
	RETURN;
END;
$$ LANGUAGE plpgsql;