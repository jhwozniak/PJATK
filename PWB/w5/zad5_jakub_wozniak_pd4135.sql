--PWB 
--Zadania do wyk³adu 5
--Student: Jakub WoŸniak
--Nr indeksu: pd4135
--Proszê o wykonanie jednego wybranego zestawu zadañ z zadania 1  oraz o wykonanie zadania 2 --(wszystkie podpunkty) spod wyk³adu 5. Ponadto nale¿y wykonaæ zadanie 5 (wszystkie --podpunkty) --oraz jedno zadanie (wszystkie podpunkty) z zadañ 4, 8.
--Zad 1. Dla bazy danych z wyk³adu 1.
--Zestaw 1
--1. Dla ka¿dego dzia³u wyznacz dane pracownika, którego nazwisko jest pierwsze w porz¹dku alfabetycznym.
SELECT Empno, Ename, Sal, Deptno
FROM Emp
WHERE (Deptno, Ename) IN (
    SELECT Deptno, MIN(Ename)
    FROM Emp
    GROUP BY Deptno);

--2. Wybierz kierowników (pracowników pracuj¹cych na stanowisku MANAGER), którzy maj¹ dok³adnie dwóch podw³adnych. 
--Podaj, gdzie oni pracuj¹ i w jakiej klasie zaszeregowania s¹ ich zarobki.
SELECT Emp.Ename, Emp.Job, Dept.Loc, Salgrade.Grade
FROM Emp, Salgrade, Dept
WHERE (Emp.Sal BETWEEN Salgrade.Losal AND Salgrade.Hisal)
AND Emp.Deptno = Dept.Deptno
AND Emp.Sal = (
    SELECT Emp.Sal
    FROM Emp
    JOIN Dept ON Emp.Deptno = Dept.Deptno
    AND Job = 'MANAGER'
    AND Emp.Empno IN (
        SELECT Mgr
        FROM Emp
        HAVING COUNT(*) = 2
        GROUP BY Mgr)
    );
    
--3. Wyznacz nazwê dzia³u, w którym pracownicy zarabiaj¹ (sumarycznie) najwiêcej oraz nazwê dzia³u, w którym 
--pracownicy zarabiaj¹ (sumarycznie) najmniej. Wynik zapisz w postaci jednego zdania:
--Pracownicy zarabiaj¹ najwiêcej w dziale ...., a najmniej w dziale ...... Ró¿nica wynosi ....
SELECT    
    'Pracownicy zarabiaj¹ najwiêcej w dziale '|| 
    (SELECT Dept.Dname FROM Dept WHERE Dept.Deptno = dept_max.Deptno) ||
    ', a najmniej w dziale '||
    (SELECT Dept.Dname FROM Dept WHERE Dept.Deptno = dept_min.Deptno) ||
    'Ró¿nica wynosi '||
    (dept_max.suma - dept_min.suma) as Diff
FROM 
    (SELECT Emp.Deptno, SUM(Emp.Sal) suma
    FROM Emp
    GROUP BY Deptno
    ORDER BY suma DESC
    FETCH FIRST 1 ROWS ONLY) dept_max,

    (SELECT Emp.Deptno, SUM(Emp.Sal) suma
    FROM Emp    
    GROUP BY Deptno
    ORDER BY suma ASC
    FETCH FIRST 1 ROWS ONLY) dept_min;

--4. Wypisz wszystkich pracowników z podzia³em na strony zak³adaj¹c, ¿e jedna strona zawiera 4o linii wydruku. 
--Kolejnoœæ wypisywania powinna braæ pod uwagê numer departamentu, a w tym samym departamencie datê zatrudnienia.
SELECT *
FROM
    (SELECT Emp.Deptno, Emp.Ename, Emp.Hiredate,
        ROW_NUMBER() OVER(ORDER BY Emp.Deptno, Emp.Hiredate) rnumbers
    FROM Emp) d
WHERE d.rnumbers <= 40;

--Zad 2. Dla bazy danych z zadania 3 w wyk³adzie 2 u³ó¿ zapytania:

--1. Wyznacz studenta, który jest zapisany na najwiêksz¹ liczbê kursów.
SELECT Studenci.Nazwisko, COUNT(*) AS Liczba_kursów
FROM Studenci 
INNER JOIN Rejestracje ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
INNER JOIN Kursy ON Rejestracje.IdKursu = Kursy.IdKursu
GROUP BY Studenci.Nazwisko
ORDER BY 2 DESC
FETCH FIRST 1 ROWS ONLY;

