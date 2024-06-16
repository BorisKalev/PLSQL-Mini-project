-- Listes bkvetements
/*Description: Permet laffichage de la table vetements
**  Auteur(s): Boris Kalev
** Date de creation: 15-04-2023 */


SET SERVEROUTPUT ON
SET VERIFY OFF

BEGIN
  affiche_package.afficher_vetements;
END;
/

SET VERIFY ON


PAUSE "Appuyer sur une touche pour continuer ..."
@C:\PLSQL-Gr810\ProjetFinal\MENU.SQL