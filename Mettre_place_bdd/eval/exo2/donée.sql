drop database papyrus2;

CREATE DATABASE papyrus2;

use papyrus2;


CREATE table fournis(
	numfou varchar(25) primary key,
	nomfou varchar(25),
	ruefou varchar(50),
	posfou char(5),
	vilfou varchar(30),
	confou varchar(15),
	satisf tinyint(3)
);

CREATE table entcom(
	numcom int(10) primary key,
	obscom varchar(50),
	datcom date,
	numfou varchar(25) references fournis (numfou)
);


CREATE table produit(
	codart char(4) primary key,
	libart varchar(30),
	stkale int(10),
	stkphy int(10),
	qteann int(10),
	unimes char(5)
);

CREATE table ligcom(
	numlig tinyint(3) primary key,
	qtecde int(10),
	priuni decimal(9,2),
	qteliv int(10),
	derliv datetime,
	numcom int(10) references entcom (numcom),
	codart char(4) references produit (codart)
);

CREATE table vente(
	delliv smallint (5),
	qte1 int(10),
	prix1 decimal(9,2),
	qte2 int(10),
	prix2 decimal(9,2),
	qte3 int(10),
	prix3 decimal(9,2),
	numfou varchar(25) references fournis (numfou),
	codart char(4) references produit (codart)
);


INSERT into produit (codart, libart, stkale, stkphy, qteann, unimes) VALUES
	('I100', 'Papier 1 ex continu', 100, 557, 3500, 'B1000'),
	('I105', 'Papier 2 ex continu', 75, 5, 2300, 'B1000'),
	('I108', 'Papier 3 ex continu', 200, 557, 3500, 'B500'),
	('I110', 'Papier 4 ex continu', 10, 12, 63, 'B400'),
	('P220', 'Pré-imprimé commande', 500, 2500, 24500, 'B500'),
	('P230', 'Pré-imprimé facture', 500, 250, 12500, 'B500'),
	('P240', 'Pré-imprimé bulletin paie', 500, 3000, 6250, 'B500'),
	('P250', 'Pré-imprimé bon livraison', 500, 2500, 24500, 'B500'),
	('P270', 'Pré-imprimé bon fabrication', 500, 2500, 24500, 'B500'),
	('R080', 'ruban Epson 850', 10, 2, 120, 'unite'),
	('R132', 'ruban imp1200 lignes', 25, 200, 182, 'unite'),
	('B002', 'Bande magnétique 6250', 20, 12, 410, 'unite'),
	('B001', 'Bande magnétique 1200', 20, 87, 240, 'unite'),
	('D035', 'CD R slim 80 mm', 40, 42, 150, 'B010'),
	('D050', 'CD R-W 80mm', 50, 4, 0, 'B010');

INSERT into fournis (numfou, nomfou, ruefou, posfou, vilfou, confou, satisf) VALUES
	(120, 'GROBRIGAN', '20 rue du papier', '92200', 'Papercity', 'Georges', 8),
	(540, 'ECLIPSE', '53 rue laisse flotter les rubans', '78250', 'Bugbugville', 'Nestor', 7),
	(8700, 'MEDICIS', '120 rue des plantes', '75014', 'Paris', 'Lison', null),
	(9120, 'DISCOBOL', '11 rue des sports', '85100', 'La Roche sur Yon', 'Hercule', 8),
	(9150, 'DEPANPAP', '26 avenue des locomotives', '59987', 'Coroncountry', 'Pollux', 5),
	(9180, 'HURRYTAPE', '68 boulevard des octets', '78440', 'Dumpville', 'Track', null);

