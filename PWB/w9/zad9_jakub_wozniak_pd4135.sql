--PWB 
--Zadania do wyk�adu 9
--Student: Jakub Wo�niak
--Nr indeksu: pd4135
--Zadania:

--1.Wgraj dost�pny w module Materia�y skrypt rodzina.sql, po czym wykonaj nast�puj�ce zadania:
--a. Napisz procedur� WstawMiejscowosc podaj�c jako parametry wej�ciowe id oraz nazw� miejscowo�ci. 
--Sprawd�, czy nazwa miejscowo�ci nie istnieje w bazie. Je�li tak, nie wstawiaj jej ponownie.

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
        Raise_application_error(-20500, 'Miejscowo��: ' || nowa_nazwa || ' ju� istnieje w bazie.');
    END IF;           
END;

--b. Napisz procedur� WstawPraprzodka podaj�c jako parametry wej�ciowe pesel, imi�, nazwisko oraz dat� i miejsce urodzenia. 
--Przez praprzodka rozumiem osob�, kt�ra jest korzeniem drzewa, czyli nie ma w bazie matki ani ojca. 
--Sprawd�, czy osoba o podanym peselu nie istnieje ju� w bazie. Je�li tak, nie wstawiaj jej ponownie.

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
        Raise_application_error(-20500,'Osoba jest ju� w bazie');
    END IF;       
END;
/

--c. Napisz procedur� WstawPotomka podaj�c jako parametry wej�ciowe pesel, imi�, nazwisko, dat� i miejsce urodzenia oraz 
--pesel matki i ojca. Sprawd�, czy osoba o podanym peselu nie istnieje ju� w bazie. Je�li tak, nie wstawiaj jej ponownie. 
--Sprawd� r�wnie�, czy istniej� podane pesele rodzic�w. Je�li nie, nie wstawiaj osoby, tylko wypisz komunikat.

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
        /* Czy istniej� pesele rodzic�w */
        IF (m>0 AND f>0) THEN
            INSERT INTO Osoba Values(nowy_pesel, imie, nazwisko, data_urodzenia, miejsce_urodzenia, null, pesel_matki, pesel_ojca, null);
            COMMIT;
        ELSE
            Raise_application_error(-20501,'Peseli rodzic�w nie ma w bazie');
        END IF;
    ELSE
        Raise_application_error(-20500,'Osoba jest ju� w bazie');
    END IF;       
END;
/

--d. Napisz procedur� RejestrujZgon podaj�c jako parametr wej�ciowy pesel i dat� zgonu. 
--Ta procedura ma rzecz jasna aktualizowa� rekord o danym peselu wstawiaj�c zadan� na wej�ciu dat� zgonu.

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

--e. Napisz procedur� PodajRodzic�w podaj�c jako parametr wej�ciowy pesel osoby, kt�rej rodzic�w chcemy zna�. 
--Procedura ma wypisywa� na ekran imiona i nazwiska rodzic�w osoby o zadanym peselu.

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


--f. Napisz procedur� PodajRodze�stwo podaj�c jako parametr wej�ciowy pesel osoby, kt�rej rodze�stwo chcemy zna�. 
--Procedura ma wypisywa� na ekran imiona i nazwiska si�str i braci osoby o zadanym peselu.

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

--g. Napisz procedur� StatystykaZwiazkow wypisuj�c� na ekran i rejestruj�c� w stworzonej uprzednio tabeli Statystyka 
--nast�puj�ce informacje: Rok, Liczba zawartych zwi�zk�w, Liczba rozwod�w.

