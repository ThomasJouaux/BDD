-- Active: 1664372619408@@127.0.0.1@3306@papyrus
START TRANSACTION;

SELECT nomfou FROM fournis WHERE numfou=120;

UPDATE fournis  SET nomfou= 'GROSBRIGAND' WHERE numfou=120;

SELECT nomfou FROM fournis WHERE numfou=120;


ROLLBACK;

SELECT numfou , nomfou FROM fournis WHERE numfou =120;

--La transaction n'est pas terminer , pour la terminer il faut utiliser CALL suivis d'un argument 

-- en verouillant la table

-- en utilisant 'Rollback' 

