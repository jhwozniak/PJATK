--PWB 
--Zadania do wyk�adu 7
--Student: Jakub Wo�niak
--Nr indeksu: pd4135
--Zadania:

--1. Opracuj pe�ny schemat bazy danych zawieraj�cy tabel� Po�yczki (a wi�c obejmuj�cy tak�e --kierownik�w i klient�w). 
--Postaraj si� zidentyfikowa� wszystkie po��dane wi�zy sp�jno�ci definiowane w spos�b deklaratywny.
CREATE TABLE Klienci (
    Numer NUMBER(11,0) PRIMARY KEY NOT NULL,
    Pesel NUMBER(11,0) UNIQUE NOT NULL,
    Imie VARCHAR(30) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    Adres VARCHAR(100) NOT NULL
    );

CREATE TABLE Kierownicy (
    Numer NUMBER(11,0) PRIMARY KEY NOT NULL,
    Imie VARCHAR(30) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    Dzial VARCHAR(20)
    );

CREATE TABLE Po�yczki (
    Numer_po�yczki NUMBER(11,0) PRIMARY KEY NOT NULL,     
    Kwota NUMBER(8,0) NOT NULL,
    Typ VARCHAR(8) CHECK (Typ IN ('Konsumpcyjna', 'Inwestycyjna', 'Edukacyjna')),
    Data_przyznania DATE DEFAULT Sysdate,
    Decydent NUMBER(11,0),
    Klient NUMBER(11,0),
    FOREIGN KEY (Decydent) REFERENCES Kierownicy(Numer),
    FOREIGN KEY (Klient) REFERENCES Klienci(Numer)    
    );


--2. Opracuj skrypt zak�adaj�cy baz� danych klient�w, produkt�w oraz zam�wie�. Pami�taj o --odpowiedniej reprezentacji zwi�zk�w. 
--Uwzgl�dnij warunki poprawno�ci danych w postaci deklaratywnych wi�z�w sp�jno�ci oraz akcji referencyjnych (realizowalnych w Oracle w spos�b deklaratywny).
CREATE TABLE Customers (
    Customer_number NUMBER(11,0) PRIMARY KEY NOT NULL,
    Pesel NUMBER(11,0) UNIQUE NOT NULL,
    Forname VARCHAR(30) NOT NULL,
    Surname VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Phone VARCHAR(30),
    Email VARCHAR(50)    
    );

CREATE TABLE Products (
    Product_number NUMBER(11,0) PRIMARY KEY NOT NULL,
    Product_name VARCHAR(30) NOT NULL,
    Product_category VARCHAR(30), 
    Net_price NUMBER(10,2) NOT NULL,
    Vat NUMBER(4,2),
    Gross_price NUMBER(10,2)
    );
    
CREATE TABLE Orders (
    Order_number NUMBER(11,0) PRIMARY KEY NOT NULL,
    Order_date DATE DEFAULT Sysdate,
    Customer_number NUMBER(11,0),    
    Product_number NUMBER(11,0),
    FOREIGN KEY (Customer_number) REFERENCES Customers(Customer_number),     
    FOREIGN KEY (Product_number) REFERENCES Products(Product_number)  
    );

ALTER TABLE Products
ADD (CONSTRAINT prod_cat CHECK (Product_category IN ('Rolki', '�y�wy', 'Narty')));
ALTER TABLE Products
ADD (CONSTRAINT prices_comp CHECK (Gross_price >= Net_price));

INSERT INTO Customers (Customer_number, Pesel, Forname, Surname, Address, Phone, Email)
    VALUES (2, '81082705734', 'Boles�aw', 'Zasada', 'ul.P�ocka 3/5 04-220 S�upsk', '605240904', 'bzasada@gmail.com');
INSERT INTO Customers (Customer_number, Pesel, Forname, Surname, Address, Phone, Email)
    VALUES (5, '87082105730', 'Antonina', 'Sielska', 'ul.Gdy�ska 10A 12-900 Sopot', '705740101', 'asielska@gmail.com');
INSERT INTO Customers (Customer_number, Pesel, Forname, Surname, Address, Phone, Email)
    VALUES (13, '07082257341', 'Franiciszek', 'Czy�ski', 'ul.Bulwar Po�udniowy 1 02-566 Suwa�ki', '785506506', 'franciszek100@o2.pl');

INSERT INTO Products (Product_number, Product_name, Product_category, Net_price, Vat, Gross_price)
    VALUES (20230004, 'FR UFR 4x90 Intuition', 'Rolki', 1600, 0.23, 1968);
INSERT INTO Products (Product_number, Product_name, Product_category, Net_price, Vat, Gross_price)
    VALUES (20230005, 'Wizard NR 4x100', 'Rolki', 220, 0.23, 2706);
INSERT INTO Products (Product_number, Product_name, Product_category, Net_price, Vat, Gross_price)
    VALUES (20230006, 'Fisher Fire 2023 Edition', 'Narty', 1000, 0.23, 1230);
INSERT INTO Products (Product_number, Product_name, Product_category, Net_price, Vat, Gross_price)
    VALUES (20230007, 'Atomic RX', 'Narty', 990, 0.23, 1107);
INSERT INTO Products (Product_number, Product_name, Product_category, Net_price, Vat, Gross_price)
    VALUES (20230008, 'Seba Hockey XL', '�y�wy', 2500, 0.23, 3075);
INSERT INTO Products (Product_number, Product_name, Product_category, Net_price, Vat, Gross_price)
    VALUES (20230009, 'K2 Chase', '�y�wy', 1200, 0.23, 1476);

INSERT INTO Orders (Order_number, Order_date, Customer_number, Product_number)
    VALUES (501,TO_DATE(Sysdate, 'dd/mm/yyy'), 2, 20230004);
INSERT INTO Orders (Order_number, Order_date, Customer_number, Product_number)
    VALUES (502,TO_DATE(Sysdate, 'dd/mm/yyy'), 2, 20230005);
INSERT INTO Orders (Order_number, Order_date, Customer_number, Product_number)
    VALUES (503,TO_DATE(Sysdate, 'dd/mm/yyy'), 2, 20230009);
INSERT INTO Orders (Order_number, Order_date, Customer_number, Product_number)
    VALUES (504,TO_DATE(Sysdate, 'dd/mm/yyy'), 5, 20230004);
INSERT INTO Orders (Order_number, Order_date, Customer_number, Product_number)
    VALUES (505,TO_DATE(Sysdate, 'dd/mm/yyy'), 5, 20230007);
INSERT INTO Orders (Order_number, Order_date, Customer_number, Product_number)
    VALUES (506,TO_DATE(Sysdate, 'dd/mm/yyy'), 13, 20230006);

--3. Podaj definicj� tabeli Emp1 (jako instrukcj� CREATE TABLE Emp1...) razem ze wszystkimi --naturalnymi dla danych pracownika wi�zami sp�jno�ci.

CREATE TABLE Emp1
       (Empno NUMBER(4) PRIMARY KEY NOT NULL,
        Ename VARCHAR2(10) NOT NULL,
        Job VARCHAR2(9),
        Mgr NUMBER(4),
        Hiredate DATE,
        Sal NUMBER(7, 2),
        Comm NUMBER(7, 2),
        Deptno NUMBER(2),
        FOREIGN KEY (Mgr) REFERENCES Emp1(Empno),
        FOREIGN KEY (Deptno) REFERENCES Dept(Deptno),
        CONSTRAINT sal_comm CHECK(0.1*Sal<=Comm AND Comm<=0.5*Sal)
        );









