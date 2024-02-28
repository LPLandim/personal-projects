SELECT * FROM TABELA_DE_CLIENTES;

SELECT CPF, NOME, BAIRRO, CIDADE 
    FROM TABELA_DE_CLIENTES;

SELECT NOME, CPF, CIDADE, BAIRRO 
    FROM TABELA_DE_CLIENTES;

SELECT NOME AS "Nome do Cliente", CPF AS "Identificador", CIDADE, BAIRRO 
    FROM TABELA_DE_CLIENTES;

SELECT nome AS "Nome do Cliente", cpf AS "Identificador", cidade, TDC.bairro
    FROM TABELA_DE_CLIENTES TDC;
    
SELECT TDC.* FROM TABELA_DE_CLIENTES TDC;   

--------------------------------------------------------------------

-- Aula 2.2 - Consulta com filtro

SELECT * FROM TABELA_DE_PRODUTOS;

SELECT * FROM TABELA_DE_PRODUTOS WHERE 1=1;

SELECT * FROM TABELA_DE_PRODUTOS WHERE CODIGO_DO_PRODUTO = '290478';

SELECT * FROM TABELA_DE_PRODUTOS WHERE SABOR = 'Laranja';

SELECT * FROM TABELA_DE_PRODUTOS WHERE EMBALAGEM = 'PET'; -- true

SELECT * FROM TABELA_DE_PRODUTOS WHERE EMBALAGEM = 'pet'; -- false


------------------------------------------------------------------------

-- Aula 2.3 - Filtros quantitativos

SELECT * FROM TABELA_DE_CLIENTES;

SELECT * FROM TABELA_DE_CLIENTES 
    WHERE IDADE > 20;
    
SELECT * FROM TABELA_DE_CLIENTES 
    WHERE IDADE < 20; 
    
SELECT * FROM TABELA_DE_CLIENTES 
    WHERE IDADE <> 18;
    
SELECT * FROM TABELA_DE_CLIENTES 
    WHERE IDADE BETWEEN 18 AND 22;
    
SELECT * FROM TABELA_DE_CLIENTES 
    WHERE DATA_DE_NASCIMENTO >= TO_DATE('14/11/1995', 'DD/MM/YYYY');
    
SELECT * FROM TABELA_DE_CLIENTES
    WHERE BAIRRO >= 'Lapa';
    
----------------------------------------------------------------------

-- Aula 2.4 - Expressões Lógicas

SELECT * FROM TABELA_DE_PRODUTOS    
    WHERE SABOR = 'Manga' OR TAMANHO = '470 ml'; 
    
SELECT * FROM TABELA_DE_PRODUTOS    
    WHERE SABOR = 'Manga' AND TAMANHO = '470 ml'; 

SELECT * FROM TABELA_DE_PRODUTOS    
    WHERE NOT (SABOR = 'Manga' AND TAMANHO = '470 ml');

SELECT * FROM TABELA_DE_PRODUTOS    
    WHERE NOT (SABOR = 'Manga' OR TAMANHO = '470 ml');   
    
----------------------------------------------------------------------
SELECT * FROM TABELA_DE_PRODUTOS
    WHERE SABOR = 'Manga' OR SABOR = 'Laranja' OR SABOR = 'Melancia';
    
SELECT * FROM TABELA_DE_PRODUTOS
    WHERE SABOR IN ('Manga', 'Laranja', 'Melancia');   
    
SELECT * FROM TABELA_DE_PRODUTOS
    WHERE SABOR IN ('Manga', 'Laranja', 'Melancia') AND TAMANHO = '1 Litro'; 
    
    
SELECT * from TABELA_DE_CLIENTES;  
SELECT * from TABELA_DE_CLIENTES
    WHERE cidade in ('Rio de Janeiro', 'Sao Paulo') AND IDADE >= 20;
    
SELECT * from TABELA_DE_CLIENTES
    WHERE cidade IN ('Rio de Janeiro', 'Sao Paulo')
                 AND (IDADE >= 20 AND IDADE <= 25);     

SELECT * from TABELA_DE_CLIENTES
    WHERE cidade IN ('Rio de Janeiro', 'Sao Paulo')
                 AND (IDADE BETWEEN 20 AND 25);  
                 
--------------------------------------------------------    

-- Aula 2.5 -- Usando Like

SELECT * FROM TABELA_DE_PRODUTOS
    WHERE SABOR IN('Lima/Limao', 'Morango/Limao');
    
SELECT * FROM TABELA_DE_PRODUTOS
    WHERE SABOR LIKE '%Limao';
    
SELECT * FROM TABELA_DE_PRODUTOS
    WHERE SABOR LIKE '%Maca';  
    
SELECT * FROM TABELA_DE_PRODUTOS
    WHERE SABOR LIKE '%Maca%';   
    
SELECT * FROM TABELA_DE_PRODUTOS
    WHERE SABOR LIKE '%Morango';      
    
SELECT * FROM TABELA_DE_PRODUTOS
    WHERE SABOR LIKE 'Morango%';
    
SELECT * FROM TABELA_DE_PRODUTOS
    WHERE SABOR LIKE 'Morango%' AND EMBALAGEM = 'PET';   

SELECT * FROM TABELA_DE_CLIENTES
    WHERE NOME LIKE '%Silva%';