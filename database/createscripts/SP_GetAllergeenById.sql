DROP PROCEDURE IF EXISTS Sp_GetAllergeenById;

DELIMITER $$

CREATE PROCEDURE Sp_GetAllergeenById(
    IN p_id INT
)
BEGIN

    SELECT ALGE.Id
          ,ALGE.Naam
          ,ALGE.Omschrijving
    FROM  Allergeen AS ALGE
    WHERE ALGE.Id = p_id;


END$$

DELIMITER ;