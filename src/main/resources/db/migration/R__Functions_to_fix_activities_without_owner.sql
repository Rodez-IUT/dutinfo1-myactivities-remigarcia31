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