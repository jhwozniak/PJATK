--PWB 
--Zadania do wyk³adu 9
--Student: Jakub WoŸniak
--Nr indeksu: pd4135
--Zadania:

--1.Wgraj dostêpny w module Materia³y skrypt rodzina.sql, po czym wykonaj nastêpuj¹ce zadania:
--a. Napisz procedurê WstawMiejscowosc podaj¹c jako parametry wejœciowe id oraz nazwê miejscowoœci. 
--SprawdŸ, czy nazwa miejscowoœci nie istnieje w bazie. Jeœli tak, nie wstawiaj jej ponownie.

START /Users/Admin/rodzina.sql;

CREATE OR REPLACE PROCEDURE WstawMiejscowosc(id_miejscowosci IN Miejscowosc.id_miejscowosci%TYPE, 
    nowa_nazwa IN Miejscowosc.Nazwa%TYPE) 
    AS
        p NUMBER;
BEGIN
    SELECT COUNT(*) INTO p FROM Miejscowosc
    WHERE Miejscowosc.nazwa = nowa_nazwa;
    IF p=0 THEN
        INSERT INTO Miejscowosc VALUES(id_miejscowosci, nowa_nazwa);
        COMMIT;
    ELSE 
        Raise_application_error(-20500, 'Miejscowoœæ: ' || nowa_nazwa || ' ju¿ istnieje w bazie.');
    END IF;           
END;

--b. Napisz procedurê WstawPraprzodka podaj¹c jako parametry wejœciowe pesel, imiê, nazwisko oraz datê i miejsce urodzenia. 
--Przez praprzodka rozumiem osobê, która jest korzeniem drzewa, czyli nie ma w bazie matki ani ojca. 
--SprawdŸ, czy osoba o podanym peselu nie istnieje ju¿ w bazie. Jeœli tak, nie wstawiaj jej ponownie.

CREATE OR REPLACE PROCEDURE WstawPraprzodka(nowy_pesel IN Osoba.pesel%TYPE, imie IN Osoba.imie%TYPE, 
    nazwisko IN Osoba.nazwisko%TYPE, data_urodzenia IN Osoba.data_urodzenia%TYPE, 
    miejsce_urodzenia IN Osoba.miejsce_urodzenia%TYPE) 
    AS
        p NUMBER;        
BEGIN
    /* Sprawdzamy, czy taka osoba jest w bazie*/
    SELECT COUNT(*) INTO p FROM Osoba 
    WHERE Osoba.pesel = nowy_pesel;
    IF p=0 THEN
        INSERT INTO Osoba Values(nowy_pesel, imie, nazwisko, data_urodzenia, miejsce_urodzenia, null, null, null, null);
        COMMIT;
    ELSE
        Raise_application_error(-20500,'Osoba jest ju¿ w bazie');
    END IF;       
END;
/

--c. Napisz procedurê WstawPotomka podaj¹c jako parametry wejœciowe pesel, imiê, nazwisko, datê i miejsce urodzenia oraz 
--pesel matki i ojca. SprawdŸ, czy osoba o podanym peselu nie istnieje ju¿ w bazie. Jeœli tak, nie wstawiaj jej ponownie. 
--SprawdŸ równie¿, czy istniej¹ podane pesele rodziców. Jeœli nie, nie wstawiaj osoby, tylko wypisz komunikat.

CREATE OR REPLACE PROCEDURE WstawPotomka(
        nowy_pesel IN Osoba.pesel%TYPE, 
        imie IN Osoba.imie%TYPE, 
        nazwisko IN Osoba.nazwisko%TYPE, 
        data_urodzenia IN Osoba.data_urodzenia%TYPE, 
        miejsce_urodzenia IN Osoba.miejsce_urodzenia%TYPE, 
        pesel_matki IN Osoba.matka%TYPE, 
        pesel_ojca IN Osoba.ojciec%TYPE
    ) 
    AS
        p NUMBER;
        m NUMBER;
        f NUMBER;
