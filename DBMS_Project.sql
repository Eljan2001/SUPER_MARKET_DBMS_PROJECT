DROP DATABASE IF EXISTS super_market;

CREATE DATABASE super_market;

use super_market;


CREATE TABLE CUSTOMER(
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(55),
    order_id INT,
    product_id INT,
    registered_region VARCHAR(55)
);


CREATE TABLE EMPLOYEE(
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(55),
    store_id INT,
    adress VARCHAR(55),
    Salary INT
);



CREATE TABLE PRODUCT(
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(55),
    price INT,
    store_id INT
);



CREATE TABLE ORDER_(
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_location VARCHAR(55)
);



CREATE TABLE PROMOTION(
    promo_code INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    promo_name VARCHAR(55)
);



CREATE TABLE PAYMENT(
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_amount INT,
    customer_id INT,
    payment_mode VARCHAR(55)
);

CREATE TABLE STORE(
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    store_name VARCHAR(55),
    store_address VARCHAR(55)
);

CREATE TABLE DELIVERY(
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    delivery_date VARCHAR(55),
    customer_id INT
);





-- SETTING FOREIGN KEYS FOR PROMOTION TABLE

ALTER TABLE PROMOTION 
ADD CONSTRAINT fk_product_id_prom
FOREIGN KEY(product_id) REFERENCES PRODUCT(product_id)
ON UPDATE CASCADE ON DELETE SET NULL;


-- SETTING FOREIGN KEYS FOR PAYMENT TABLE

ALTER TABLE PAYMENT
ADD CONSTRAINT fk_customer_id_pay
FOREIGN KEY(customer_id) REFERENCES CUSTOMER(customer_id)
ON UPDATE CASCADE ON DELETE SET NULL;


-- SETTING FOREIGN KEYS FOR DELIVERY TABLE

ALTER TABLE DELIVERY 
ADD CONSTRAINT fk_customer_id_deliv
FOREIGN KEY(customer_id) REFERENCES CUSTOMER(customer_id)
ON UPDATE CASCADE ON DELETE SET NULL;

-- SETTING FOREIGN KEYS FOR EMPLOYEE TABLE

ALTER TABLE EMPLOYEE
ADD CONSTRAINT fk_store_id
FOREIGN KEY(store_id) REFERENCES STORE(store_id)
ON UPDATE CASCADE ON DELETE SET NULL;

-- SETTING FOREIGN KEYS FOR CUSTOMER TABLE

ALTER TABLE CUSTOMER
ADD CONSTRAINT fk_order_id
FOREIGN KEY(order_id) REFERENCES ORDER_(order_id)
ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE CUSTOMER
ADD CONSTRAINT fk_product_id_cust
FOREIGN KEY(product_id) REFERENCES PRODUCT(product_id)
ON UPDATE CASCADE ON DELETE SET NULL;

-- SETTING FOREIGN KEYS FOR PRODUCT TABLE

ALTER TABLE PRODUCT
ADD CONSTRAINT fk_store_id_prod
FOREIGN KEY(store_id) REFERENCES STORE(store_id)
ON UPDATE CASCADE ON DELETE SET NULL;


-- DOING INSERTS

INSERT INTO ORDER_(order_location)
values
("Baku"),
("Sumqayit"),
("Fuzuli"),
("Qazakh"),
("Sabirabad"),
("Nakhchivan"),
("Baku"),
("Zaqatala"),
("Ganja"),
("Baku");

INSERT INTO STORE (store_name, store_address)
values
("Adidas","Nizami Street"),
("CHELEBI FURNITURE","28 May M/S"),
("Emporium Port Baku","28 May M/S"),
("Zara","Nizami Street"),
("Boon","Rasulzada Street"),
("Gallery 4 Kids","Sahil M/S"),
("Royal Oud","Rasul Rza Street"),
("Notebooks","Nizami Street"),
("The Entertainer","Fatali Khan Khoyski Street"),
("MaxTech","Samil Ezizbeyov Street");


INSERT INTO PRODUCT(product_name,price,store_id)
values
("Soccer Ball", 20,1),
("Furniture", 300,2),
("Christmas tree", 60,5),
("Wrist watch", 25,10),
("Perfume", 50,7),
("Laptop", 1700,10),
("Cloth", 170,4),
("Basket Ball", 23,1),
("Mask", 15,3),
("Toys", 40,6);

INSERT INTO CUSTOMER(customer_name,order_id,product_id, registered_region)
values
("Eljan Abbaszada",1,1, "Baku"),
("Aygun Aydinova",2,2, "Qazakh"),
("Nihad Elizade",3,3, "Ganja"),
("Eljan Abbaszada",4,4, "Baku"),
("Kanan Faridov",5,5, "Sumqait"),
("Mustafa Bagirov",6,6, "Nakchivan"),
("Yusif Agayev",7,7, "Sabirabad"),
("Nihad Elizade",8,8, "Ganja"),
("Xeyale Abbasova",9,9, "Fuzuli"),
("Eljan Abbaszada",10,10, "Baku");

