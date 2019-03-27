CREATE OR REPLACE FUNCTION action_log() RETURNS TRIGGER AS $$
DECLARE
	idN bigint;
BEGIN
	idN := OLD.id;

	INSERT INTO action_log(id, action_name, entity_name, entity_id, author)
	VALUES (nextval('id_generator'), lower(TG_OP), TG_RELNAME, idN, current_user);
	RETURN NULL;
END;	

$$ LANGUAGE plpgsql;

CREATE TRIGGER action_log
    AFTER DELETE ON activity
    FOR EACH ROW EXECUTE PROCEDURE action_log();
