--PWB 
--Zadania do wyk�adu 3
--Student: Jakub Wo�niak
--Nr indeksu: pd4135

--Zad 1. U�� zapytania do przyk�adowej bazy danych zdefiniowanej na wyk�adzie 1.

--Zestaw 2

--1. Wybierz dane o pracownikach zatrudnionych na stanowisku MANAGER w DALLAS lub BOSTON. Uporz�dkuj wed�ug malej�cych zarobk�w.

SELECT *
FROM Emp INNER JOIN Dept ON Emp.Deptno = Dept.Deptno
WHERE (Dept.Loc = 'DALLAS' OR Dept.Loc = 'BOSTON') AND Emp.Job = 'MANAGER'
ORDER BY Emp.Sal DESC;

--2. Wypisz nazwiska i miejsca pracy os�b, kt�rych zarobki znajduj� si� w trzeciej klasie zaszeregowania. Uporz�dkuj wed�ug nazwy --dzia�u.

SELECT Emp.Ename, Dept.Loc
FROM Emp, Dept
WHERE (Emp.Deptno = Dept.Deptno) AND Emp.Empno IN (
    SELECT Emp.Empno
    FROM Emp, Salgrade
    WHERE (Emp.Sal BETWEEN Salgrade.Losal AND Salgrade.Hisal) AND Salgrade.Grade = '3')
ORDER BY Dept.Dname;

--3. Wybierz nazwiska pracownik�w, kt�rych zarobki s� w tej samej klasie zaszeregowania co zarobki ich kierownik�w. Obok nazwiska --pracownika zamie�� nazwisko jego kierownika i klas� zaszeregowania zarobk�w tego kierownika.

SELECT Prac.Ename, Kier.Ename AS Mgr, Salgrade.Grade
FROM Emp Prac, Emp Kier, Salgrade
WHERE (Prac.Mgr = Kier.Empno) AND (Kier.Sal BETWEEN Salgrade.Losal AND Salgrade.Hisal)
AND (Salgrade.Grade = (
    SELECT Salgrade.Grade
    FROM Salgrade
    WHERE Prac.Sal BETWEEN Salgrade.Losal AND Salgrade.Hisal));

--4. Wyznacz stanowiska (bez powt�rze�), na kt�rych nikt nie dosta� prowizji. Uporz�dkuj wyniki wed�ug liczby liter w stanowisku.

SELECT DISTINCT Emp.Job, Emp.Comm
FROM Emp
WHERE Emp.Comm IS NULL OR Emp.Comm ='0'
ORDER BY LENGTH(Emp.Job);

--5. Ustaw w pary pracownik�w, kt�rzy maj� tego samego kierownika. Nazwiska w parze powinny by� r�ne i pary nie powinny si� --powtarza�.

SELECT DISTINCT e.Ename, m.Ename
FROM Emp e, Emp m
WHERE e.Mgr = m.Mgr AND e.Ename <> m.Ename;


--Zad 2. U�� zapytania do przyk�adowej bazy danych zdefiniowanej na wyk�adzie 2 w zadaniu 3.

--1. Wypisz numery indeks�w, nazwiska student�w razem z nazw� kursu na kt�ry zostali zarejestrowani.

SELECT Studenci.NrIndeksu, Studenci.Nazwisko, Kursy.Nazwa
FROM Studenci 
INNER JOIN Rejestracje ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
INNER JOIN Kursy ON Rejestracje.IdKursu = Kursy.IdKursu;

--2. Wypisz nazwiska wyk�adowc�w razem z nazw� kursu, kt�ry wyk�adaj�.

SELECT Wykladowcy.Nazwisko, Kursy.Nazwa
FROM Kursy
INNER JOIN Wykladowcy ON Kursy.IdWykladowcy = Wykladowcy.IdWykladowcy;

--3. Wypisz numery indeks�w i nazwiska student�w, kt�rzy zapisali si� na kurs prowadzony przez wyk�adowc� o  nazwisku 'KOWALSKI'.

SELECT Studenci.NrIndeksu, Studenci.Nazwisko
FROM Studenci 
INNER JOIN Rejestracje ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
INNER JOIN Kursy ON Rejestracje.IdKursu = Kursy.IdKursu
INNER JOIN Wykladowcy ON Kursy.IdWykladowcy = Wykladowcy.IdWykladowcy
WHERE Wykladowcy.Nazwisko LIKE 'Kowalski%';

--4. Wypisz numery indeks�w i nazwiska student�w, kt�rzy nie zapisali si� na �aden kurs.

SELECT Studenci.NrIndeksu, Studenci.Nazwisko, Kursy.Nazwa
FROM Studenci 
FULL JOIN Rejestracje ON Rejestracje.NrIndeksu = Studenci.NrIndeksu
FULL JOIN Kursy ON Rejestracje.IdKursu = Kursy.IdKursu
WHERE Kursy.Nazwa IS NULL;

--5. Wypisz identyfikatory i nazwiska wyk�adowc�w, kt�rzy nie prowadz� �adnego kursu.

SELECT Wykladowcy.IdWykladowcy, Wykladowcy.Nazwisko
FROM Kursy
RIGHT JOIN Wykladowcy ON Kursy.IdWykladowcy = Wykladowcy.IdWykladowcy
WHERE Kursy.Nazwa IS NULL;


