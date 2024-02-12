--PWB 
--Zadania do wyk�adu 10
--Student: Jakub Wo�niak
--Nr indeksu: pd4135
--Zadania:

--2. Zbuduj obiektowo-relacyjn� baz� zam�wie� (nie stosuj kluczy obcych tylko referencje razem z wi�zami SCOPE IS).
CREATE TYPE Product_type AS OBJECT 
    (product_number NUMBER(4),
    product_name VARCHAR(20)
    ); 

CREATE TYPE Customer_type AS OBJECT 
    (customer_number NUMBER(4),
    forname VARCHAR(50),
    surname VARCHAR(50),
    address VARCHAR(50)
    );

CREATE TYPE Order_type AS OBJECT 
    (order_number NUMBER(4),
    customer_ref REF Customer_type,
    product_ref REF Product_type
    );

CREATE TABLE Obj_Products OF Product_type;
CREATE TABLE Obj_Customers OF Customer_type;
CREATE TABLE Obj_Orders OF Order_type
(customer_ref SCOPE IS Obj_Customers, product_ref SCOPE IS Obj_Products);

--3. Napisz i wykonaj instrukcje INSERT wpisuj�ce przyk�adowe dane do bazy. 
--Wprowad� co najmniej 2 klient�w, co najmniej 5 towar�w i co najmniej 4 zam�wienia.
INSERT INTO Obj_Customers VALUES(123,'Mariusz','Lodowy', 'ul. Hokejowa 12/3 12-909 Bia�a G�ra');
INSERT INTO Obj_Customers VALUES(124,'Jagoda','�nie�nik', 'ul. Przy stoku 1a 11-330 L�dek Zdr�j');

INSERT INTO Obj_Products VALUES(70,'narty Atomic SLX 155');
INSERT INTO Obj_Products VALUES(60,'narty K2 Snowblade');
INSERT INTO Obj_Products VALUES(50,'narty Dynastar Green');
INSERT INTO Obj_Products VALUES(40,'�y�wy FigureX');
INSERT INTO Obj_Products VALUES(30,'�y�wy hockey Top');

INSERT INTO Obj_Orders (SELECT 1, REF(c), REF(p) FROM Obj_Customers c, Obj_Products p 
    WHERE c.customer_number = 123 AND p.product_number = 70);
INSERT INTO Obj_Orders (SELECT 2, REF(c), REF(p) FROM Obj_Customers c, Obj_Products p 
    WHERE c.customer_number = 123 AND p.product_number = 60);
INSERT INTO Obj_Orders (SELECT 3, REF(c), REF(p) FROM Obj_Customers c, Obj_Products p 
    WHERE c.customer_number = 124 AND p.product_number = 50);
INSERT INTO Obj_Orders (SELECT 4, REF(c), REF(p) FROM Obj_Customers c, Obj_Products p 
    WHERE c.customer_number = 124 AND p.product_number = 40);

--4. Napisz zapytanie kt�re wypisuje wszystkie zam�wienia z bazy.
SELECT o.order_number, o.customer_ref.customer_number, o.customer_ref.forname, o.customer_ref.surname, 
    o.product_ref.product_number, o.product_ref.product_name 
FROM Obj_Orders o;