BEGIN
    SELECT COUNT(*) INTO p FROM Osoba 
    WHERE Osoba.pesel = nowy_pesel;
    SELECT COUNT(*) INTO m FROM Osoba 
    WHERE Osoba.matka = pesel_matki;
    SELECT COUNT(*) INTO f FROM Osoba 
    WHERE Osoba.ojciec = pesel_ojca;
    /* Sprawdzamy, czy taka osoba jest w bazie*/
    IF p=0 THEN
        /* Czy istniej¹ pesele rodziców */
        IF (m>0 AND f>0) THEN
            INSERT INTO Osoba Values(nowy_pesel, imie, nazwisko, data_urodzenia, miejsce_urodzenia, null, pesel_matki, pesel_ojca, null);
            COMMIT;
        ELSE
            Raise_application_error(-20501,'Peseli rodziców nie ma w bazie');
        END IF;
    ELSE
        Raise_application_error(-20500,'Osoba jest ju¿ w bazie');
    END IF;       
END;
/

--d. Napisz procedurê RejestrujZgon podaj¹c jako parametr wejœciowy pesel i datê zgonu. 
--Ta procedura ma rzecz jasna aktualizowaæ rekord o danym peselu wstawiaj¹c zadan¹ na wejœciu datê zgonu.

CREATE OR REPLACE PROCEDURE RejestrujZgon(
        nowy_pesel IN Osoba.pesel%TYPE, 
        kiedy_zgon IN Osoba.data_zgonu%TYPE
    ) 
    AS
        p NUMBER;        
BEGIN
    SELECT COUNT(*) INTO p FROM Osoba 
    WHERE Osoba.pesel = nowy_pesel;    
    /* Sprawdzamy, czy taka osoba jest w bazie */
    IF p=1 THEN
        /* Rejestrujemy zgon */
        UPDATE Osoba SET Osoba.data_zgonu = kiedy_zgon
        WHERE Osoba.pesel = nowy_pesel;
        COMMIT;
    ELSE
        Raise_application_error(-20500,'Osoby nie ma w bazie');
    END IF;       
END;
/

--e. Napisz procedurê PodajRodziców podaj¹c jako parametr wejœciowy pesel osoby, której rodziców chcemy znaæ. 
--Procedura ma wypisywaæ na ekran imiona i nazwiska rodziców osoby o zadanym peselu.

CREATE OR REPLACE PROCEDURE PodajRodzicow(
        nowy_pesel IN Osoba.pesel%TYPE         
    ) 
    AS
        p NUMBER;
        m_imie Osoba.imie%TYPE;
        m_nazwisko Osoba.imie%TYPE;
        f_imie Osoba.imie%TYPE;
        f_nazwisko Osoba.imie%TYPE;
BEGIN
    SELECT COUNT(*) INTO p FROM Osoba 
    WHERE Osoba.pesel = nowy_pesel; 
    
    SELECT Osoba.imie INTO m_imie FROM Osoba
    WHERE Osoba.pesel = (SELECT Osoba.matka FROM Osoba WHERE Osoba.pesel = nowy_pesel);
    
    SELECT Osoba.nazwisko INTO m_nazwisko FROM Osoba
    WHERE Osoba.pesel = (SELECT Osoba.matka FROM Osoba WHERE Osoba.pesel = nowy_pesel);

    SELECT Osoba.imie INTO f_imie FROM Osoba
    WHERE Osoba.pesel = (SELECT Osoba.ojciec FROM Osoba WHERE Osoba.pesel = nowy_pesel);
    
    SELECT Osoba.nazwisko INTO f_nazwisko FROM Osoba
    WHERE Osoba.pesel = (SELECT Osoba.ojciec FROM Osoba WHERE Osoba.pesel = nowy_pesel);
    
    /* Sprawdzamy, czy taka osoba jest w bazie */
    IF p=1 THEN
        DBMS_OUTPUT.PUT_LINE('Matka: ' || m_imie ||' ' || m_nazwisko);
        DBMS_OUTPUT.PUT_LINE('Ojciec: ' || f_imie ||' ' || f_nazwisko);
    ELSE
        Raise_application_error(-20500,'Osoby nie ma w bazie');
    END IF;       
END;
/


--f. Napisz procedurê PodajRodzeñstwo podaj¹c jako parametr wejœciowy pesel osoby, której rodzeñstwo chcemy znaæ. 
--Procedura ma wypisywaæ na ekran imiona i nazwiska sióstr i braci osoby o zadanym peselu.

CREATE OR REPLACE PROCEDURE PodajRodzenstwo(nowy_pesel IN Osoba.pesel%TYPE) IS
    CURSOR kursor_osoba IS
        SELECT * FROM Osoba
        WHERE Osoba.matka = (SELECT Osoba.matka FROM Osoba WHERE Osoba.pesel = nowy_pesel)
        AND Osoba.ojciec = (SELECT Osoba.ojciec FROM Osoba WHERE Osoba.pesel = nowy_pesel)
        AND Osoba.pesel <> nowy_pesel;
    rek_osoby kursor_osoba%ROWTYPE;
    p NUMBER;        
