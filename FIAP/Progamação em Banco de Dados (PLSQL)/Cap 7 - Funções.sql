/* ----------------- Programação em Banco de Dados - FIAP ON -------------------

-- Cap 7. - Funções                                                           */
    
-- A Função

CREATE OR REPLACE FUNCTION f_descobrir_salario
   (p_id IN emp.empno%TYPE)
RETURN NUMBER
IS
   v_salario emp.sal%TYPE := 0;
BEGIN
   SELECT sal INTO v_salario
     FROM emp
    WHERE empno = p_id;
   RETURN v_salario;
END f_descobrir_salario;
/

SELECT empno as "Código do Funcionário", f_DESCOBRIR_SALARIO(empno) as "Salário"
  FROM emp;
  
SET SERVEROUTPUT ON
BEGIN
   DBMS_OUTPUT.PUT_LINE(DESCOBRIR_SALARIO(7900));
END;
/
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION f_contadept
    RETURN number IS 
    total NUMBER(7) := 0; 
BEGIN 
   SELECT count(*) INTO total 
     FROM dept; 
   RETURN total; 
END; 
/

SET SERVEROUTPUT ON
DECLARE 
   v_conta NUMBER(7); 
BEGIN 
   v_conta := f_CONTADEPT(); 
   DBMS_OUTPUT.PUT_LINE('Quantidade de Departamentos: ' || v_conta); 
END;
/

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION f_sal_anual (
     p_sal           NUMBER,
     p_comm          NUMBER )
RETURN NUMBER
IS
BEGIN
    RETURN (p_sal + NVL(p_comm, 0)) * 12;
END f_sal_anual;
/

SELECT f_sal_anual(10000, NULL)
    FROM DUAL;

SELECT sal, comm, F_SAL_ANUAL(sal, comm) as "SAL ANUAL"
  FROM emp;
  
  
SET SERVEROUTPUT ON
DECLARE 
   total NUMBER(7); 
BEGIN 
   total := f_SAL_ANUAL(900, 100); 
   DBMS_OUTPUT.PUT_LINE('Salario anual: ' || total); 
END;
/

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION f_ordinal (
     p_numero        NUMBER)
RETURN VARCHAR2
IS
BEGIN
  CASE p_numero
    WHEN 1 THEN RETURN 'primeiro';     
    WHEN 2 THEN RETURN 'segundo';     
    WHEN 3 THEN RETURN 'terceiro';     
    WHEN 4 THEN RETURN 'quarto';     
    WHEN 5 THEN RETURN 'quinto';     
    WHEN 6 THEN RETURN 'sexto';     
    WHEN 7 THEN RETURN 'sétimo';     
    WHEN 8 THEN RETURN 'oitavo';     
    WHEN 9 THEN RETURN 'nono';     
    ELSE RETURN 'não previsto';
  END CASE;
END f_ordinal;
/

SELECT F_ORDINAL(12), F_ORDINAL(5)
  FROM dual;
  
  
SET SERVEROUTPUT ON
BEGIN 
   FOR i IN 1..9 LOOP 
       DBMS_OUTPUT.PUT_LINE(F_ORDINAL(i));
   END LOOP;
END;
/ 

--------------------------------------------------------------------------------

-- Visualização de erros de compilação

SHOW ERRORS;

SELECT line, position, text 
  FROM user_errors 
 WHERE name = 'F_ORDINAL' 
ORDER BY sequence;

SELECT text
  FROM user_source
 WHERE name = 'F_ORDINAL'
 ORDER BY line;