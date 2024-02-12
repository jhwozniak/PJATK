----PWB Zadanie: 1 Student: Jakub Wo�niak Nr indeksu: pd4135

--1. U�ywaj�c dowolnego programu klienckiego (SQL*Plus, iSQL*Plus, SQL Developer) zaloguj si� do bazy danych i utw�rz trzy tabele EMP, DEPT i SALGRADE - korzystaj�c ze skryptu demobld.sql dost�pnego w g��wnym katalogu tych materia��w jak i w sekcji Materia�y systemu Edu  (w SQL*Plus nale�y wykona� START Path/demobld.sql gdzie Path jest �cie�k� do katalogu w kt�rym jest zapisany skrypt demobld.sql). W przypadku trudno�ci skontaktuj si� z administratorem systemu.
--odpowied�: utworzone w Oracle SQL Developer

--2. Zastosuj instrukcj� describe, aby przekona� si�, jakie s� schematy utworzonych tabel.
DESC emp;
DESC dept;
DESC salgrade;

--3. Zastosuj instrukcj� SELECT * FROM tabela, aby przekona� si�, jakie wiersze znajduj� si� w poszczeg�lnych tabelach.
SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM salgrade;

--4. Utw�rz dowoln� tabel�, a nast�pnie j� usu�. Sprawd� przy pomocy instrukcji describe, czy rzeczywi�cie tabela zosta�a usuni�ta.
CREATE TABLE emp_copy AS
SELECT * FROM emp;

DROP TABLE emp_copy;

DESC emp_copy;

--5. Utw�rz dowoln� tabel� i indeks na jednej z jej kolumn. Spr�buj usun�� j� za pomoc� DROP TABLE. Usu� indeks a nast�pnie tabel�.
--co si� dzieje z indeksami na tabeli przy pr�bie usuni�cia tabeli.
CREATE TABLE emp_copy AS
SELECT * FROM emp;

CREATE INDEX ind_ename ON emp_copy (ename);
DROP INDEX ind_ename;

DROP TABLE emp_copy;
--odpowied�: indeksy s� usuwane razem z tabel� 