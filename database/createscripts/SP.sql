USE laravel;

-- ========================================
-- Drop existing procedures if they exist
-- ========================================
DROP PROCEDURE IF EXISTS SP_GetAllergenen;
DROP PROCEDURE IF EXISTS sp_DeleteAllergeen;
DROP PROCEDURE IF EXISTS SP_CreateAllergeen;
DROP PROCEDURE IF EXISTS sp_UpdateAllergeen;
DROP PROCEDURE IF EXISTS Sp_GetAllergeenById;

DELIMITER $$

-- ========================================
-- Get all allergenen
-- ========================================
CREATE PROCEDURE SP_GetAllergenen()
BEGIN 
    SELECT 
        ALGE.Id,
        ALGE.Naam,
        ALGE.Omschrijving
    FROM Allergeen AS ALGE;
END$$

-- ========================================
-- Delete allergeen by ID
-- ========================================
CREATE PROCEDURE sp_DeleteAllergeen(
    IN p_id INT
)
BEGIN
    DELETE FROM Allergeen 
    WHERE Id = p_id;

    -- Return affected rows (0 or 1)
    SELECT ROW_COUNT() AS affected;
END$$

-- ========================================
-- Create new allergeen
-- ========================================
CREATE PROCEDURE SP_CreateAllergeen(
    IN p_name VARCHAR(50),
    IN p_description VARCHAR(255)
)
BEGIN
    INSERT INTO Allergeen (
        Naam,
        Omschrijving
    ) VALUES (
        p_name, 
        p_description
    );
    
    -- Return new inserted id
    SELECT LAST_INSERT_ID() AS new_id;
END$$

-- ========================================
-- Update allergeen by ID
-- ========================================
CREATE PROCEDURE sp_UpdateAllergeen(
    IN p_id INT,
    IN p_naam VARCHAR(50),
    IN p_omschrijving VARCHAR(255)
)
BEGIN
    UPDATE Allergeen
    SET 
        Naam = p_naam,
        Omschrijving = p_omschrijving,
        DatumGewijzigd = SYSDATE(6)
    WHERE Id = p_id;

    SELECT ROW_COUNT() AS affected;
END$$

-- ========================================
-- Get allergeen by ID
-- ========================================
CREATE PROCEDURE Sp_GetAllergeenById(
    IN p_id INT
)
BEGIN
    SELECT 
        ALGE.Id,
        ALGE.Naam,
        ALGE.Omschrijving
    FROM Allergeen AS ALGE
    WHERE ALGE.Id = p_id;
END$$

DELIMITER ;
