use laravel;

DROP PROCEDURE IF EXISTS sp_GetProducts;

DELIMITER $$

CREATE PROCEDURE sp_GetProducts()
BEGIN
	
    SELECT PROD.Id
		  ,PROD.Naam
          ,PROD.Barcode
          ,MAGA.VerpakkingsEenheid
          ,MAGA.AantalAanwezig
          
	FROM Product AS PROD
    
    INNER JOIN Magazijn AS MAGA
    
    ON PROD.Id = MAGA.ProductId
    ORDER BY PROD.Barcode ASC;


END$$

DELIMITER ;