-- Active: 1664372619408@@127.0.0.1@3306@exemple
SELECT prenom , nodep
FROM employe
JOIN dept 
ON dept.nodept = employe.nodep;

SELECT dept.nom AS nom_dep , employe.nom AS nom_emp  , nodept , titre 
FROM employe
JOIN dept 
ON dept.nodept = employe.nodep
WHERE titre = 'secretaire' 
ORDER BY nodept ASC;

SELECT emp.prenom AS nom_emp, emp.salaire , patron.prenom, patron.salaire  
FROM employe AS emp
JOIN employe AS patron ON emp.nosup=patron.noemp
where emp.salaire>patron.salaire;





