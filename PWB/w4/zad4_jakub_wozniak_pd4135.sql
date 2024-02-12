--PWB 
--Zadania do wyk�adu 4
--Student: Jakub Wo�niak
--Nr indeksu: pd4135

--1. Dla bazy danych z wyk�adu 1.

--Zestaw 1

--1. Dla ka�dego dzia�u wyznacz nazwisko pracownika pojawiaj�ce si� jako pierwsze w porz�dku alfabetycznym.

SELECT Emp.Deptno, MIN(Emp.Ename)
FROM Emp
GROUP BY Emp.Deptno;

--2. Dla ka�dego stanowiska, podaj ilu pracownik�w pracuje na tym stanowisku i jakie s� ich �rednie zarobki.

SELECT Emp.Job, COUNT(*) AS Liczba_pracownik�w, AVG(Emp.Sal)
FROM Emp
GROUP BY Emp.Job;

--3. Dla ka�dego stanowiska, podaj w ilu dzia�ach pracuj� pracownicy na tym stanowisku.

SELECT Emp.Job, COUNT(DISTINCT Emp.Deptno)
FROM Emp
GROUP BY Emp.Job;

--4. Wybierz kierownik�w (pracownik�w pracuj�cych na stanowisku MANAGER), kt�rzy maj� dok�adnie dw�ch podw�adnych.

SELECT m.Ename, COUNT(*) AS Podw�adni 
FROM Emp e, Emp m
WHERE e.Mgr = m.Empno AND m.Job = 'MANAGER'
GROUP BY m.Ename
HAVING COUNT(*) = 2;

--5. Dla ka�dego pracownika, wyznacz �redni� warto�� zarobk�w tych pracownik�w, kt�rych zarobki s� co najwy�ej 100z� mniejsze lub 100z� wi�ksze od zarobk�w tego pracownika i kt�rzy pracuj� --w tym samym departamencie.

SELECT e.Ename,
AVG(e.Sal) OVER (PARTITION BY e.Deptno ORDER BY e.Sal RANGE BETWEEN 100 PRECEDING AND 100 FOLLOWING)  AS "�rednia +/-100"
FROM Emp e;



--2. Dla bazy danych z zadania 3 w wyk�adzie 2 u�� zapytania:

--1. Dla ka�dego studenta oblicz w ilu kursach jest zarejestrowany.

SELECT Studenci.Nazwisko, COUNT(*) AS "Liczba kurs�w"
FROM Studenci 
INNER JOIN Rejestracje ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
INNER JOIN Kursy ON Rejestracje.IdKursu = Kursy.IdKursu
GROUP BY Studenci.Nazwisko;


--2. Dla ka�dego wyk�adowcy i dla ka�dego kursu prowadzonego przez tego wyk�adowc� oblicz liczb� student�w zapisanych na ten kurs.

SELECT Wykladowcy.Nazwisko, Kursy.Nazwa, COUNT(*) "Zapisanych student�w"
FROM Wykladowcy
INNER JOIN Kursy ON Kursy.IdWykladowcy = Wykladowcy.IdWykladowcy
INNER JOIN Rejestracje ON Rejestracje.IdKursu = Kursy.Idkursu
INNER JOIN Studenci ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
GROUP BY Wykladowcy.Nazwisko, Kursy.Nazwa;


--3. Wypisz kursy, na kt�re zapisa�o si� co najmniej 5 student�w.

SELECT Kursy.Nazwa, COUNT(*) "Zapisanych student�w"
FROM Wykladowcy
INNER JOIN Kursy ON Kursy.IdWykladowcy = Wykladowcy.IdWykladowcy
INNER JOIN Rejestracje ON Rejestracje.IdKursu = Kursy.Idkursu
INNER JOIN Studenci ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
GROUP BY Kursy.Nazwa
HAVING COUNT(*) >= 5;

--4. Wypisz student�w, kt�rzy zapisali si� na wi�cej ni� 2 kursy.

SELECT Studenci.Nazwisko, COUNT(*) AS "Liczba kurs�w"
FROM Studenci 
INNER JOIN Rejestracje ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
INNER JOIN Kursy ON Rejestracje.IdKursu = Kursy.IdKursu
GROUP BY Studenci.Nazwisko
HAVING COUNT(*) > 2;

--5. Na jak� najwi�ksz� liczb� kurs�w jest zapisany student.

SELECT Studenci.Nazwisko, COUNT(*) AS Liczba_kurs�w
FROM Studenci 
INNER JOIN Rejestracje ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
INNER JOIN Kursy ON Rejestracje.IdKursu = Kursy.IdKursu
GROUP BY Studenci.Nazwisko
ORDER BY 2 DESC
FETCH FIRST 1 ROWS ONLY;

