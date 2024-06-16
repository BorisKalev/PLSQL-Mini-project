-- Sous-menu pour l'affichage des donnees des tables
/*Description: Permet laffichage du sous-menu pour laffichage des tables clients et vetements
**  Auteur(s): Boris Kalev
** Date de creation: 13-04-2023 */

CLEAR SCREEN
PROMPT	                    MENU CHOIX INSERTION 
PROMPT  		1: Creation du package_affichage 
PROMPT 			2: Afficher clients 
PROMPT 			3: Afficher vetements 
PROMPT			4: Retour au menu

ACCEPT selection PROMPT "  Entrer option 1-4: " 
SET TERM OFF
COLUMN script NEW_VALUE v_script 
SELECT CASE '&selection ' 
WHEN '1' THEN 'AFFICHAGEPACKAGE.SQL'
WHEN '2' THEN 'LISTECLIENT.SQL'
WHEN '3' THEN 'LISTEVETEMENT.SQL' 
WHEN '4' THEN 'MENU.SQL' 
ELSE 'MENU_AFFICHAGE.SQL' 
END AS script 
FROM dual; 
SET TERM ON 
@C:\PLSQL-Gr810\ProjetFinal\&v_script