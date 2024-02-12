--PWB 
--Zadania do wyk�adu 6
--Student: Jakub Wo�niak
--Nr indeksu: pd4135
--Zadania:
--1.Utw�rz dwie tabele: Towary_w_magazynie i Partia_towar�w o tym samym schemacie (Nazwa_towaru, Ilo��). 
--Wpisz 5 przyk�adowych wierszy do pierwszej tabeli i 7 przyk�adowych wierszy do drugiej tabeli. 
--Zastosuj instrukcj� MERGE do wpisania partii towar�w do towar�w w magazynie.

CREATE TABLE Towary_w_magazynie(
    Nazwa_towaru VARCHAR(50), 
    Ilo�� INT);

CREATE TABLE Partia_towar�w(
    Nazwa_towaru VARCHAR(50), 
    Ilo�� INT);

INSERT INTO Towary_w_magazynie (Nazwa_towaru, Ilo��) VALUES ('Para nart', 6);
INSERT INTO Towary_w_magazynie (Nazwa_towaru, Ilo��) VALUES ('�y�wy dzieci�ce', 2);
INSERT INTO Towary_w_magazynie (Nazwa_towaru, Ilo��) VALUES ('Kij hokejowy', 4);
INSERT INTO Towary_w_magazynie (Nazwa_towaru, Ilo��) VALUES ('Kask narciarski', 5);
INSERT INTO Towary_w_magazynie (Nazwa_towaru, Ilo��) VALUES ('Buty narciarskie L', 5);

INSERT INTO Partia_towar�w (Nazwa_towaru, Ilo��) VALUES ('Para nart', 3);
INSERT INTO Partia_towar�w (Nazwa_towaru, Ilo��) VALUES ('Gogle', 7);
INSERT INTO Partia_towar�w (Nazwa_towaru, Ilo��) VALUES ('R�kawice XS', 3);
INSERT INTO Partia_towar�w (Nazwa_towaru, Ilo��) VALUES ('�y�wy hokejowe XL', 8);
INSERT INTO Partia_towar�w (Nazwa_towaru, Ilo��) VALUES ('Komplet ochraniaczy hokejowych', 12);
INSERT INTO Partia_towar�w (Nazwa_towaru, Ilo��) VALUES ('Kurtka narciarska M', 8);
INSERT INTO Partia_towar�w (Nazwa_towaru, Ilo��) VALUES ('Kurtka narciarska L', 8);

MERGE INTO Towary_w_magazynie m
USING Partia_towar�w p ON (m.Nazwa_towaru = p.Nazwa_towaru)
WHEN MATCHED THEN UPDATE SET m.Ilo�� = m.Ilo�� + p.Ilo��
WHEN NOT MATCHED THEN INSERT (m.Nazwa_towaru, m.Ilo��) VALUES (p.Nazwa_towaru, p.ilo��);

--2.Utw�rz perspektywy Emp_na_urlopie_bezp�atnym i Pracownicy. 
--Sprawd� czy maj� one przewidywane w�asno�ci (opcja sprawdzania, opcja tylko do odczytu).

CREATE VIEW Emp_na_urlopie_bezp�atnym
AS SELECT * 
   FROM Emp
   WHERE Emp.Sal = 0 OR Emp.Sal IS NULL
WITH CHECK OPTION;

CREATE VIEW Pracownicy
AS SELECT * FROM Emp
   WITH READ ONLY;

--3.Utw�rz perspektyw�, w kt�rej dla ka�dej lokalizacji (Loc) jest podana liczba departament�w 
--oraz liczba pracownik�w zatrudnionych w tych departamentach.

CREATE VIEW Locations 
AS SELECT Dept.Loc, COUNT(DISTINCT Dept.Dname) Liczba_dep, COUNT(*) Liczba_prac
    FROM Emp
    JOIN Dept ON Emp.Deptno = Dept.Deptno
    GROUP BY Dept.Loc;

--4.Utw�rz perspektyw�, w kt�re zebrane s� wszystkie dane dotycz�ce pojedynczej osoby � 
--mianowicie tej kt�ra korzysta z perspektywy. Dane powinny pochodzi� zar�wno z tabeli Emp jak i pozosta�ych tabel Dept i Salgrade. 
--Zak�adamy, �e identyfikator u�ytkownika (dost�pny za pomoc� sta�ej user � sprawd� wynik zapytania: 
--SELECT User FROM Dual;) jest taki sam jak warto�� Ename. Utw�rz wiersz w tabeli Emp ze swoim identyfikatorem jako Ename. 
--Napisz instrukcj� SELECT wykorzystuj�c� zbudowan� perspektyw�.

