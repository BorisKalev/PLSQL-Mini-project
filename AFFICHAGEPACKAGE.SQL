-- Package d'affichage 
--Description de la PROCEDURE:
/*Description: Permet la creation des procedures qui afficherons par la suite tous les donnees de la table respectives.
**  Auteur(s): Boris Kalev
** Date de creation: 15-04-2023
*/

CREATE OR REPLACE PACKAGE affiche_package AS
  PROCEDURE afficher_vetements;
  PROCEDURE afficher_clients;
END affiche_package;
/

CREATE OR REPLACE PACKAGE BODY affiche_package AS
  PROCEDURE afficher_vetements IS
  BEGIN
    FOR liste IN (SELECT code, nom, quantitestock, prix, noclient FROM habit.bkvetements) LOOP
      DBMS_OUTPUT.PUT_LINE(RPAD(liste.code, 15) || RPAD(liste.nom, 20) || RPAD(liste.quantitestock || ' unité(s)', 15) || RPAD(liste.prix || '$', 15) || liste.noclient);
    END LOOP;
  END afficher_vetements;
  
  PROCEDURE afficher_clients IS
  BEGIN
    FOR liste IN (SELECT noclient, nomclient, no, rue, ville, codepostal, telephone FROM habit.bkclients) LOOP
      DBMS_OUTPUT.PUT_LINE(RPAD(liste.noclient, 15) || RPAD(liste.nomclient, 20) || RPAD(liste.no || ' ' || liste.rue, 30) || RPAD(liste.ville, 20) || RPAD(liste.codepostal, 20)|| RPAD(liste.telephone, 20));
    END LOOP;
  END afficher_clients;
END affiche_package;
/

PAUSE "Appuyer sur une touche pour continuer ..."
@C:\PLSQL-Gr810\ProjetFinal\MENU.SQL