--2. Wyznacz wyk³adowcê, które prowadzi najwiêksz¹ liczbê kursów.
SELECT Wykladowcy.Nazwisko, Kursy.Nazwa, COUNT(*) Liczba_kursów
FROM Wykladowcy
INNER JOIN Kursy ON Kursy.IdWykladowcy = Wykladowcy.IdWykladowcy
INNER JOIN Rejestracje ON Rejestracje.IdKursu = Kursy.Idkursu
INNER JOIN Studenci ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
GROUP BY Wykladowcy.Nazwisko, Kursy.Nazwa
ORDER BY Liczba_kursów DESC
FETCH FIRST 1 ROWS ONLY;

--3. Wyznacz studentów, którzy nie s¹ zapisani na ¿aden kurs.
SELECT Studenci.Nazwisko
FROM Studenci 
FULL JOIN Rejestracje ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
FULL JOIN Kursy ON Rejestracje.IdKursu = Kursy.IdKursu
WHERE Studenci.NrIndeksu NOT IN (
    SELECT Rejestracje.NrIndeksu
    FROM Rejestracje);

--4. Wyznacz wyk³adowców, którzy nie prowadz¹ ¿adnych kursów.
SELECT Wykladowcy.IdWykladowcy, Wykladowcy.Nazwisko, Kursy.IdWykladowcy
FROM Wykladowcy
LEFT JOIN Kursy ON Kursy.IdWykladowcy = Wykladowcy.IdWykladowcy
WHERE Kursy.IdWykladowcy IS NULL;
    
--5. Wyznacz kursy, na które nie zapisa³ siê nikt (oznacz je gwiazdk¹) oraz kursy, 
--na które zapisa³a siê najwiêksza liczba studentów.
SELECT Kursy.Nazwa ||'*' AS Kursy
FROM Kursy
FULL JOIN Rejestracje ON Rejestracje.IdKursu = Kursy.IdKursu
WHERE Kursy.IdKursu NOT IN (
    SELECT Rejestracje.IdKursu
    FROM Rejestracje)
UNION
SELECT 
    (SELECT Kursy.Nazwa FROM Kursy WHERE Kursy.Nazwa = kursy_max.Nazwa) 
FROM (
    SELECT Kursy.Nazwa, COUNT(*) 
    FROM Studenci 
    FULL JOIN Rejestracje ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
    FULL JOIN Kursy ON Rejestracje.IdKursu = Kursy.IdKursu
    GROUP BY Kursy.Nazwa
    ORDER BY COUNT(*) DESC
    FETCH FIRST 1 ROWS ONLY) kursy_max;

--Zad 5. Dany jest schemat relacyjnej bazy danych:
 
--Autorzy(Id_autora,Imiê, Nazwisko)
--Ksi¹¿ki(ISBN,Wydawca,Tytu³,Rok)
--Autorstwa(ISBN,Id_autora)
--Tematy(Nrtematu,Nazwa,Wyjaœnienie)
--Na_tematy(ISBN, Nrtematu)

--1. Napisz instrukcje CREATE TABLE zak³adaj¹ce powy¿sze tabele i definiuj¹ce odpowiednie wiêzy referencyjne.
CREATE TABLE Autorzy (
    Id_autora INT PRIMARY KEY,
    Imiê VARCHAR(40),
    Nazwisko VARCHAR(40)
);

CREATE TABLE Ksi¹¿ki (
    ISBN VARCHAR(20) PRIMARY KEY,
    Wydawca VARCHAR(40),
    Tytu³ VARCHAR(80),
    Rok INT
);

CREATE TABLE Autorstwa (
    ISBN VARCHAR(20),
    Id_autora INT,
    FOREIGN KEY (ISBN) REFERENCES Ksi¹¿ki(ISBN),
    FOREIGN KEY (Id_autora) REFERENCES Autorzy(Id_autora),
    PRIMARY KEY (ISBN, Id_autora)
);

CREATE TABLE Tematy (
    Nrtematu INT PRIMARY KEY,
    Nazwa VARCHAR(40),
    Wyjaœnienie VARCHAR(160)
);

CREATE TABLE Na_tematy (
    ISBN VARCHAR(20),
    Nrtematu INT,
    FOREIGN KEY (ISBN) REFERENCES Ksi¹¿ki(ISBN),
    FOREIGN KEY (Nrtematu) REFERENCES Tematy(Nrtematu),
    PRIMARY KEY (ISBN, Nrtematu)
);

