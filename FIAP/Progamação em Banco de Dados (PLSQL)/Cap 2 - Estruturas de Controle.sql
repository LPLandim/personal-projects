/* ----------------- Programação em Banco de Dados - FIAP ON -------------------

-- Cap 1. - Estruturas de Controle                                            */

-- Mais sobre tipos de dados

CREATE TABLE tabela1
    (col1 VARCHAR2(18));
INSERT INTO tabela1
  VALUES ('Campo com 18 bytes');
SET serveroutput ON
DECLARE
  v_col1 VARCHAR2(18);
BEGIN
  SELECT col1 INTO v_col1
    FROM tabela1;
  DBMS_OUTPUT.PUT_LINE ('Valor = ' || v_col1);
END;
/
--------------------------------------------------------------------------------

TRUNCATE TABLE tabela1;
ALTER TABLE tabela1
MODIFY col1 VARCHAR2(30);
INSERT INTO tabela1
  VALUES ('Tamanho alterado para 30 bytes');
SET SERVEROUTPUT ON
DECLARE
  v_col1 VARCHAR2(18);
BEGIN
  SELECT col1 INTO v_col1
    FROM tabela1;
  DBMS_OUTPUT.PUT_LINE ('Valor = ' || v_col1);
END;
/
--------------------------------------------------------------------------------

DECLARE
  v_col1 tabela1.col1%TYPE;
BEGIN
  SELECT col1 INTO v_col1
    FROM tabela1;
  DBMS_OUTPUT.PUT_LINE ('Valor = ' || v_col1);
END;
/
--------------------------------------------------------------------------------

-- Estruturas de Seleção
-- IF THEN, IF THEN ELSE, IF THNE ELSIF

-- IF THEN

IF (condição) THEN
    conjunto de instruções;
END IF;
-----------------------------------------------
DECLARE
    v_col1    tabela1.col1%TYPE;
    v_tamanho NUMBER(3);
BEGIN  
    SELECT LENGTH(col1), col1 INTO v_tamanho, v_col1
        FROM tabela1;
    IF v_tamanho > 25 THEN
        DBMS_OUTPUT.PUT_LINE ('Texto = ' || v_col1);
    END IF;
END;
/

-- IF THEN ELSE

IF (condição) THEN
   conjunto de instruções 1;
ELSE
   conjunto de instruções 2;
END IF;
-----------------------------------------------

DECLARE
  v_col1    tabela1.col1%TYPE;
  v_tamanho NUMBER(3);
BEGIN  
    SELECT LENGTH(col1), col1 INTO v_tamanho, v_col1
        FROM tabela1; 
    IF v_tamanho > 25 THEN
        DBMS_OUTPUT.PUT_LINE ('Texto = ' || v_col1);
    ELSE
     DBMS_OUTPUT.PUT_LINE ('Texto menor ou igual a 25');
  END IF;
END;
/

-- IF THEN ELSIF

IF (condição1 ) THEN
          conjunto de instruções 1;
ELSIF (condição 2)
          conjunto de instruções  2 ;
...
ELSE
           conjunto de instruções n;
END IF;
---------------------------------------------

DECLARE
  v_col1    tabela1.col1%TYPE;
  v_tamanho NUMBER(3);
BEGIN
    SELECT LENGTH(col1), col1 INTO v_tamanho, v_col1
        FROM tabela1;
     IF v_tamanho > 25 THEN 
     DBMS_OUTPUT.PUT_LINE ('Texto = ' || v_col1);
  ELSIF v_tamanho > 20 THEN
     DBMS_OUTPUT.PUT_LINE ('Texto maior que 20');
  ELSIF v_tamanho > 15 THEN
     DBMS_OUTPUT.PUT_LINE ('Texto maior que 15');
  ELSE
     DBMS_OUTPUT.PUT_LINE ('Texto menor ou igual a 15');
    END IF;
END;
/
--------------------------------------------------------------------------------

-- AND OR

-- AND
DECLARE
  v_tamanho NUMBER(3);
BEGIN  
    SELECT LENGTH(col1) INTO v_tamanho
        FROM tabela1;  
    IF v_tamanho > 25 AND
    TO_CHAR(SYSDATE, 'YYYY') = 2023 THEN
        DBMS_OUTPUT.PUT_LINE ('Maior que 25 bytes e ano 2023');
    END IF;
END;
/
------------------------------------

-- OR
DECLARE
  v_tamanho NUMBER(3);
BEGIN  
    SELECT LENGTH(col1) INTO v_tamanho
        FROM tabela1;
    IF v_tamanho > 25 OR TO_CHAR(SYSDATE, 'YYYY') = 2023 THEN 
        DBMS_OUTPUT.PUT_LINE ('Maior que 25 bytes ou ano 2023');
    END IF;
END;
/

--------------------------------------------------------------------------------

-- Estruturas de Repetição

-- Loop básico para fornecer ações repetitivas sem condições gerais.
-- Loop FOR para fornecer controle iterativo para ações com base em uma contagem.
-- Loop WHILE para fornecer controle iterativo para ações com base em uma condição.

--------------------------------------------------------------------------------

-- LOOP BÁSICO

LOOP  -- delimitador de início do laço                          
 conjunto de instruções; -- instruções a serem executadas
  EXIT [WHEN condição]; -- ponto de saída do laço - condição de saída do laço
END LOOP; -- delimitador de fim do laço
----------------------------------------------------

DECLARE
  v_contador NUMBER(2) := 1;
BEGIN  
    LOOP
        INSERT INTO tabela1
        VALUES ('Inserindo texto numero ' || v_contador);
        v_contador := v_contador + 1;
        EXIT WHEN v_contador > 10;  
    END LOOP;
END;
/

SELECT * FROM tabela1;
--------------------------------------------

-- LOOP FOR

FOR contador in [REVERSE] limite_inferior..limite_superior  
    LOOP  
        conjunto de instruções;
  . . .
    END LOOP;
---------------------------------------

BEGIN  FOR i IN 11..20
    LOOP
        INSERT INTO tabela1
        VALUES ('Inserindo texto numero ' || i);
    END LOOP;
END;
/
SELECT * FROM tabela1;
--------------------------------------------------------------------------------

-- LOOP WHILE

WHILE condição 
    LOOP
        conjunto de instruções;
    . . .
    END LOOP;
---------------------------------

DECLARE
  v_contador NUMBER(2) := 1;
BEGIN  
    WHILE v_contador <= 10 
    LOOP
        INSERT INTO tabela1
            VALUES ('Inserindo texto numero ' || v_contador);
        v_contador := v_contador + 1;  
    END LOOP;
END;
/
SELECT * FROM tabela1;
--------------------------------------------------------------------------------

-- LOOP ANINHADO

BEGIN  
    FOR i IN 1..3 
    LOOP
        FOR j IN 1..5 
        LOOP
            INSERT INTO tabela1
            VALUES ('Inserindo texto numero ' || i || j);
        END LOOP;
    END LOOP;
END;
/
SELECT * FROM tabela1;