-- Aula 5.1 - Incluindo um Cliente

CREATE OR REPLACE PROCEDURE pr_incluir_cliente
(p_id CLIENTE.ID%type,
 p_razao CLIENTE.razao_social%type,
 p_cnpj CLIENTE.cnpj%type,
 p_segmercado CLIENTE.segmercado_ID%type,
 p_faturamento CLIENTE.faturamento_previsto%type,
 p_categoria CLIENTE.categoria%type)
IS
BEGIN
    INSERT INTO CLIENTE
        VALUES(p_id, p_razao, p_cnpj, p_segmercado, SYSDATE, p_faturamento, p_categoria);
    COMMIT;
END;
/

SELECT * FROM CLIENTE;
EXECUTE pr_incluir_cliente(1, 'Supermercado Campeão', '1234567890', 1, 90000, 'Médio Grande');

CREATE OR REPLACE PROCEDURE pr_incluir_dados_venda
(p_id PRODUTO_VENDA_EXERCICIO.id%type,
 p_cod_produto PRODUTO_VENDA_EXERCICIO.cod_produto%type,
 p_data PRODUTO_VENDA_EXERCICIO.data%type,
 p_quantidade PRODUTO_VENDA_EXERCICIO.quantidade%type,
 p_preco PRODUTO_VENDA_EXERCICIO.preco%type,
 p_valor PRODUTO_VENDA_EXERCICIO.valor_total%type,
 p_imposto PRODUTO_VENDA_EXERCICIO.percentual_imposto%type)
IS
BEGIN
    INSERT INTO PRODUTO_VENDA_EXERCICIO
        VALUES(p_id, p_cod_produto, p_data, p_quantidade, p_preco, p_valor, p_imposto);
END;
/

SELECT * FROM PRODUTO_VENDA_EXERCICIO;
EXECUTE pr_incluir_dados_venda(1, '41232', TO_DATE('01/01/2022', 'DD/MM/YYYY'), 100, 10, 1000, 10);

--------------------------------------------------------------------------------

-- Aula 5.2 - Obtendo a categoria

-- Pequeno fatura até 10000
-- Médio entre 10001 e 50000
-- Médio grande entre 50001 e 100000
-- Grande mais de 100000

SET SERVEROUTPUT ON

DECLARE
    v_Faturamento cliente.faturamento_previsto%type := 65000;
    v_Categoria cliente.categoria%type;
BEGIN
    IF v_Faturamento <= 10000 THEN
       v_Categoria := 'PEQUENO';
    ELSIF v_Faturamento <= 50000 THEN
          v_Categoria := 'MÉDIO';
    ELSIF v_Faturamento <= 100000 THEN
          v_Categoria := 'MÉDIO GRANDE';
    ELSE 
        v_Categoria := 'GRANDE';
    END IF;
        dbms_output.put_line('A categoria é ' || v_Categoria);
END;
/
--------------------------------------------------------------------------------

-- Aula 5.3 - Criando a função para obter a categoria

CREATE OR REPLACE FUNCTION fn_categoria_cliente
(p_Faturamento IN cliente.FATURAMENTO_PREVISTO%type)
RETURN CLIENTE.categoria%type
IS     
    v_Categoria cliente.categoria%type;
BEGIN
    IF p_Faturamento <= 10000 THEN
       v_Categoria := 'PEQUENO';
    ELSIF p_Faturamento <= 50000 THEN
          v_Categoria := 'MÉDIO';
    ELSIF p_Faturamento <= 100000 THEN
          v_Categoria := 'MÉDIO GRANDE';
    ELSE 
        v_Categoria := 'GRANDE';
    END IF;
        dbms_output.put_line('A categoria é ' || v_Categoria);
    RETURN v_Categoria;
END;
/

VARIABLE g_Categoria VARCHAR2(100);
EXECUTE :g_Categoria := fn_categoria_cliente(1000);
PRINT g_Categoria;

-----------

CREATE OR REPLACE FUNCTION FN_RETORNA_IMPOSTO 
(p_COD_PRODUTO produto_venda_exercicio.cod_produto%type)
RETURN produto_venda_exercicio.percentual_imposto%type
IS
   v_CATEGORIA produto_exercicio.categoria%type;
   v_IMPOSTO produto_venda_exercicio.percentual_imposto%type;
BEGIN
    v_CATEGORIA := fn_retorna_categoria(p_COD_PRODUTO);
    IF TRIM(v_CATEGORIA) = 'Sucos de Frutas' THEN
        v_IMPOSTO := 10;
    ELSIF  TRIM(v_CATEGORIA) = 'Águas' THEN
        v_IMPOSTO := 20;
    ELSIF  TRIM(v_CATEGORIA) = 'Mate' THEN
        v_IMPOSTO := 15;
    END IF;
    RETURN v_IMPOSTO;
END;
/
--------------------------------------------------------------------------------

-- Aula 5.4 - Complementando a procedure

create or replace PROCEDURE pr_incluir_cliente
(p_id CLIENTE.ID%type,
 p_razao CLIENTE.razao_social%type,
 p_cnpj CLIENTE.cnpj%type,
 p_segmercado CLIENTE.segmercado_ID%type,
 p_faturamento CLIENTE.faturamento_previsto%type)
IS
    v_categoria CLIENTE.categoria%type;
BEGIN
    v_categoria := fn_categoria_cliente(p_faturamento);
    
    INSERT INTO CLIENTE
        VALUES(p_id, p_razao, p_cnpj, p_segmercado, SYSDATE, p_faturamento, v_categoria);
    COMMIT;
END;
/

SELECT * FROM CLIENTE;

EXECUTE pr_incluir_cliente(2, 'SUPERMERCADO DO VALE', '1111111111', 1, 90000);

EXECUTE pr_incluir_cliente(3, 'SUPERMERCADO CARIOCA', '2222222222', 1, 30000);







