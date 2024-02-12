--PWB 
--Zadania do wyk³adu 8
--Student: Jakub WoŸniak
--Nr indeksu: pd4135
--Zadania:

--1. Opracuj schemat bazy danych dla przyk³adu 8.1, utwórz j¹, wprowadŸ przyk³adowe dane i wykonaj blok PL/SQL zawarty w tekœcie.
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

CREATE TABLE dziennik_b³êdów
    (
        Opis VARCHAR2(50)
    );

INSERT INTO Magazyn (Produkt, Stan) VALUES ('Fiat', 10); 
INSERT INTO Magazyn (Produkt, Stan) VALUES ('Opel', 15);
INSERT INTO Magazyn (Produkt, Stan) VALUES ('Alfa romeo', 5);
INSERT INTO Magazyn (Produkt, Stan) VALUES ('Syrena', 20);
INSERT INTO Magazyn (Produkt, Stan) VALUES ('Polonez', 35);

DECLARE
  iloœæ NUMBER(5);
BEGIN
  SELECT m.Stan INTO iloœæ FROM Magazyn m
  WHERE m.Produkt = 'Fiat';  
  IF iloœæ> 0 THEN
    UPDATE Magazyn SET Stan = Stan - 1
    WHERE Produkt = 'Fiat';
    INSERT INTO Zakupy
    VALUES ('Kupiono Fiata', Sysdate);
  ELSE
    INSERT INTO Zakupy
    VALUES ('Brak Fiatów', Sysdate);
  END IF;
  COMMIT;
EXCEPTION 
WHEN no_data_found THEN
   INSERT INTO dziennik_b³êdów
   VALUES ('Nie znaleziono produktu FIAT');
END;
/
--Komentarz: stan magazynu zmniejszy³ siê o jednego Fiata. Tabela zakupów powiêkszy³a siê o jeden wiersz z opisem zakupu i dat¹. 
--Stany magazynowe by³by dodatnie, wiêc nie odnotowano wyj¹tków.

--2. Wykonaj na komputerze wszystkie skrypty znajduj¹ce w sekcji 8.1 po przyk³adzie 8.1.
SET SERVEROUTPUT ON
ACCEPT rocz_zarob PROMPT 'Podaj roczne zarobki: '
DECLARE
mies NUMBER(9,2) := &rocz_zarob;
BEGIN
  mies := mies/12;
  DBMS_OUTPUT.PUT_LINE ('Miesiêczne zarobki = ' ||mies);
END;
/
--Komentarz: skrypt pobiera od u¿ytkownika (zmienna podstawienia) roczny poziom zarobków i wyœwietla na ekranie zarobki miesiêczne 

ACCEPT rocz_zarob PROMPT 'Podaj roczne zarobki: '
VARIABLE mies NUMBER
BEGIN
  :mies := &rocz_zarob/12;
END;
/
PRINT Mies
--Komentarz: skrypt pobiera od u¿ytkownika (zmienna wi¹zania) roczny poziom zarobków i wyœwietla na ekranie zarobki miesiêczne 

DECLARE usuniête NUMBER;
BEGIN
  DELETE FROM Dept WHERE Deptno = 50;
  usuniête := SQL%ROWCOUNT;
  INSERT INTO dziennik VALUES ('Dzia³', usuniête, Sysdate);
END;
/
--Komentarz: skrypt wykorzystuje zmienn¹ systemow¹ SQL%ROWCOUNT do obliczenia liczby usuwanych dzia³ów o numerze 50.
--Opis dzia³ania zapisywany jest jako wiersz w tabeli Dziennik

--3. Utwórz wymagan¹ w przyk³adzie 8.2 tabelê Dziennik i wykonaj zawarty w nim blok.

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
--Komentarz: skrypt wykorzystuje zmienn¹ wierszow¹ rek_osob, przypisuj¹c na ni¹ wartoœci znalezione we wszystkich kolumnach
--tabeli Emp dla pracownika o nazwisku 'SCOTT'. Wynik jest zapisany w tabeli Dziennik z dok³adnym wyspecyfikowaniem, 
--wartoœci których kolumn spod zmiennej wierszowej stosujemy (tutaj: nazwisko, stanowisko, pensja)

