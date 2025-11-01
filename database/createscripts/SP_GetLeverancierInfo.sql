use Laravel;

DROP PROCEDURE IF EXISTS sp_GetLeverancierInfo;

DELIMITER $$

CREATE PROCEDURE sp_GetLeverancierInfo(
    IN p_productId INT
)
BEGIN

    SELECT PROD.Naam
          ,PPLE.DatumLevering
          ,PPLE.Aantal
          ,PPLE.DatumEerstVolgendeLevering
          ,MAGA.AantalAanwezig

    FROM Product AS PROD

    INNER JOIN ProductPerLeverancier AS PPLE
    ON PPLE.ProductId = PROD.Id

    INNER JOIN Magazijn AS MAGA
    ON MAGA.ProductId = PROD.Id

    WHERE PROD.Id = p_productId;



END$$

DELIMITER ;