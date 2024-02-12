--PWB 
--Zadania do wyk�adu 8
--Student: Jakub Wo�niak
--Nr indeksu: pd4135
--Zadania:

--1. Opracuj schemat bazy danych dla przyk�adu 8.1, utw�rz j�, wprowad� przyk�adowe dane i wykonaj blok PL/SQL zawarty w tek�cie.
CREATE TABLE Magazyn 
    (        
        Produkt VARCHAR2(30),
        Stan NUMBER(5)   
    );
    
CREATE TABLE Zakupy
    (
        Opis VARCHAR2(50),
        Data_zakupu DATE
    );

CREATE TABLE dziennik_b��d�w
    (
        Opis VARCHAR2(50)
    );

INSERT INTO Magazyn (Produkt, Stan) VALUES ('Fiat', 10); 
INSERT INTO Magazyn (Produkt, Stan) VALUES ('Opel', 15);
INSERT INTO Magazyn (Produkt, Stan) VALUES ('Alfa romeo', 5);
INSERT INTO Magazyn (Produkt, Stan) VALUES ('Syrena', 20);
INSERT INTO Magazyn (Produkt, Stan) VALUES ('Polonez', 35);

DECLARE
  ilo�� NUMBER(5);
BEGIN
  SELECT m.Stan INTO ilo�� FROM Magazyn m
  WHERE m.Produkt = 'Fiat';  
  IF ilo��> 0 THEN
    UPDATE Magazyn SET Stan = Stan - 1
    WHERE Produkt = 'Fiat';
    INSERT INTO Zakupy
    VALUES ('Kupiono Fiata', Sysdate);
  ELSE
    INSERT INTO Zakupy
    VALUES ('Brak Fiat�w', Sysdate);
  END IF;
  COMMIT;
EXCEPTION 
WHEN no_data_found THEN
   INSERT INTO dziennik_b��d�w
   VALUES ('Nie znaleziono produktu FIAT');
END;
/
--Komentarz: stan magazynu zmniejszy� si� o jednego Fiata. Tabela zakup�w powi�kszy�a si� o jeden wiersz z opisem zakupu i dat�. 
--Stany magazynowe by�by dodatnie, wi�c nie odnotowano wyj�tk�w.

--2. Wykonaj na komputerze wszystkie skrypty znajduj�ce w sekcji 8.1 po przyk�adzie 8.1.
SET SERVEROUTPUT ON
ACCEPT rocz_zarob PROMPT 'Podaj roczne zarobki: '
DECLARE
mies NUMBER(9,2) := &rocz_zarob;
BEGIN
  mies := mies/12;
  DBMS_OUTPUT.PUT_LINE ('Miesi�czne zarobki = ' ||mies);
END;
/
--Komentarz: skrypt pobiera od u�ytkownika (zmienna podstawienia) roczny poziom zarobk�w i wy�wietla na ekranie zarobki miesi�czne 

ACCEPT rocz_zarob PROMPT 'Podaj roczne zarobki: '
VARIABLE mies NUMBER
BEGIN
  :mies := &rocz_zarob/12;
END;
/
PRINT Mies
--Komentarz: skrypt pobiera od u�ytkownika (zmienna wi�zania) roczny poziom zarobk�w i wy�wietla na ekranie zarobki miesi�czne 

DECLARE usuni�te NUMBER;
BEGIN
  DELETE FROM Dept WHERE Deptno = 50;
  usuni�te := SQL%ROWCOUNT;
  INSERT INTO dziennik VALUES ('Dzia�', usuni�te, Sysdate);
END;
/
--Komentarz: skrypt wykorzystuje zmienn� systemow� SQL%ROWCOUNT do obliczenia liczby usuwanych dzia��w o numerze 50.
--Opis dzia�ania zapisywany jest jako wiersz w tabeli Dziennik

--3. Utw�rz wymagan� w przyk�adzie 8.2 tabel� Dziennik i wykonaj zawarty w nim blok.

CREATE TABLE Dziennik 
    (
        Nazwisko VARCHAR2(10 BYTE),
        Stanowisko VARCHAR2(9 BYTE),
        Pensja NUMBER(7,2),
        Data_zatrudnienia DATE
    );

