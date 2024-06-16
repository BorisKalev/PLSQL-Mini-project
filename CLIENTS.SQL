-- Insertion pour bkclients
/*Description: Permet linsertion dans la table clients
**  Auteur(s): Boris Kalev
** Date de creation: 13-04-2023
*/

SET SERVEROUTPUT ON
SET VERIFY OFF

ACCEPT noclient PROMPT "Entrer le numero du client: "
ACCEPT nomclient PROMPT "Entrer le nom du client: "
ACCEPT no PROMPT "Entrer le numéro de la rue: "
ACCEPT rue PROMPT "Entrer le nom de la rue: "
ACCEPT ville PROMPT "Entrer le nom de la ville: "
ACCEPT codepostal PROMPT "Entrer le code postal: "
ACCEPT telephone PROMPT "Entrer le numéro de téléphone: "

DECLARE
	var_noclient habit.bkclients.noclient%TYPE := ('&noclient');
	var_nomclient habit.bkclients.nomclient%TYPE := ('&nomclient');
	var_no habit.bkclients.no%TYPE := ('&no');
	var_rue habit.bkclients.rue%TYPE := ('&rue');
	var_ville habit.bkclients.ville%TYPE := ('&ville');
	var_codepostal habit.bkclients.codepostal%TYPE := ('&codepostal');
	var_telephone habit.bkclients.telephone%TYPE := ('&telephone');
	
BEGIN
	INSERT INTO habit.bkclients(noclient,nomclient,no,rue,ville,codepostal,telephone) 
	VALUES(var_noclient,var_nomclient,var_no,var_rue,var_ville,var_codepostal,var_telephone);
	COMMIT;
	
	-- Affichage des enregistrements avec un CURSOR FOR
	FOR liste IN (SELECT noclient, nomclient, no, rue, ville, codepostal, telephone FROM habit.bkclients) LOOP
		DBMS_OUTPUT.PUT_LINE(RPAD(liste.noclient,15)||RPAD(liste.nomclient,20)||RPAD(liste.no||' '||liste.rue,30)||RPAD(liste.ville||' '||liste.codepostal,20)||liste.telephone);
	END LOOP;
	
EXCEPTION
	WHEN dup_val_on_index THEN
		DBMS_OUTPUT.PUT_LINE('Cette cle primaire existe deja (Le noclient existe deja) !');
	WHEN others THEN
		DBMS_OUTPUT.PUT_LINE('Une erreur cest produite!');
END;
/

SET VERIFY ON

PAUSE "Appuyer sur une touche pour continuer ..."
@C:\PLSQL-Gr810\ProjetFinal\MENU.SQL