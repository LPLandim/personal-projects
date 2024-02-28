/* ----------------- Programação em Banco de Dados - FIAP ON -------------------

-- Cap 6. - Procedures                                                        */
    
-- O Procedimento

SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE sp_quadrado
    (p_num IN NUMBER :=0)
    IS
BEGIN
    dbms_output.put_line ('O quadrado de ' || p_num || ' é: ');
    DBMS_OUTPUT.PUT_LINE (p_num * p_num );
END sp_quadrado;
/

EXECUTE sp_quadrado(10);

--------------------------------------------------------------------------------

-- Utilizando parâmetros de entrada

CREATE OR REPLACE PROCEDURE sp_reajuste
    (v_codigo_emp IN emp.empno%type,
     v_porcentagem IN number)
    IS
BEGIN
    UPDATE emp
         SET sal = sal + (sal *( v_porcentagem / 100 ) )
    WHERE empno = v_codigo_emp;
      COMMIT;
END sp_reajuste;
/

SELECT empno, sal
  FROM emp
 WHERE empno = 7839;
 
EXECUTE sp_reajuste(7839, 10);

SELECT empno, sal
  FROM emp
 WHERE empno = 7839;

--------------------------------------------------------------------------------

-- Utilizando parâmetros de saída
CREATE OR REPLACE PROCEDURE sp_reajuste
    (v_codigo_emp IN emp.empno%type,
    v_porcentagem IN number DEFAULT 25)
    IS
BEGIN
	UPDATE emp
        SET sal = sal + (sal *( v_porcentagem / 100 ) )
    Where empno = v_codigo_emp;
           COMMIT;
END sp_reajuste;
/

SELECT empno, sal
  FROM emp
 WHERE empno = 7839;
 
EXECUTE sp_reajuste(7839);

SELECT empno, sal
  FROM emp
 WHERE empno = 7839;
 
--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE sp_consulta_emp
    (p_id IN emp.empno%TYPE,
     p_nome OUT emp.ename%TYPE,
     p_salario OUT emp.sal%TYPE)
    IS 
BEGIN
    SELECT ename,  sal INTO
           p_nome, p_salario
      FROM emp
     WHERE empno = p_id;
END sp_consulta_emp;
/

SET SERVEROUTPUT ON
DECLARE
   v_nome    emp.ename%TYPE;
   v_salario emp.sal%TYPE;
BEGIN
   sp_consulta_emp(7839, v_nome, v_salario);
   DBMS_OUTPUT.PUT_LINE(v_nome);
   DBMS_OUTPUT.PUT_LINE(v_salario);
END;
/
--------------------------------------------------------------------------------

-- Utilizando parâmetros de entrada e saída

CREATE OR REPLACE PROCEDURE sp_formata_fone
    (p_fone IN OUT VARCHAR2)
IS
BEGIN
    p_fone := '(' || SUBSTR(p_fone, 1, 3) || ')' ||
                     SUBSTR(p_fone, 4, 4) || '-' ||
                     SUBSTR(p_fone, 7);
END sp_formata_fone;
/

SET SERVEROUTPUT ON
DECLARE
   v_fone VARCHAR2(30) := '01138858010';
BEGIN
    sp_formata_fone(v_fone);
    DBMS_OUTPUT.PUT_LINE(v_fone);
END;
/
--------------------------------------------------------------------------------

-- Visualização de erros de compilação

SHOW ERRORS
    Erros para PROCEDURE REAJUSTE:
LINE/COL ERROR
-------- -------------------------------------------
8/2      PL/SQL: SQL Statementignored
10/26    PL/SQL: ORA-00904: nome inválido de coluna
/

CREATE OR REPLACE PROCEDURE errotst AS
    v_conta NUMBER;
BEGIN
    v_conta := 7
END errotst;
/
SELECT line, position, text
  FROM user_errors
 WHERE name = 'ERROTST'
 ORDER BY sequence;
 LINE POSITION TEXT

--------------------------------------------------------------------------------

-- Passagem de parâmetros

CREATE OR REPLACE PROCEDURE sp_incluir_dept
    (p_cod  IN dept.deptno%TYPE DEFAULT '50',
     p_nome IN dept.dname%TYPE DEFAULT 'FIAP',
     p_loc  IN dept.loc%TYPE DEFAULT 'SP')
IS
BEGIN
    INSERT INTO dept(deptno, dname, loc)
    VALUES(p_cod, p_nome, p_loc);
END sp_incluir_dept;
/

BEGIN
   sp_incluir_dept;
END;
/

BEGIN
   sp_incluir_dept (55, 'Onze', 'SC');
END;
/

select * from dept;

BEGIN
   sp_incluir_dept (p_cod => 60, p_nome => 'Doze', p_loc => 'RJ');
END;
/

BEGIN
   sp_incluir_dept (65, p_nome => 'Treze');
END;
/