------------------------------
--zape³niamy bazê danych------
------------------------------
--Autorzy
INSERT INTO Autorzy (Id_autora, Imiê, Nazwisko) VALUES (1, 'Stanis³aw', 'Lem');
INSERT INTO Autorzy (Id_autora, Imiê, Nazwisko) VALUES (2, 'Karol', 'Okrasa');
INSERT INTO Autorzy (Id_autora, Imiê, Nazwisko) VALUES (3, 'Henryk', 'Sienkiewicz');
INSERT INTO Autorzy (Id_autora, Imiê, Nazwisko) VALUES (4, 'Aleksander', 'Shvets');
INSERT INTO Autorzy (Id_autora, Imiê, Nazwisko) VALUES (5, 'Cathy', 'Tanimura');

--Ksi¹¿ki
INSERT INTO Ksi¹¿ki (ISBN, Wydawca, Tytu³, Rok) VALUES ('9780151621385', 'Wydawnictwo Literackie', 'Opowieœci o pilocie Pirxie', 2022);
INSERT INTO Ksi¹¿ki (ISBN, Wydawca, Tytu³, Rok) VALUES ('8374771194', 'Edipresse Ksi¹¿ki', 'Gotuj z Okras¹', 2006);
INSERT INTO Ksi¹¿ki (ISBN, Wydawca, Tytu³, Rok) VALUES ('9788373272255', 'Wydawnictwo GREG', 'Potop', 2006);
INSERT INTO Ksi¹¿ki (ISBN, Wydawca, Tytu³, Rok) VALUES ('90088545211', 'Refactoring.Guru', 'Design patterns', 2022);
INSERT INTO Ksi¹¿ki (ISBN, Wydawca, Tytu³, Rok) VALUES ('9781492088783', 'O Reilly Media', 'SQL for data analysis', 2021);

--Tematy
INSERT INTO Tematy (Nrtematu, Nazwa, Wyjaœnienie) VALUES (1, 'sf', 'tematy science-fiction');
INSERT INTO Tematy (Nrtematu, Nazwa, Wyjaœnienie) VALUES (2, 'gotowanie', 'tematy o gotowaniu');
INSERT INTO Tematy (Nrtematu, Nazwa, Wyjaœnienie) VALUES (3, 'powieœæ historyczna', 'fikcja historyczna');
INSERT INTO Tematy (Nrtematu, Nazwa, Wyjaœnienie) VALUES (4, 'programowanie', 'ksi¹¿ki o programowaniu');
INSERT INTO Tematy (Nrtematu, Nazwa, Wyjaœnienie) VALUES (5, 'bazy danych', 'SQL i bazy danych');

--Autorstwa
INSERT INTO Autorstwa (ISBN, Id_autora) VALUES ('9780151621385', 1);
INSERT INTO Autorstwa (ISBN, Id_autora) VALUES ('8374771194', 2);
INSERT INTO Autorstwa (ISBN, Id_autora) VALUES ('9788373272255', 3);
INSERT INTO Autorstwa (ISBN, Id_autora) VALUES ('90088545211', 4);
INSERT INTO Autorstwa (ISBN, Id_autora) VALUES ('9781492088783', 5);

--Na_tematy
INSERT INTO Na_tematy (ISBN, Nrtematu) VALUES ('9780151621385', 1);
INSERT INTO Na_tematy (ISBN, Nrtematu) VALUES ('8374771194', 2);
INSERT INTO Na_tematy (ISBN, Nrtematu) VALUES ('9788373272255', 3);
INSERT INTO Na_tematy (ISBN, Nrtematu) VALUES ('90088545211', 4);
INSERT INTO Na_tematy (ISBN, Nrtematu) VALUES ('9781492088783', 5);

--2. Napisz zapytania:
 -- -wypisuj¹ce nazwiska autorów, którzy napisali przynajmniej jedn¹ ksi¹¿kê na temat baz danych;
SELECT Autorzy.Nazwisko
FROM Autorzy
JOIN Autorstwa ON Autorzy.Id_autora = Autorstwa.Id_autora
JOIN Ksi¹¿ki ON Autorstwa.ISBN = Ksi¹¿ki.ISBN
JOIN Na_tematy ON Ksi¹¿ki.ISBN = Na_tematy.ISBN
JOIN Tematy ON Na_tematy.Nrtematu = Tematy.Nrtematu
WHERE Tematy.Nazwa = 'bazy danych';

 -- -znajduj¹ce imiê i nazwisko autora, który napisa³ najwiêcej ksi¹¿ek na temat baz danych.