DECLARE
  rek_osob Emp%ROWTYPE; 
BEGIN
  SELECT * INTO rek_osob FROM Emp e WHERE e.Ename = 'SCOTT';
  rek_osob.Sal := 1.1*rek_osob.Sal;
  INSERT INTO Dziennik VALUES (rek_osob.Ename, rek_osob.Job, rek_osob.Sal, SYSDATE);
COMMIT;
END;
/
--Komentarz: skrypt wykorzystuje zmienn� wierszow� rek_osob, przypisuj�c na ni� warto�ci znalezione we wszystkich kolumnach
--tabeli Emp dla pracownika o nazwisku 'SCOTT'. Wynik jest zapisany w tabeli Dziennik z dok�adnym wyspecyfikowaniem, 
--warto�ci kt�rych kolumn spod zmiennej wierszowej stosujemy (tutaj: nazwisko, stanowisko, pensja)

--4. Utw�rz wymagan� w przyk�adzie w sekcji 8.3 tabel� Dziennik1 i wykonaj blok PL/SQL.
CREATE TABLE Dziennik1
    (
        opis VARCHAR2(100)
    );

SET SERVEROUTPUT ON
DECLARE
  vEname Emp.Ename%TYPE;
  vJob Emp.Job%TYPE;
  komunikat VARCHAR2(100);
BEGIN
  SELECT e.Ename, e.Job
  INTO vEname, vJob
  FROM Emp e
  WHERE e.Hiredate BETWEEN to_date('93/01/01', 'yy/mm/dd') AND to_date('93/12/31', 'yy/mm/dd');
EXCEPTION
WHEN no_data_found THEN
  INSERT INTO Dziennik1 
  VALUES ('0 zatrudnionych w 93');
  DBMS_OUTPUT.Put_line('0 zatrudnionych w 93');
WHEN too_many_rows THEN
  INSERT INTO Dziennik1 VALUES ('Wi�cej ni� 1 w 93');
  DBMS_OUTPUT.Put_line('Wi�cej ni� 1 w 93');
WHEN OTHERS THEN -- Obs�uga pozosta�ych b��d�w
  komunikat := 'B��d nr.= ' || SQLCODE|| ',komunikat= ' || Substr(SQLERRM,1,100);
   -- SQLCODE i SQLERRM nie mog� wyst�pi� w instrukcji SQL!
  INSERT INTO Dziennik1 VALUES (komunikat);
  DBMS_OUTPUT.Put_line('Wyst�pi� inny b��d');
END;
/
--Komentarz: skrypt pobiera do zmiennych vEname i vJob wynik zapytania o pracownik�w zatrudnionych w 1993 r. Obs�uga b��d�w polega 
--na wy�wietleniu stosownych komunikat�w w 3 przypadkach: 1) je�li zapytanie nie zwr�ci�o �adnego wyniku, 
--2) je�li zwr�ci�o wi�cej ni� jeden wynik, 3) w innych przykadkach - wtedy za pomoc� zmiennej systemowej SQLCODE podajemy kod b��du i wynik zapisujemy w tabeli Dziennik1.

--5. Napisz blok PL/SQL, w kt�rym u�ytkownik zaktualizuje pensj� wybranego pracownika w tabeli Emp. 
--Numer pracownika, kt�rego pensja ma by� zaktualizowana oraz warto�� pensji maj� by� wprowadzane na bie��co. Zadabaj o to, aby numer pracownika by� numerem istniej�cym w tabeli Emp, za� pensja by�a wi�ksza od 500.
ACCEPT nrPracownika PROMPT 'Podaj numer pracownika w formacie XXXX: '
ACCEPT nowaPensja PROMPT 'Podaj poziom nowej pensji: '
DECLARE
  rek_osob Emp%ROWTYPE; 
BEGIN
  SELECT * INTO rek_osob FROM Emp e WHERE e.Empno = &nrPracownika;
  rek_osob.Sal := &nowaPensja;
  UPDATE Emp SET Sal = rek_osob.Sal WHERE Emp.Empno = &nrPracownika;
  COMMIT;
END;
/

