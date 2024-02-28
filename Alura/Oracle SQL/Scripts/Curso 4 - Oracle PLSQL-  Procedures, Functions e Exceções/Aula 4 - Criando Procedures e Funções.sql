-- Aula 4.1 - Criando a primera procedure

CREATE PROCEDURE pr_incluir_segmercado
(p_id IN NUMBER, 
 p_descricao IN VARCHAR2)
IS
BEGIN
    INSERT INTO SEGMERCADO (ID, DESCRICAO)
        VALUES(P_id, UPPER(P_descricao));
    COMMIT;
END;
/

SELECT * FROM SEGMERCADO;

-- Executando a procedure
EXECUTE pr_incluir_segmercado(4, 'Farmaceuticos');

BEGIN
    pr_incluir_segmercado(4, 'Farmaceuticos');
END;
/
--------------------------------------------------------------------------------

-- Aula 4.2 - Alterando e excluindo uma procedure

CREATE OR REPLACE PROCEDURE pr_incluir_segmercado
(p_id IN SEGMERCADO.ID%type, 
 p_descricao IN SEGMERCADO.DESCRICAO%type)
IS
BEGIN
    INSERT INTO SEGMERCADO (ID, DESCRICAO)
        VALUES(P_id, UPPER(P_descricao));
    COMMIT;
END;
/


CREATE OR REPLACE PROCEDURE pr_incluir_segmercado2
(p_id IN SEGMERCADO.ID%type, 
 p_descricao IN SEGMERCADO.DESCRICAO%type)
IS
BEGIN
    INSERT INTO SEGMERCADO (ID, DESCRICAO)
        VALUES(P_id, UPPER(P_descricao));
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE pr_incluir_segmercado3
(p_id IN SEGMERCADO.ID%type, 
 p_descricao IN SEGMERCADO.DESCRICAO%type)
IS
BEGIN
    INSERT INTO SEGMERCADO (ID, DESCRICAO)
        VALUES(P_id, UPPER(P_descricao));
    COMMIT;
END;
/

DROP PROCEDURE PR_INCLUIR_SEGMERCADO3;

-- EXERCICIO

CREATE OR REPLACE PROCEDURE pr_incluindo_produto
(p_cod IN produto_exercicio.cod%type,
 p_descricao IN produto_exercicio.descricao%type,
 p_categoria IN produto_exercicio.categoria%type)
IS
BEGIN
    INSERT INTO PRODUTO_EXERCICIO (COD, DESCRICAO, CATEGORIA)
        VALUES(p_cod, p_descricao, p_categoria);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE PR_ALTERANDO_CATEGORIA_PRODUTO
(p_cod IN produto_exercicio.cod%type,
 p_categoria IN PRODUTO_EXERCICIO.categoria%type)
IS

BEGIN
    UPDATE PRODUTO_EXERCICIO SET CATEGORIA = p_categoria WHERE COD = p_cod;
END;
/

CREATE OR REPLACE PROCEDURE PR_EXCLUINDO_PRODUTO 
(p_COD produto_exercicio.cod%type)
IS
BEGIN
   DELETE FROM PRODUTO_EXERCICIO WHERE COD = P_COD;
   COMMIT;
END;
/


EXECUTE pr_incluindo_produto('33854','Frescor da Montanha - Aroma Laranja - 1 Litro','Mate');
EXECUTE pr_incluindo_produto('89254','Frescor da Montanha - Aroma Uva - 1 Litro','Águas');
EXECUTE pr_alterando_categoria_produto('33854','Águas');
EXECUTE pr_excluindo_produto('89254');

SELECT * FROM PRODUTO_EXERCICIO;

--------------------------------------------------------------------------------

-- Aula 4.3 - Retornando o descritor do segmento de mercado

SET SERVEROUTPUT ON;
DECLARE
    v_id SEGMERCADO.id%type := 4;
    v_descricao SEGMERCADO.descricao%type;
BEGIN
    SELECT DESCRICAO INTO v_descricao FROM SEGMERCADO WHERE ID = v_id;
    dbms_output.put_line(v_descricao);
END;
/

SELECT DESCRICAO FROM SEGMERCADO WHERE ID = 2;

SET SERVEROUTPUT ON;
DECLARE
    v_id SEGMERCADO.id%type := 3;
    v_idSaida SEGMERCADO.id%type;
    v_descricao SEGMERCADO.descricao%type;
BEGIN
    SELECT DESCRICAO INTO v_descricao FROM SEGMERCADO WHERE ID = v_id;
    SELECT ID INTO v_idSaida FROM SEGMERCADO WHERE ID = v_id;
    dbms_output.put_line(v_descricao);
    dbms_output.put_line(v_idSaida);
END;
/
--------------------------------------------------------------------------------

-- Aula 4.4 - Criando uma Função

CREATE OR REPLACE FUNCTION fn_obter_descricao_segmercado
(f_id IN SEGMERCADO.ID%type)
RETURN SEGMERCADO.DESCRICAO%type
IS
    f_descricao SEGMERCADO.DESCRICAO%type;
BEGIN
    SELECT DESCRICAO INTO f_descricao FROM SEGMERCADO WHERE ID = f_id;
    RETURN f_descricao;
END;
/

SELECT ID, fn_obter_descricao_segmercado(id),descricao, LOWER(DESCRICAO) FROM SEGMERCADO;

-- Exercicio

CREATE OR REPLACE FUNCTION FN_RETORNA_CATEGORIA 
(f_cod IN PRODUTO_EXERCICIO.cod%type)
RETURN PRODUTO_EXERCICIO.Categoria%type
IS 
    f_categoria PRODUTO_EXERCICIO.categoria%type;
BEGIN
    SELECT categoria INTO f_categoria FROM PRODUTO_EXERCICIO WHERE cod = f_cod;
    RETURN f_categoria;
END;
/

SELECT COD, FN_RETORNA_CATEGORIA(cod), categoria
    FROM PRODUTO_EXERCICIO;
--------------------------------------------------------------------------------

-- Aula 4.5 - Executando a função

VARIABLE g_descricao VARCHAR2(100);
EXECUTE :g_descricao := fn_obter_descricao_segmercado(3);
PRINT g_descricao;

SET SERVEROUTPUT ON;
DECLARE 
    v_descricao SEGMERCADO.descricao%type;
    v_id SEGMERCADO.ID%type := 2;
BEGIN
    v_descricao := fn_obter_descricao_segmercado(v_id);
    dbms_output.put_line('A descrição do segmento de mercado é: ' || v_descricao);
END;