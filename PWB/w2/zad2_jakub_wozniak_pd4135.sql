--PWB 
--Zadania do wyk³¹du 2
--Student: Jakub WoŸniak
--Nr indeksu: pd4135

--Zadanie 1. U³ó¿ i przetestuj nastêpuj¹ce zapytania:

--1.1 Wyznacz pracowników, którzy zarabiaj¹ powy¿ej 2000 i których nazwiska nie zaczynaj¹ siê na literê A. Uporz¹dkuj wyniki wed³ug daty zatrudnienia.
SELECT Emp.Ename FROM Emp
WHERE Emp.Sal > 2000 AND Emp.Ename NOT LIKE 'A%'
ORDER BY Emp.Hiredate ASC;

--1.2 Wyznacz pracowników, którzy zarabiaj¹ poni¿ej 1500 i których nazwiska nie koñcz¹ siê na literê S. Uporz¹dkuj wyniki wed³ug daty zatrudnienia.
SELECT Emp.Ename FROM Emp
WHERE Emp.Sal < 1500 AND Emp.Ename NOT LIKE '%S'
ORDER BY Emp.Hiredate ASC;

--1.3 Wyznacz wszystkie stanowiska (bez powtórzeñ).
SELECT DISTINCT Emp.Job
FROM Emp;

--1.4 Wyznacz pracowników, którzy nie dostali prowizji.
SELECT * FROM Emp
WHERE Emp.Comm IS NULL OR Emp.Comm = 0;

--1.5 Wypisz identyfikatory osób, które nie maj¹ kierownika. Do³¹cz ich zarobki i stanowiska. Uporz¹dkuj wyniki wed³ug rosn¹cych zarobków.
SELECT Emp.Empno, Emp.Sal, Emp.Job
FROM Emp
WHERE Emp.Mgr IS NULL
ORDER BY Emp.Sal ASC;

--Zadanie 3. Dany jest schemat bazy danych (w konwencji MS Visio):
--3.1 Utwórz skrypt tworz¹cy tabele obejmuj¹cy specyfikacjê kluczy g³ównych i obcych.
CREATE TABLE Studenci 
    (NrIndeksu NUMBER(5) PRIMARY KEY NOT NULL,
    Nazwisko VARCHAR(25) NOT NULL,
    RokUrodzenia NUMBER(4) NOT NULL,
    Kierunek VARCHAR(15));

CREATE TABLE Rejestracje 
    (NrIndeksu NUMBER(5) NOT NULL, 
    IdKursu VARCHAR(5) NOT NULL, 
    PRIMARY KEY (NrIndeksu, IdKursu),
    CONSTRAINT fk_nr_indeksu FOREIGN KEY (NrIndeksu) REFERENCES Studenci,
    CONSTRAINT fk_id_kursu FOREIGN KEY (IdKursu) REFERENCES Kursy,
    Data DATE);

CREATE TABLE Kursy 
    (IdKursu VARCHAR(5) PRIMARY KEY NOT NULL,
    Nazwa VARCHAR(25) NOT NULL,
    IdWykladowcy VARCHAR(5) NULL REFERENCES Wykladowcy);

CREATE TABLE Wykladowcy 
    (IdWykladowcy VARCHAR(5) PRIMARY KEY,
    Nazwisko VARCHAR(25) NOT NULL,
    Stopien VARCHAR(10) NOT NULL,
    Stanowisko VARCHAR(15));
        
--3.2 U¿ywaj¹c instrukcji CREATE INDEX utwórz indeks jednoznaczny na kolumnie Nazwa tabeli Kursy oraz zwyk³e indeksy na kolumnie Nazwisko w tabeli Studenci i Wyk³adowcy.
CREATE UNIQUE INDEX ind_nazwa ON Kursy (Nazwa);
CREATE INDEX ind_nazwisko ON Studenci (Nazwisko);
CREATE INDEX ind_w_nazwisko ON Wykladowcy (Nazwisko);

