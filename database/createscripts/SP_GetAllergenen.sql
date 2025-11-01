USE laravel;

DROP PROCEDURE IF EXISTS `SP_GetAllergenen`;

DELIMITER $$

CREATE PROCEDURE SP_GetAllergenen()
BEGIN 
    SELECT ALGE.Id
            ,ALGE.Naam
            ,ALGE.Omschrijving
        FROM ALLERGEEN AS ALGE;

END$$

DELIMITER ;