-- Active: 1664372619408@@127.0.0.1@3306@hotel


#1
CREATE VIEW liste_hotel
AS 
SELECT hot_nom , sta_nom
FROM hotel
JOIN station ON station.sta_id = hotel.hot_sta_id;

SELECT * FROM liste_hotel;

#2
CREATE VIEW liste_chambre
AS 
SELECT cha_numero , hot_nom
FROM chambre
JOIN hotel ON chambre.cha_hot_id = hotel.hot_id;

SELECT * FROM liste_chambre;

#3
CREATE VIEW liste_reservation 
AS
SELECT cli_nom , res_date_debut
FROM reservation
JOIN client ON reservation.res_cli_id = client.cli_id; 

SELECT * FROM liste_reservation;

#4
CREATE VIEW liste_chambre_nomsta
AS   
SELECT DISTINCT hot_nom , sta_nom
FROM chambre
JOIN hotel ON chambre.cha_hot_id = hotel.hot_id
JOIN station ON hotel.hot_sta_id = station.sta_id;

SELECT * FROM liste_chambre_nomsta;

#5
CREATE VIEW reservation_nom_cli 
AS
SELECT cli_nom , hot_nom
FROM client 
JOIN reservation ON client.cli_id = reservation.res_cli_id
JOIN chambre ON reservation.res_id = chambre.cha_hot_id
JOIN hotel ON  hotel.hot_id = chambre.cha_hot_id
GROUP BY hot_nom;

SELECT * FROM reservation_nom_cli;