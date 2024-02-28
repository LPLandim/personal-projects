/* ----------------- Programação em Banco de Dados - FIAP ON -------------------

-- Cap 3. - Cursores                                            */

-- Mais um pouco sobre tipos de dados

SET serveroutput ON
DECLARE
    v_empno    emp.empno%TYPE;
    v_ename    emp.ename%TYPE;
    v_job      emp.job%TYPE;
    v_mgr      emp.mgr%TYPE;
    v_hiredate emp.hiredate%TYPE;
    v_sal      emp.sal%TYPE;
    v_comm     emp.comm%TYPE;
    v_deptno   emp.deptno%TYPE;
BEGIN
    SELECT empno, ename, job, mgr,
        hiredate, sal, comm, deptno
    INTO v_empno, v_ename, v_job, v_mgr,
        v_hiredate, v_sal, v_comm, v_deptno
    FROM emp
        WHERE empno = 7839;
  DBMS_OUTPUT.PUT_LINE ('Codigo   = ' || v_empno);
  DBMS_OUTPUT.PUT_LINE ('Nome     = ' || v_ename);
  DBMS_OUTPUT.PUT_LINE ('Cargo    = ' || v_job);
  DBMS_OUTPUT.PUT_LINE ('Gerente  = ' || v_mgr);
  DBMS_OUTPUT.PUT_LINE ('Data     = ' || v_hiredate);
  DBMS_OUTPUT.PUT_LINE ('Sala     = ' || v_sal);
  DBMS_OUTPUT.PUT_LINE ('Comissao = ' || v_comm);
  DBMS_OUTPUT.PUT_LINE ('Depart.  = ' || v_deptno);  
END;
/

select * from emp;

SET serveroutput ON
  DECLARE
    emprec emp%ROWTYPE;
BEGIN
  SELECT * INTO emprec
    FROM emp
  WHERE empno = 7839;
  DBMS_OUTPUT.PUT_LINE ('Codigo   = ' || emprec.empno);
  DBMS_OUTPUT.PUT_LINE ('Nome     = ' || emprec.ename);
  DBMS_OUTPUT.PUT_LINE ('Cargo    = ' || emprec.job);
  DBMS_OUTPUT.PUT_LINE ('Gerente  = ' || emprec.mgr);
  DBMS_OUTPUT.PUT_LINE ('Data     = ' || emprec.hiredate);
  DBMS_OUTPUT.PUT_LINE ('Sala     = ' || emprec.sal);
  DBMS_OUTPUT.PUT_LINE ('Comissao = ' || emprec.comm);
  DBMS_OUTPUT.PUT_LINE ('Depart.  = ' || emprec.deptno);  
  END;
/

--------------------------------------------------------

-- Cursor Implícito 

DECLARE  
    emprec emp%ROWTYPE;
BEGIN
  SELECT SUM(sal)   
    INTO emprec.sal  
    FROM emp
  GROUP BY deptno; 
    DBMS_OUTPUT.PUT_LINE ('Salario = ' || emprec.sal);
END;
  /
  -- ERROR at line 1:
  -- ORA-01422: exact fetch returns more than requested number of rows
  -- ORA-06512: at line 4
  
/* Tanto  o  CURSOR  implícito  quanto  o  CURSOR explícito
possuem quatro atributos em comum: %FOUND, %ISOPEN, %NOTFOUND e %ROWCOUNT.
Esses atributos retornam informações úteis sobre a execução dos comandos.     

%FOUND retorna  verdadeiro  (TRUE),  caso  alguma  linha  (tupla)  tenha  sido afetada.

%ISOPEN retorna verdadeiro (TRUE), caso o CURSOR esteja aberto.

%NOTFOUND retorna   verdadeiro   (TRUE),   caso   não   tenha   encontrado nenhuma tupla.
Caso tenha encontrado, retornará falso (FALSE) até a última tupla.

%ROWCOUNT retorna o número de tuplas do CURSOR.                               */

--------------------------------------------------------------------------------

