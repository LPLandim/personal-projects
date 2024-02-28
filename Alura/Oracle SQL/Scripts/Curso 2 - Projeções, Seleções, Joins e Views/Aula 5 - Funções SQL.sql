/* --------------------------------- Aula 5 ------------------------------------
                                 Fun��es no SQL

-- String (textos)
-- Datas
-- Matem�ticas (number)
-- Convers�o de Dados
                                                                              
--------------------------------------------------------------------------------

-- Aula 5.1 -- Fun��es de String

LOWER
Come�aremos pela fun��o LOWER, que converte todo um texto em letras min�sculas.
Assim, se aplicarmos o LOWER a um texto escrito com letras mai�sculas e min�sculas,
ele ser� todo convertido para letras min�sculas.

---------------------------------------------------------------------------------

UPPER
O UPPER faz o oposto: transforma todo o texto em letras mai�sculas.

---------------------------------------------------------------------------------

INITCAP
O INITCAP torna mai�scula s� a primeira letra de cada palavra do texto.

Um exemplo pr�tico de uso da INITCAP � quando temos um banco de dados com uma coluna que
cont�m nomes pr�prios. Digamos que uma tela de entrada de dados
� a fonte que alimenta cada linha da tabela com nomes, que s�o digitados por pessoas.

Para padronizar, podemos aplicar o LOWER sobre este campo e,
em seguida, aplicamos o INITCAP sobre o resultado do LOWER. 
Assim, colocaremos tudo em min�sculo primeiro para depois deixar as iniciais mai�sculas.
Assim, teremos todos os nomes com a primeira letra mai�scula.

� uma forma de ajustar cadastros de clientes ou alguma outra informa��o descritiva
que precisa ser padronizada com todas as primeiras letras mai�sculas.

---------------------------------------------------------------------------------

CONCAT
A CONCAT concatena todas as informa��es. 
Podemos ter um campo com o nome de uma pessoa cliente
e outro campo (coluna da tabela) com o sobrenome.

Com isso, digamos que eu queira criar uma �nica coluna com o nome e sobrenome juntos.
Neste caso, rodamos a fun��o CONCAT para concatenar o campo do nome,
seguido de um espa�o em branco e unido ao sobrenome.

O resultado ser� um campo �nico com essas tr�s informa��es concatenadas,
ou seja, unidas, dentro do texto final.

---------------------------------------------------------------------------------

LPAD
A LPAD acrescenta caracteres na frente do texto.

Digamos que eu passe como par�metro uma fun��o que aplica espa�os
de 40 caracteres sobre um determinado texto.

Se, por exemplo, o texto que faz parte do campo tiver apenas 5 caracteres,
ele ser� preenchido com 35 espa�os em branco para que o texto final
tenha 40 caracteres ao todo.
J� se o texto tiver 15 caracteres, ser�o criados 25 espa�os em branco.

Por�m, n�o precisamos preencher o texto apenas com espa�os em branco
por meio do LPAD. Podemos especificar um caractere espec�fico.

Neste caso, o LPAD repetir� aquele caractere quantas vezes for poss�vel
para que o texto final tenha um tamanho especificado,
unindo o caractere escolhido e o restante do texto.

---------------------------------------------------------------------------------

RPAD
A fun��o RPAD faz o oposto: em vez de concatenar os strings ou espa�os
na frente do nome, ele o faz no fim do nome.
Muda apenas a posi��o onde os caracteres ser�o inseridos.

---------------------------------------------------------------------------------

SUBSTR
A fun��o SUBSTR retira trechos de um texto maior.
Por exemplo, quando queremos retirar o sobrenome do nome completo de uma pessoa.

---------------------------------------------------------------------------------

INSTR
O INSTR testa se uma determinada cadeia de caracteres est� contida no texto.
Se essa cadeia n�o existir, a fun��o voltar� o valor 0, mas se ela existir,
a fun��o retornar� a posi��o em que a cadeia de caracteres come�a.


Por exemplo, temos uma tabela com nomes e queremos saber se algum nome
tem o sobrenome "Silva". Aplicamos a fun��o INSTR e, se o resultado obtido for 0,
isso quer dizer que n�o existe o nome Silva. Se o n�mero for diferente de zero,
o sobrenome Silva pertence ao nome contido na posi��o apontada.

---------------------------------------------------------------------------------

LTRIM
A fun��o LTRIM retira espa�os � esquerda do caractere.
Se temos um string alguns espa�os em branco, por exemplo, antes de come�ar o texto,
podemos usar o LTRIM para retirar os espa�os em branco do in�cio do valor do campo original.

---------------------------------------------------------------------------------

RTRIM
O RTRIM retira espa�os em branco � direita do campo.

---------------------------------------------------------------------------------

TRIM
O TRIM retira espa�os em branco da esquerda e da direita do campo.

---------------------------------------------------------------------------------

TRANSLATE
A fun��o TRANSLATE traduz determinados caracteres de um nome para outros caracteres.
Podemos dizer que toda letra "A" de um nome pode ser substitu�da por um asterisco.

--------------------------------------------------------------------------------

REPLACE
A fun��o REPLACE faz algo similar � TRANSLATE,
mas em vez de trabalhar com um caractere espec�fico,
ela traduz uma cadeia de caracteres. Podemos, por exemplo,
substituir todo sobrenome "Silva" presente em uma base de dados por "Machado".


Essas s�o as principais fun��es do tipo texto, mas existem muitas outras.
A seguir, abriremos o SQL Developer e praticaremos essas fun��es no Oracle.

--------------------------------------------------------------------------------- */

