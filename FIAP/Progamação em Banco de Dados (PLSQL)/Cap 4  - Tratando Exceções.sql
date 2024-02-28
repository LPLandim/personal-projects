/* ----------------- Programação em Banco de Dados - FIAP ON -------------------

-- Cap 4. - Tratamento de exceções                                            */

SELET * FROM emp;
SP2-0734: unknown command beginning "SELET * FR..." - rest of line ignored.

SET SERVEROUTPUT ON
DECLARE
   cinco NUMBER := 5;
BEGIN
   DBMS_OUTPUT.PUT_LINE ( cinco / ( cinco - cinco ) );
END;
/
DECLARE
*
ERROR at line 1:
ORA-01476: divisor is equal to zero
ORA-06512: at line 4

--------------------------------------------------
EXCEPTION
	WHEN exceção1 [OR exceção2 …] THEN
		comando1;
		comando2;
		…
	[WHEN exceção3 [OR exceção4 …] THEN
		comando1;
		comando2;
		…]
	[WHEN OTHERS THEN
		comando1;
		comando2;
		…]
        /
--------------------------------

SET SERVEROUTPUT ON

DECLARE    
  cinco NUMBER := 5; 
BEGIN    
  DBMS_OUTPUT.PUT_LINE (cinco / ( cinco - cinco )); 
EXCEPTION    
  WHEN ZERO_DIVIDE THEN         
    DBMS_OUTPUT.PUT_LINE ('ERRO! - Divisao por zero');    
  WHEN OTHERS THEN         
    DBMS_OUTPUT.PUT_LINE ('Erro imprevisto'); 
END;
/

-- Funções para a captura de erro

CREATE TABLE erros
(usuario  VARCHAR2(30),
 data     DATE,
 cod_erro NUMBER,
 msg_erro VARCHAR2(100));
/
 
SET SERVEROUTPUT ON
DECLARE
   cod erros.cod_erro%TYPE;
   msg erros.msg_erro%TYPE;
   cinco NUMBER := 5;
BEGIN
    DBMS_OUTPUT.PUT_LINE (cinco / ( cinco - cinco ));
    EXCEPTION
    WHEN ZERO_DIVIDE THEN
        cod := SQLCODE;
        msg := SUBSTR(SQLERRM, 1, 100);
insert into erros
    values (USER, SYSDATE, cod, msg);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE ('Erro imprevisto');
END;
/

select * from erros;

-- Exceções nomeadas pelo desenvolvedor

DECLARE
  e_meu_erro EXCEPTION;
  emprec emp%ROWTYPE;
    CURSOR cursor_emp IS 
         SELECT empno, ename          
            FROM emp          
        WHERE empno = 1111;
BEGIN
   OPEN cursor_emp;
   LOOP
      FETCH cursor_emp INTO emprec.deptno, emprec.sal;
      IF cursor_emp%NOTFOUND THEN
         RAISE e_meu_erro;
      END IF;
         DBMS_OUTPUT.PUT_LINE ('Codigo : ' || emprec.empno);
         DBMS_OUTPUT.PUT_LINE ('Nome   : ' || emprec.ename);
      EXIT WHEN cursor_emp%NOTFOUND;
   END LOOP;
EXCEPTION
   WHEN E_MEU_ERRO THEN
         DBMS_OUTPUT.PUT_LINE ('Codigo nao cadastrado');
         ROLLBACK;
END;
/

-- Associando exceções a erros padrão do servidor

PRAGMA EXCEPTION_INIT(nome_exceção, código_Oracle_erro);

DECLARE  
  e_meu_erro EXCEPTION;  
  PRAGMA EXCEPTION_INIT (e_meu_erro, -2292);
BEGIN  
  DELETE FROM dept   
    WHERE deptno = 10;  
  COMMIT;
EXCEPTION  
  WHEN e_meu_erro THEN   
    DBMS_OUTPUT.PUT_LINE ('Integridade Referencial Violada');   
    ROLLBACK;
END;
/

-- Procedimento RAISE_APPLICATION_ERROR

RAISE_APPLICATION_ERROR(numero_erro, mensagem [, {TRUE | FALSE}]);  

DECLARE   
    cinco NUMBER := 5;
BEGIN 
    DBMS_OUTPUT.PUT_LINE (cinco / ( cinco - cinco ));
    EXCEPTION    
        WHEN ZERO_DIVIDE THEN 
            RAISE_APPLICATION_ERROR (-20901, 'Erro aritmetico. Reveja o programa');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE ('Erro imprevisto');
END;
/
ORA-20901: Erro aritmetico. Reveja o programa

DECLARE
    e_meu_erro EXCEPTION;
    PRAGMA EXCEPTION_INIT (e_meu_erro, -2292);
BEGIN
    DELETE FROM dept
        WHERE deptno = 33;
    IF SQL%NOTFOUND THEN 
        RAISE_APPLICATION_ERROR (-20901, 'Departamento Inexistente');
        ROLLBACK;
    END IF;    
        COMMIT;
    EXCEPTION WHEN e_meu_erro THEN
        DBMS_OUTPUT.PUT_LINE ('Integridade Referencial Violada');
    ROLLBACK;
END;
/

ERROR at line 1:
ORA-20901: Departamento Inexistente

-- Propagando uma exceção para um bloco externo

DECLARE
   cod erros.cod_erro%TYPE;
   msg erros.msg_erro%TYPE;
   cinco NUMBER := 5;
BEGIN
    BEGIN
        DELETE FROM dept
         WHERE deptno = 10;
        EXCEPTION
           WHEN ZERO_DIVIDE THEN
                DBMS_OUTPUT.PUT_LINE ('Erro no bloco interno');
    END;
        DBMS_OUTPUT.PUT_LINE (cinco / ( cinco - cinco ));
EXCEPTION
    WHEN OTHERS THEN
        cod := SQLCODE;
        msg := SUBSTR(SQLERRM, 1, 100);
        insert into erros values (USER, SYSDATE, cod, msg);
END;
/

select * from erros;