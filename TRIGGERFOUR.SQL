-- TRIGGER sur la table bkclients pour faire une mise a jour en cascade

CREATE OR REPLACE TRIGGER tr_client_update
AFTER UPDATE ON habit.bkclients
FOR EACH ROW
BEGIN
  IF UPDATING('noclient') THEN
    UPDATE habit.bkvetements
    SET noclient = :new.noclient
    WHERE noclient = :old.noclient;
  END IF;
END;
/