SELECT Autorzy.Imiê, Autorzy.Nazwisko, COUNT(*) AS "Liczba ksi¹¿ek"
FROM Autorzy
JOIN Autorstwa ON Autorzy.Id_autora = Autorstwa.Id_autora
JOIN Ksi¹¿ki ON Autorstwa.ISBN = Ksi¹¿ki.ISBN
JOIN Na_tematy ON Ksi¹¿ki.ISBN = Na_tematy.ISBN
JOIN Tematy ON Na_tematy.Nrtematu = Tematy.Nrtematu
WHERE Tematy.Nazwa = 'bazy danych'
GROUP BY Autorzy.Imiê, Autorzy.Nazwisko
ORDER BY 3 DESC;

--3. Biblioteka kupuje now¹ ksi¹¿kê. Napisz instrukcje SQL, które uaktualniaj¹ stan bazy danych w odniesieniu do tabel AUTORZY, AUTORSTWA i KSIA¯KI.
INSERT INTO Autorzy (Id_autora, Imiê, Nazwisko)
VALUES (6, 'Andrzej', 'Sapkowski');
INSERT INTO Ksi¹¿ki (ISBN, Wydawca, Tytu³, Rok)
VALUES ('9788375780642', 'SuperNova', 'WiedŸmin: miecz przeznaczenia', 2014);
INSERT INTO Autorstwa (ISBN, Id_autora)
VALUES ('9788375780642', 6);

--Zad 8 
--8. Baza danych ma nastêpuj¹cy schemat:
--Nauczyciele(Num_naucz, Nazwisko, Adres, Id_przedm)
--Przedmioty(Id_przedm, Opis)
--Rozk³ad(Dzieñ, Godz, Id_klasy, Id_przedm, Num_naucz)
--Klasy(Id_klasy, Sala, Num_wychowawcy)
--Uczniowie(Num_ucznia, Nazwisko, Id_klasy)
--Stopnie(Num_ucznia, Id_przedm, Ocena)

CREATE TABLE Nauczyciele (
    Num_naucz INT PRIMARY KEY,
    Nazwisko VARCHAR(50),
    Adres VARCHAR(100),
    Id_przedm INT
);

CREATE TABLE Przedmioty (
    Id_przedm INT PRIMARY KEY,
    Opis VARCHAR(100)
);

CREATE TABLE Klasy (
    Id_klasy INT PRIMARY KEY,
    Sala VARCHAR(50),
    Num_wychowawcy INT
);

CREATE TABLE Uczniowie (
    Num_ucznia INT PRIMARY KEY,
    Nazwisko VARCHAR(50),
    Id_klasy INT,
    FOREIGN KEY (Id_klasy) REFERENCES Klasy(Id_klasy)
);

CREATE TABLE Stopnie (
    Num_ucznia INT,
    Id_przedm INT,
    Ocena INT,
    FOREIGN KEY (Num_ucznia) REFERENCES Uczniowie(Num_ucznia),
    FOREIGN KEY (Id_przedm) REFERENCES Przedmioty(Id_przedm),
    PRIMARY KEY (Num_ucznia, Id_przedm)
);

CREATE TABLE Rozk³ad (
    Dzieñ VARCHAR(20),
    Godz VARCHAR(20),
    Id_klasy INT,
    Id_przedm INT,
    Num_naucz INT,
    FOREIGN KEY (Id_klasy) REFERENCES Klasy(Id_klasy),
    FOREIGN KEY (Id_przedm) REFERENCES Przedmioty(Id_przedm),
    FOREIGN KEY (Num_naucz) REFERENCES Nauczyciele(Num_naucz)
);
------------------------------
--zape³niamy bazê danych------
------------------------------
INSERT INTO Nauczyciele (Num_naucz, Nazwisko, Adres, Id_przedm) VALUES (1, 'Chmielewski', 'ul. Browarna 12/4', 1);
INSERT INTO Nauczyciele (Num_naucz, Nazwisko, Adres, Id_przedm) VALUES (2, 'Wiœniewska', 'ul. Czereœniowa 3a', 2);
INSERT INTO Nauczyciele (Num_naucz, Nazwisko, Adres, Id_przedm) VALUES (3, 'Cybulska', 'ul. Filmowa 1/2', 3);

