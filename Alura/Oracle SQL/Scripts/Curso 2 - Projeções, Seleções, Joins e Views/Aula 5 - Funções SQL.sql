/* --------------------------------- Aula 5 ------------------------------------
                                 Funções no SQL

-- String (textos)
-- Datas
-- Matemáticas (number)
-- Conversão de Dados
                                                                              
--------------------------------------------------------------------------------

-- Aula 5.1 -- Funções de String

LOWER
Começaremos pela função LOWER, que converte todo um texto em letras minúsculas.
Assim, se aplicarmos o LOWER a um texto escrito com letras maiúsculas e minúsculas,
ele será todo convertido para letras minúsculas.

---------------------------------------------------------------------------------

UPPER
O UPPER faz o oposto: transforma todo o texto em letras maiúsculas.

---------------------------------------------------------------------------------

INITCAP
O INITCAP torna maiúscula só a primeira letra de cada palavra do texto.

Um exemplo prático de uso da INITCAP é quando temos um banco de dados com uma coluna que
contém nomes próprios. Digamos que uma tela de entrada de dados
é a fonte que alimenta cada linha da tabela com nomes, que são digitados por pessoas.

Para padronizar, podemos aplicar o LOWER sobre este campo e,
em seguida, aplicamos o INITCAP sobre o resultado do LOWER. 
Assim, colocaremos tudo em minúsculo primeiro para depois deixar as iniciais maiúsculas.
Assim, teremos todos os nomes com a primeira letra maiúscula.

É uma forma de ajustar cadastros de clientes ou alguma outra informação descritiva
que precisa ser padronizada com todas as primeiras letras maiúsculas.

---------------------------------------------------------------------------------

CONCAT
A CONCAT concatena todas as informações. 
Podemos ter um campo com o nome de uma pessoa cliente
e outro campo (coluna da tabela) com o sobrenome.

Com isso, digamos que eu queira criar uma única coluna com o nome e sobrenome juntos.
Neste caso, rodamos a função CONCAT para concatenar o campo do nome,
seguido de um espaço em branco e unido ao sobrenome.

O resultado será um campo único com essas três informações concatenadas,
ou seja, unidas, dentro do texto final.

---------------------------------------------------------------------------------

LPAD
A LPAD acrescenta caracteres na frente do texto.

Digamos que eu passe como parâmetro uma função que aplica espaços
de 40 caracteres sobre um determinado texto.

Se, por exemplo, o texto que faz parte do campo tiver apenas 5 caracteres,
ele será preenchido com 35 espaços em branco para que o texto final
tenha 40 caracteres ao todo.
Já se o texto tiver 15 caracteres, serão criados 25 espaços em branco.

Porém, não precisamos preencher o texto apenas com espaços em branco
por meio do LPAD. Podemos especificar um caractere específico.

Neste caso, o LPAD repetirá aquele caractere quantas vezes for possível
para que o texto final tenha um tamanho especificado,
unindo o caractere escolhido e o restante do texto.

---------------------------------------------------------------------------------

RPAD
A função RPAD faz o oposto: em vez de concatenar os strings ou espaços
na frente do nome, ele o faz no fim do nome.
Muda apenas a posição onde os caracteres serão inseridos.

---------------------------------------------------------------------------------

SUBSTR
A função SUBSTR retira trechos de um texto maior.
Por exemplo, quando queremos retirar o sobrenome do nome completo de uma pessoa.

---------------------------------------------------------------------------------

INSTR
O INSTR testa se uma determinada cadeia de caracteres está contida no texto.
Se essa cadeia não existir, a função voltará o valor 0, mas se ela existir,
a função retornará a posição em que a cadeia de caracteres começa.


Por exemplo, temos uma tabela com nomes e queremos saber se algum nome
tem o sobrenome "Silva". Aplicamos a função INSTR e, se o resultado obtido for 0,
isso quer dizer que não existe o nome Silva. Se o número for diferente de zero,
o sobrenome Silva pertence ao nome contido na posição apontada.

---------------------------------------------------------------------------------

LTRIM
A função LTRIM retira espaços à esquerda do caractere.
Se temos um string alguns espaços em branco, por exemplo, antes de começar o texto,
podemos usar o LTRIM para retirar os espaços em branco do início do valor do campo original.

---------------------------------------------------------------------------------

RTRIM
O RTRIM retira espaços em branco à direita do campo.

---------------------------------------------------------------------------------

TRIM
O TRIM retira espaços em branco da esquerda e da direita do campo.

---------------------------------------------------------------------------------

TRANSLATE
A função TRANSLATE traduz determinados caracteres de um nome para outros caracteres.
Podemos dizer que toda letra "A" de um nome pode ser substituída por um asterisco.

--------------------------------------------------------------------------------

REPLACE
A função REPLACE faz algo similar à TRANSLATE,
mas em vez de trabalhar com um caractere específico,
ela traduz uma cadeia de caracteres. Podemos, por exemplo,
substituir todo sobrenome "Silva" presente em uma base de dados por "Machado".


Essas são as principais funções do tipo texto, mas existem muitas outras.
A seguir, abriremos o SQL Developer e praticaremos essas funções no Oracle.

--------------------------------------------------------------------------------- */

