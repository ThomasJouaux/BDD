-- Active: 1664372619408@@127.0.0.1@3306@papyrus
SELECT numcom , fournis.numfou AS numero_fournisseur
FROM fournis 
JOIN entcom 
ON fournis.numfou  = entcom.numfou 
WHERE fournis.numfou = 09120;

SELECT  numcom , fournis.numfou AS numero_fournisseur 
FROM entcom
JOIN fournis
ON entcom.numfou = fournis.numfou;

SELECT count(entcom.numfou) AS fourni_concerné, count(fournis.numfou) AS commande_fournisseur_passee
FROM entcom
JOIN fournis
ON entcom.numfou = fournis.numfou;

SELECT codart , libart , stkale , stkphy , qteann
FROM produit WHERE qteann < 1000;

SELECT nomfou , posfou
FROM fournis WHERE 
posfou LIKE '78%' 
OR
posfou LIKE '75%'
OR
posfou LIKE '92%'
OR
posfou LIKE '77%';

SELECT * 
FROM entcom WHERE datcom like "%_4_%" 
OR
datcom LIKE "%_3_%";

SELECT numcom , datcom 
FROM entcom
WHERE datcom = CURRENT_DATE() AND obscom IS NOT NULL;

SELECT  numcom,(SUM(prix1) + SUM(prix2) + SUM(prix3) )AS total
FROM fournis 
JOIN entcom ON fournis.numfou = entcom.numfou
JOIN vente ON fournis.numfou = vente.numfou
JOIN produit ON produit.codart = vente.codart
GROUP BY numcom DESC;

SELECT numcom , SUM(priuni * QTECDE) FROM ligcom
GROUP BY NUMCOM;



SELECT   FROM entcom
JOIN fournis on fournis.numfou = entcom.numfou
join vente on vente.numfou = fournis.numfou;

SELECT NUMCOM, SUM(priuni * QTECDE) FROM ligcom
WHERE QTECDE < 1000 
GROUP BY NUMCOM
HAVING (SUM(priuni * QTECDE)) > 10000;

SELECT NOMFOU , NUMCOM , DATCOM
FROM fournis  
JOIN entcom ON fournis.NUMFOU = entcom.NUMFOU;

SELECT OBSCOM , entcom.NUMCOM , NOMFOU  , ligcom.CODART AS Libelle_article , SUM(QTECDE * PRIUNI) AS total
FROM fournis
JOIN entcom ON fournis.NUMFOU = entcom.NUMFOU
JOIN ligcom ON entcom.NUMCOM = ligcom.NUMCOM
WHERE OBSCOM LIKE "%_urgent_%"
GROUP BY NOMFOU;


SELECT delliv , COUNT(DELLIV) AS nombre_commande , NOMFOU 
FROM fournis
JOIN vente ON fournis.NUMFOU = vente.NUMFOU
GROUP BY NOMFOU
HAVING DELLIV > 1; 

SELECT delliv , COUNT(DELLIV) AS nombre_commande , vente.NUMFOU , NOMFOU
FROM vente
JOIN fournis ON fournis.NUMFOU = vente.NUMFOU
WHERE DELLIV > 1 
GROUP BY NUMFOU;

SELECT numcom , datcom 
FROM entcom 
WHERE NUMCOM = 70210;

SELECT numcom , datcom 
FROM entcom
GROUP BY NUMCOM 
HAVING NUMCOM = 70210; 


SELECT DISTINCT PRIX1 , LIBART
FROM produit
JOIN vente ON produit.CODART = vente.CODART         --Marche sur heidi mais pas vscode
WHERE prix1 < (
    SELECT MIN(prix1)
    FROM vente
    WHERE CODART LIKE "R%"
);

SELECT DISTINCT NOMFOU ,LIBART
FROM fournis
JOIN vente ON fournis.NUMFOU = vente.NUMFOU
JOIN produit ON vente.CODART = produit.CODART
WHERE STKPHY <= ( 
    SELECT SUM(STKALE)*150/100
    FROM produit
    WHERE NOMFOU < LIBART
);


SELECT DISTINCT NOMFOU ,LIBART
FROM fournis
JOIN vente ON fournis.NUMFOU = vente.NUMFOU
JOIN produit ON vente.CODART = produit.CODART
WHERE STKPHY <= ( 
    SELECT SUM(STKALE)*150/100
    FROM produit
    WHERE NOMFOU < LIBART AND DELLIV < 31
);

SELECT DISTINCT SUM(stkphy), nomfou 
FROM fournis
JOIN vente ON fournis.NUMFOU = vente.NUMFOU
JOIN produit ON vente.CODART = produit.CODART
GROUP BY NOMFOU
ORDER BY sum(STKPHY) DESC;

SELECT QTEANN , LIBART
FROM produit
JOIN vente ON  vente.CODART = produit.CODART
WHERE QTEANN > (
    SELECT SUM((QTE1 + QTE2 + QTE3)*0.9)
    FROM vente
);

SELECT (((prix1*qte1) + (prix2*qte2) + (prix3*qte3))*0.2) AS chiffre_affaire, nomfou , DATCOM
FROM vente 
JOIN fournis ON vente.NUMFOU = fournis.NUMFOU
JOIN entcom ON entcom.NUMFOU = fournis.NUMFOU
WHERE DATCOM LIKE '2007%'
GROUP BY NOMFOU;

-- Oui la derniere , aucune commande en 1993 

-- IV 

UPDATE vente
SET 
prix1 = prix1 * 1.02,
prix2 = prix2 * 1.04
WHERE NUMFOU = 9180;

UPDATE vente
SET 
prix2 = prix1 
WHERE prix2 IS NULL;  

UPDATE entcom
JOIN fournis ON entcom.NUMFOU = fournis.NUMFOU
SET 
OBSCOM = '**********'
WHERE SATISF < 5;
-- pas de satisf infereur a 5

-- Obligé de le faire en 2 requetes disctincte 
DELETE FROM vente
WHERE CODART = 'I110';

DELETE FROM produit 
WHERE CODART = 'I110';

DELETE FROM entcom 
WHERE OBSCOM IS NULL;

