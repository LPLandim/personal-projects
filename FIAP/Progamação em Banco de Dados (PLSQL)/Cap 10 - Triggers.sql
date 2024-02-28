/* ----------------- Programação em Banco de Dados - FIAP ON -------------------

-- Cap 10. - Triggers                                                          */
    
-- Sintaxe Triggers

CREATE [OR REPLACE] TRIGGER [esquema.]nome_trigger 
{BEFORE ou AFTER} 
[evento] ON [esquema.]tabela_nome
[referencing Old as valor_anterior ou NEW as valor_novo)
{nível de linha ou nível de instrução} [WHEN (condição)]] DECLARE
BEGIN
   corpo_trigger 
END;
/

-- Trigger DML

SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER tgr_mudancas_salariais 
    BEFORE UPDATE ON emp 
    FOR EACH ROW 
DECLARE 
   saldo number; 
BEGIN 
   saldo := :NEW.sal  - :OLD.sal; 
   DBMS_OUTPUT.PUT_LINE('Salario Anterior: ' || :OLD.sal); 
   DBMS_OUTPUT.PUT_LINE('Salario Novo: ' || :NEW.sal); 
   DBMS_OUTPUT.PUT_LINE('Diferença Salarial: ' || saldo); 
END; 
/

SET SERVEROUTPUT ON
UPDATE EMP SET sal = sal * 2
    WHERE empno = 7900
/ 

SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER tgr_mudancas_salariais 
    BEFORE INSERT OR UPDATE OR DELETE ON emp 
    FOR EACH ROW 
DECLARE 
   saldo number; 
BEGIN 
   saldo := :NEW.sal  - :OLD.sal; 
   DBMS_OUTPUT.PUT_LINE('Salario Anterior: ' || :OLD.sal); 
   DBMS_OUTPUT.PUT_LINE('Salario Novo: ' || :NEW.sal); 
   DBMS_OUTPUT.PUT_LINE('Diferença Salarial: ' || saldo); 
END; 
/

-- Acionando o gatilho com um instrução INSERT

SET SERVEROUTPUT ON
INSERT INTO emp (empno, sal)
    VALUES (1000, 2780);
/

-- Acionando o gatilho com uma instrução UPDATE

SET SERVEROUTPUT ON
UPDATE EMP
   SET sal = sal * 2
 WHERE empno = 1000;
/

-- Acionando o gatilho com uma instrução DELETE

SET SERVEROUTPUT ON
DELETE emp
    WHERE empno = 1000;
/
--------------------------------------------------------------------------------

SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER tgr_mudancas_salariais 
    BEFORE INSERT OR UPDATE OR DELETE ON emp 
    FOR EACH ROW 
DECLARE 
   saldo number; 
BEGIN 
    CASE
        WHEN INSERTING THEN
            DBMS_OUTPUT.PUT_LINE('    Novo : ' || :NEW.sal); 
         WHEN UPDATING THEN
            saldo := :NEW.sal  - :OLD.sal; 
                DBMS_OUTPUT.PUT_LINE('Anterior : ' || :OLD.sal); 
                DBMS_OUTPUT.PUT_LINE('    Novo : ' || :NEW.sal); 
                DBMS_OUTPUT.PUT_LINE('Diferenca: ' || saldo); 
         WHEN DELETING THEN
            DBMS_OUTPUT.PUT_LINE('Anterior : ' || :OLD.sal); 
    END CASE;
END; 
/

-- Acionando o gatilho com uma instrução INSERT

SET SERVEROUTPUT ON
INSERT INTO emp (empno, sal)
    VALUES (1000, 2780);
/

-- Acionando o gatilho com uma instrução UPDATE

SET SERVEROUTPUT ON
UPDATE EMP SET sal = sal * 2
    WHERE empno = 1000;
/

-- Acionando o gatilho com uma instrução DELETE
SET SERVEROUTPUT ON
DELETE emp
    WHERE empno = 1000;
/
--------------------------------------------------------------------------------

-- Transações autônomas com Trigger

