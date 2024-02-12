--PWB 
--Zadania do wyk³adu 6
--Student: Jakub WoŸniak
--Nr indeksu: pd4135
--Zadania:
--1.Utwórz dwie tabele: Towary_w_magazynie i Partia_towarów o tym samym schemacie (Nazwa_towaru, Iloœæ). 
--Wpisz 5 przyk³adowych wierszy do pierwszej tabeli i 7 przyk³adowych wierszy do drugiej tabeli. 
--Zastosuj instrukcjê MERGE do wpisania partii towarów do towarów w magazynie.

CREATE TABLE Towary_w_magazynie(
    Nazwa_towaru VARCHAR(50), 
    Iloœæ INT);

CREATE TABLE Partia_towarów(
    Nazwa_towaru VARCHAR(50), 
    Iloœæ INT);

INSERT INTO Towary_w_magazynie (Nazwa_towaru, Iloœæ) VALUES ('Para nart', 6);
INSERT INTO Towary_w_magazynie (Nazwa_towaru, Iloœæ) VALUES ('£y¿wy dzieciêce', 2);
INSERT INTO Towary_w_magazynie (Nazwa_towaru, Iloœæ) VALUES ('Kij hokejowy', 4);
INSERT INTO Towary_w_magazynie (Nazwa_towaru, Iloœæ) VALUES ('Kask narciarski', 5);
INSERT INTO Towary_w_magazynie (Nazwa_towaru, Iloœæ) VALUES ('Buty narciarskie L', 5);

INSERT INTO Partia_towarów (Nazwa_towaru, Iloœæ) VALUES ('Para nart', 3);
INSERT INTO Partia_towarów (Nazwa_towaru, Iloœæ) VALUES ('Gogle', 7);
INSERT INTO Partia_towarów (Nazwa_towaru, Iloœæ) VALUES ('Rêkawice XS', 3);
INSERT INTO Partia_towarów (Nazwa_towaru, Iloœæ) VALUES ('£y¿wy hokejowe XL', 8);
INSERT INTO Partia_towarów (Nazwa_towaru, Iloœæ) VALUES ('Komplet ochraniaczy hokejowych', 12);
INSERT INTO Partia_towarów (Nazwa_towaru, Iloœæ) VALUES ('Kurtka narciarska M', 8);
INSERT INTO Partia_towarów (Nazwa_towaru, Iloœæ) VALUES ('Kurtka narciarska L', 8);

MERGE INTO Towary_w_magazynie m
USING Partia_towarów p ON (m.Nazwa_towaru = p.Nazwa_towaru)
WHEN MATCHED THEN UPDATE SET m.Iloœæ = m.Iloœæ + p.Iloœæ
WHEN NOT MATCHED THEN INSERT (m.Nazwa_towaru, m.Iloœæ) VALUES (p.Nazwa_towaru, p.iloœæ);

--2.Utwórz perspektywy Emp_na_urlopie_bezp³atnym i Pracownicy. 
--SprawdŸ czy maj¹ one przewidywane w³asnoœci (opcja sprawdzania, opcja tylko do odczytu).

CREATE VIEW Emp_na_urlopie_bezp³atnym
AS SELECT * 
   FROM Emp
   WHERE Emp.Sal = 0 OR Emp.Sal IS NULL
WITH CHECK OPTION;

CREATE VIEW Pracownicy
AS SELECT * FROM Emp
   WITH READ ONLY;

--3.Utwórz perspektywê, w której dla ka¿dej lokalizacji (Loc) jest podana liczba departamentów 
--oraz liczba pracowników zatrudnionych w tych departamentach.

CREATE VIEW Locations 
AS SELECT Dept.Loc, COUNT(DISTINCT Dept.Dname) Liczba_dep, COUNT(*) Liczba_prac
    FROM Emp
    JOIN Dept ON Emp.Deptno = Dept.Deptno
    GROUP BY Dept.Loc;

