DROP DATABASE IF EXISTS gescom;
CREATE DATABASE gescom;
USE gescom;

CREATE TABLE suppliers(
    sup_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sup_name VARCHAR(50) NOT NULL,
    sup_city VARCHAR(50) NOT NULL,
    sup_adress VARCHAR(150) NOT NULL,
    sup_mail VARCHAR(75),
    sup_phone INT(10)
);

CREATE TABLE customers(
    cus_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cus_lastname VARCHAR(50) NOT NULL,
    cus_firstname VARCHAR(150) NOT NULL,
    cus_adress VARCHAR(50) NOT NULL,
    cus_zipcode VARCHAR(50) NOT NULL,
    cus_city VARCHAR(50) NOT NULL,
    cus_mail VARCHAR(75),
    cus_phone INT(10)
);

CREATE TABLE orders(
    ord_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ord_order_date DATE,
    ord_ship_date DATE,
    ord_bill_date DATE,
    ord_reception_date DATE NOT NULL,
    ord_status VARCHAR(25) NOT NULL,
    cus_id INT NOT NULL,
    FOREIGN KEY (cus_id) REFERENCES customers(cus_id)
);

CREATE TABLE categories(
    cat_id INT NOT NULL PRIMARY KEY,
    cat_name VARCHAR(200),
    cat_parent_id INT NOT NULL,
    FOREIGN KEY (cat_parent_id) REFERENCES categories(cat_id)
);

CREATE TABLE products(
    pro_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    pro_ref VARCHAR(10) NOT NULL,
    pro_name VARCHAR(200) NOT NULL,
    pro_desc TEXT(1000) NOT NULL,
    pro_price DECIMAL(6,2) NOT NULL,
    pro_stock SMALLINT(4) ,
    pro_color VARCHAR(30),
    pro_picture VARCHAR(40),
    pro_add_date DATE NOT NULL,
    pro_update_date DATETIME NOT NULL,
    pro_publish TINYINT(1) NOT NULL,
    cat_id INT NOT NULL ,
    FOREIGN KEY (cat_id) REFERENCES categories(cat_id),
    sup_id INT NOT NULL,
    FOREIGN KEY (sup_id) REFERENCES suppliers(sup_id)
);

CREATE TABLE details(
    det_id INT PRIMARY KEY,
    det_price DECIMAL(6,2),
    det_quantity INT(5) NOT NULL,
    pro_id INT NOT NULL, 
    ord_id INT NOT NULL, 
    FOREIGN KEY (pro_id) REFERENCES products(pro_id),
    FOREIGN KEY (ord_id) REFERENCES orders(ord_id)
);
SELECT det_quantity FROM details LIMIT 100;
CREATE INDEX testindex ON products(pro_ref);
