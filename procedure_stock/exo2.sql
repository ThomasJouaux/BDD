-- Active: 1664372619408@@127.0.0.1@3306@papyrus
DELIMITER | 
CREATE PROCEDURE Lst_Commandes(IN obscom_arg varchar(50))
BEGIN 
    SELECT OBSCOM , entcom.NUMCOM , NOMFOU  , ligcom.CODART AS Libelle_article , SUM(QTECDE * PRIUNI) AS total
    FROM fournis
    JOIN entcom ON fournis.NUMFOU = entcom.NUMFOU
    JOIN ligcom ON entcom.NUMCOM = ligcom.NUMCOM
    WHERE obscom = obscom_arg;
END |
DELIMITER;

CALL Lst_Commandes('Commande cadencée');

DROP PROCEDURE `Lst_Commandes`;
