-- Active: 1664372619408@@127.0.0.1@3306@papyrus
DELIMITER | 
CREATE PROCEDURE CA_Fournisseur(IN NUMFOU_ARG VARCHAR(25) , IN datcom_ARG DATE) 
BEGIN
SELECT
    (((prix1 * qte1) + (prix2 * qte2) + (prix3 * qte3)) * 0.2) AS chiffre_affaire,
    nomfou,
    DATCOM
FROM
    vente
    JOIN fournis ON vente.NUMFOU = fournis.NUMFOU
    JOIN entcom ON entcom.NUMFOU = fournis.NUMFOU
WHERE entcom.NUMFOU = NUMFOU_ARG AND datcom = datcom_ARG;

END ;
DELIMITER ;


CALL CA_Fournisseur('120', '2007-05-10');

DROP PROCEDURE CA_Fournisseur;