SET SERVEROUTPUT ON
CREATE TABLE auditoria
    (codigo   NUMBER(5),
     hora     DATE,
     operacao VARCHAR2(6),
     antigo   NUMBER (7,2),
     novo     NUMBER (7,2));
  
CREATE OR REPLACE PROCEDURE sp_registra
     (p_codigo   IN  VARCHAR2,
      P_operacao IN  VARCHAR2,
      P_antigo   IN  NUMBER,
      P_novo     IN  NUMBER) AS
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO auditoria (codigo, hora, operacao, antigo, novo)
        VALUES (p_codigo, SYSDATE, p_operacao, p_antigo, p_novo);
    COMMIT;
END;
/

CREATE OR REPLACE TRIGGER tgr_mudancas_salariais 
    BEFORE INSERT OR UPDATE OR DELETE ON emp 
    FOR EACH ROW 
BEGIN 
   CASE
     WHEN INSERTING THEN
          sp_registra(:NEW.empno, 'INSERT', :OLD.sal, :NEW.sal);  
     WHEN UPDATING THEN
          sp_registra(:OLD.empno, 'UPDATE', :OLD.sal, :NEW.sal);  
     WHEN DELETING THEN
          sp_registra(:OLD.empno, 'DELETE', :OLD.sal, :NEW.sal);  
    END CASE;
END; 
/
-------------------

-- Acionando o gatilho com um instrução INSERT
SET SERVEROUTPUT ON
ALTER SESSION SET nls_date_format='DD/MM/YY HH24:MI:SS';
INSERT INTO emp (empno, sal)
    VALUES (1000, 2780);
/
SELECT * FROM auditoria;


-- Acionando o gatilho com uma instrução UPDATE

UPDATE EMP SET sal = sal * 2
    WHERE empno = 1000;
/
SELECT * FROM auditoria;


-- Acionando o gatilho com uma instrução DELETE

DELETE emp
    WHERE empno = 1000;
/
SELECT * FROM auditoria;
--------------------------------------------------------------------------------

-- Testando condições com WHEN

CREATE OR REPLACE TRIGGER tgr_mudancas_salariais 
    BEFORE INSERT OR DELETE OR UPDATE OF sal ON emp 
    FOR EACH ROW 
    WHEN(NEW.SAL > 1000)
BEGIN 
    CASE
        WHEN INSERTING THEN
            sp_registra(:NEW.empno, 'INSERT', :OLD.sal, :NEW.sal);  
        WHEN UPDATING THEN
            sp_registra(:OLD.empno, 'UPDATE', :OLD.sal, :NEW.sal);  
        WHEN DELETING THEN
            sp_registra(:OLD.empno, 'DELETE', :OLD.sal, :NEW.sal);  
    END CASE;
END; 
/


-- Tentativa de acionar o gatilho com uma instrução INSERT 
-- e salário inferior a 1000

TRUNCATE TABLE auditoria;

INSERT INTO emp (empno, sal)
    VALUES (1000, 780);

SELECT * FROM auditoria;

-- Acionando o gatilho com uma instrução INSERT e
-- salário superior a 1000

INSERT INTO emp (empno, sal)
VALUES (1001, 2780);

SELECT * FROM auditoria;


-- Tentativa de acionar o gatilho com uma instrução UPDATE e
-- salário inferior a 1000

UPDATE EMP SET sal = 780
    WHERE empno = 1000;

SELECT * FROM auditoria;

-- Acionando o gatilho com uma instrução UPDATE e
-- salário superior a 1000

UPDATE EMP SET sal = 3000
    WHERE empno = 1000;

SELECT * FROM auditoria;

-- Tentativa de acionar o gatilho com uma instrução DELETE e
-- salário superior a 1000

DELETE emp
    WHERE empno = 1000;

SELECT * FROM auditoria;

CREATE OR REPLACE TRIGGER tgr_mudancas_salariais 
    BEFORE INSERT OR DELETE OR UPDATE OF sal ON emp 
    FOR EACH ROW 
    WHEN(NEW.SAL > 1000 OR OLD.SAL > 1000)
