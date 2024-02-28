-- Aula 3.1 - Primeiro Comando SQL

ALTER USER cursoplsql QUOTA UNLIMITED ON USERS;

INSERT INTO SEGMERCADO (ID, DESCRICAO)
    VALUES(1, 'Varejo');

SELECT * FROM SEGMERCADO;
DELETE FROM SEGMERCADO;
--------------------------------------------------------------------------------

DECLARE
    v_id NUMBER(5) := 2;
    v_descricao VARCHAR2(100) := 'Industria';
BEGIN
    INSERT INTO SEGMERCADO (ID, DESCRICAO)
        VALUES(v_id, v_descricao);
    COMMIT;
END;
/
--------------------------------------------------------------------------------

DECLARE
    v_cod VARCHAR2(5) := '41232';
    v_descricao VARCHAR2(100) := 'Sabor de Verão - Laranja - 1 Litro';
    v_categoria VARCHAR2(100) := 'Sucos de Frutas';
BEGIN
    INSERT INTO PRODUTO_EXERCICIO (COD, DESCRICAO, CATEGORIA)
        VALUES(v_cod, v_descricao, v_categoria);
    COMMIT;
END;
/

SELECT * FROM PRODUTO_EXERCICIO;
--------------------------------------------------------------------------------

-- Aula 3.2 - Percent Type

DECLARE
    v_id SEGMERCADO.ID%type := 3;
    v_descricao SEGMERCADO.DESCRICAO%type := 'Atacado';
BEGIN
    INSERT INTO SEGMERCADO (ID, DESCRICAO)
        VALUES(v_id, v_descricao);
    COMMIT;
END;
/

SELECT * FROM SEGMERCADO;
--------------------------------------------------------------------------------
-- EXERCICIO
DECLARE
    v_cod PRODUTO_EXERCICIO.COD%type := '32223';
    v_descricao PRODUTO_EXERCICIO.DESCRICAO%type := 'Sabor de Verão - Uva - 1 Litro';
    v_categoria PRODUTO_EXERCICIO.CATEGORIA%type := 'Sucos de Frutas';
BEGIN
    INSERT INTO PRODUTO_EXERCICIO (COD, DESCRICAO, CATEGORIA)
        VALUES(v_cod, v_descricao, v_categoria);
    COMMIT;
END;
/
SELECT * FROM PRODUTO_EXERCICIO;

-- Exercicio

DECLARE
   v_COD produto_exercicio.cod%type := '67120';
   v_DESCRICAO produto_exercicio.descricao%type := 'Frescor da Montanha - Aroma Limão - 1 Litro';
   v_CATEGORIA produto_exercicio.categoria%type := 'Águas';
BEGIN
   INSERT INTO PRODUTO_EXERCICIO (COD, DESCRICAO, CATEGORIA)
   VALUES (v_COD, REPLACE(v_DESCRICAO,'-','>'), v_CATEGORIA);
   COMMIT;
END;
/

SELECT * FROM produto_exercicio;
--------------------------------------------------------------------------------

-- Aula 3.3 - Vários comandos em um bloco

DECLARE
    v_id SEGMERCADO.ID%type := 3;
    v_descricao SEGMERCADO.DESCRICAO%type := 'Atacadista';
BEGIN
    UPDATE SEGMERCADO SET DESCRICAO = UPPER(v_descricao) WHERE ID = v_id;
    v_id := 1;
    v_descricao := 'Varejista';
    UPDATE SEGMERCADO SET DESCRICAO = UPPER(v_descricao) WHERE ID = v_id;
    v_id := 2;
    v_descricao := 'Industrial';
    UPDATE SEGMERCADO SET DESCRICAO = UPPER(v_descricao) WHERE ID = v_id;
    
    commit;
END;
/

SELECT * FROM SEGMERCADO;

-- Exercicio

DECLARE
  v_COD produto_exercicio.cod%type;
BEGIN
   v_COD := '41232';
   UPDATE PRODUTO_EXERCICIO SET DESCRICAO = REPLACE(DESCRICAO,'-','>') WHERE COD = v_COD;
   v_COD := '32223';
   UPDATE PRODUTO_EXERCICIO SET DESCRICAO = REPLACE(DESCRICAO,'-','>') WHERE COD = v_COD;
   COMMIT;
END;
/

SELECT * FROM produto_exercicio;

--------------------------------------------------------------------------------

-- Aula 3.4 - Excluindo o segmento de mercado

DECLARE
    v_id SEGMERCADO.ID%type := 5;
    v_descricao SEGMERCADO.DESCRICAO%type := 'Esportistas';
BEGIN
    INSERT INTO SEGMERCADO (ID, DESCRICAO)
        VALUES(v_id, UPPER(v_descricao));
    COMMIT;
END;
/

SELECT * FROM SEGMERCADO;

-- Excluindo id 5
DECLARE
    v_id SEGMERCADO.ID%type := 5;
BEGIN
    DELETE FROM SEGMERCADO WHERE ID = v_id;
    COMMIT;
END;
/

-- Inclusão de Segmento de Mercado
DECLARE
    v_id SEGMERCADO.ID%type := 5;
    v_descricao SEGMERCADO.DESCRICAO%type := 'Esportistas';
BEGIN
    INSERT INTO SEGMERCADO (ID, DESCRICAO)
        VALUES(v_id, UPPER(v_descricao));
    COMMIT;
END;
/

-- Atualização de Segmento de Mercado
DECLARE
    v_id SEGMERCADO.ID%type := 3;
    v_descricao SEGMERCADO.DESCRICAO%type := 'Atacadista';
BEGIN
    UPDATE SEGMERCADO SET DESCRICAO = UPPER(v_descricao) WHERE ID = v_id;
    v_id := 1;
    v_descricao := 'Varejista';
    UPDATE SEGMERCADO SET DESCRICAO = UPPER(v_descricao) WHERE ID = v_id;
    v_id := 2;
    v_descricao := 'Industrial';
    UPDATE SEGMERCADO SET DESCRICAO = UPPER(v_descricao) WHERE ID = v_id;
    
    commit;
END;
/

-- Exclusão de Segmento de Mercado
DECLARE
    v_id SEGMERCADO.ID%type := 5;
BEGIN
    DELETE FROM SEGMERCADO WHERE ID = v_id;
    COMMIT;
END;
/

-- Exercicio

DECLARE
   v_COD produto_exercicio.cod%type := '92347';
   v_DESCRICAO produto_exercicio.descricao%type := 'Aroma do Campo - Mate - 1 Litro';
   v_CATEGORIA produto_exercicio.categoria%type := 'Águas';
BEGIN
   INSERT INTO PRODUTO_EXERCICIO (COD, DESCRICAO, CATEGORIA) 
        VALUES (v_COD, REPLACE(v_DESCRICAO,'-','>'), v_CATEGORIA);
   COMMIT;
END;
/


DECLARE
   v_COD produto_exercicio.cod%type := '92347';
   v_CATEGORIA produto_exercicio.categoria%type := 'Mate';
BEGIN
   UPDATE PRODUTO_EXERCICIO SET CATEGORIA = v_CATEGORIA WHERE COD = v_COD;
   COMMIT;
END;
/