--6. Wykonaj na komputerze przyk�ad 8.3 (dotycz�cy podwy�szenia zarobk�w o 10% najmniej zarabiaj�cym pracownikom oraz zmniejszenia zarobk�w o 10% najwi�cej zarabiaj�cym pracownikom). Sprawd� efekt w tabeli Emp.
DECLARE
  CURSOR kursor_osoba IS
    SELECT e.Ename, e.Sal FROM Emp e
    FOR UPDATE OF e.Sal;
  rek_osoby kursor_osoba%ROWTYPE;
BEGIN
  OPEN kursor_osoba;
  LOOP
    FETCH kursor_osoba INTO rek_osoby;
    EXIT WHEN kursor_osoba%NOTFOUND;
    IF rek_osoby.Sal < 10000 THEN
      UPDATE Emp SET Sal = Sal * 1.1
      WHERE CURRENT OF kursor_osoba;
    ELSIF rek_osoby.Sal > 100000 THEN
      UPDATE Emp SET Sal = Sal * 0.9
      WHERE CURRENT OF kursor_osoba;
    END IF;    
  END LOOP;
  CLOSE kursor_osoba;
  COMMIT;
END;
/
--Komentarz: skrypt podnosi pensje o 10% rocznie pracownikom zarabiaj�ym poni�ej 10000 i obni�a o 10% rocznie pracownikom zarabiaj�m powy�ej 10000. 
--Skrypt wykorzystuje kursor do przegladania wierszy z zapytania SELECT o zbi�r nazwisk pracownik�w i ich pensji. 
--Jednocze�nie, skrypt korzysta z blokowania wierszy sprowadzanych z bazy danych przez kursor (FOR UPDATE OF) 
--i odblokowuje do modyfikacji (WHERE CURRENT OF). 

--7. Utw�rz tabel� Emps_in_Depts (Deptno NUMBER(2), Pracownicy VARCHAR2(4000)).
--Napisz blok PL/SQL, w kt�rym do tabeli Emps_in_Depts s� wprowadzone wiersze postaci (deptno,ename1$ename2$....enamek$), 
--gdzie ename1,ename2,...,enamek s� wszystkimi pracownikami zatrudnionymi w dziale o numerze deptno np. (10,CLARK$KING$MILLER$).
CREATE TABLE Emps_in_Depts
    (
        Deptno NUMBER (2,0),
        Pracownicy VARCHAR2(4000)        
    );

DECLARE      
    vEname VARCHAR2(4000);
    numer NUMBER(2,0);
    
    --Kursor nr 1 do przegl�dania nr dzia��w
    CURSOR kursor_dzial IS
        SELECT DISTINCT Deptno FROM Emp;
    
    --Kursor nr 2 do przegl�dania nazwisk
    CURSOR kursor_osoba IS
        SELECT * FROM Emp WHERE Emp.Deptno = numer;
    
    nr_dzialu kursor_dzial%ROWTYPE;    
    rek_osoby kursor_osoba%ROWTYPE;
    
BEGIN
    OPEN kursor_dzial;
    LOOP
        FETCH kursor_dzial INTO nr_dzialu;
        EXIT WHEN kursor_dzial%NOTFOUND;
        numer := nr_dzialu.Deptno;        
        OPEN kursor_osoba;
        
        LOOP
            FETCH kursor_osoba INTO rek_osoby;
            EXIT WHEN kursor_osoba%NOTFOUND;            
            vEname := vEname || '$' || rek_osoby.Ename;
        END LOOP;        
        INSERT INTO Emps_in_depts (Deptno, Pracownicy) VALUES (numer, vEname);
        vEname := '';
        CLOSE kursor_osoba;  
    END LOOP;
    CLOSE kursor_dzial;
END;
/

--8. U�ywaj�c dynamicznego SQL utw�rz now� tabel� a nast�pnie j� usu�.

--procedura 1 - tworzymy tabel�
BEGIN
   EXECUTE IMMEDIATE 'CREATE TABLE Wycieczka (Id NUMBER, Destination VARCHAR2(50))';
END;

--procedura 2 - usuwamy tabel�
DECLARE 
    sql_stmt VARCHAR2(100);       
BEGIN
   sql_stmt := 'DROP TABLE Wycieczka';
   EXECUTE IMMEDIATE sql_stmt;
END;
   