-- Aula 5.2 -- Funções String na Prática

SELECT NOME FROM TABELA_DE_CLIENTES;

SELECT NOME, LOWER(NOME) FROM TABELA_DE_CLIENTES;

SELECT NOME, UPPER(NOME) FROM TABELA_DE_CLIENTES;

-------------------------------------------------------------

SELECT NOME_DO_PRODUTO FROM TABELA_DE_PRODUTOS;

SELECT NOME_DO_PRODUTO, INITCAP(NOME_DO_PRODUTO) 
    FROM TABELA_DE_PRODUTOS;
    
-------------------------------------------------------------

SELECT ENDERECO_1, BAIRRO FROM TABELA_DE_CLIENTES;

SELECT ENDERECO_1, BAIRRO, CONCAT(CONCAT(ENDERECO_1, ', '), BAIRRO)
    FROM TABELA_DE_CLIENTES;
    
SELECT ENDERECO_1 || ', ' || BAIRRO || ' - ' || CIDADE || ' - ' || ESTADO || ' - ' || CEP 
    AS "Endereço Completo"
    FROM TABELA_DE_CLIENTES;
    
--------------------------------------------------------------------------------

SELECT NOME_DO_PRODUTO, LPAD(NOME_DO_PRODUTO, 70, '*')
    FROM TABELA_DE_PRODUTOS;
    
SELECT NOME_DO_PRODUTO, RPAD(NOME_DO_PRODUTO, 70, '*')
    FROM TABELA_DE_PRODUTOS;
    
SELECT NOME_DO_PRODUTO, SUBSTR(NOME_DO_PRODUTO, 3, 5)
    FROM TABELA_DE_PRODUTOS;
    
SELECT NOME_DO_PRODUTO, INSTR(NOME_DO_PRODUTO, 'Campo')
    FROM TABELA_DE_PRODUTOS; 
    
SELECT NOME, INSTR(NOME, 'Mattos') 
    FROM TABELA_DE_CLIENTES;
    
SELECT NOME FROM TABELA_DE_CLIENTES 
    WHERE INSTR(NOME, 'Mattos') <> 0;
    
--------------------------------------------------------------------------------    
    
SELECT '   Paes  ' AS X, LTRIM('   Paes  ') AS Y
    FROM DUAL;
    
SELECT '   Paes  ' AS X, LTRIM('   Paes  ') AS Y, RTRIM('   Paes  ') AS Z,
 TRIM('   Paes  ') AS W
    FROM DUAL;
    
--------------------------------------------------------------------------------     

SELECT NOME_DO_PRODUTO FROM TABELA_DE_PRODUTOS;

SELECT NOME_DO_PRODUTO, REPLACE(NOME_DO_PRODUTO, 'Litro', 'L')
    FROM TABELA_DE_PRODUTOS;
    