-- Aula 5.2 -- Fun��es String na Pr�tica

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
    AS "Endere�o Completo"
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
-- Aula 5.3 -- Fun��es de Datas

Fun��o TO_CHAR
A TO_CHAR vai pegar aquela data armazenada dentro do Oracle e convert�-la em texto.
Esse texto ser� a data exibida num dado formato,
determinado por voc� por meio de alguns s�mbolos aplicados na fun��o.

Esse formato pode ser "dia/m�s/ano", "ano/m�s/dia", ano com dois d�gitos,
com quatro d�gitos, a hora de 0 a 12 ou 0 a 24, e assim por diante.

--------------------------------------------------------------------------------

Fun��o TO_DATE
Essa fun��o converte uma data em texto para o formato de data.
Ou seja, ela faz o inverso de TO_CHAR.

Precisamos passar para TO_DATE os mesmos s�mbolos de formato de data que usamos no
TO_CHAR. Por�m, aqui vamos representar a forma com que o texto est� exibindo a data.

Ambas as fun��es utilizam esse tipo de s�mbolos que representam as datas.

--------------------------------------------------------------------------------

S�mbolos
Na documenta��o do Oracle, vemos que o n�mero de s�mbolos � muito maior do que
o que mostraremos a seguir. Falaremos dos principais por enquanto.

D - Dia da semana
DD - Dia do m�s
DDD - N�mero do dia no ano
DAY - Dia por extenso
MM - M�s do ano
MON - M�s abreviado (jan., feb., mar., ...)
MONTH - M�s por extenso
YYYY - Ano com 4 d�gitos
YY - Ano com 2 d�gitos
S�mbolo separador da data

/ * , ; ou um texto qualquer
HH - Hora com dois d�gitos
HH12 - Hora de 0 a 12
HH24 - Hora de 0 a 24
MI - Minuto
SS - Segundo

� com esses s�mbolos que montamos a representa��o do formato da data
a ser convertida, de n�mero para string ou de string para n�mero.
Usamos os mesmos crit�rios na fun��o TO_CHAR e TO_DATE.

--------------------------------------------------------------------------------

Fun��o SYSDATE
Essa fun��o nos apresenta a hora e o dia marcados pelo computador onde est� o Oracle.
Ou seja: s�o a hora e o dia do momento.

O SYSDATE � muito usado, por exemplo, quando queremos gravar dados no
banco de dados junto da hora e do dia em que aqueles dados foram gravados.

--------------------------------------------------------------------------------

Fun��o MONTHS_BETWEEN
Com essa fun��o, pegamos duas datas e apresentamos o n�mero de meses entre elas.
Esse resultado pode ser positivo ou negativo, a depender se a data inicial
for maior ou menor que a data final.

Se representarmos essa data com horas, minutos e segundos,
pode ser que esse resultado seja um n�mero com casas decimais, como "300,99987 meses".

--------------------------------------------------------------------------------

Fun��o ADD_MONTHS
Com o ADD_MONTHS, pegamos uma data e inserimos o n�mero de meses que
queremos adicionar a essa data. Esse n�mero de meses pode ser positivo ou negativo

--------------------------------------------------------------------------------

Fun��o NEXT_DAY
Essa fun��o nos devolve o pr�ximo dia da semana a partir de uma determinada data.
Ent�o, se colocarmos uma data e escrever o n�mero do dia na semana ou o nome
do dia da semana, ele nos dar� a data desse dia a partir da data que especificamos