CREATE OR REPLACE PROCEDURE StatystykaZwiazkow AUTHID CURRENT_USER IS    
BEGIN
    EXECUTE IMMEDIATE ('DROP TABLE Statystyka');      
    EXECUTE IMMEDIATE ('CREATE TABLE Statystyka (
        rok INTEGER NULL,
        l_zwiazkow INTEGER NULL,
        l_rozwodow INTEGER NULL)');
    
    /* Zape�nia tabel� Statystyka - kolumny 1 i 2*/
    FOR row IN (SELECT EXTRACT(YEAR FROM Zwiazek_Malzenski.Data_zawarcia_zwiazku) AS kol1, COUNT(Zwiazek_Malzenski.Data_zawarcia_zwiazku) AS kol2
        FROM Zwiazek_malzenski
        GROUP BY Zwiazek_Malzenski.Data_zawarcia_zwiazku) 
        LOOP
            INSERT INTO Statystyka VALUES(row.kol1,row.kol2, 0);          
        END LOOP;  
    
    /* Zape�nia tabel� Statystyka - kolumne 3*/
    FOR row IN (SELECT EXTRACT(YEAR FROM Zwiazek_Malzenski.Data_zawarcia_zwiazku) AS kol1, COUNT(Zwiazek_Malzenski.Powod_wygasniecia_zwiazku) AS kol3
        FROM Zwiazek_malzenski
        WHERE Zwiazek_Malzenski.Powod_wygasniecia_zwiazku = 'Rozw�d' 
        GROUP BY Zwiazek_Malzenski.Data_zawarcia_zwiazku) 
        LOOP
            UPDATE Statystyka SET Statystyka.l_rozwodow = row.kol3
            WHERE Statystyka.rok = row.kol1;
        END LOOP;
        
    /* Wy�wietla tabel� Statystyka */
    dbms_output.put_line('Rok '||'L.zwiazk�w '||'L.rozwod�w');
    dbms_output.put_line('-----------------------------------');
    FOR row IN (SELECT * FROM Statystyka) 
        LOOP
            dbms_output.put_line(row.rok||'     '||row.l_zwiazkow||'        '||row.l_rozwodow);
        END LOOP;         
END;
/

--h. Napisz procedur� UzupelnijPlec uzupe�niaj�c� pole p�e�. 
--Je�li pole Imie ko�czy si� na liter� "a" w pole p�e� nale�y wpisa� "kobieta", w przeciwnym przypadku - "m�czyzna". 
--W zadaniu chodzi o u�ycie kursora z klauzul� "FOR UPDATE" i tylko t� wersj� oceniam.

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
                UPDATE Osoba SET Osoba.Plec = 'm�czyzna'
                WHERE CURRENT OF kursor_osoba;
            END IF;            
    END LOOP;
    CLOSE kursor_osoba;              
END;
/

--2. Napisz nast�puj�ce wyzwalacze:
--a. Napisz wyzwalacz, kt�ry przy aktualizacji rekordu w tabeli Zwiazek_Malzenski w celu wstawienia do bazy 
--daty wyga�ni�cia zwi�zku zadba o to, aby Data_Wygasniecia_Zwiazku by�a p�niejsza od daty zawarcia zwi�zku. 
--Przy pr�bie wpisania b�ednych danych wypisz stosowny komunikat o b��dzie.

CREATE OR REPLACE TRIGGER Spr_daty_wygasniecia_zwiazku
BEFORE INSERT OR UPDATE OF Data_zawarcia_zwiazku, Data_wygasniecia_zwiazku ON Zwiazek_malzenski
FOR EACH ROW 
BEGIN                    
    IF (:NEW.Data_wygasniecia_zwiazku <= :OLD.Data_zawarcia_zwiazku) THEN
        Raise_application_error(-20501,'Data wyga�niecia musi by� p�niejsza ni� data zawarcia');  
    END IF;
END;
/

--b. Napisz wyzwalacz, kt�ry przy wstawianiu osoby sprawdzi, czy pesel osoby ma dok�adnie 11 cyfr.

CREATE OR REPLACE TRIGGER pesel_validator 
BEFORE INSERT ON Osoba
FOR EACH ROW
DECLARE 
    str VARCHAR2(11);
BEGIN
    str := TRIM(:NEW.Pesel);    
    IF LENGTH(str)<>11 THEN
        Raise_application_error(-20505,'Pesel musi mie� 11 cyfr');         
    END IF;
END;
/

--c. Napisz wyzwalacz, kt�ry wygeneruje kolejne Id_Miejscowosci przy wstawianiu do tabeli Miejscowosc. 
--Wykorzystaj sekwencj� Seq_Miejscowosc lub wymy�l inny spos�b.

CREATE OR REPLACE TRIGGER GenerujIdMiejsc
BEFORE INSERT ON Miejscowosc
FOR EACH ROW
BEGIN
  SELECT NVL(MAX(Id_Miejscowosci)+1,1)
  INTO :NEW.Id_miejscowosci
  FROM Miejscowosc;
END;
/

--d. Napisz wyzwalacz, kt�ry przy usuwaniu z tabeli Osoba, usunie wszystkie zwi�zki danej osoby, 
--za� przy aktualizacji peselu osoby, zaktualizuje ten pesel w tabeli Zwiazek_Malzenski. Pami�taj, �e, aby by�o wida�
--dzia�anie tego wyzwalacza, wcze�niej musisz ponownie wgra� skrypt bez wi�z�w sp�jno�ci referencyjnej.

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







