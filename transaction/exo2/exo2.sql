-- Active: 1664372619408@@127.0.0.1@3306@papyrus
-- Car la transaction n'etais pas encore envoyé 

START TRANSACTION;

SELECT nomfou FROM fournis WHERE numfou=120;

UPDATE fournis  SET nomfou= 'GROSBRIGAND' WHERE numfou=120;

SELECT nomfou FROM fournis WHERE numfou=120;

LOCK TABLE fournis READ;

UNLOCK TABLE;
SELECT nomfou FROM fournis WHERE numfou=120;


-- francois aled j'comprend rien 