--3.3 U¿ywaj¹c instrukcji INSERT wstaw do bazy danych nastêpuj¹ce dane:
--tabela Wykladowcy:
INSERT INTO Wykladowcy (IdWykladowcy, Nazwisko, Stopien, Stanowisko)
    VALUES (1010, 'Kowalski Jan', 'Dr', 'Adiunkt');
INSERT INTO Wykladowcy (IdWykladowcy, Nazwisko, Stopien, Stanowisko)
    VALUES (1011, 'Jakubowski Emil', 'Dr hab', 'Docent');
INSERT INTO Wykladowcy (IdWykladowcy, Nazwisko, Stopien, Stanowisko)
    VALUES (1012, 'Gazda Miros³awa', 'Dr', 'Profesor');

--tabela Kursy:
INSERT INTO Kursy (IdKursu, Nazwa, IdWykladowcy)
    VALUES (1, 'Bazy danych', 1010);
INSERT INTO Kursy (IdKursu, Nazwa, IdWykladowcy)
    VALUES (2, 'Systemy operacyjne', 1012);
INSERT INTO Kursy (IdKursu, Nazwa, IdWykladowcy)
    VALUES (3, 'Multimedia', 1011);
INSERT INTO Kursy (IdKursu, Nazwa)
    VALUES (4, 'Sieci komputerowe');

--tabela Studenci
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (101, 'Kuczyñska Ewa', 1980,	'Bazy danych');
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (102, 'Lubicz Robert', 1985, 'Multimedia');
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (103, 'Krajewski Bogdan', 1988, 'Bazy danych');
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (104, 'Lityñska Anna', 1987,	'Multimedia');
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (105, 'Marzec Marcin', 1982, 'Multimedia');
INSERT INTO Studenci (NrIndeksu, Nazwisko, RokUrodzenia, Kierunek)
    VALUES (106, 'Cichocki Rafa³', 1989, 'Bazy danych');

--tabela Rejestracje
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (101, 1);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (102, 3);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (104, 3);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (106, 1);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (104, 2);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (101, 4);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (103, 1);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (103, 1);
INSERT INTO Rejestracje (NrIndeksu, IdKursu)
    VALUES (105, 1);
	 
--3.4 Napisz instrukcjê, która zmieni rejestracjê studenta o nazwisku Marzec z Bazy danych na Multimedia. Dokonaj zatwierdzenia zmian.
UPDATE Rejestracje 
SET IdKursu = (SELECT IdKursu FROM Kursy WHERE Nazwa = 'Multimedia')
WHERE NrIndeksu = (SELECT NrIndeksu FROM Studenci WHERE Nazwisko LIKE 'Marzec%');
COMMIT;

--3.5 Napisz instrukcjê, która usunie wszystkie rejestracje studenta o nazwisku Marzec. Wycofaj zmiany.
DELETE FROM Rejestracje
WHERE NrIndeksu = (SELECT NrIndeksu FROM Studenci WHERE Nazwisko LIKE 'Marzec%');
ROLLBACK;

--3.6 Wstaw dzisiejsz¹ datê do kolumny Data tabeli Rejestracje.
UPDATE Rejestracje
SET Data = SYSDATE;

--3.7 U³ó¿ nastêpuj¹ce zapytania:
--Wypisz kursy, które nie maj¹ przyporz¹dkowanych wyk³adowców.
SELECT Nazwa 
FROM Kursy
WHERE IdWykladowcy IS NULL;

--Wypisz rejestracje dokonane przez studenta o numerze indeksu 101.
SELECT IdKursu
FROM Rejestracje
WHERE NrIndeksu = 101;

--Wypisz nazwy kursów w kolejnoœci alfabetycznej.
SELECT Nazwa 
FROM Kursy
ORDER BY Nazwa ASC;

--Wypisz nazwiska studentów za³¹czaj¹c ich wiek.
SELECT Nazwisko, Trunc(EXTRACT(YEAR FROM SYSDATE) - RokUrodzenia) "Wiek"
FROM Studenci;

