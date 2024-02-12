--PWB 
--Zadania do wyk³adu 4
--Student: Jakub WoŸniak
--Nr indeksu: pd4135

--1. Dla bazy danych z wyk³adu 1.

--Zestaw 1

--1. Dla ka¿dego dzia³u wyznacz nazwisko pracownika pojawiaj¹ce siê jako pierwsze w porz¹dku alfabetycznym.

SELECT Emp.Deptno, MIN(Emp.Ename)
FROM Emp
GROUP BY Emp.Deptno;

--2. Dla ka¿dego stanowiska, podaj ilu pracowników pracuje na tym stanowisku i jakie s¹ ich œrednie zarobki.

SELECT Emp.Job, COUNT(*) AS Liczba_pracowników, AVG(Emp.Sal)
FROM Emp
GROUP BY Emp.Job;

--3. Dla ka¿dego stanowiska, podaj w ilu dzia³ach pracuj¹ pracownicy na tym stanowisku.

SELECT Emp.Job, COUNT(DISTINCT Emp.Deptno)
FROM Emp
GROUP BY Emp.Job;

--4. Wybierz kierowników (pracowników pracuj¹cych na stanowisku MANAGER), którzy maj¹ dok³adnie dwóch podw³adnych.

SELECT m.Ename, COUNT(*) AS Podw³adni 
FROM Emp e, Emp m
WHERE e.Mgr = m.Empno AND m.Job = 'MANAGER'
GROUP BY m.Ename
HAVING COUNT(*) = 2;

--5. Dla ka¿dego pracownika, wyznacz œredni¹ wartoœæ zarobków tych pracowników, których zarobki s¹ co najwy¿ej 100z³ mniejsze lub 100z³ wiêksze od zarobków tego pracownika i którzy pracuj¹ --w tym samym departamencie.

SELECT e.Ename,
AVG(e.Sal) OVER (PARTITION BY e.Deptno ORDER BY e.Sal RANGE BETWEEN 100 PRECEDING AND 100 FOLLOWING)  AS "Œrednia +/-100"
FROM Emp e;



--2. Dla bazy danych z zadania 3 w wyk³adzie 2 u³ó¿ zapytania:

--1. Dla ka¿dego studenta oblicz w ilu kursach jest zarejestrowany.

SELECT Studenci.Nazwisko, COUNT(*) AS "Liczba kursów"
FROM Studenci 
INNER JOIN Rejestracje ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
INNER JOIN Kursy ON Rejestracje.IdKursu = Kursy.IdKursu
GROUP BY Studenci.Nazwisko;


--2. Dla ka¿dego wyk³adowcy i dla ka¿dego kursu prowadzonego przez tego wyk³adowcê oblicz liczbê studentów zapisanych na ten kurs.

SELECT Wykladowcy.Nazwisko, Kursy.Nazwa, COUNT(*) "Zapisanych studentów"
FROM Wykladowcy
INNER JOIN Kursy ON Kursy.IdWykladowcy = Wykladowcy.IdWykladowcy
INNER JOIN Rejestracje ON Rejestracje.IdKursu = Kursy.Idkursu
INNER JOIN Studenci ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
GROUP BY Wykladowcy.Nazwisko, Kursy.Nazwa;


--3. Wypisz kursy, na które zapisa³o siê co najmniej 5 studentów.

SELECT Kursy.Nazwa, COUNT(*) "Zapisanych studentów"
FROM Wykladowcy
INNER JOIN Kursy ON Kursy.IdWykladowcy = Wykladowcy.IdWykladowcy
INNER JOIN Rejestracje ON Rejestracje.IdKursu = Kursy.Idkursu
INNER JOIN Studenci ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
GROUP BY Kursy.Nazwa
HAVING COUNT(*) >= 5;

--4. Wypisz studentów, którzy zapisali siê na wiêcej ni¿ 2 kursy.

SELECT Studenci.Nazwisko, COUNT(*) AS "Liczba kursów"
FROM Studenci 
INNER JOIN Rejestracje ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
INNER JOIN Kursy ON Rejestracje.IdKursu = Kursy.IdKursu
GROUP BY Studenci.Nazwisko
HAVING COUNT(*) > 2;

--5. Na jak¹ najwiêksz¹ liczbê kursów jest zapisany student.

SELECT Studenci.Nazwisko, COUNT(*) AS Liczba_kursów
FROM Studenci 
INNER JOIN Rejestracje ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
INNER JOIN Kursy ON Rejestracje.IdKursu = Kursy.IdKursu
GROUP BY Studenci.Nazwisko
ORDER BY 2 DESC
FETCH FIRST 1 ROWS ONLY;

