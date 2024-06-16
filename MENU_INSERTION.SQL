--Menu d'insertions 
/*Description: Permet laffichage du sous-menu pour les insetions des tables clients et vetements
**  Auteur(s): Boris Kalev
** Date de creation: 13-04-2023 */
CLEAR SCREEN
PROMPT	                    MENU CHOIX INSERTION 
PROMPT 			1: Inserer clients 
PROMPT 			2: Inserer vetements 
PROMPT			3: Retour au menu

ACCEPT selection PROMPT "  Entrer option 1-3: " 
SET TERM OFF
COLUMN script NEW_VALUE v_script 
SELECT CASE '&selection ' 
WHEN '1' THEN 'CLIENTS.SQL'
WHEN '2' THEN 'VETEMENTS.SQL' 
WHEN '3' THEN 'MENU.SQL' 
ELSE 'MENU_INSERTION.SQL' 
END AS script 
FROM dual; 
SET TERM ON 
@C:\PLSQL-Gr810\ProjetFinal\&v_script
