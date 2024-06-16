-- MENU de Suppresion/ Mise a jour

/*Description: Permet de update la table (noclient). Et permet aussi de delete un client
**  Auteur(s): Boris Kalev
** Date de creation: 13-04-2023 */

CLEAR SCREEN
PROMPT	                    MENU CHOIX INSERTION 
PROMPT 			1: Mettre A Jour la clients
PROMPT 			2: Suppresion 
PROMPT			3: Retour au menu

ACCEPT selection PROMPT "  Entrer option 1-3: " 
SET TERM OFF
COLUMN script NEW_VALUE v_script 
SELECT CASE '&selection ' 
WHEN '1' THEN 'UPDATE.SQL'
WHEN '2' THEN 'DELETE.SQL' 
WHEN '3' THEN 'MENU.SQL' 
ELSE 'MENU_INSERTION.SQL' 
END AS script 
FROM dual; 
SET TERM ON 
@C:\PLSQL-Gr810\ProjetFinal\&v_script