-- Trigger pour supprimer des bkvetements et les enregistrer dans la table de vetements supprimer


CREATE OR REPLACE TRIGGER trigger_bkvetements
BEFORE DELETE ON habit.bkclients
FOR EACH ROW
DECLARE
  v_code_bkvetements habit.bkvetements.code%TYPE;
BEGIN
  -- Stocker les bkvetements a supprimer dans une table temporaire
  INSERT INTO habit.bkvetementsupprimes (code, noclient, prix, quantitestock)
  SELECT code, noclient, prix, quantitestock
  FROM habit.bkvetements
  WHERE noclient = :OLD.noclient;

  -- Supprimer les bkvetements du client
  DELETE FROM habit.bkvetements WHERE noclient = :OLD.noclient;
  
  -- Afficher un message si le client a ete supprimer
  DBMS_OUTPUT.PUT_LINE('Les vetements du client ' || :OLD.noclient || ' ont ete supprimes.');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Erreur: le client ' || :OLD.noclient || ' n existe pas.');
END;
/