BEGIN
    SELECT COUNT(*) INTO p FROM Osoba 
    WHERE Osoba.pesel = nowy_pesel;     
    /* Sprawdzamy, czy taka osoba jest w bazie */
    IF p=1 THEN
        OPEN kursor_osoba;
        LOOP
            FETCH kursor_osoba INTO rek_osoby;
            EXIT WHEN kursor_osoba%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Rodzenstwo: ' || rek_osoby.Imie || ' ' || rek_osoby.Nazwisko);    
        END LOOP;
        CLOSE kursor_osoba;                 
    ELSE
        Raise_application_error(-20500,'Osoby nie ma w bazie');
    END IF;       
END;
/

--g. Napisz procedurê StatystykaZwiazkow wypisuj¹c¹ na ekran i rejestruj¹c¹ w stworzonej uprzednio tabeli Statystyka 
--nastêpuj¹ce informacje: Rok, Liczba zawartych zwi¹zków, Liczba rozwodów.

CREATE OR REPLACE PROCEDURE StatystykaZwiazkow AUTHID CURRENT_USER IS    
BEGIN
    EXECUTE IMMEDIATE ('DROP TABLE Statystyka');      
    EXECUTE IMMEDIATE ('CREATE TABLE Statystyka (
        rok INTEGER NULL,
        l_zwiazkow INTEGER NULL,
        l_rozwodow INTEGER NULL)');
    
    /* Zape³nia tabelê Statystyka - kolumny 1 i 2*/
    FOR row IN (SELECT EXTRACT(YEAR FROM Zwiazek_Malzenski.Data_zawarcia_zwiazku) AS kol1, COUNT(Zwiazek_Malzenski.Data_zawarcia_zwiazku) AS kol2
        FROM Zwiazek_malzenski
        GROUP BY Zwiazek_Malzenski.Data_zawarcia_zwiazku) 
        LOOP
            INSERT INTO Statystyka VALUES(row.kol1,row.kol2, 0);          
        END LOOP;  
    
    /* Zape³nia tabelê Statystyka - kolumne 3*/
    FOR row IN (SELECT EXTRACT(YEAR FROM Zwiazek_Malzenski.Data_zawarcia_zwiazku) AS kol1, COUNT(Zwiazek_Malzenski.Powod_wygasniecia_zwiazku) AS kol3
        FROM Zwiazek_malzenski
        WHERE Zwiazek_Malzenski.Powod_wygasniecia_zwiazku = 'Rozwód' 
        GROUP BY Zwiazek_Malzenski.Data_zawarcia_zwiazku) 
        LOOP
            UPDATE Statystyka SET Statystyka.l_rozwodow = row.kol3
            WHERE Statystyka.rok = row.kol1;
        END LOOP;
        
    /* Wyœwietla tabelê Statystyka */
    dbms_output.put_line('Rok '||'L.zwiazków '||'L.rozwodów');
    dbms_output.put_line('-----------------------------------');
    FOR row IN (SELECT * FROM Statystyka) 
        LOOP
            dbms_output.put_line(row.rok||'     '||row.l_zwiazkow||'        '||row.l_rozwodow);
        END LOOP;         
END;
/

--h. Napisz procedurê UzupelnijPlec uzupe³niaj¹c¹ pole p³eæ. 
--Jeœli pole Imie koñczy siê na literê "a" w pole p³eæ nale¿y wpisaæ "kobieta", w przeciwnym przypadku - "mê¿czyzna". 
--W zadaniu chodzi o u¿ycie kursora z klauzul¹ "FOR UPDATE" i tylko tê wersjê oceniam.

CREATE OR REPLACE PROCEDURE UzupelnijPlec IS
    CURSOR kursor_osoba IS
        SELECT * FROM Osoba
        FOR UPDATE OF Plec;        
    rek_osoby kursor_osoba%ROWTYPE;            