Por exemplo: se colocarmos a data "01/01/2000" e escrevermos "sexta-feira"
ou o n�mero "6", essa fun��o nos retornar� a data da pr�xima sexta-feira
a partir do dia primeiro de janeiro de 2000.

--------------------------------------------------------------------------------

Fun��o LAST_DAY
Essa fun��o nos devolve o �ltimo dia do m�s da data especificada em seu par�metro.
Ent�o, se especificarmos "15/01/2000", receberemos "31/01/2000".

--------------------------------------------------------------------------------

Fun��o TRUNC (date)
� como se essa fun��o "truncasse" uma data. Ou seja: ele vai, por exemplo,
pegar uma data com a hora, minuto e segundo e converter para apenas data.
� como se ele tirasse a parte decimal da representa��o interna da data.

Quando queremos comparar duas datas que, internamente, s�o armazenadas com horas,
minutos e segundos, essa fun��o � bastante importante.

--------------------------------------------------------------------------------

Fun��o ROUND (date)
Essa fun��o "arredonda" a data. Ent�o, dependendo do per�odo em que queremos
aplicar o arredondamento, a fun��o vai pegar o primeiro
ou �ltimo dia do intervalo trabalhado. Isso depende da data estar antes ou
depois do dia 15, a metade do m�s.

Ou seja: antes do dia 15, devolve-se o primeiro dia do m�s; depois do dia 15,
devolve-se o �ltimo dia do m�s.                                              */

--------------------------------------------------------------------------------

-- Aula 5.3 -- Fun��es de Datas na Pr�tica

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
    
SELECT ADD_MONTHS(sysdate, 10) FROM DUAL; -- Adiciona 10 meses � data do sistema  

SELECT NEXT_DAY(sysdate, 'Sexta') FROM DUAL; -- Pr�xima sexta 

SELECT sysdate, LAST_DAY(sysdate) FROM DUAL; -- �ltimo dia do m�s

SELECT sysdate + 200, TRUNC(sysdate + 200, 'Month') FROM DUAL; -- Primeiro dia do m�s
                                                               -- da data especificada
                                                               
SELECT sysdate, ROUND(sysdate, 'Month') FROM DUAL; -- Arredonda a data                                                            


select NOME, to_char(DATA_DE_NASCIMENTO,'dd "de" MONTH "de" YYYY')
    from TABELA_DE_CLIENTES; -- nome do cliente e sua data de nascimento por extenso
    
--------------------------------------------------------------------------------
/*
-- Aula 5.6 - Fun��es num�ricas 

ROUND (number)
O ROUND faz o arredondamento dos n�meros. Se a casa decimal for maior que cinco
o arredondamento � feito para cima, se for menor, para baixo.

Por exemplo, se tivermos o n�mero 5,4 e utilizarmos o ROUND o resultado ser� 5.
J�, se o n�mero for 5,7 teremos o resultado 6.

ROUND(n [, integer ])

--------------------------------------------------------------------------------

TRUNC (number)
A fun��o TRUNC sempre faz o arredondamento para baixo.
Sendo assim, se tivermos o n�mero 5,2 ou 5,9 o resultado ser� 5.

TRUNC(date [, fmt ])

--------------------------------------------------------------------------------

CEIL
J� o CEIL � o oposto, o arredondamento sempre � feito para cima.
Sendo assim, se o n�mero for 5,2 ou 5,8 o resultado ser� 6.

CEIL(n)

--------------------------------------------------------------------------------

FLOOR
O FLOOR pega o primeiro n�mero inteiro antes da casa decimal,
ou seja, funciona assim como o TRUNC.

FLOOR(n)

--------------------------------------------------------------------------------

POWER
O POWER retorna o valor da express�o especificada para a pot�ncia indicada.
Sendo assim, se tivermos POWER (10, 2) teremos 10�.

POWER(n2, n1)

--------------------------------------------------------------------------------

EXP
A fun��o EXP retorna e elevado � en�sima pot�ncia, de forma com que
e = 2,71828183... . A fun��o retorna um valor do mesmo tipo do argumento.

EXP(n)

--------------------------------------------------------------------------------

SQRT
O SQRT retorna a raiz quadrada de n.

SQRT(n)

SIGN
O SIGN retorna tr�s valores diferente. Se o n�mero for negativo ele devolve -1,
se for n�lo devolve 0 e se o n�mero for positivo devolve 1.

SIGN(n)

--------------------------------------------------------------------------------

ABS
A fun��o ABS sempre deixa o n�mero positivo. Isso significa que
o valor absoluto de 10 � 10 e o valor absoluto de -10 tamb�m � 10.

ABS(n)

--------------------------------------------------------------------------------

MOD
O MOD retorna o restante de n2 dividido por n1 e se n1 for 0 retorna n2.

MOD(n2, n1)

--------------------------------------------------------------------------------

Al�m dessas tamb�m existem outras fun��es matem�ticas, como:

LOG(M,N) - Logaritmo de base m de n;

SIN(n) - Seno de n;

SINH(n) - Seno hiperb�lico de n;

TAN(n) - Tangente de n;

COS(n) - Cosseno de n;

COSH(n) - Cosseno hiberb�lico de n;                                           */

