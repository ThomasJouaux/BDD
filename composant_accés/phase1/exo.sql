-- Active: 1664372619408@@127.0.0.1@3306@exemple
SELECT * FROM employe;

SELECT * FROM dept;

SELECT nom , dateemb , nosup , nodep , salaire FROM employe;

SELECT nom AS "Nom de l'employé" FROM employe ;

SELECT titre FROM employe;

SELECT DISTINCT titre FROM employe;

SELECT nom , noemp , nodep FROM employe WHERE titre = 'secrétaire';

SELECT nom , nodep FROM employe WHERE nodep > 40;

SELECT nom , prenom FROM employe WHERE nom < prenom;

SELECT nom , salaire , nodep FROM employe WHERE (titre = 'Représentant') AND (nodep = 35) AND (salaire > 20000);

SELECT nom , salaire , titre FROM employe WHERE (titre = 'Représentant') OR (titre = 'Président');

SELECT nom , titre , nodep , salaire FROM employe WHERE (nodep = 34) AND (titre = 'Représentant') OR (titre = 'Secrétaire');

SELECT nom , salaire FROM employe WHERE salaire BETWEEN 20000 AND 30000;