--4.Utwórz perspektywê, w które zebrane s¹ wszystkie dane dotycz¹ce pojedynczej osoby – 
--mianowicie tej która korzysta z perspektywy. Dane powinny pochodziæ zarówno z tabeli Emp jak i pozosta³ych tabel Dept i Salgrade. 
--Zak³adamy, ¿e identyfikator u¿ytkownika (dostêpny za pomoc¹ sta³ej user – sprawdŸ wynik zapytania: 
--SELECT User FROM Dual;) jest taki sam jak wartoœæ Ename. Utwórz wiersz w tabeli Emp ze swoim identyfikatorem jako Ename. 
--Napisz instrukcjê SELECT wykorzystuj¹c¹ zbudowan¹ perspektywê.

CREATE VIEW Employee
AS SELECT Emp.Empno, Emp.Ename, Emp.Deptno, Dept.Dname, Dept.Loc, Emp.Sal, Salgrade.Grade 
    FROM Emp, Dept, Salgrade
    WHERE Emp.Deptno = Dept.Deptno
    AND Sal BETWEEN Salgrade.Losal AND Salgrade.Hisal
    AND Emp.Ename = (
        SELECT User FROM Dual);

--5.U³ó¿ perspektywê, która wyœwietla nazwy tabel, których jesteœ w³aœcicielem razem z ich liczb¹ kolumn oraz liczb¹ wierszy.
CREATE VIEW TableStats
AS SELECT u.Table_Name, COUNT(*) AS "L_Kolumn", SUM(w.Num_Rows)/COUNT(*) AS "L_Wierszy"  
    FROM User_Tab_Columns u, User_Tables w
    WHERE u.Table_Name = w.Table_Name
    GROUP BY u.Table_Name;

--6.Zidentyfikuj grupy u¿ytkowników w bazie danych dla firmy dokonuj¹cej sprzeda¿y produktów. 
--Dla ka¿dej grupy u¿ytkowników zdefiniuj  zestaw wymaganych perspektyw. Oto logiczny schemat bazy danych tej firmy:
--Pracownicy(Id_prac, Imiê, Nazwisko, Data_urodzenia, Adres)
--Zatrudnienie(Id_prac, Data_pocz, Stanowisko, Data_koniec, Zarobki)
--Produkty(Id_produktu, Nazwa, Cena)
--Klienci(Id_klienta, Imie, Nazwisko, Adres)
--Sprzeda¿(Id_sprzeda¿y, Id_klienta, Id_towaru, Iloœæ, Data, Id_prac)

CREATE VIEW Pracownicy
AS SELECT * FROM Pracownicy;

CREATE VIEW Hr
AS SELECT * FROM Pracownicy JOIN Zatrudnienie ON Pracownicy.Id_prac = Zatrudnienie.Id_prac;

CREATE VIEW Produkcja
AS SELECT * FROM Produkty;

CREATE VIEW Klienci
AS SELECT * FROM Klienci;

CREATE VIEW Sprzeda¿
AS SELECT * FROM Sprzeda¿ 
    JOIN Klienci ON Sprzeda¿.Id_klienta = Klienci.Id_klienta
    JOIN Produkty ON Sprzeda¿.Id_towaru = Produkty.Id_produktu
    JOIN Pracownicy ON Sprzeda¿.Id_prac = Pracownicy.Id_prac;

--7.W schemacie bazy danych zadania 6 dokonano nastêpuj¹cych zmian. Dodano tabelê Kategorie(Id_kat, Nazwa) oraz 
--dodano kolumnê Id_kat do tabeli Produkty tzn. Produkty(Id_produktu, Nazwa, Cena) 
--Dodano tabelê Premie(Id_prac, Data, Premia) 
--Przeanalizuj jakie zmiany spowoduje to w definicji zidentyfikowanych poprzednio perspektyw.

