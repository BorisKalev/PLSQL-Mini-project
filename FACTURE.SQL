-- La facture
/*Description: Permet dafficher la facture du clients avec tous les vetements correspondont au meme noclient
** Description (suite): utiliser un curseur comme boucle pour pouvoir bien enregistrer tous les vetements que le clients a acheter
** Description (suite): pour ensuite sauvegarder le prix de ces vetements dans des variables, pour a la fin lafficher comme necaissaire
**  Auteur(s): Boris Kalev
** Date de creation: 15-04-2023
** Date de modification: 18-04-2023 */
SET SERVEROUTPUT ON;
SET VERIFY OFF

ACCEPT noclient PROMPT "Entrer le numero du client: "

DECLARE
  v_noclient habit.bkclients.noclient%TYPE := ('&noclient'); -- entrée de l'utilisateur
  v_nomclient habit.bkclients.nomclient%TYPE;
  v_adresseclient VARCHAR2(100);
  v_curseur SYS_REFCURSOR;
  v_noprod habit.bkvetements.code%TYPE;
  v_prixunitaire NUMBER;
  v_quantite NUMBER;
  v_prixvet NUMBER;
  v_taxes NUMBER;
  v_total NUMBER;
  v_taxes_total NUMBER :=0;
  v_total_avant_taxe NUMBER;
  
BEGIN
  -- Vérifier si le numéro de CLIENT existe
  SELECT nomclient, no || ' ' || rue || ', ' || ville INTO v_nomclient, v_adresseclient FROM habit.bkclients WHERE noclient = v_noclient;
  IF v_nomclient IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('Le numéro de CLIENT est invalide.');
    RETURN;
  END IF;
  
  DBMS_OUTPUT.PUT_LINE('FACTURE');
  DBMS_OUTPUT.PUT_LINE('-------');
  DBMS_OUTPUT.PUT_LINE('Numero du client : ' || v_noclient);
  DBMS_OUTPUT.PUT_LINE('Nom du client : ' || v_nomclient);
  DBMS_OUTPUT.PUT_LINE('Adresse du client : ' || v_adresseclient);
  DBMS_OUTPUT.PUT_LINE('Noprod' || LPAD('Prix', 10) || LPAD('Quantite', 10) || LPAD('Sous-total', 15));
  DBMS_OUTPUT.PUT_LINE('-----' || LPAD('----', 10) || LPAD('--------', 10) || LPAD('---------', 15));

  -- Ouvrir un curseur pour récupérer les détails de la facture
  OPEN v_curseur FOR
    SELECT code, prix, quantitestock
    FROM habit.bkvetements
    WHERE noclient = v_noclient;
  
  -- Parcourir les résultats du curseur et afficher les détails de la facture
  
	LOOP
	
      FETCH v_curseur INTO v_noprod, v_prixunitaire, v_quantite;
      EXIT WHEN v_curseur%NOTFOUND;
      v_prixvet := habit.TAXEPACKAGE.COUTVENTE(v_noclient, v_noprod, v_quantite);
      v_taxes := habit.TAXEPACKAGE.TAXE(v_noprod, v_quantite, v_noclient);
      v_total := v_prixvet + v_taxes;
	  v_taxes_total := v_taxes_total + v_taxes; -- Pour me permettre d'enregistrer le total des taxes et lafficher par la suite
         
	  DBMS_OUTPUT.PUT_LINE(v_noprod || LPAD(v_prixunitaire || '$', 10) || LPAD(v_quantite, 10) || LPAD(v_prixvet || '$', 15));
    
  END LOOP;
		 
  -- Fermer le curseur
  CLOSE v_curseur;
  
		  
  
  SELECT SUM(habit.TAXEPACKAGE.COUTVENTE(habit.bkvetements.noclient, habit.bkvetements.code, habit.bkvetements.quantitestock) * 1.15) INTO v_total FROM habit.bkvetements WHERE noclient = v_noclient;
	      v_total_avant_taxe := v_total - v_taxes_total; --Permet de trouver le total avant TAXE
		  DBMS_OUTPUT.PUT_LINE('Total :' || LPAD('', 15) || v_total_avant_taxe || '$');
		  DBMS_OUTPUT.PUT_LINE('Taxes (15%) :' || LPAD('', 15) || v_taxes_total || '$');
  
  DBMS_OUTPUT.PUT_LINE('----------------------------------------');
  DBMS_OUTPUT.PUT_LINE('GRAND TOTAL : ' || v_total || '$');
END;
/
SET VERIFY ON
	
	
PAUSE "Appuyer sur une touche pour continuer ..."
@C:\PLSQL-Gr810\ProjetFinal\MENU.SQL