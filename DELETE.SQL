--DELETE.SQL

SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT noclient PROMPT "Entrer le numero du client a supprimer: ";

DECLARE
  v_noclient habit.bkclients.noclient%TYPE := '&noclient';
BEGIN
  DELETE FROM habit.bkclients WHERE noclient = v_noclient;
  
  DBMS_OUTPUT.PUT_LINE('Le client ' || v_noclient || ' a ete supprime.');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Erreur: le client ' || v_noclient || ' n existe pas.');
END;
/

SET VERIFY ON;

PAUSE "Appuyer sur une touche pour continuer ..."
@C:\PLSQL-Gr810\ProjetFinal\MENU.SQL