BEGIN
    DELETE 
      FROM emp
    WHERE deptno = 10;
    DBMS_OUTPUT.PUT_LINE ('Linhas apagadas = ' || SQL%ROWCOUNT);
    ROLLBACK;
  END;
/

/* No exemplo acima, o banco de dados Oracle cria um CURSOR implícito,
    apaga os registros do departamento 10 da tabela EMP,
    exibe a quantidade de linhas deletadas e desfaz a operação */
    
-- Cursores explicitos 

-- Declaração do cursor
DECLARE  
    CURSOR cursor_emp IS 
          SELECT deptno, SUM(sal)            
          FROM emp       
        GROUP BY deptno;
  …
/
-- Abertura do Cursor  
    OPEN nome_cursor; 
/
---------------------------------------------  
DECLARE  
    CURSOR cursor_emp IS 
      SELECT deptno, SUM(sal)            
      FROM emp       
    GROUP BY deptno;
BEGIN
    OPEN cursor_emp;
END;
  /
  
select * from emp; 

-- Recuperação das linhas do cursor

FETCH cursor_name
  INTO [variável1, variável2, ...|record_name];
  
-----------------------

DECLARE
    emprec emp%ROWTYPE;
    CURSOR cursor_emp IS 
          SELECT deptno, SUM(sal)            
              FROM emp       
          GROUP BY deptno;
BEGIN
    OPEN cursor_emp;
    FETCH cursor_emp INTO emprec.deptno, emprec.sal;
    DBMS_OUTPUT.PUT_LINE ('Departamento: ' || emprec.deptno);
    DBMS_OUTPUT.PUT_LINE ('Salario     : ' || emprec.sal);
END;
  /
-----------------------------------------

DECLARE
    emprec emp%ROWTYPE;  
    CURSOR cursor_emp IS 
        SELECT deptno, SUM(sal)            
            FROM emp       
        GROUP BY deptno;
BEGIN
    OPEN cursor_emp;
    LOOP
        FETCH cursor_emp INTO emprec.deptno, emprec.sal;
        EXIT WHEN cursor_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE ('Departamento: ' || emprec.deptno);
        DBMS_OUTPUT.PUT_LINE ('Salario     : ' || emprec.sal);
    END LOOP;
END;
  /
  
-- Fechamento de Cursor 

CLOSE nome_cursor;
/
----------------

DECLARE
    emprec emp%ROWTYPE;  
    CURSOR cursor_emp IS 
        SELECT deptno, SUM(sal)            
          FROM emp       
      GROUP BY deptno;
BEGIN
    OPEN cursor_emp;
    LOOP
        FETCH cursor_emp INTO emprec.deptno, emprec.sal;
        EXIT WHEN cursor_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE ('Departamento: ' || emprec.deptno);
        DBMS_OUTPUT.PUT_LINE ('Salario     : ' || emprec.sal);
    END LOOP;
    CLOSE cursor_emp;
END;
  /

-- Loops de Cursor FOR

FOR nome_registro IN nome_cursor 
    LOOP
      Instruções;
    END LOOP;
/

-- Loops FOR de Cursor usando subconsultas

SET serveroutput ON
BEGIN   
    FOR emprec IN (SELECT deptno, SUM(sal) soma 
                      FROM emp GROUP BY deptno) 
    LOOP       
      DBMS_OUTPUT.PUT_LINE ('Departamento: ' || emprec.deptno);
      DBMS_OUTPUT.PUT_LINE ('Salario     : ' || emprec.soma);   
    END LOOP;
END;
/

-- Cursores de Atualização

DECLARE
    emprec emp%ROWTYPE;  
    CURSOR cursor_emp IS 
      SELECT empno, sal            
        FROM emp
         FOR UPDATE;
BEGIN
    OPEN cursor_emp;
    LOOP
        FETCH cursor_emp INTO emprec.empno, emprec.sal;
        EXIT WHEN cursor_emp%NOTFOUND;
        UPDATE emp SET sal = sal * 1.05 
        WHERE CURRENT OF cursor_emp;
    END LOOP;
    CLOSE cursor_emp;
END;
  /
  
select * from emp;