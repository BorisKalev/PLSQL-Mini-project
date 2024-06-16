-- Insertion pour bkvetements

/*Description: Permet linsertion dans la table vetements
**  Auteur(s): Boris Kalev
** Date de creation: 13-04-2023
*/


SET SERVEROUTPUT ON
SET VERIFY OFF

ACCEPT code PROMPT "Entrer le code du vetements: "
ACCEPT nom PROMPT "Entrer le nom du vetements: "
ACCEPT quantitestock PROMPT "Entre le nombre de quantite en stock : "
ACCEPT prix PROMPT "Entrer le prix : "
ACCEPT noclient PROMPT "Entrer le numero du client : "

DECLARE
	err_integrite EXCEPTION;
	PRAGMA EXCEPTION_INIT(err_integrite, -2291);

	var_code habit.bkvetements.code%TYPE:=upper('&code');
	var_nom habit.bkvetements.nom%TYPE:=upper('&nom');
	var_quantitestock NUMBER := ('&quantitestock');
	var_prix NUMBER := '&prix';
	var_noclient habit.bkvetements.noclient%TYPE := '&noclient';
	
	BEGIN
	INSERT INTO habit.bkvetements(code,nom,quantitestock,prix,noclient) VALUES(var_code,var_nom,var_quantitestock,var_prix,var_noclient);
	COMMIT;
	--Affichage des enregistrements avec un CURSOR FOR
	FOR liste IN(select code,nom,quantitestock,prix,noclient from habit.bkvetements) LOOP
		DBMS_OUTPUT.PUT_LINE(RPAD(liste.code,15)||RPAD(liste.nom,20)||liste.quantitestock||' unite(s) '||RPAD(liste.prix||'$',15)||liste.noclient);
	END LOOP;
EXCEPTION
	WHEN dup_val_on_index THEN
		DBMS_OUTPUT.PUT_LINE('Cette cle primaire existe deja (Le code existe deja) !');
	WHEN err_integrite THEN
		DBMS_OUTPUT.PUT_LINE('Erreur dintegrite referentielle');
	WHEN others THEN
	    DBMS_OUTPUT.PUT_LINE('une erreur cest produite!');
END;
/

SET VERIFY ON
	
	


PAUSE "Appuyer sur une touche pour continuer ..."
@C:\PLSQL-Gr810\ProjetFinal\MENU.SQL