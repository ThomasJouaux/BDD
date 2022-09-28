CREATE DATABASE DROP IF EXISTS personne_app_grp ;

USE personne_app_grp;

CREATE TABLE Personne(
   per_num INT AUTO_INCREMENT,
   per_nom VARCHAR(50) ,
   per_prenom VARCHAR(50) ,
   per_adress VARCHAR(50) ,
   per_ville VARCHAR(50) ,
   PRIMARY KEY(per_num)
);

CREATE TABLE groupe(
   gro_num INT AUTO_INCREMENT,
   gro_libelle VARCHAR(50) ,
   per_num INT,
   PRIMARY KEY(gro_num),
   UNIQUE(per_num),
   FOREIGN KEY(per_num) REFERENCES Personne(per_num)
);