--------------------------------------------------------------------------------

-- Aula 5.7 -- Fun��es Num�ricas na pr�tica

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
-- Aula 5.8 - Fun��es de convers�o

EXTRACT
Outra fun��o bem importante � a EXTRACT. Ela extrai um peda�o da data,
que pode ser o ano, m�s, dia, hora, minuto e assim por diante.

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
       
Por exemplo, se aplicarmos o YEAR extra�mos o ano da data.

--------------------------------------------------------------------------------

TO_NUMBER
Ele converte um texto string em n�mero.

TO_NUMBER(expr [ DEFAULT return_value ON CONVERSION ERROR ]
  [, fmt [, 'nlsparam' ] ])
  
Al�m disso, assim como no TO_CHAR, que podemos colocar o formato de sa�da da convers�o,
podemos fazer o mesmo no TO_NUMBER, ou seja, converter a forma que o n�mero ser� exibido.

Existem algumas formas de representa��o de sa�da do n�mero:

9 - Posi��o num�rica - Ex: 9999 - 1234

0 - Zeros antes do n�mero - Ex: 009999 = 001234

$ - S�mbolo de moeda - Ex: $9999 = $1234

. - Usar o ponto como separador - EX: 9999.99 = 1234.12

, - Usar a v�gula como separador - Ex: 9999,99 = 1234,12

MI - S�mbolo negativo do lado direito do n�mero

PR - N�mero negativo em par�nteses

EEEE - Nota��o cient�fica

--------------------------------------------------------------------------------

NVL
A fun��o NVL testa se o valor � nulo. Se for,
ele converte o resultado em um determinado valor.

NVL(expr1, expr2)

--------------------------------------------------------------------------------

GREATEST
No caso do GREATEST, se tivermos uma s�rie de n�meros separados
por v�rgula ele vai dizer qual � o n�mero maior.

GREATEST(expr [, expr ]...)                                                   */

--------------------------------------------------------------------------------

-- Aula 5.9 - Fun��es de convers�o na pr�tica

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


SELECT NVL(TV.NOME, '--N�o Encontrado--') AS "Nome do Vendedor",
       NVL(TV.BAIRRO, '--N�o Encontrado--') AS "Bairro do Vendedor",
       NVL(TC.NOME, '--N�o Encontrado--') AS "Nome do Cliente",
       NVL(TC.BAIRRO, '--N�o Encontrado--') AS "Bairro do Cliente"
    FROM TABELA_DE_VENDEDORES TV
FULL OUTER JOIN TABELA_DE_CLIENTES TC ON (TV.BAIRRO = TC.BAIRRO);

--------------------------------------------------------------------------------

/* Queremos construir uma query cujo resultado seja, para cada cliente:

O cliente NOME DO CLIENTE comprou QUANTIDADE no ano de ANO
Fa�a isso somente para o ano de 2016. */

SELECT 'O cliente ' || TC.NOME || ' comprou ' || 'R$' ||
TO_CHAR(ROUND(SUM(INF.QUANTIDADE * INF.preco),2)) || ' no ano de ' || 
TO_CHAR(DATA_VENDA, 'YYYY') AS SENTENCA 
    FROM notas_fiscais NF
INNER JOIN ITENS_NOTAS_FISCAIS INF ON (NF.NUMERO = INF.NUMERO)
INNER JOIN TABELA_DE_CLIENTES TC ON (NF.CPF = TC.CPF)
WHERE TO_CHAR(DATA_VENDA, 'YYYY') = '2016'
GROUP BY TC.NOME, TO_CHAR(DATA_VENDA, 'YYYY')

--------------------------------------------------------------------------------