BEGIN 
    CASE
        WHEN INSERTING THEN
            sp_registra(:NEW.empno, 'INSERT', :OLD.sal, :NEW.sal);  
        WHEN UPDATING THEN
            sp_registra(:OLD.empno, 'UPDATE', :OLD.sal, :NEW.sal);  
        WHEN DELETING THEN
            sp_registra(:OLD.empno, 'DELETE', :OLD.sal, :NEW.sal);  
    END CASE;
END; 
/
--------------------------------------------------------------------------------

-- Cláusula Referencing

CREATE OR REPLACE TRIGGER tgr_mudancas_salariais 
    BEFORE INSERT OR DELETE OR UPDATE OF sal ON emp 
    REFERENCING NEW AS novo_emp
                OLD AS antigo_emp
    FOR EACH ROW 
    WHEN(novo_emp.SAL > 1000 OR antigo_emp.SAL > 1000)
BEGIN 
    CASE
        WHEN INSERTING THEN
            sp_registra(:novo_emp.empno,    'INSERT', :antigo_emp.sal, :novo_emp.sal);  
        WHEN UPDATING THEN
            sp_registra(:antigo_emp.empno,  'UPDATE', :antigo_emp.sal, :novo_emp.sal);  
        WHEN DELETING THEN
            sp_registra(:antigo_emp.empno,  'DELETE', :antigo_emp.sal, :novo_emp.sal);  
    END CASE;
END; 
/

-- Momento de Ativação

SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER tgr_testa_momento 
    BEFORE INSERT OR UPDATE OR DELETE ON emp 
BEGIN 
    CASE
        WHEN INSERTING THEN
            DBMS_OUTPUT.PUT_LINE('Insert – BEFORE STATEMENT'); 
        WHEN UPDATING THEN
            DBMS_OUTPUT.PUT_LINE('Update – BEFORE STATEMENT'); 
        WHEN DELETING THEN
            DBMS_OUTPUT.PUT_LINE('Delete – BEFORE STATEMENT'); 
    END CASE;
END; 
/


-- Acionando o gatilho BEFORE STATEMENT com o comando DELETE

DELETE emp;
ROLLBACK;

SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER tgr_testa_momento 
    BEFORE INSERT OR UPDATE OR DELETE ON emp
    FOR EACH ROW 
BEGIN 
    CASE
        WHEN INSERTING THEN
            DBMS_OUTPUT.PUT_LINE('Insert – BEFORE EACH ROW'); 
         WHEN UPDATING THEN
              DBMS_OUTPUT.PUT_LINE('Update – BEFORE EACH ROW'); 
         WHEN DELETING THEN
              DBMS_OUTPUT.PUT_LINE('Delete – BEFORE EACH ROW'); 
    END CASE;
END; 
/

-- Acionando o gatilho BEFORE EACH ROW com o comando DELETE

DELETE emp;
ROLLBACK;


SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER tgr_testa_momento 
    AFTER INSERT OR UPDATE OR DELETE ON emp
    FOR EACH ROW 
BEGIN 
    CASE
        WHEN INSERTING THEN
            DBMS_OUTPUT.PUT_LINE('Insert – AFTER EACH ROW'); 
         WHEN UPDATING THEN
              DBMS_OUTPUT.PUT_LINE('Update – AFTER EACH ROW'); 
         WHEN DELETING THEN
              DBMS_OUTPUT.PUT_LINE('Delete – AFTER EACH ROW'); 
    END CASE;
END; 
/

-- Acionando o gatilho AFTER EACH ROW com o comando DELETE

DELETE emp;
ROLLBACK;

SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER tgr_testa_momento 
    AFTER INSERT OR UPDATE OR DELETE ON emp
BEGIN 
    CASE
        WHEN INSERTING THEN
            DBMS_OUTPUT.PUT_LINE('Insert – AFTER STATEMENT'); 
         WHEN UPDATING THEN
              DBMS_OUTPUT.PUT_LINE('Update – AFTER STATEMENT'); 
         WHEN DELETING THEN
              DBMS_OUTPUT.PUT_LINE('Delete – AFTER STATEMENT'); 
    END CASE;
END; 
/

-- Acionando o gatilho AFTER STATEMENT com o comando DELETE

DELETE emp;
ROLLBACK;