INSERT INTO EMPLOYEE(employee_name,store_id,adress,Salary)
values
("Orkhan Agayev",1, "Ahmadli", 670),
("Emil Sukhurov",2, "Badamdar", 320),
("Farid Mammadov",3, "Bilacari", 600),
("Lamiya Mammadova",4, "Binaqadi", 600),
("Ilkin Alizade",5, "7th microregion", 350),
("Arzu Aliyeva",6, "3rd microregion", 490),
("Rufat Mammadov",7, "Badamdar", 810),
("Nijat Mammadov",8, "Hovsan", 280),
("Shabnam Bakshaliyeva",9, "Sabunchu", 700),
("Binnet Musayev",10, "Ahmadli", 630);




INSERT INTO PROMOTION(product_id, promo_name)
values
(1,"GREATPENALTY"),
(2,"DECORATEALL"),
(3,"SANTAARRIVAL"),
(4,"HANDCLOCK"),
(5,"GOODSMELL"),
(6,"HACKER"),
(7,"WEAR"),
(8,"SLAMDUNK"),
(9,"CONCEALMENT"),
(10,"PLAYWITHME");

INSERT INTO PAYMENT(payment_amount, customer_id,payment_mode)
values
(43,1,"Online"), 
(110,2,"Cash"), 
(225,3,"Cash"), 
(60,4,"Cash"), 
(1700,5,"Cash"),
(220,6,"Cash"), 
(1725,7,"Cash"),
(40,8,"Cash"),
(300,9,"Cash"), 
(1700,10,"Cash"); 


INSERT INTO DELIVERY(delivery_date, customer_id)
values
("29.10.2019",1),
("21.06.2021",2),
("12.12.2020",3),
("11.04.2021",4),
("30.08.2015",5),
("23.12.2020",6),
("02.10.2019",7),
("29.10.2019",8),
("27.05.2020",9),
("08.12.2017",10);


-- CREATE PROCEDURE TO FIND SAME CUSTOMERS 

DELIMITER //

CREATE PROCEDURE PROCEDURE1(
    IN SHOW_SAME_CUSTOMERS VARCHAR(55)
) 
BEGIN
    SELECT CUSTOMER.customer_name,PRODUCT.product_name FROM CUSTOMER,PRODUCT
    WHERE CUSTOMER.customer_name = SHOW_SAME_CUSTOMERS and CUSTOMER.product_id=PRODUCT.product_id;
END//

DELIMITER ;

CALL PROCEDURE1('ELJAN ABBASZADA');

-- CREATE PROCEDURE TO SHOW CUSTOMERS AND THE NUMBER OF PRODUCTS ORDERED BY THEM AND SUM OF PRICE

DELIMITER //

CREATE PROCEDURE PROCEDURE2(
) 
BEGIN
    SELECT CONCAT(CUSTOMER.customer_name,', ',COUNT(PRODUCT.product_id),', ',SUM(PRODUCT.price)) from CUSTOMER,PRODUCT
    where CUSTOMER.product_id = PRODUCT.product_id 
    group by CUSTOMER.customer_name;
END //

DELIMITER ;

CALL PROCEDURE2();

-- CREATE PROCEDURE TO FIND WHERE THE CUSTOMER ORDERED THE PRODUCT(ORDER_LOCATION)

DELIMITER //

CREATE PROCEDURE PROCEDURE3(
)
BEGIN
    SELECT GROUP_CONCAT(CUSTOMER.customer_name,', ',  ORDER_.order_location,', ',PRODUCT.product_name,'    ') from CUSTOMER,ORDER_,PRODUCT
    WHERE CUSTOMER.order_id = ORDER_.order_id and CUSTOMER.product_id = PRODUCT.product_id
    GROUP BY CUSTOMER.customer_name;
END //

DELIMITER ;

CALL PROCEDURE3();

-- CREATE FUNCTION TO FIND CHEAP OR EXPENSIVE PRODUCTS

DELIMITER //

CREATE FUNCTION FUNCTION1(
    price INT
)
RETURNS VARCHAR(55) DETERMINISTIC
BEGIN
    DECLARE PRICE_RATE VARCHAR(55);
    IF (price>=100) THEN
        SET PRICE_RATE="EXPENSIVE";
    ELSEIF price<100 THEN
        SET PRICE_RATE="CHEAP";
    END IF;
    RETURN PRICE_RATE;
END//

DELIMITER ;

select product_name,price,FUNCTION1(price) from PRODUCT;



-- SETTING TRIGGER TO PREVENT CHANGE OF NAME

DELIMITER //

CREATE TRIGGER TRIGGER1

BEFORE UPDATE ON CUSTOMER
FOR EACH ROW
BEGIN
    IF (OLD.customer_name!=NEW.customer_name) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot change customer_name';
    END IF;
END//

DELIMITER ;


UPDATE customer
SET customer_name = 'Another Name'
where product_id = 1;

-- CREATE TRIGGER TO STORE OLD PRODUCTS AFTER DELETE

CREATE TABLE STORE_PRODUCTS(
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(55),
    price INT,
    store_id INT,
    DELETE_DATE DATE
);

DELIMITER //

CREATE TRIGGER TRIGGER2 
AFTER DELETE ON PRODUCT
FOR EACH ROW
BEGIN
    INSERT INTO STORE_PRODUCTS(product_id,product_name,price,store_id,DELETE_DATE)
    values
    (OLD.product_id,OLD.product_name,OLD.price,OLD.store_id,NOW());
END //
DELIMITER ;

DELETE FROM PRODUCT
WHERE product_id=1;