-- Active: 1664372619408@@127.0.0.1@3306@hotel
-------------------------------------------------------------LOT 1 : --------------------------------------------------------------------------------
SELECT hot_nom , hot_ville FROM hotel;

SELECT cli_nom , cli_prenom , cli_adresse FROM client WHERE cli_nom = "White";

SELECT sta_nom , sta_altitude FROM station WHERE sta_altitude < 1000;

SELECT cha_capacite cha_numero FROM chambre WHERE cha_capacite > 1;

SELECT cli_nom ,  cli_ville FROM client WHERE cli_ville != 'Londre';

SELECT hot_nom, hot_ville , hot_categorie FROM hotel WHERE hot_ville='Bretou' AND hot_categorie>3;

------------------------------------------------------------LOT 2 : ----------------------------------------------------------------------------------
SELECT sta_nom , hot_nom , hot_categorie , hot_ville 
FROM hotel
JOIN station
ON hotel.hot_id = station.sta_id;

SELECT hot_nom , hot_categorie , hot_ville , cha_numero , cha_capacite
FROM hotel 
JOIN chambre
ON hotel.hot_id = chambre.cha_id;

SELECT hot_nom , hot_categorie , hot_ville , cha_numero , cha_capacite
FROM hotel 
JOIN chambre
ON hotel.hot_id = chambre.cha_id
WHERE hot_ville = 'Bretou';

SELECT  cli_nom , res_date , hot_nom 
FROM hotel
JOIN chambre ON hotel.hot_id = chambre.cha_hot_id
JOIN reservation ON chambre.cha_id = reservation.res_cha_id
JOIN client ON reservation.res_id = client.cli_id;

SELECT sta_nom , hot_nom , cha_numero , cha_capacite
FROM station 
JOIN hotel ON station.sta_id = hotel.hot_sta_id
JOIN chambre ON hotel.hot_id = cha_hot_id
JOIN reservation ON chambre.cha_id = reservation.res_cha_id
JOIN client ON reservation.res_id = client.cli_id;

SELECT cli_nom , hot_nom , res_date_debut , (datediff(res_date_fin , res_date_debut)) AS duree_sejour
FROM hotel
JOIN chambre ON hotel.hot_id = chambre.cha_hot_id
JOIN reservation ON chambre.cha_id = reservation.res_cha_id
JOIN client ON reservation.res_id = client.cli_id;

----------------------------------------------------------- LOT 3 : -------------------------------------------------------------------
SELECT sta_nom , COUNT(*) AS nombre_hotel
FROM station
JOIN hotel ON station.sta_id = hotel.hot_sta_id 
GROUP BY sta_nom;




SELECT sta_nom , COUNT(*) AS nombre_chambre
FROM station
JOIN hotel ON station.sta_id = hotel.hot_sta_id 
JOIN chambre ON hotel.hot_id = chambre.cha_hot_id
GROUP BY sta_nom;

SELECT sta_nom , COUNT(*) AS nombre_chambre
FROM station
JOIN hotel ON station.sta_id = hotel.hot_sta_id 
JOIN chambre ON hotel.hot_id = chambre.cha_hot_id
WHERE cha_capacite >1
GROUP BY sta_nom;

SELECT hot_nom , cli_nom
FROM hotel
JOIN chambre ON hotel.hot_id = cha_hot_id
JOIN reservation ON chambre.cha_id = reservation.res_cha_id 
JOIN client ON reservation.res_cli_id = client.cli_id
WHERE cli_nom ="Squire";

SELECT sta_nom , AVG(datediff(res_date_fin, res_date_debut))
FROM station
JOIN hotel ON station.sta_id = hotel.hot_id
JOIN chambre ON hotel.hot_id = chambre.cha_id
JOIN reservation ON chambre.cha_id = reservation.res_id
GROUP BY sta_nom;
