-- Active: 1664372619408@@127.0.0.1@3306@papyrus
#1
CREATE VIEW v_GlobalCde
AS 
SELECT ligcom.codart , SUM(prix1 + prix2 + prix3) AS PrixTot, SUM(qte1+qte2+qte3) AS QteTot
FROM ligcom 
JOIN produit ON ligcom.CODART = produit.CODART
JOIN vente ON vente.CODART = produit.CODART
GROUP BY CODART;

SELECT * FROM `v_GlobalCde`;

#2
CREATE VIEW v_VentesI100
AS
SELECT * 
FROM vente 
WHERE CODART = 'I100'; 

SELECT * FROM v_VentesI100;

#3
CREATE VIEW v_VentesI100Grobrigan
AS
SELECT *
FROM vente 
WHERE CODART = 'I100' AND NUMFOU = 00120;

SELECT * FROM v_VentesI100Grobrigan;
