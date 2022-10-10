-- Active: 1664372619408@@127.0.0.1@3306@hotel
CREATE TRIGGER insert_station AFTER INSERT ON station
    FOR EACH ROW
    BEGIN
        DECLARE altitude INT;
        SET altitude = NEW.sta_altitude;
        IF altitude<1000 THEN
            SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu. Règle de gestion altitude !';
        END IF;
END;

insert into station (sta_nom, sta_altitude) values ('station du bas', 666);

--modif_reservation : interdire la modification des réservations (on autorise l'ajout et la suppression).

CREATE TRIGGER block_modif_reservation BEFORE UPDATE ON reservation  
    FOR EACH ROW
    BEGIN
    IF OLD.res_date = NEW.res_date THEN
        SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu , vous ne pouvez pas modifier les reservations';
    END IF;
END;

UPDATE reservation
SET res_date = '2007-12-03';

DROP TRIGGER block_modif_reservation;


-- insert_reservation : interdire l'ajout de réservation pour les hôtels possédant déjà 10 réservations.
SELECT count(res_date) , hot_nom
                      FROM reservation
                      JOIN client ON reservation.res_cli_id=client.cli_id
                      JOIN chambre ON reservation.res_cha_id=chambre.cha_id
                      JOIN hotel ON hotel.hot_id = chambre.cha_hot_id
                      GROUP BY hot_nom , cli_nom;
CREATE TRIGGER insert_reservation BEFORE INSERT ON reservation
        FOR EACH ROW
        BEGIN
        DECLARE qt INT;
        SET qt = (SELECT count(res_date)
                      FROM reservation
                );
        IF qt > 10 THEN 
        SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu , il y a plus de 10 reservation pour cet hotel';
        END IF;
END;


INSERT INTO reservation(res_date , res_date_debut , res_date_fin , res_cli_id)
VALUES ('2000-12-03', '2000-01-04' , '2000-02-04', 4);

DROP TRIGGER insert_reservation;

-- insert_reservation2 : interdire les réservations si le client possède déjà 3 réservations.

SELECT cli_nom , count(res_date)
FROM reservation
JOIN client ON reservation.res_cli_id = client.cli_id
GROUP BY cli_nom;
CREATE TRIGGER insert_reservation2 BEFORE INSERT ON reservation
    FOR EACH ROW
    BEGIN
    DECLARE cap INT;
    SET cap = (SELECT count(res_date)
               FROM reservation
               JOIN client ON reservation.res_cli_id = client.cli_id
               GROUP BY cli_nom);
    IF cap > 3 THEN 
    SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu , il y a plus de 3 reservation pour ce client';
    END IF;
END;
INSERT INTO reservation (res_cha_id,res_cli_id,res_date , res_date_debut , res_date_fin)
VALUES (4,2,'2000-12-03', '2000-01-04' , '2000-02-04');

SELECT SUM(cha_capacite) , hot_nom
FROM hotel
JOIN chambre ON hotel.hot_id = chambre.cha_hot_id
GROUP BY hot_nom;

-- insert_chambre : lors d'une insertion, on calcule le total des capacités des chambres pour l'hôtel, si ce total est supérieur à 50, on interdit l'insertion de la chambre.
CREATE TRIGGER insert_chambre BEFORE INSERT ON chambre 
    FOR EACH ROW 
    BEGIN
    DECLARE chambre_capacity INT;
    SET chambre_capacity = (SELECT SUM(cha_capacite)
                            FROM hotel
                            JOIN chambre ON hotel.hot_id = chambre.cha_hot_id
                            );
    IF chambre_capacity > 50 THEN 
        SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu , le total de capacité de chambre est superieur a 50';
    END IF;
END;

INSERT INTO chambre(cha_hot_id ,cha_numero ,cha_capacite, cha_type)
VALUES (6 , 101 , 6 , 1);

DROP TRIGGER insert_chambre;


-- A REVOIR SA MERE YA DES ERREURS A LA CON CA MSAOUL KPVR, BKT,LB TPOLB


--------------------------------------------------------------------CAS PRATIQUE-------------------------------------------------------------------------------------

USE cp;

-- Mettez en place ce trigger, puis ajoutez un produit dans une commande, vérifiez que le champ total est bien mis à jour.

CREATE TRIGGER maj_total AFTER INSERT ON lignedecommande
    FOR EACH ROW
    BEGIN
        DECLARE id_c INT;
        DECLARE tot DOUBLE;
        SET id_c = NEW.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
        UPDATE commande SET total=tot WHERE id=id_c; -- on stocke le total dans la table commande
END;


SELECT * FROM produit;
INSERT INTO produit(designation , prix_achat , prix_vente)
VALUES ('basket' , 40 , 500);
INSERT INTO commande( id_client ,date_commande , remise)
VALUES (2 ,'2022-04-10' , 10);
INSERT INTO lignedecommande(id_commande , id_produit , quantite , prix)
VALUES(4 , 6 , 5 , 60);
SELECT * FROM commande;

--Ce trigger ne fonctionne que lorsque l'on ajoute des produits dans la commande, les modifications ou suppressions ne permettent pas de recalculer le total. 
--Modifiez le code ci-dessus pour faire en sorte que la modification ou la suppression de produit recalcul le total de la commande.
USE cp; 
CREATE TRIGGER maj_total_suppr AFTER DELETE ON lignedecommande
    FOR EACH ROW
        BEGIN
        DECLARE id_c INT;
        DECLARE tot DOUBLE;
        SET id_c = OLD.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
        UPDATE commande SET total=tot-total WHERE id=id_c; -- on stocke le total dans la table commande
END;
DELETE FROM lignedecommande
WHERE id_commande = 4;

SELECT * FROM commande;
DROP TRIGGER maj_total_suppr;

--Un champ remise était prévu dans la table commande. Prenez en compte ce champ dans le code de votre trigger.
USE cp;
CREATE TRIGGER maj_total_remise AFTER INSERT ON lignedecommande
    FOR EACH ROW
    BEGIN
        DECLARE id_c INT;
        DECLARE tot DOUBLE;
        DECLARE remise INT;
        SET id_c = NEW.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
        SET remise = (SELECT remise FROM lignedecommande WHERE id_commande = id_c); --On recupere la remise
        UPDATE commande SET total=tot-remise WHERE id=id_c; -- on stocke le total avec la remise dans la table commande
END;

SELECT * FROM produit;
INSERT INTO produit(designation , prix_achat , prix_vente)
VALUES ('basket' , 40 , 500);
INSERT INTO commande( id_client ,date_commande , remise)
VALUES (2 ,'2022-04-10' , 10);
INSERT INTO lignedecommande(id_commande , id_produit , quantite , prix)
VALUES(4 , 6 , 5 , 60);
SELECT * FROM commande;






















--------------------------------------------------- SCRIPT CREATION BASE CP ------------------------------------------------------------------------

DROP DATABASE cp;

CREATE DATABASE cp;

USE cp;

CREATE TABLE client (
	id 				INT AUTO_INCREMENT  NOT NULL,
	nom 			VARCHAR(30) NOT NULL,
	prenom 			VARCHAR(30) NOT NULL,
	adresse 		VARCHAR(30) NOT NULL,
	ville 			VARCHAR(30) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE produit (
	id 				INT AUTO_INCREMENT NOT NULL,
	designation 	VARCHAR(30),
	prix_achat 		DOUBLE NOT NULL,
	prix_vente 		DOUBLE NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE commande (
	id 				INT AUTO_INCREMENT NOT NULL,
	id_client 		INT ,
	date_commande 	DATETIME DEFAULT NOW(),
	remise 			INT NOT NULL,
	total			DOUBLE,
	PRIMARY KEY (id),
	FOREIGN KEY (id_client) REFERENCES client(id)
);

CREATE TABLE lignedecommande (
	id_commande 	INT,
	id_produit 		INT,
	quantite 		INT,
	prix		 	DOUBLE,
	FOREIGN KEY (id_commande) REFERENCES commande(id),
	FOREIGN KEY (id_produit) REFERENCES produit(id)
);


INSERT INTO client (id, nom, prenom, adresse, ville) VALUES (1, 'dupontel', 'bernard', 'rue du bas', 'flichcourt');
INSERT INTO client (id, nom, prenom, adresse, ville) VALUES (2, 'gates', 'bill', 'rue du haut', 'amiens');
INSERT INTO client (id, nom, prenom, adresse, ville) VALUES (3, 'apple', 'alfred', 'rue du milieu', 'abbeville');
INSERT INTO client (id, nom, prenom, adresse, ville) VALUES (4, 'bb', 'raoul', 'rue du bas', 'dreuil');
INSERT INTO client (id, nom, prenom, adresse, ville) VALUES (5, 'dupontel', 'jacques', 'rue du bas', 'paris');

INSERT INTO produit (id, designation, prix_achat, prix_vente) VALUES (1, 'Lot de 10', 34, 6700);
INSERT INTO produit (id, designation, prix_achat, prix_vente) VALUES (2, 'Lot de 40', 34, 6700);
INSERT INTO produit (id, designation, prix_achat, prix_vente) VALUES (3, 'Gazon', 364, 700);
INSERT INTO produit (id, designation, prix_achat, prix_vente) VALUES (4, 'Lot de 1', 34, 6700);
INSERT INTO produit (id, designation, prix_achat, prix_vente) VALUES (5, 'Lot de 0', 34, 6700);

INSERT INTO commande (id_client, date_commande, remise) VALUES (2, '2018-09-01', 50);
INSERT INTO commande (id_client, date_commande, remise) VALUES (1, '2018-09-01', 10);
INSERT INTO commande (id_client, date_commande, remise) VALUES (2, '2018-09-01', 10);


INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (2, 3, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (2, 2, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (2, 1, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (2, 5, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (2, 4, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (1, 3, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (1, 2, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (1, 1, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (3, 3, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (3, 2, 10, 2);
INSERT INTO lignedecommande (id_commande, id_produit, prix, quantite) VALUES (3, 2, 10, 2);

