DROP PROCEDURE IF EXISTS SP_CreateAllergeen;

DELIMITER $$

CREATE PROCEDURE SP_CreateAllergeen(
	IN p_name VARCHAR(50),
    IN p_description VARCHAR(255)
)

BEGIN
	INSERT INTO Allergeen (
		Naam,
        Omschrijving)
        VALUES (p_name, p_description);
        
        SELECT LAST_INSERT_ID() AS new_id;
        
END$$

DELIMITER ;