CREATE VIEW Employee
AS SELECT Emp.Empno, Emp.Ename, Emp.Deptno, Dept.Dname, Dept.Loc, Emp.Sal, Salgrade.Grade 
    FROM Emp, Dept, Salgrade
    WHERE Emp.Deptno = Dept.Deptno
    AND Sal BETWEEN Salgrade.Losal AND Salgrade.Hisal
    AND Emp.Ename = (
        SELECT User FROM Dual);

--5.U�� perspektyw�, kt�ra wy�wietla nazwy tabel, kt�rych jeste� w�a�cicielem razem z ich liczb� kolumn oraz liczb� wierszy.
CREATE VIEW TableStats
AS SELECT u.Table_Name, COUNT(*) AS "L_Kolumn", SUM(w.Num_Rows)/COUNT(*) AS "L_Wierszy"  
    FROM User_Tab_Columns u, User_Tables w
    WHERE u.Table_Name = w.Table_Name
    GROUP BY u.Table_Name;

--6.Zidentyfikuj grupy u�ytkownik�w w bazie danych dla firmy dokonuj�cej sprzeda�y produkt�w. 
--Dla ka�dej grupy u�ytkownik�w zdefiniuj  zestaw wymaganych perspektyw. Oto logiczny schemat bazy danych tej firmy:
--Pracownicy(Id_prac, Imi�, Nazwisko, Data_urodzenia, Adres)
--Zatrudnienie(Id_prac, Data_pocz, Stanowisko, Data_koniec, Zarobki)
--Produkty(Id_produktu, Nazwa, Cena)
--Klienci(Id_klienta, Imie, Nazwisko, Adres)
--Sprzeda�(Id_sprzeda�y, Id_klienta, Id_towaru, Ilo��, Data, Id_prac)

CREATE VIEW Pracownicy
AS SELECT * FROM Pracownicy;

CREATE VIEW Hr
AS SELECT * FROM Pracownicy JOIN Zatrudnienie ON Pracownicy.Id_prac = Zatrudnienie.Id_prac;

CREATE VIEW Produkcja
AS SELECT * FROM Produkty;

CREATE VIEW Klienci
AS SELECT * FROM Klienci;

CREATE VIEW Sprzeda�
AS SELECT * FROM Sprzeda� 
    JOIN Klienci ON Sprzeda�.Id_klienta = Klienci.Id_klienta
    JOIN Produkty ON Sprzeda�.Id_towaru = Produkty.Id_produktu
    JOIN Pracownicy ON Sprzeda�.Id_prac = Pracownicy.Id_prac;

--7.W schemacie bazy danych zadania 6 dokonano nast�puj�cych zmian. Dodano tabel� Kategorie(Id_kat, Nazwa) oraz 
--dodano kolumn� Id_kat do tabeli Produkty tzn. Produkty(Id_produktu, Nazwa, Cena) 
--Dodano tabel� Premie(Id_prac, Data, Premia) 
--Przeanalizuj jakie zmiany spowoduje to w definicji zidentyfikowanych poprzednio perspektyw.

--Odpowied�: obie dodane tabele mo�na rozpatrywa� jako tzw. encje s�ownikowe na diagramie encji relacyjnej bazy danych.
--Stosuje si� je, aby u�atwi� kontrol� poprawno�ci wprowadzanych przez u�ytkownika warto�ci danego atrybutu.
--1) Pomi�dzy tabelami Kategorie i Produkty istnieje relacja jeden-do-wielu, z tabel� Kategorie jako encj� nadrz�dn�. 
--Klucz obcy Id_kat w tabeli Produkty odnosi si� do klucza g��wnego Id_kat w tabeli Kategorie. Nale�a�oby zmodyfikowa� istniej�ce
--perspektywy "Sprzeda�" oraz "Produkty" w nast�puj�cy spos�b:

CREATE VIEW Produkcja
AS SELECT * FROM Produkty JOIN Kategorie ON Produkty.Id_kat = Kategorie.Id_kat;

