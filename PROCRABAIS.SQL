-- PROCRABAIS

/*Description: Permet de mettre un rabais a un clients selon le prix de tous ces vetements combine ensemble
**  Auteur(s): Boris Kalev
** Date de creation: 15-04-2023
** Date de modification: 19-04-2023 */

SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT noclient PROMPT "Entrer le numero du client: ";

DECLARE
  v_noclient habit.bkclients.noclient%TYPE := ('&noclient'); -- entrée de l'utilisateur
  v_prixunitaire NUMBER;
  v_quantite NUMBER;
  v_total NUMBER;
  v_prixvet NUMBER;
  v_noprod habit.bkvetements.code%TYPE;
  v_taxes NUMBER;
  
  CURSOR v_curseur IS
    SELECT code, prix, quantitestock
    FROM habit.bkvetements
    WHERE noclient = v_noclient;
BEGIN
	
  OPEN v_curseur;
  LOOP
    FETCH v_curseur INTO v_noprod, v_prixunitaire, v_quantite;
    EXIT WHEN v_curseur%NOTFOUND;
    v_prixvet := habit.TAXEPACKAGE.COUTVENTE(v_noclient, v_noprod, v_quantite);
	v_taxes := habit.TAXEPACKAGE.TAXE(v_noprod, v_quantite, v_noclient);
	v_total := v_prixvet + v_taxes;
  END LOOP;
   SELECT SUM(habit.TAXEPACKAGE.COUTVENTE(habit.bkvetements.noclient, habit.bkvetements.code, habit.bkvetements.quantitestock) *1.15) INTO v_total FROM habit.bkvetements WHERE noclient = v_noclient;
  
   DBMS_OUTPUT.PUT_LINE('AVANT le rabais le prix est de : '||v_total || '$');
  IF v_total <= 1000 THEN
    v_total := v_total * 0.95;
    DBMS_OUTPUT.PUT_LINE('Apres le rabais le prix est de : '||v_total || '$');
  ELSIF v_total > 1000 and v_total <= 5000 THEN
    v_total := v_total * 0.90;
    DBMS_OUTPUT.PUT_LINE('Apres le rabais le prix est de : '||v_total || '$');
  ELSE 
    v_total := v_total * 0.85;	
    DBMS_OUTPUT.PUT_LINE('Apres le rabais le prix est de : '||v_total || '$');
  END IF;
  
  -- Mettre à jour les prix des vêtements pour le client donné
UPDATE habit.bkvetements
SET prix = prix *
CASE
WHEN v_total <= 1000 THEN 0.95
WHEN v_total > 1000 and v_total <= 5000 THEN 0.90
ELSE 0.85
END
WHERE noclient = v_noclient;
  
  -- Fermer le curseur
  CLOSE v_curseur;
END;
/

SET VERIFY ON;

PAUSE "Appuyer sur une touche pour continuer ..."
@C:\PLSQL-Gr810\ProjetFinal\MENU.SQL