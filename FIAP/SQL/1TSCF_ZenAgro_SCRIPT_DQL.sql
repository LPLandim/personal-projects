-- SCRIPT DQL (Data Query Language) -> LINGUAGEM DE CONSULTA DE DADOS 

--Gabriela Soares Teixeira - RM98853
--Gustavo Santana Pereira - RM98935
--Lucas Paes Landim Pereira - RM550394
--Renan Macedo Carrara Coimbra- RM552187

-- Primeira consulta
-- Com essa consulta estamos selecionando os campos CD_CUSTO, CD_PRODUCAO e VL_JUROS da tabela t_outro_custo.
-- Procurando por registros onde o valor dos juros (VL_JUROS) é maior que 70000. 
-- Os resultados estão sendo ordenados de forma crescente pelo código do custo (CD_CUSTO).

SELECT CD_CUSTO,CD_PRODUCAO,VL_JUROS FROM t_outro_custo WHERE VL_JUROS > 70000 ORDER BY CD_CUSTO ASC;

--SEGUNDA consulta
-- Com esta consulta fornecemos uma lista dos códigos de produção e durações das safras para as safras de ‘Mandioca Tipo A’ ou ‘Mandioca Tipo B’ 
-- que tem a data de inicio após 1º de janeiro de 2020, com as safras mais longas listadas primeiro.

SELECT 
    CD_PRODUCAO, 
    (DT_FIM_SAFRA - DT_INICIO_SAFRA) AS duracao_safra
FROM 
    T_PRODUCAO
WHERE 
    DT_INICIO_SAFRA > TO_DATE('2020-01-01', 'YYYY-MM-DD') AND
    DS_PRODUTO IN ('Mandioca')
ORDER BY 
    duracao_safra DESC;

-- Terceira consulta
-- Com essa consulta estamos selecionando os campos CD_PRODUCAO e DT_INICIO_SAFRA da tabela T_PRODUCAO.
-- Procurando por registros onde a data de início da safra (DT_INICIO_SAFRA) está entre 3 de janeiro de 2020.
-- e 5 de janeiro de 2022, ou no ano de 2022.
SELECT CD_PRODUCAO, DT_INICIO_SAFRA FROM T_PRODUCAO WHERE DT_INICIO_SAFRA BETWEEN '03-01-20' AND '05-01-22' OR TO_CHAR(dt_inicio_safra, 'YYYY') = '2022';

-- Quarta consulta
-- Com essa consulta selecionando o nome do produtor (nm_produtor), o endereço (ds_endereco)
-- e o valor total da lavoura (vl_total_lavoura) da tabela T_PRODUTOR (com o apelido de P) e da tabela t_despesa_lavoura (com o apelido de D). 
-- procurando por produtores cujo tipo de produto é ‘Mandioca Tipo A’. 
-- Os resultados estão ordenados de forma decrescente pelo valor total da lavoura.
SELECT
    P.nm_produtor, 
    P.ds_endereco, 
    D.vl_total_lavoura
FROM 
    T_PRODUTOR P
INNER JOIN 
    t_despesa_lavoura D ON P.cd_produtor = D.cd_produtor
WHERE 
    P.tp_produto = 'Mandioca Tipo A'
ORDER BY 
    3 DESC;


