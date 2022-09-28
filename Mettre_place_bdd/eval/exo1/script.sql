-- Active: 1664372619408@@127.0.0.1@3306@eval_bdd
DROP DATABASE IF EXISTS eval_bdd;

CREATE DATABASE eval_bdd;

USE eval_bdd;



CREATE TABLE Produit (
     pro_num INT PRIMARY KEY,
     pro_libelle VARCHAR(50),
     pro_description VARCHAR(50)
);

CREATE TABLE Client (
    cli_num INT PRIMARY KEY,
    cli_nom  VARCHAR(50),
    cli_adresse VARCHAR(50),
    cli_tel VARCHAR(30)
);
CREATE INDEX index_cli_nom ON Client(cli_nom);

CREATE TABLE Commande(
    com_num INT PRIMARY KEY,
    cli_num INT,
    com_date DATETIME,
    com_obs VARCHAR(50)
);

CREATE TABLE est_compose (
    com_num INT,
    pro_num INT, 
    est_qte INT,
    PRIMARY KEY(com_num , pro_num),
    FOREIGN KEY (com_num )REFERENCES Commande(com_num),
    FOREIGN KEY (pro_num) REFERENCES Produit(pro_num)
);