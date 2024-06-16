--Cree la table bkvetements supprime

--FACULTATIF DEJA CREE DANS APEX
CREATE TABLE bkvetementssupprimes (
  code NUMBER(10) PRIMARY KEY,
  noclient NUMBER(10),
  prix NUMBER(10,2),
  quantitestock NUMBER(10)
);

ALTER TABLE bkvetements
ADD CONSTRAINT fk_bkvetements_bkvetementsupprimes
FOREIGN KEY (code, noclient)
REFERENCES bkvetementssupprimes(code, noclient);