BEGIN
    OPEN kursor_osoba;
    LOOP
        FETCH kursor_osoba INTO rek_osoby;
        EXIT WHEN kursor_osoba%NOTFOUND;
            IF rek_osoby.Imie LIKE '%a' THEN 
                UPDATE Osoba SET Osoba.Plec = 'kobieta'
                WHERE CURRENT OF kursor_osoba;
            ELSE
                UPDATE Osoba SET Osoba.Plec = 'mê¿czyzna'
                WHERE CURRENT OF kursor_osoba;
            END IF;            
    END LOOP;
    CLOSE kursor_osoba;              
END;
/

--2. Napisz nastêpuj¹ce wyzwalacze:
--a. Napisz wyzwalacz, który przy aktualizacji rekordu w tabeli Zwiazek_Malzenski w celu wstawienia do bazy 
--daty wygaœniêcia zwi¹zku zadba o to, aby Data_Wygasniecia_Zwiazku by³a póŸniejsza od daty zawarcia zwi¹zku. 
--Przy próbie wpisania b³ednych danych wypisz stosowny komunikat o b³êdzie.

CREATE OR REPLACE TRIGGER Spr_daty_wygasniecia_zwiazku
BEFORE INSERT OR UPDATE OF Data_zawarcia_zwiazku, Data_wygasniecia_zwiazku ON Zwiazek_malzenski
FOR EACH ROW 
BEGIN                    
    IF (:NEW.Data_wygasniecia_zwiazku <= :OLD.Data_zawarcia_zwiazku) THEN
        Raise_application_error(-20501,'Data wygaœniecia musi byæ póŸniejsza ni¿ data zawarcia');  
    END IF;
END;
/

--b. Napisz wyzwalacz, który przy wstawianiu osoby sprawdzi, czy pesel osoby ma dok³adnie 11 cyfr.

CREATE OR REPLACE TRIGGER pesel_validator 
BEFORE INSERT ON Osoba
FOR EACH ROW
DECLARE 
    str VARCHAR2(11);
BEGIN
    str := TRIM(:NEW.Pesel);    
    IF LENGTH(str)<>11 THEN
        Raise_application_error(-20505,'Pesel musi mieæ 11 cyfr');         
    END IF;
END;
/

--c. Napisz wyzwalacz, który wygeneruje kolejne Id_Miejscowosci przy wstawianiu do tabeli Miejscowosc. 
--Wykorzystaj sekwencjê Seq_Miejscowosc lub wymyœl inny sposób.

CREATE OR REPLACE TRIGGER GenerujIdMiejsc
BEFORE INSERT ON Miejscowosc
FOR EACH ROW
BEGIN
  SELECT NVL(MAX(Id_Miejscowosci)+1,1)
  INTO :NEW.Id_miejscowosci
  FROM Miejscowosc;
END;
/

--d. Napisz wyzwalacz, który przy usuwaniu z tabeli Osoba, usunie wszystkie zwi¹zki danej osoby, 
--zaœ przy aktualizacji peselu osoby, zaktualizuje ten pesel w tabeli Zwiazek_Malzenski. Pamiêtaj, ¿e, aby by³o widaæ
--dzia³anie tego wyzwalacza, wczeœniej musisz ponownie wgraæ skrypt bez wiêzów spójnoœci referencyjnej.

CREATE OR REPLACE TRIGGER Usun_zwiazki_Osoba
AFTER DELETE ON Osoba
FOR EACH ROW
BEGIN
    IF DELETING THEN
        UPDATE Zwiazek_malzenski
        SET Zwiazek_malzenski.maz = NULL
        WHERE Zwiazek_malzenski.maz = :OLD.pesel; 
        
        UPDATE Zwiazek_malzenski
        SET Zwiazek_malzenski.zona = NULL
        WHERE Zwiazek_malzenski.zona = :OLD.pesel; 
        
        UPDATE Osoba
        SET Osoba.matka = NULL
        WHERE Osoba.matka = :OLD.pesel; 
        
        UPDATE Osoba
        SET Osoba.ojciec = NULL
        WHERE Osoba.ojciec = :OLD.pesel;     
    END IF;
    
    IF UPDATING AND :NEW.pesel<>:OLD.pesel THEN
        UPDATE Zwiazek_malzenski
        SET Zwiazek_malzenski.maz = :NEW.pesel
        WHERE Zwiazek_malzenski.maz = :OLD.pesel; 
        
        UPDATE Zwiazek_malzenski
        SET Zwiazek_malzenski.zona = :NEW.pesel
        WHERE Zwiazek_malzenski.zona = :OLD.pesel;                
    END IF;  
END;