SELECT NOME_DO_PRODUTO, REPLACE(REPLACE(NOME_DO_PRODUTO, 'Litro', 'L'), 'Ls', 'L')
    FROM TABELA_DE_PRODUTOS;
    
--------------------------------------------------------------------------------
/*
-- Aula 5.3 -- Funções de Datas

Função TO_CHAR
A TO_CHAR vai pegar aquela data armazenada dentro do Oracle e convertê-la em texto.
Esse texto será a data exibida num dado formato,
determinado por você por meio de alguns símbolos aplicados na função.

Esse formato pode ser "dia/mês/ano", "ano/mês/dia", ano com dois dígitos,
com quatro dígitos, a hora de 0 a 12 ou 0 a 24, e assim por diante.

--------------------------------------------------------------------------------

Função TO_DATE
Essa função converte uma data em texto para o formato de data.
Ou seja, ela faz o inverso de TO_CHAR.

Precisamos passar para TO_DATE os mesmos símbolos de formato de data que usamos no
TO_CHAR. Porém, aqui vamos representar a forma com que o texto está exibindo a data.

Ambas as funções utilizam esse tipo de símbolos que representam as datas.

--------------------------------------------------------------------------------

Símbolos
Na documentação do Oracle, vemos que o número de símbolos é muito maior do que
o que mostraremos a seguir. Falaremos dos principais por enquanto.

D - Dia da semana
DD - Dia do mês
DDD - Número do dia no ano
DAY - Dia por extenso
MM - Mês do ano
MON - Mês abreviado (jan., feb., mar., ...)
MONTH - Mês por extenso
YYYY - Ano com 4 dígitos
YY - Ano com 2 dígitos
Símbolo separador da data

/ * , ; ou um texto qualquer
HH - Hora com dois dígitos
HH12 - Hora de 0 a 12
HH24 - Hora de 0 a 24
MI - Minuto
SS - Segundo

É com esses símbolos que montamos a representação do formato da data
a ser convertida, de número para string ou de string para número.
Usamos os mesmos critérios na função TO_CHAR e TO_DATE.

--------------------------------------------------------------------------------

Função SYSDATE
Essa função nos apresenta a hora e o dia marcados pelo computador onde está o Oracle.
Ou seja: são a hora e o dia do momento.

O SYSDATE é muito usado, por exemplo, quando queremos gravar dados no
banco de dados junto da hora e do dia em que aqueles dados foram gravados.

--------------------------------------------------------------------------------

Função MONTHS_BETWEEN
Com essa função, pegamos duas datas e apresentamos o número de meses entre elas.
Esse resultado pode ser positivo ou negativo, a depender se a data inicial
for maior ou menor que a data final.

Se representarmos essa data com horas, minutos e segundos,
pode ser que esse resultado seja um número com casas decimais, como "300,99987 meses".

--------------------------------------------------------------------------------

Função ADD_MONTHS
Com o ADD_MONTHS, pegamos uma data e inserimos o número de meses que
queremos adicionar a essa data. Esse número de meses pode ser positivo ou negativo

--------------------------------------------------------------------------------

Função NEXT_DAY
Essa função nos devolve o próximo dia da semana a partir de uma determinada data.
Então, se colocarmos uma data e escrever o número do dia na semana ou o nome
do dia da semana, ele nos dará a data desse dia a partir da data que especificamos

Por exemplo: se colocarmos a data "01/01/2000" e escrevermos "sexta-feira"
ou o número "6", essa função nos retornará a data da próxima sexta-feira
a partir do dia primeiro de janeiro de 2000.

--------------------------------------------------------------------------------

Função LAST_DAY
Essa função nos devolve o último dia do mês da data especificada em seu parâmetro.
Então, se especificarmos "15/01/2000", receberemos "31/01/2000".

--------------------------------------------------------------------------------

Função TRUNC (date)
É como se essa função "truncasse" uma data. Ou seja: ele vai, por exemplo,
pegar uma data com a hora, minuto e segundo e converter para apenas data.
É como se ele tirasse a parte decimal da representação interna da data.

Quando queremos comparar duas datas que, internamente, são armazenadas com horas,
minutos e segundos, essa função é bastante importante.

--------------------------------------------------------------------------------

Função ROUND (date)
Essa função "arredonda" a data. Então, dependendo do período em que queremos
aplicar o arredondamento, a função vai pegar o primeiro
ou último dia do intervalo trabalhado. Isso depende da data estar antes ou
depois do dia 15, a metade do mês.

Ou seja: antes do dia 15, devolve-se o primeiro dia do mês; depois do dia 15,
devolve-se o último dia do mês.                                              */

