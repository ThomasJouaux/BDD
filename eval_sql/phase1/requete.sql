-- Active: 1664372619408@@127.0.0.1@3306@northwind
--1 - Liste des contacts français :
SELECT
    *
FROM
    customers
WHERE
    country = 'France';

--2 - Produits vendus par le fournisseur « Exotic Liquids » :
SELECT
    ProductName AS produit,
    UnitPrice AS Prix
FROM
    suppliers s
    JOIN products p ON s.SupplierID = p.SupplierID
WHERE
    CompanyName = 'Exotic Liquids';

--3 - Nombre de produits vendus par les fournisseurs Français dans l’ordre décroissant :
SELECT
    CompanyName AS Fournisseur,
    count(ProductName)
FROM
    suppliers s
    JOIN products p ON s.SupplierID = p.SupplierID
WHERE
    Country = 'France'
GROUP BY
    CompanyName
ORDER BY
    count(ProductName) DESC;

--4 Liste des clients Français ayant plus de 10 commandes :
SELECT
    CompanyName AS client,
    COUNT(orders.CustomerID) AS `Nbre commandes`
FROM
    customers
    JOIN orders ON customers.CustomerID = orders.CustomerID
WHERE
    customers.Country = 'France'
GROUP BY
    CompanyName
HAVING
    COUNT(orders.CustomerID) > 10;

-- 5 - Liste des clients ayant un chiffre d’affaires > 30.000 :
SELECT
    CompanyName AS client,
    sum(od.UnitPrice * Quantity) as CA,
    customers.Country
FROM
    customers
    JOIN orders ON customers.CustomerID = orders.CustomerID
    JOIN `order details` od ON orders.OrderID = od.OrderID
GROUP BY
    CompanyName
HAVING
    sum(od.UnitPrice * Quantity) > 30000;

--6 – Liste des pays dont les clients ont passé commande de produits fournis par « Exotic Liquids » :
SELECT
    customers.country
FROM
    customers
    JOIN orders ON customers.CustomerID = orders.CustomerID
    JOIN `order details` od ON orders.OrderID = od.OrderID
    JOIN products ON products.ProductID = od.ProductID
    JOIN suppliers ON products.SupplierID = suppliers.SupplierID
WHERE
    suppliers.CompanyName = 'Exotic Liquids'
GROUP BY
    customers.country;

--7 – Montant des ventes de 1997 :
SELECT
    sum(od.quantity * od.unitprice) AS 'Montant vente 97'
FROM
    `order details` od
    JOIN orders ON od.OrderID = orders.OrderID
WHERE
    OrderDate like '1997%';

--8 – Montant des ventes de 1997 mois par mois :
SELECT
    sum(od.quantity * od.unitprice) AS 'Montant vente 97'
FROM
    `order details` od
    JOIN orders ON od.OrderID = orders.OrderID
WHERE
    OrderDate like '1997%'
GROUP BY
    MONTH(OrderDate);

-- 9 – Depuis quelle date le client « Du monde entier » n’a plus commandé ?
SELECT
    max(OrderDate) AS 'derniere commande'
FROM
    `order details` od
    JOIN orders ON od.OrderID = orders.OrderID
    JOIN customers ON orders.CustomerID = customers.CustomerID
WHERE
    CompanyName = 'Du monde entier';

--10 – Quel est le délai moyen de livraison en jours ?
SELECT
    round(AVG(datediff(ShippedDate, orderdate))) AS 'Délai moyen de livraison en jours'
FROM
    orders;

-------------------------------------------- PHASE 2------------------------------------------------------------------------------------
--Codez deux procédures stockées correspondant aux requêtes 9 et 10. Les procédures stockées doivent prendre en compte les éventuels paramètres.
--9 
CREATE PROCEDURE Last_commande(IN CompanyName_arg VARCHAR(50)) BEGIN
SELECT
    max(OrderDate) AS 'derniere commande'
FROM
    `order details` od
    JOIN orders ON od.OrderID = orders.OrderID
    JOIN customers ON orders.CustomerID = customers.CustomerID
WHERE
    CompanyName = CompanyName_arg;

END;

CALL Last_commande('Du monde entier');

DROP PROCEDURE `Last_commande`;

--10
CREATE PROCEDURE moyenne_livraison(IN Diff_date_arg VARCHAR(50)) BEGIN
SELECT
    round(AVG(datediff(ShippedDate, orderdate))) AS 'Délai moyen de livraison en jours'
FROM
    orders;

END;

CALL moyenne_livraison('');

------------------------------------------------------------------PHASE 3-------------------------------------------------------------------------------------
CREATE TRIGGER livraison_pays_identique
AFTER
INSERT
    ON `order details` FOR EACH ROW BEGIN DECLARE pays VARCHAR(15);

SET
    pays = (
        SELECT
            suppliers.SupplierID
        FROM
            orders
            JOIN customers ON orders.CustomerID = customers.CustomerID
            JOIN orderdetails ON orders.OrderID = orderdetails.OrderID
            JOIN products ON orderdetails.ProductID = products.ProductID
            JOIN suppliers ON products.SupplierID = suppliers.SupplierID
        WHERE
            suppliers.Country = customers.Country
            AND `order details`.ProductID = NEW.ProductID
            AND `order details`.OrderID = NEW.OrderID
    );

if suppliers.Country != customers.Country THEN SIGNAL SQLSTATE '40000'
SET
    MESSAGE_TEXT = 'Le pays n est pas similaire !';

END if;

END;

DROP TRIGGER livraison_pays_identique;


