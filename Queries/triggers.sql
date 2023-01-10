

DELIMITER $$
  CREATE TRIGGER securityLevelProccessor 
    BEFORE INSERT ON Hall FOR EACH ROW
        BEGIN
            DECLARE value_of_security_level INT;
            SET value_of_security_level = NEW.wall_material * 10 + NEW.number_of_cameras * 5 + (SELECT COUNT(safebox_id) FROM SafeBox WHERE NEW.floor = hall_floor);

            IF value_of_security_level < 50 THEN SET NEW.security_level = 1;
            ELSEIF value_of_security_level < 100 THEN SET NEW.security_level = 2;
            ELSEIF value_of_security_level < 150 THEN SET NEW.security_level = 3;
            ELSEIF value_of_security_level < 200 THEN SET NEW.security_level = 4;
            ELSEIF value_of_security_level < 250 THEN SET NEW.security_level = 5;
            ELSEIF value_of_security_level < 300 THEN SET NEW.security_level = 6;
            ELSEIF value_of_security_level < 350 THEN SET NEW.security_level = 7;
            ELSEIF value_of_security_level < 400 THEN SET NEW.security_level = 8;
            ELSEIF value_of_security_level < 450 THEN SET NEW.security_level = 9;
            ELSEIF value_of_security_level < 500 THEN SET NEW.security_level = 10;
            ELSE SET NEW.security_level = 11;
            END IF;
        END; $$    
DELIMITER ;



DELIMITER $$
  CREATE TRIGGER contractExpiration  
    AFTER INSERT ON Expiration
    FOR EACH ROW
    BEGIN
         DELETE FROM Contract
         WHERE Contract.safebox_id = (SELECT safebox_id FROM Expiration WHERE safebox_id = Contract.safebox_id) 
         AND Contract.time = (SELECT start_time FROM Expiration WHERE start_time = Contract.time)
         AND Contract.customer_national_id in (SELECT Expiration.customer_national_id FROM Expiration WHERE Expiration.customer_national_id = Contract.customer_national_id);
    END $$
DELIMITER ;