--4. Utwórz wymagan¹ w przyk³adzie w sekcji 8.3 tabelê Dziennik1 i wykonaj blok PL/SQL.
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
  INSERT INTO Dziennik1 VALUES ('Wiêcej ni¿ 1 w 93');
  DBMS_OUTPUT.Put_line('Wiêcej ni¿ 1 w 93');
WHEN OTHERS THEN -- Obs³uga pozosta³ych b³êdów
  komunikat := 'B³¹d nr.= ' || SQLCODE|| ',komunikat= ' || Substr(SQLERRM,1,100);
   -- SQLCODE i SQLERRM nie mog¹ wyst¹piæ w instrukcji SQL!
  INSERT INTO Dziennik1 VALUES (komunikat);
  DBMS_OUTPUT.Put_line('Wyst¹pi³ inny b³¹d');
END;
/
--Komentarz: skrypt pobiera do zmiennych vEname i vJob wynik zapytania o pracowników zatrudnionych w 1993 r. Obs³uga b³êdów polega 
--na wyœwietleniu stosownych komunikatów w 3 przypadkach: 1) jeœli zapytanie nie zwróci³o ¿adnego wyniku, 
--2) jeœli zwróci³o wiêcej ni¿ jeden wynik, 3) w innych przykadkach - wtedy za pomoc¹ zmiennej systemowej SQLCODE podajemy kod b³êdu i wynik zapisujemy w tabeli Dziennik1.

--5. Napisz blok PL/SQL, w którym u¿ytkownik zaktualizuje pensjê wybranego pracownika w tabeli Emp. 
--Numer pracownika, którego pensja ma byæ zaktualizowana oraz wartoœæ pensji maj¹ byæ wprowadzane na bie¿¹co. Zadabaj o to, aby numer pracownika by³ numerem istniej¹cym w tabeli Emp, zaœ pensja by³a wiêksza od 500.
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

--6. Wykonaj na komputerze przyk³ad 8.3 (dotycz¹cy podwy¿szenia zarobków o 10% najmniej zarabiaj¹cym pracownikom oraz zmniejszenia zarobków o 10% najwiêcej zarabiaj¹cym pracownikom). SprawdŸ efekt w tabeli Emp.
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
--Komentarz: skrypt podnosi pensje o 10% rocznie pracownikom zarabiaj¹ym poni¿ej 10000 i obni¿a o 10% rocznie pracownikom zarabiaj¹m powy¿ej 10000. 
--Skrypt wykorzystuje kursor do przegladania wierszy z zapytania SELECT o zbiór nazwisk pracowników i ich pensji. 
--Jednoczeœnie, skrypt korzysta z blokowania wierszy sprowadzanych z bazy danych przez kursor (FOR UPDATE OF) 
--i odblokowuje do modyfikacji (WHERE CURRENT OF). 

--7. Utwórz tabelê Emps_in_Depts (Deptno NUMBER(2), Pracownicy VARCHAR2(4000)).
--Napisz blok PL/SQL, w którym do tabeli Emps_in_Depts s¹ wprowadzone wiersze postaci (deptno,ename1$ename2$....enamek$), 
--gdzie ename1,ename2,...,enamek s¹ wszystkimi pracownikami zatrudnionymi w dziale o numerze deptno np. (10,CLARK$KING$MILLER$).
CREATE TABLE Emps_in_Depts
    (
        Deptno NUMBER (2,0),
        Pracownicy VARCHAR2(4000)        
    );

DECLARE      
    vEname VARCHAR2(4000);
    numer NUMBER(2,0);
    
    --Kursor nr 1 do przegl¹dania nr dzia³ów
    CURSOR kursor_dzial IS
        SELECT DISTINCT Deptno FROM Emp;
    
    --Kursor nr 2 do przegl¹dania nazwisk
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

--8. U¿ywaj¹c dynamicznego SQL utwórz now¹ tabelê a nastêpnie j¹ usuñ.

--procedura 1 - tworzymy tabelê
BEGIN
   EXECUTE IMMEDIATE 'CREATE TABLE Wycieczka (Id NUMBER, Destination VARCHAR2(50))';
END;

--procedura 2 - usuwamy tabelê
DECLARE 
    sql_stmt VARCHAR2(100);       
BEGIN
   sql_stmt := 'DROP TABLE Wycieczka';
   EXECUTE IMMEDIATE sql_stmt;
END;
   








