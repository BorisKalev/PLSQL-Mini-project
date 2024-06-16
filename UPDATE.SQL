--Permet de faire la update

SET VERIFY OFF;
ACCEPT noclient_old PROMPT "Entrer l'ancien numero du client : ";
ACCEPT noclient_new PROMPT "Entrer le nouveau numero du client : ";

DECLARE
  v_noclient_old habit.bkclients.noclient%TYPE := '&noclient_old';
  v_noclient_new habit.bkclients.noclient%TYPE := '&noclient_new';
  v_count NUMBER;

BEGIN
  SELECT COUNT(*)
  INTO v_count
  FROM habit.bkclients
  WHERE noclient = v_noclient_old;

  IF v_count = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Le numero du client n''existe pas');
  END IF;

  UPDATE habit.bkclients
  SET noclient = v_noclient_new
  WHERE noclient = v_noclient_old;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Le numero du client a ete mis a jour.');
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Une erreur est survenue : ' || SQLERRM);
END;
/
SET VERIFY ON;

PAUSE "Appuyer sur une touche pour continuer ..."
@C:\PLSQL-Gr810\ProjetFinal\MENU.SQL