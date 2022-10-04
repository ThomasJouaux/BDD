-- Active: 1664372619408@@127.0.0.1@3306@papyrus

#1
DELIMITER |
CREATE PROCEDURE Lst_fournis()
BEGIN 
  SELECT  numcom , fournis.numfou AS numero_fournisseur 
  FROM entcom
  JOIN fournis
  ON entcom.numfou = fournis.numfou;
END|
DELIMITER;
CALL Lst_fournis;

SHOW CREATE PROCEDURE `Lst_fournis`; 