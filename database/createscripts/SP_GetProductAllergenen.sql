USE laravel;

DROP PROCEDURE IF EXISTS sp_GetProductAllergenen;

DELIMITER $$

CREATE PROCEDURE sp_GetProductAllergenen(
    IN p_productId INT
)
BEGIN
    SELECT PROD.Naam AS ProductNaam
          ,PROD.Barcode
          ,ALGE.Naam
          ,ALGE.Omschrijving
    FROM Product AS PROD
    INNER JOIN ProductPerAllergeen AS PPAL
        ON PROD.Id = PPAL.ProductId
    INNER JOIN Allergeen AS ALGE
        ON PPAL.AllergeenId = ALGE.Id
    WHERE PROD.Id = p_productId
    ORDER BY ALGE.Naam ASC;
END$$

DELIMITER ;