--------------------------------------------------------------------------------

-- Aula 5.3 -- Funções de Datas na Prática

SELECT sysdate FROM DUAL;
SELECT TO_CHAR(sysdate, 'DD/MM/YYYY') FROM DUAL;

SELECT NOME, DATA_DE_NASCIMENTO FROM TABELA_DE_CLIENTES;

SELECT NOME, TO_CHAR(DATA_DE_NASCIMENTO, 'DD MONTH YYYY, DAY')
    FROM TABELA_DE_CLIENTES;
    
SELECT sysdate + 127 FROM DUAL; 

SELECT NOME, IDADE, TO_CHAR(DATA_DE_NASCIMENTO, 'DD MONTH YYYY, DAY')
    FROM TABELA_DE_CLIENTES;
    
SELECT NOME, IDADE, (sysdate - DATA_DE_NASCIMENTO) / 365
    FROM TABELA_DE_CLIENTES;

SELECT NOME, IDADE, MONTHS_BETWEEN(sysdate, DATA_DE_NASCIMENTO) / 12 
    FROM TABELA_DE_CLIENTES;
    
SELECT ADD_MONTHS(sysdate, 10) FROM DUAL; -- Adiciona 10 meses à data do sistema  

SELECT NEXT_DAY(sysdate, 'Sexta') FROM DUAL; -- Próxima sexta 

SELECT sysdate, LAST_DAY(sysdate) FROM DUAL; -- Último dia do mês

SELECT sysdate + 200, TRUNC(sysdate + 200, 'Month') FROM DUAL; -- Primeiro dia do mês
                                                               -- da data especificada
                                                               
SELECT sysdate, ROUND(sysdate, 'Month') FROM DUAL; -- Arredonda a data                                                            


select NOME, to_char(DATA_DE_NASCIMENTO,'dd "de" MONTH "de" YYYY')
    from TABELA_DE_CLIENTES; -- nome do cliente e sua data de nascimento por extenso
    
--------------------------------------------------------------------------------
/*
-- Aula 5.6 - Funções numéricas 

ROUND (number)
O ROUND faz o arredondamento dos números. Se a casa decimal for maior que cinco
o arredondamento é feito para cima, se for menor, para baixo.

Por exemplo, se tivermos o número 5,4 e utilizarmos o ROUND o resultado será 5.
Já, se o número for 5,7 teremos o resultado 6.

ROUND(n [, integer ])

--------------------------------------------------------------------------------

TRUNC (number)
A função TRUNC sempre faz o arredondamento para baixo.
Sendo assim, se tivermos o número 5,2 ou 5,9 o resultado será 5.

TRUNC(date [, fmt ])

--------------------------------------------------------------------------------

CEIL
Já o CEIL é o oposto, o arredondamento sempre é feito para cima.
Sendo assim, se o número for 5,2 ou 5,8 o resultado será 6.

CEIL(n)

--------------------------------------------------------------------------------

FLOOR
O FLOOR pega o primeiro número inteiro antes da casa decimal,
ou seja, funciona assim como o TRUNC.

FLOOR(n)

--------------------------------------------------------------------------------

POWER
O POWER retorna o valor da expressão especificada para a potência indicada.
Sendo assim, se tivermos POWER (10, 2) teremos 10².

POWER(n2, n1)

--------------------------------------------------------------------------------

EXP
A função EXP retorna e elevado à enésima potência, de forma com que
e = 2,71828183... . A função retorna um valor do mesmo tipo do argumento.

EXP(n)

--------------------------------------------------------------------------------

SQRT
O SQRT retorna a raiz quadrada de n.

SQRT(n)

SIGN
O SIGN retorna três valores diferente. Se o número for negativo ele devolve -1,
se for núlo devolve 0 e se o número for positivo devolve 1.

SIGN(n)

--------------------------------------------------------------------------------

ABS
A função ABS sempre deixa o número positivo. Isso significa que
o valor absoluto de 10 é 10 e o valor absoluto de -10 também é 10.

ABS(n)

--------------------------------------------------------------------------------

MOD
O MOD retorna o restante de n2 dividido por n1 e se n1 for 0 retorna n2.

MOD(n2, n1)

--------------------------------------------------------------------------------

Além dessas também existem outras funções matemáticas, como:

LOG(M,N) - Logaritmo de base m de n;

SIN(n) - Seno de n;

SINH(n) - Seno hiperbólico de n;

TAN(n) - Tangente de n;

COS(n) - Cosseno de n;

COSH(n) - Cosseno hiberbólico de n;                                           */

