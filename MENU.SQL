-- Le menu principal
/*Description: Permet laffichage du menu principal
**  Auteur(s): Boris Kalev
** Date de creation: 13-04-2023
** Date de modification: 17-04-2023 */
   
set linesize 300;

CLEAR SCREEN
PROMPT	                      MENU PRINCIPAL 
PROMPT 			1: Menu Insertion 
PROMPT 			2: Menu Affichage Enregistrements
PROMPT			3: Facture
PROMPT			4: Rabais
PROMPT			5: Menu Mise A Jour et Suppresion
PROMPT			6: Quitter
ACCEPT selection PROMPT "  Entrer option 1-6: " 
SET TERM OFF
COLUMN script NEW_VALUE v_script 
SELECT CASE '&selection ' 
WHEN '1' THEN 'MENU_INSERTION.SQL'
WHEN '2' THEN 'MENU_AFFICHAGE.SQL' 
WHEN '3' THEN 'FACTURE.SQL' 
WHEN '4' THEN 'PROCRABAIS.SQL' 
WHEN '5' THEN 'MENU_MISEAJOUR_SUPPRESSION.SQL' 
WHEN '6' THEN 'QUITTER.SQL' 
ELSE 'MENU.SQL' 
END AS script 
FROM dual; 
SET TERM ON 
@C:\PLSQL-Gr810\ProjetFinal\&v_script