-- Active: 1664372619408@@127.0.0.1@3306@papyrus
USE papyrus;
CREATE TABLE articles_a_commander (
    CODART CHAR(4),
    DATE_JOUR DATE,
    qte INT,
    FOREIGN KEY(CODART)REFERENCES produit(codart)
);

DROP TABLE articles_a_commander;

CREATE TRIGGER maj_article AFTER UPDATE ON produit
    FOR EACH ROW
    BEGIN 
     DECLARE id_article CHAR(4);
     DECLARE stock_Alerte INT;
     DECLARE stock_physique INT;
     SET id_article = OLD.codart;
     SET stock_Alerte = (SELECT stkale FROM produit WHERE codart = id_article);
     SET stock_physique = (SELECT stkphy FROM produit WHERE codart = id_article);
        IF stock_physique <= stock_Alerte THEN
            SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu , vous devez recommander des articles , votre stock physique est inferieur au stock d alerte ';
        ELSE 
            INSERT INTO articles_a_commander(qte) VALUES (NEW.stkphy - OLD.stkphy);
        END IF;
    END;


DROP TRIGGER maj_article;

UPDATE produit
SET  stkphy = 150 WHERE codart ='I100';