--------------------------------------------------------------------------------

-- Aula 5.7 -- Funções Numéricas na prática

SELECT 3.4 FROM DUAL;

SELECT ROUND(3.4) FROM DUAL; -- 3
SELECT ROUND(3.6) FROM DUAL; -- 4
SELECT ROUND(3.5) FROM DUAL; -- 4

SELECT TRUNC(3.4) FROM DUAL; -- 3
SELECT TRUNC(3.6) FROM DUAL; -- 3
SELECT TRUNC(3.5) FROM DUAL; -- 3

SELECT CEIL(3.4) FROM DUAL; -- 4
SELECT CEIL(3.6) FROM DUAL; -- 4
SELECT CEIL(3.5) FROM DUAL; -- 4

SELECT FLOOR(3.4) FROM DUAL; -- 3
SELECT FLOOR(3.6) FROM DUAL; -- 3
SELECT FLOOR(3.5) FROM DUAL; -- 3

--------------------------------------------------------------------------------

SELECT POWER(10, 4) FROM DUAL; -- 10000
SELECT POWER(34, 4) FROM DUAL; -- 1336336

SELECT EXP(4) FROM DUAL; -- 54,5981...

SELECT SQRT(144) FROM DUAL; -- 12
SELECT SQRT(10) FROM DUAL;  -- 3,162...

SELECT ABS(10) FROM DUAL;  -- 10
SELECT ABS(-10) FROM DUAL; -- 10

SELECT MOD(10, 6) FROM DUAL; -- 4


-- Calcule o valor do imposto pago no ano de 2016, arredondando para o menor inteiro.
SELECT TO_CHAR(DATA_VENDA, 'YYYY') AS "Ano",
       FLOOR(SUM(IMPOSTO * (QUANTIDADE * PRECO))) AS "Imposto pago em Reais"
    FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF ON NF.NUMERO = INF.NUMERO
WHERE TO_CHAR(DATA_VENDA, 'YYYY') = 2016
GROUP BY TO_CHAR(DATA_VENDA, 'YYYY');