INSERT INTO Przedmioty (Id_przedm, Opis) VALUES (1, 'Jêzyk polski');
INSERT INTO Przedmioty (Id_przedm, Opis) VALUES (2, 'Matematyka');
INSERT INTO Przedmioty (Id_przedm, Opis) VALUES (3, 'Jêzyk angielski');

INSERT INTO Klasy (Id_klasy, Sala, Num_wychowawcy) VALUES (1, '21', 1);
INSERT INTO Klasy (Id_klasy, Sala, Num_wychowawcy) VALUES (2, '22', 2);
INSERT INTO Klasy (Id_klasy, Sala, Num_wychowawcy) VALUES (3, '23', 3);

INSERT INTO Uczniowie (Num_ucznia, Nazwisko, Id_klasy) VALUES (1, 'Barañska', 1);
INSERT INTO Uczniowie (Num_ucznia, Nazwisko, Id_klasy) VALUES (2, 'Or³owski', 1);
INSERT INTO Uczniowie (Num_ucznia, Nazwisko, Id_klasy) VALUES (3, 'Kot', 1);
INSERT INTO Uczniowie (Num_ucznia, Nazwisko, Id_klasy) VALUES (4, 'Wróblewska', 2);
INSERT INTO Uczniowie (Num_ucznia, Nazwisko, Id_klasy) VALUES (5, 'Karaœ', 2);
INSERT INTO Uczniowie (Num_ucznia, Nazwisko, Id_klasy) VALUES (6, 'Okoñ', 2);
INSERT INTO Uczniowie (Num_ucznia, Nazwisko, Id_klasy) VALUES (7, 'Lisowski', 3);
INSERT INTO Uczniowie (Num_ucznia, Nazwisko, Id_klasy) VALUES (8, 'Ryœ', 3);
INSERT INTO Uczniowie (Num_ucznia, Nazwisko, Id_klasy) VALUES (9, 'Czajka', 3);
INSERT INTO Uczniowie (Num_ucznia, Nazwisko, Id_klasy) VALUES (10, 'Czapla', 3);

INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (1, 1, 3);
INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (2, 1, 4);
INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (3, 2, 3);
INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (3, 1, 5);
INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (3, 3, 2);
INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (3, 1, 2);
INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (4, 3, 4);
INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (4, 1, 5);
INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (5, 2, 3);
INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (5, 1, 4);
INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (6, 3, 4);
INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (7, 1, 4);
INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (7, 1, 5);
INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (8, 2, 5);
INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (9, 1, 5);
INSERT INTO Stopnie (Num_ucznia, Id_przedm, Ocena) VALUES (10, 1, 4);

INSERT INTO Rozk³ad (Dzieñ, Godz, Id_klasy, Id_przedm, Num_naucz) VALUES ('Poniedzia³ek', '08:00', 1, 1, 1);
INSERT INTO Rozk³ad (Dzieñ, Godz, Id_klasy, Id_przedm, Num_naucz) VALUES ('Poniedzia³ek', '08:55', 1, 2, 2);
INSERT INTO Rozk³ad (Dzieñ, Godz, Id_klasy, Id_przedm, Num_naucz) VALUES ('Poniedzia³ek', '08:00', 2, 3, 3);
INSERT INTO Rozk³ad (Dzieñ, Godz, Id_klasy, Id_przedm, Num_naucz) VALUES ('Wtorek', '08:00', 3, 1, 1);
INSERT INTO Rozk³ad (Dzieñ, Godz, Id_klasy, Id_przedm, Num_naucz) VALUES ('Wtorek', '10:00', 1, 3, 3);
INSERT INTO Rozk³ad (Dzieñ, Godz, Id_klasy, Id_przedm, Num_naucz) VALUES ('Œroda', '08:00', 2, 3, 3);
INSERT INTO Rozk³ad (Dzieñ, Godz, Id_klasy, Id_przedm, Num_naucz) VALUES ('Œroda', '08:55', 1, 1, 1);
INSERT INTO Rozk³ad (Dzieñ, Godz, Id_klasy, Id_przedm, Num_naucz) VALUES ('Czwartek', '12:00', 2, 2, 2);
INSERT INTO Rozk³ad (Dzieñ, Godz, Id_klasy, Id_przedm, Num_naucz) VALUES ('Czwartek', '13:30', 3, 2, 2);
INSERT INTO Rozk³ad (Dzieñ, Godz, Id_klasy, Id_przedm, Num_naucz) VALUES ('Pi¹tek', '8:55', 1, 1, 1);