--OdpowiedŸ: obie dodane tabele mo¿na rozpatrywaæ jako tzw. encje s³ownikowe na diagramie encji relacyjnej bazy danych.
--Stosuje siê je, aby u³atwiæ kontrolê poprawnoœci wprowadzanych przez u¿ytkownika wartoœci danego atrybutu.
--1) Pomiêdzy tabelami Kategorie i Produkty istnieje relacja jeden-do-wielu, z tabel¹ Kategorie jako encj¹ nadrzêdn¹. 
--Klucz obcy Id_kat w tabeli Produkty odnosi siê do klucza g³ównego Id_kat w tabeli Kategorie. Nale¿a³oby zmodyfikowaæ istniej¹ce
--perspektywy "Sprzeda¿" oraz "Produkty" w nastêpuj¹cy sposób:

CREATE VIEW Produkcja
AS SELECT * FROM Produkty JOIN Kategorie ON Produkty.Id_kat = Kategorie.Id_kat;

CREATE VIEW Sprzeda¿
AS SELECT * FROM Sprzeda¿ 
    JOIN Klienci ON Sprzeda¿.Id_klienta = Klienci.Id_klienta
    JOIN Produkty ON Sprzeda¿.Id_towaru = Produkty.Id_produktu
    JOIN Kategorie ON Produkty.Id_kat = Kategorie.Id_kat
    JOIN Pracownicy ON Sprzeda¿.Id_prac = Pracownicy.Id_prac;

--2) Pomiêdzy tabelami Premie i Zatrudnienie istnieje relacja jeden-do-wielu po stronie tabeli Premie jako encji nadrzêdnej, z kluczem
--g³ównym Id_prac, na który wskazuje klucz obcy Id_prac w tabeli Zatrudnienie. Nale¿a³oby zmodyfikowaæ istniej¹c¹
--perspektywê "Zatrudnienie":

CREATE VIEW Hr
AS SELECT * FROM Pracownicy 
    JOIN Zatrudnienie ON Pracownicy.Id_prac = Zatrudnienie.Id_prac
    JOIN Premie ON Zatrudnienie.Id_prac = Premie.Id_prac;

--8.Dla bazy danych z zadania 3 w wyk³adzie 2 najpierw usuñ dane z wszystkich tabel, 
--nastêpnie opracuj wymagane sekwencje i u¿yj ich do wprowadzenia z powrotem danych.

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
    VALUES (Nr_indeksu.NextVal, 'Kuczyñska Ewa', 1980,	'Bazy danych');
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (Nr_indeksu.NextVal, 'Lubicz Robert', 1985, 'Multimedia');
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (Nr_indeksu.NextVal, 'Krajewski Bogdan', 1988, 'Bazy danych');
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (Nr_indeksu.NextVal, 'Lityñska Anna', 1987,	'Multimedia');
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (Nr_indeksu.NextVal, 'Marzec Marcin', 1982, 'Multimedia');
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (Nr_indeksu.NextVal, 'Cichocki Rafa³', 1989, 'Bazy danych');
    
INSERT INTO Wykladowcy (IdWykladowcy, Nazwisko, Stopien, Stanowisko)
    VALUES (Id_wykladowcy.NextVal, 'Kowalski Jan', 'Dr', 'Adiunkt');
INSERT INTO Wykladowcy (IdWykladowcy, Nazwisko, Stopien, Stanowisko)
    VALUES (Id_wykladowcy.NextVal, 'Jakubowski Emil', 'Dr hab', 'Docent');
INSERT INTO Wykladowcy (IdWykladowcy, Nazwisko, Stopien, Stanowisko)
    VALUES (Id_wykladowcy.NextVal, 'Gazda Miros³awa', 'Dr', 'Profesor');

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

--9.SprawdŸ, jakie tabele znajduj¹ siê w twojej bazie danych.

SELECT DISTINCT u.Table_Name
FROM User_Tab_Columns u;

--10.SprawdŸ, jakie perspektywy znajduj¹ siê w twojej bazie danych.

SELECT view_name
FROM user_views;

--11.SprawdŸ, jakie sekwencje znajduj¹ siê w twojej bazie danych.

select sequence_name from user_sequences;










