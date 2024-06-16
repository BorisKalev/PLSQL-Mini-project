-- TAXEPACKAGE
 /*
** Description: Permet de cree des function qui me retourne le prix dun vetements avant et apres taxe pour ensuite les utiliser dans les autre scripts
**  Auteur(s): Boris Kalev
** Date de creation: 15-04-2023
** Date de modification: 17-04-2023 */
 
 CREATE OR REPLACE PACKAGE habit.TAXEPACKAGE AS
  FUNCTION COUTVENTE(p_noclient IN NUMBER, p_code IN habit.bkvetements.code%TYPE, p_quantite IN NUMBER) 
  RETURN NUMBER;
  
  FUNCTION TAXE(p_code IN habit.bkvetements.code%TYPE, p_quantite IN NUMBER, p_noclient IN habit.bkclients.noclient%TYPE)
  RETURN NUMBER;

END TAXEPACKAGE;
/


CREATE OR REPLACE PACKAGE BODY habit.TAXEPACKAGE AS
  FUNCTION COUTVENTE(p_noclient IN NUMBER, p_code IN habit.bkvetements.code%TYPE, p_quantite IN NUMBER)
    RETURN NUMBER IS
    v_prix habit.bkvetements.prix%TYPE;
    v_prix_total NUMBER;
  BEGIN
    -- récupérer le prix unitaire du vêtement
    SELECT prix INTO v_prix FROM habit.bkvetements WHERE code = p_code;
    v_prix_total := v_prix * p_quantite;
    RETURN v_prix_total;
  END COUTVENTE;
  
  FUNCTION TAXE(p_code IN habit.bkvetements.code%TYPE, p_quantite IN NUMBER, p_noclient IN habit.bkclients.noclient%TYPE)
  RETURN NUMBER IS
    v_prixvet NUMBER;
    v_taxe NUMBER := 0.15; -- définir la taxe à 15%
  BEGIN
    v_prixvet := COUTVENTE(p_noclient, p_code, p_quantite);
    RETURN v_prixvet * v_taxe;
  END TAXE;
  

  
END TAXEPACKAGE;
/

PAUSE "Appuyer sur une touche pour continuer ..."
@C:\PLSQL-Gr810\ProjetFinal\MENU.SQL