CREATE VIEW Sprzeda�
AS SELECT * FROM Sprzeda� 
    JOIN Klienci ON Sprzeda�.Id_klienta = Klienci.Id_klienta
    JOIN Produkty ON Sprzeda�.Id_towaru = Produkty.Id_produktu
    JOIN Kategorie ON Produkty.Id_kat = Kategorie.Id_kat
    JOIN Pracownicy ON Sprzeda�.Id_prac = Pracownicy.Id_prac;

--2) Pomi�dzy tabelami Premie i Zatrudnienie istnieje relacja jeden-do-wielu po stronie tabeli Premie jako encji nadrz�dnej, z kluczem
--g��wnym Id_prac, na kt�ry wskazuje klucz obcy Id_prac w tabeli Zatrudnienie. Nale�a�oby zmodyfikowa� istniej�c�
--perspektyw� "Zatrudnienie":

CREATE VIEW Hr
AS SELECT * FROM Pracownicy 
    JOIN Zatrudnienie ON Pracownicy.Id_prac = Zatrudnienie.Id_prac
    JOIN Premie ON Zatrudnienie.Id_prac = Premie.Id_prac;

--8.Dla bazy danych z zadania 3 w wyk�adzie 2 najpierw usu� dane z wszystkich tabel, 
--nast�pnie opracuj wymagane sekwencje i u�yj ich do wprowadzenia z powrotem danych.

DELETE FROM Studenci;
DELETE FROM Kursy;
DELETE FROM Wykladowcy;
DELETE FROM Rejestracje;

CREATE SEQUENCE nr_indeksu
INCREMENT BY 2
START WITH 100;

CREATE SEQUENCE nr_kursu
INCREMENT BY 5
START WITH 55;

CREATE SEQUENCE id_wykladowcy
INCREMENT BY 1
START WITH 1000;

INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (Nr_indeksu.NextVal, 'Kuczy�ska Ewa', 1980,	'Bazy danych');
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (Nr_indeksu.NextVal, 'Lubicz Robert', 1985, 'Multimedia');
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (Nr_indeksu.NextVal, 'Krajewski Bogdan', 1988, 'Bazy danych');
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (Nr_indeksu.NextVal, 'Lity�ska Anna', 1987,	'Multimedia');
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (Nr_indeksu.NextVal, 'Marzec Marcin', 1982, 'Multimedia');
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (Nr_indeksu.NextVal, 'Cichocki Rafa�', 1989, 'Bazy danych');
    
INSERT INTO Wykladowcy (IdWykladowcy, Nazwisko, Stopien, Stanowisko)
    VALUES (Id_wykladowcy.NextVal, 'Kowalski Jan', 'Dr', 'Adiunkt');
INSERT INTO Wykladowcy (IdWykladowcy, Nazwisko, Stopien, Stanowisko)
    VALUES (Id_wykladowcy.NextVal, 'Jakubowski Emil', 'Dr hab', 'Docent');
INSERT INTO Wykladowcy (IdWykladowcy, Nazwisko, Stopien, Stanowisko)
    VALUES (Id_wykladowcy.NextVal, 'Gazda Miros�awa', 'Dr', 'Profesor');

INSERT INTO Kursy (IdKursu, Nazwa, IdWykladowcy)
    VALUES (Id_kursu.NextVal, 'Bazy danych', 1000);
INSERT INTO Kursy (IdKursu, Nazwa, IdWykladowcy)
    VALUES (Id_kursu.NextVal, 'Systemy operacyjne', 1001);
INSERT INTO Kursy (IdKursu, Nazwa, IdWykladowcy)
    VALUES (Id_kursu.NextVal, 'Multimedia', 1000);
INSERT INTO Kursy (IdKursu, Nazwa, IdWykladowcy)
    VALUES (Id_kursu.NextVal, 'Sieci komputerowe', 1002);
    
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (100, 55);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (100, 60);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (102, 55);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (104, 60);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (104, 65);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (104, 70);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (106, 55);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (108, 65);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (110, 70);

--9.Sprawd�, jakie tabele znajduj� si� w twojej bazie danych.

SELECT DISTINCT u.Table_Name
FROM User_Tab_Columns u;

--10.Sprawd�, jakie perspektywy znajduj� si� w twojej bazie danych.

SELECT view_name
FROM user_views;

--11.Sprawd�, jakie sekwencje znajduj� si� w twojej bazie danych.

select sequence_name from user_sequences;