--------------------------------------------------------------------------------
/*
-- Aula 5.8 - Funções de conversão

EXTRACT
Outra função bem importante é a EXTRACT. Ela extrai um pedaço da data,
que pode ser o ano, mês, dia, hora, minuto e assim por diante.

EXTRACT( { YEAR
         | MONTH
         | DAY
         | HOUR
         | MINUTE
         | SECOND
         | TIMEZONE_HOUR
         | TIMEZONE_MINUTE
         | TIMEZONE_REGION
         | TIMEZONE_ABBR
         }
         FROM { expr }
       )
       
Por exemplo, se aplicarmos o YEAR extraímos o ano da data.

--------------------------------------------------------------------------------

TO_NUMBER
Ele converte um texto string em número.

TO_NUMBER(expr [ DEFAULT return_value ON CONVERSION ERROR ]
  [, fmt [, 'nlsparam' ] ])
  
Além disso, assim como no TO_CHAR, que podemos colocar o formato de saída da conversão,
podemos fazer o mesmo no TO_NUMBER, ou seja, converter a forma que o número será exibido.

Existem algumas formas de representação de saída do número:

9 - Posição numérica - Ex: 9999 - 1234

0 - Zeros antes do número - Ex: 009999 = 001234

$ - Símbolo de moeda - Ex: $9999 = $1234

. - Usar o ponto como separador - EX: 9999.99 = 1234.12

, - Usar a vígula como separador - Ex: 9999,99 = 1234,12

MI - Símbolo negativo do lado direito do número

PR - Número negativo em parênteses

EEEE - Notação científica

--------------------------------------------------------------------------------

NVL
A função NVL testa se o valor é nulo. Se for,
ele converte o resultado em um determinado valor.

NVL(expr1, expr2)

--------------------------------------------------------------------------------

GREATEST
No caso do GREATEST, se tivermos uma série de números separados
por vírgula ele vai dizer qual é o número maior.

GREATEST(expr [, expr ]...)                                                   */

--------------------------------------------------------------------------------

-- Aula 5.9 - Funções de conversão na prática

SELECT EXTRACT(MONTH FROM TO_DATE('12/11/2019', 'DD/MM/YYYY'))
    FROM DUAL; -- 11
    
SELECT EXTRACT(MONTH FROM TO_DATE('12/11/2019', 'MM/DD/YYYY'))
    FROM DUAL; -- 12  
  
--------------------------------------------------------------------------------  
    
SELECT '10' + 10 FROM DUAL;            -- 20 
SELECT TO_NUMBER('10') + 10 FROM DUAL; -- 20

SELECT TO_CHAR(1234.123, '9999') FROM DUAL; -- 1234
SELECT TO_CHAR(1234.123, '9999.999') FROM DUAL; -- 1234.123
SELECT TO_CHAR(1234.123, '9999,999') FROM DUAL; -- 1,234

--------------------------------------------------------------------------------

SELECT NVL(10, 0) FROM DUAL; -- 10
SELECT NVL(NULL, 0) FROM DUAL; -- 10


SELECT NVL(TV.NOME, '--Não Encontrado--') AS "Nome do Vendedor",
       NVL(TV.BAIRRO, '--Não Encontrado--') AS "Bairro do Vendedor",
       NVL(TC.NOME, '--Não Encontrado--') AS "Nome do Cliente",
       NVL(TC.BAIRRO, '--Não Encontrado--') AS "Bairro do Cliente"
    FROM TABELA_DE_VENDEDORES TV
FULL OUTER JOIN TABELA_DE_CLIENTES TC ON (TV.BAIRRO = TC.BAIRRO);

--------------------------------------------------------------------------------

/* Queremos construir uma query cujo resultado seja, para cada cliente:

O cliente NOME DO CLIENTE comprou QUANTIDADE no ano de ANO
Faça isso somente para o ano de 2016. */

SELECT 'O cliente ' || TC.NOME || ' comprou ' || 'R$' ||
TO_CHAR(ROUND(SUM(INF.QUANTIDADE * INF.preco),2)) || ' no ano de ' || 
TO_CHAR(DATA_VENDA, 'YYYY') AS SENTENCA 
    FROM notas_fiscais NF
INNER JOIN ITENS_NOTAS_FISCAIS INF ON (NF.NUMERO = INF.NUMERO)
INNER JOIN TABELA_DE_CLIENTES TC ON (NF.CPF = TC.CPF)
WHERE TO_CHAR(DATA_VENDA, 'YYYY') = '2016'
GROUP BY TC.NOME, TO_CHAR(DATA_VENDA, 'YYYY')

--------------------------------------------------------------------------------



