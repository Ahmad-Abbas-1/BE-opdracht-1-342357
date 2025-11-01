DELIMITER $$

DROP PROCEDURE IF EXISTS sp_DeleteAllergeen$$

CREATE PROCEDURE sp_DeleteAllergeen(
    IN p_id int
)
BEGIN
    -- Verwijder het record in de tabel allergeen
    DELETE FROM Allergeen 
    WHERE Id = p_id;

    -- Bepaal hoeveel rijen verwijdert zijn (0 of 1)
    SELECT ROW_COUNT() AS affected;

END$$

DELIMITER ;