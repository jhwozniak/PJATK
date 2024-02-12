----PWB Zadanie: 1 Student: Jakub WoŸniak Nr indeksu: pd4135

--1. U¿ywaj¹c dowolnego programu klienckiego (SQL*Plus, iSQL*Plus, SQL Developer) zaloguj siê do bazy danych i utwórz trzy tabele EMP, DEPT i SALGRADE - korzystaj¹c ze skryptu demobld.sql dostêpnego w g³ównym katalogu tych materia³ów jak i w sekcji Materia³y systemu Edu  (w SQL*Plus nale¿y wykonaæ START Path/demobld.sql gdzie Path jest œcie¿k¹ do katalogu w którym jest zapisany skrypt demobld.sql). W przypadku trudnoœci skontaktuj siê z administratorem systemu.
--odpowiedŸ: utworzone w Oracle SQL Developer

--2. Zastosuj instrukcjê describe, aby przekonaæ siê, jakie s¹ schematy utworzonych tabel.
DESC emp;
DESC dept;
DESC salgrade;

--3. Zastosuj instrukcjê SELECT * FROM tabela, aby przekonaæ siê, jakie wiersze znajduj¹ siê w poszczególnych tabelach.
SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM salgrade;

--4. Utwórz dowoln¹ tabelê, a nastêpnie j¹ usuñ. SprawdŸ przy pomocy instrukcji describe, czy rzeczywiœcie tabela zosta³a usuniêta.
CREATE TABLE emp_copy AS
SELECT * FROM emp;

DROP TABLE emp_copy;

DESC emp_copy;

--5. Utwórz dowoln¹ tabelê i indeks na jednej z jej kolumn. Spróbuj usun¹æ j¹ za pomoc¹ DROP TABLE. Usuñ indeks a nastêpnie tabelê.
--co siê dzieje z indeksami na tabeli przy próbie usuniêcia tabeli.
CREATE TABLE emp_copy AS
SELECT * FROM emp;

CREATE INDEX ind_ename ON emp_copy (ename);
DROP INDEX ind_ename;

DROP TABLE emp_copy;
--odpowiedŸ: indeksy s¹ usuwane razem z tabel¹ 