INSERT into entcom (numcom, obscom, datcom, numfou) values
	(70010, null, '2007/02/10', 00120),
	(70011, 'Commande urgente', '2007/03/01', 00540),
	(70020, null, '2007/04/25', 09180),
	(70025, 'Commande urgente', '2007/04/30',09150),
	(70210, 'Commande cadencée', '2007/05/05',00120),
	(70300, null, '2007/06/06',09120),
	(70250, 'Commande cadencée', '2007/10/02',08700),
	(70620,null, '2007/10/09', 00540),
	(70625, null, '2007/10/09', 00120),
	(70629, null, '2007/10/10', 09180);

	INSERT into vente (codart, numfou, delliv, qte1, prix1, qte2, prix2, qte3, prix3) VALUES
		('I100', 00120, 90, 0, 700, 50, 600, 120, 500),
		('I100', 00540, 70, 0, 710, 60, 630, 100, 600),
		('I100', 09120, 60, 0, 800, 70, 600, 90, 500),
		('I100', 09150, 90, 0, 650, 90, 600, 200, 590),
		('I100', 09180, 30, 0, 720, 50, 670, 100, 490),
		('I105', 00120, 90, 10, 705, 50, 630, 120, 500),
		('I105', 00540, 70, 0, 810, 60, 645, 100, 600),
		('I105', 09120, 60, 0, 920, 70, 800, 90, 700),
		('I105', 09150, 90, 0, 685, 90, 600, 200, 590),
		('I105', 08700, 30, 0, 720, 50, 670, 100, 510),
		('I108', 00120, 90, 5, 795, 30, 720, 100, 680),
		('I108', 09120, 60, 0, 920, 70, 820, 100, 780),
		('I110', 09180, 90, 0, 900, 70, 870, 90, 835),
		('I110', 09120, 60, 0, 950, 70, 850, 90, 790),
		('D035', 00120, 0, 0, 40, null, null, null, null),
		('D035', 09120, 5, 0, 40, 100, 30, null, null),
		('I105', 09120, 8, 0, 37, null, null, null, null),
		('P220', 0120, 15, 0, 3700, 100, 3500, null, null),
		('P230', 0120, 30, 0, 5200, 100, 5000, null, null),
		('P240', 00120, 15, 0, 2200, 100, 2000, null, null),
		('P250', 00120, 30, 0, 1500, 100, 1400, 500, 1200),
		('P250', 09120, 30, 0, 1500, 100, 1400, 500, 1200),
		('P220', 08700, 20, 50, 3500, 100, 3350, null, null),
		('P230', 08700, 60, 0, 5000, 50, 4900, null, null),
		('R080', 09120, 10, 0, 120, 100, 100, null, null),
		('R132', 09120, 5, 0, 275, null, null, null, null),
		('B001', 08700, 15, 0, 150, 50, 145, 100, 140),
		('B002', 08700, 15, 0, 210, 50, 200, 100, 185);
	
	
	INSERT into ligcom (numcom, numlig,codart, qtecde, priuni, qteliv, derliv) VALUES
		(70010, 1, 'I100', 3000, 470, 3000, '2007/03/15'),
		(70010, 2, 'I105', 2000, 485, 2000, '2007/07/05'),
		(70010, 3, 'I108', 1000, 680, 1000, '2007/08/20'),
		(70010, 4, 'D035', 200, 40, 250, '2007/02/20'),
		(70010, 5, 'P220', 6000, 3500, 6000, '2007/03/31'),
		(70010, 6, 'P240', 6000, 2000, 2000, '2007/03/31'),
		(70011, 7, 'I105', 1000, 600, 1000, '2007/05/16'),
		(70020, 8, 'B001', 200, 140, null, '2007/12/31'),
		(70020, 9, 'B002', 200, 140, null, '2007/12/31'),
		(70025, 10, 'I100', 1000, 590, 1000, '2007/05/15'),
		(70025, 11, 'I105', 500, 590, 500, '2007/05/15'),
		(70210, 12, 'I100', 1000, 470, 1000, '2007/07/15'),
		(70010, 13, 'P220', 10000, 3500, 10000, '2007/08/31'),
		(70300, 14, 'I100', 50, 790, 50, '2007/10/31'),
		(70250, 15, 'P230', 15000, 4900, 12000, '2007/12/15'),
		(70250, 16, 'P220', 10000, 3350, 10000, '2007/11/10'),
		(70620, 17, 'I105', 200, 600, 200, '2007/11/01'),
		(70625, 18, 'I100', 1000, 470, 1000, '2007/10/15'),
		(70625, 19, 'P220', 10000, 3500, 10000, '2007/10/31'),
		(70629, 20, 'B001', 200, 140, null, '2007/12/31'),
		(70629, 21, 'B002', 200, 140, null, '2007/12/31');
		