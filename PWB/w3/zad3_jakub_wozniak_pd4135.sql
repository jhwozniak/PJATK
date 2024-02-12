--PWB 
--Zadania do wyk³adu 3
--Student: Jakub WoŸniak
--Nr indeksu: pd4135

--Zad 1. U³ó¿ zapytania do przyk³adowej bazy danych zdefiniowanej na wyk³adzie 1.

--Zestaw 2

--1. Wybierz dane o pracownikach zatrudnionych na stanowisku MANAGER w DALLAS lub BOSTON. Uporz¹dkuj wed³ug malej¹cych zarobków.

SELECT *
FROM Emp INNER JOIN Dept ON Emp.Deptno = Dept.Deptno
WHERE (Dept.Loc = 'DALLAS' OR Dept.Loc = 'BOSTON') AND Emp.Job = 'MANAGER'
ORDER BY Emp.Sal DESC;

--2. Wypisz nazwiska i miejsca pracy osób, których zarobki znajduj¹ siê w trzeciej klasie zaszeregowania. Uporz¹dkuj wed³ug nazwy --dzia³u.

SELECT Emp.Ename, Dept.Loc
FROM Emp, Dept
WHERE (Emp.Deptno = Dept.Deptno) AND Emp.Empno IN (
    SELECT Emp.Empno
    FROM Emp, Salgrade
    WHERE (Emp.Sal BETWEEN Salgrade.Losal AND Salgrade.Hisal) AND Salgrade.Grade = '3')
ORDER BY Dept.Dname;

--3. Wybierz nazwiska pracowników, których zarobki s¹ w tej samej klasie zaszeregowania co zarobki ich kierowników. Obok nazwiska --pracownika zamieœæ nazwisko jego kierownika i klasê zaszeregowania zarobków tego kierownika.

SELECT Prac.Ename, Kier.Ename AS Mgr, Salgrade.Grade
FROM Emp Prac, Emp Kier, Salgrade
WHERE (Prac.Mgr = Kier.Empno) AND (Kier.Sal BETWEEN Salgrade.Losal AND Salgrade.Hisal)
AND (Salgrade.Grade = (
    SELECT Salgrade.Grade
    FROM Salgrade
    WHERE Prac.Sal BETWEEN Salgrade.Losal AND Salgrade.Hisal));

--4. Wyznacz stanowiska (bez powtórzeñ), na których nikt nie dosta³ prowizji. Uporz¹dkuj wyniki wed³ug liczby liter w stanowisku.

SELECT DISTINCT Emp.Job, Emp.Comm
FROM Emp
WHERE Emp.Comm IS NULL OR Emp.Comm ='0'
ORDER BY LENGTH(Emp.Job);

--5. Ustaw w pary pracowników, którzy maj¹ tego samego kierownika. Nazwiska w parze powinny byæ ró¿ne i pary nie powinny siê --powtarzaæ.

SELECT DISTINCT e.Ename, m.Ename
FROM Emp e, Emp m
WHERE e.Mgr = m.Mgr AND e.Ename <> m.Ename;


--Zad 2. U³ó¿ zapytania do przyk³adowej bazy danych zdefiniowanej na wyk³adzie 2 w zadaniu 3.

--1. Wypisz numery indeksów, nazwiska studentów razem z nazw¹ kursu na który zostali zarejestrowani.

SELECT Studenci.NrIndeksu, Studenci.Nazwisko, Kursy.Nazwa
FROM Studenci 
INNER JOIN Rejestracje ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
INNER JOIN Kursy ON Rejestracje.IdKursu = Kursy.IdKursu;

--2. Wypisz nazwiska wyk³adowców razem z nazw¹ kursu, który wyk³adaj¹.

SELECT Wykladowcy.Nazwisko, Kursy.Nazwa
FROM Kursy
INNER JOIN Wykladowcy ON Kursy.IdWykladowcy = Wykladowcy.IdWykladowcy;

--3. Wypisz numery indeksów i nazwiska studentów, którzy zapisali siê na kurs prowadzony przez wyk³adowcê o  nazwisku 'KOWALSKI'.

SELECT Studenci.NrIndeksu, Studenci.Nazwisko
FROM Studenci 
INNER JOIN Rejestracje ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
INNER JOIN Kursy ON Rejestracje.IdKursu = Kursy.IdKursu
INNER JOIN Wykladowcy ON Kursy.IdWykladowcy = Wykladowcy.IdWykladowcy
WHERE Wykladowcy.Nazwisko LIKE 'Kowalski%';

--4. Wypisz numery indeksów i nazwiska studentów, którzy nie zapisali siê na ¿aden kurs.

SELECT Studenci.NrIndeksu, Studenci.Nazwisko, Kursy.Nazwa
FROM Studenci 
FULL JOIN Rejestracje ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
FULL JOIN Kursy ON Rejestracje.IdKursu = Kursy.IdKursu
WHERE Kursy.Nazwa IS NULL;

--5. Wypisz identyfikatory i nazwiska wyk³adowców, którzy nie prowadz¹ ¿adnego kursu.

SELECT Wykladowcy.IdWykladowcy, Wykladowcy.Nazwisko
FROM Kursy
RIGHT JOIN Wykladowcy ON Kursy.IdWykladowcy = Wykladowcy.IdWykladowcy
WHERE Kursy.Nazwa IS NULL;