--U³ó¿ zapytania:

--1.Dla ucznia Józia wypisz jego nauczycieli.
SELECT DISTINCT Nauczyciele.Nazwisko
FROM Nauczyciele
JOIN Rozk³ad ON Nauczyciele.Num_naucz = Rozk³ad.Num_naucz
JOIN Klasy ON Rozk³ad.Id_klasy = Klasy.Id_klasy
JOIN Uczniowie ON Uczniowie.Id_klasy = Klasy.Id_klasy
WHERE Uczniowie.Nazwisko = 'Karaœ';

--2.Dla ka¿dego nauczyciela oblicz ile ma godzin zajêæ tygodniowo.
SELECT Nauczyciele.Nazwisko, COUNT(*) AS "godzin tygodniowo" 
FROM Nauczyciele
JOIN Rozk³ad ON Nauczyciele.Num_naucz = Rozk³ad.Num_naucz
GROUP BY Nauczyciele.Nazwisko; 

--3.ZnajdŸ najlepszego ucznia w szkole.
SELECT Uczniowie.Nazwisko, AVG(Stopnie.Ocena) AS "Œrednia ocen"
FROM Uczniowie
JOIN Stopnie ON Stopnie.Num_ucznia = Uczniowie.Num_ucznia
GROUP BY Uczniowie.Nazwisko, Uczniowie.Id_klasy, Uczniowie.Num_ucznia
ORDER BY AVG(Stopnie.Ocena) DESC
FETCH FIRST 1 ROWS ONLY;

--4.Wypisz uczniów, których œrednia ocen jest wy¿sza od œredniej ocen w szkole.
SELECT srednie.Nazwisko, srednie.srednia
FROM (
    SELECT Uczniowie.Nazwisko, AVG(Stopnie.Ocena) srednia
    FROM Uczniowie
    JOIN Stopnie ON Stopnie.Num_ucznia = Uczniowie.Num_ucznia
    GROUP BY Uczniowie.Nazwisko) srednie
WHERE srednie.srednia > (
    SELECT AVG(Stopnie.Ocena)
    FROM Stopnie);

--5.ZnajdŸ klasê, w której œrednia ocen jest najwy¿sza w szkole.
SELECT Uczniowie.Id_klasy, AVG(Stopnie.Ocena) AS "Œrednia ocen"
FROM Uczniowie
JOIN Stopnie ON Stopnie.Num_ucznia = Uczniowie.Num_ucznia
JOIN Klasy ON Uczniowie.Id_klasy = Klasy.Id_klasy
GROUP BY Uczniowie.Id_klasy
ORDER BY AVG(Stopnie.Ocena) DESC
FETCH FIRST 1 ROWS ONLY;

--6.SprawdŸ, czy ka¿dy nauczyciel o ka¿dej godzinie ma zaplanowane co najwy¿ej jedno zajêcie.
SELECT Dzieñ, Godz, COUNT(*) AS "liczba lekcji" 
FROM Rozk³ad
GROUP BY Dzieñ, Godz
HAVING COUNT(*) > 1;

--7.SprawdŸ, czy w szkole s¹ nauczyciele, którzy ucz¹ w ka¿dej klasie.
SELECT Nauczyciele.Nazwisko, COUNT(DISTINCT Rozk³ad.Id_klasy) "liczba klas, w których uczy"
FROM Nauczyciele
JOIN Rozk³ad ON Nauczyciele.Num_naucz = Rozk³ad.Num_naucz
GROUP BY Nauczyciele.Nazwisko
HAVING COUNT(DISTINCT Rozk³ad.Id_klasy) = (SELECT COUNT(Klasy.Id_Klasy) FROM Klasy);

--8.Przygotuj tygodniowy plan lekcji dla Józia.
SELECT Klasy.Sala, Rozk³ad.Dzieñ, Rozk³ad.Godz, Przedmioty.Opis AS "Przedmiot", Nauczyciele.Nazwisko AS "Nauczyciel"  
FROM Uczniowie
JOIN Klasy ON Uczniowie.Id_klasy = Klasy.Id_klasy
JOIN Rozk³ad ON Rozk³ad.Id_klasy = Klasy.Id_klasy
JOIN Przedmioty ON Rozk³ad.Id_przedm = Przedmioty.Id_przedm
JOIN Nauczyciele ON Rozk³ad.Num_naucz = Nauczyciele.Num_naucz
WHERE Uczniowie.Nazwisko = 'Karaœ';



















