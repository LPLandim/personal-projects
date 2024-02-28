/* ----------------- Programação em Banco de Dados - FIAP ON -------------------

-- Cap 9. - Coleções                                                          */
    
-- Sintaxe de Registros

TYPE nome_do_tipo IS RECORD
(declaração_dos_campos[, declaração_dos_campos]…);
identificador	nome_do_tipo;
/

-- Registros

SET SERVEROUTPUT ON
DECLARE
    TYPE emp_reg IS RECORD
    (v_nome emp.ename%TYPE,
     v_sal  emp.sal%TYPE);
    dados emp_reg;
BEGIN
  SELECT ename, sal INTO dados
    FROM emp
    WHERE empno = 7900;
        DBMS_OUTPUT.PUT_LINE (dados.v_nome || '. ' || dados.v_sal);
END;
/

SET SERVEROUTPUT ON
DECLARE
    dados emp%ROWTYPE;
BEGIN
  SELECT * INTO dados
    FROM emp   
    WHERE empno = 7900;
        DBMS_OUTPUT.PUT_LINE (dados.ename || '. ' || dados.sal);
END;
/
--------------------------------------------------------------------------------

-- Arrays Associativos

TYPE nome_do_tipo IS TABLE OF 
     {tipo_de_dados | variável%TYPE
     | tabela.coluna%TYPE} [NOT NULL] 
     [INDEX BY BINARY_INTEGER];
identificador	nome_do_tipo;
/

SET SERVEROUTPUT ON
DECLARE
    TYPE emp_arr IS TABLE OF emp.ename%TYPE
     INDEX BY BINARY_INTEGER;
dados emp_arr;
BEGIN
  dados(1) := 'Caneta';
  dados(2) := 'Borracha';
  dados(3) := 'Caderno';
  dados(4) := 'Estojo';
  dados(5) := 'Apontador';
        DBMS_OUTPUT.PUT_LINE (dados(1));
        DBMS_OUTPUT.PUT_LINE (dados(2));
        DBMS_OUTPUT.PUT_LINE (dados(3));
        DBMS_OUTPUT.PUT_LINE (dados(4));
        DBMS_OUTPUT.PUT_LINE (dados(5));
END;
/

SET SERVEROUTPUT ON
DECLARE
    TYPE lista_reg IS RECORD (
        nome  VARCHAR2(20),
        valor NUMBER(7,2) );
    TYPE compras_arr IS TABLE OF lista_reg
     INDEX BY BINARY_INTEGER;
    dados compras_arr;
BEGIN
  dados(1).nome := 'Caneta';
  dados(1).valor := 3.00;
  dados(2).nome := 'Borracha';
  dados(2).valor := 1.50;
  dados(3).nome := 'Caderno';
  dados(3).valor := 25.00;
  dados(4).nome := 'Estojo';
  dados(4).valor := 17.00;
  dados(5).nome := 'Apontador';
  dados(5).valor := 9.00;
  DBMS_OUTPUT.PUT_LINE (dados(1).nome);  DBMS_OUTPUT.PUT_LINE (dados(1).valor);
  DBMS_OUTPUT.PUT_LINE (dados(2).nome);  DBMS_OUTPUT.PUT_LINE (dados(2).valor);
  DBMS_OUTPUT.PUT_LINE (dados(3).nome);  DBMS_OUTPUT.PUT_LINE (dados(3).valor);
  DBMS_OUTPUT.PUT_LINE (dados(4).nome);  DBMS_OUTPUT.PUT_LINE (dados(4).valor);
  DBMS_OUTPUT.PUT_LINE (dados(5).nome);  DBMS_OUTPUT.PUT_LINE (dados(5).valor);
END;
/

-- Array associativo com Count

SET SERVEROUTPUT ON
DECLARE
    TYPE lista_reg IS RECORD (
        nome  VARCHAR2(20),
        valor NUMBER(7,2));
    TYPE compras_arr IS TABLE OF lista_reg
     INDEX BY BINARY_INTEGER;
    dados compras_arr;
BEGIN
  dados(1).nome := 'Caneta';
  dados(1).valor := 3.00;
  dados(2).nome := 'Borracha';
  dados(2).valor := 1.50;
  dados(3).nome := 'Caderno';
  dados(3).valor := 25.00;
  dados(4).nome := 'Estojo';
  dados(4).valor := 17.00;
  dados(5).nome := 'Apontador';
  dados(5).valor := 9.00;
  FOR i IN 1..dados.COUNT 
  LOOP
      DBMS_OUTPUT.PUT_LINE (dados(i).nome);
      DBMS_OUTPUT.PUT_LINE (dados(i).valor);
  END LOOP;
END;
/

-- Array associativo com First e Last

SET SERVEROUTPUT ON
DECLARE
    TYPE lista_reg IS RECORD (
        nome  VARCHAR2(20),
        valor NUMBER(7,2) );
    TYPE compras_arr IS TABLE OF lista_reg
     INDEX BY BINARY_INTEGER;
    dados compras_arr;
BEGIN
  dados(1).nome := 'Caneta';
  dados(1).valor := 3.00;
  dados(2).nome := 'Borracha';
  dados(2).valor := 1.50;
  dados(3).nome := 'Caderno';
  dados(3).valor := 25.00;
  dados(4).nome := 'Estojo';
  dados(4).valor := 17.00;
  dados(5).nome := 'Apontador';
  dados(5).valor := 9.00;
  FOR i IN dados.FIRST .. dados.LAST 
  LOOP
      DBMS_OUTPUT.PUT_LINE (dados(i).nome);
      DBMS_OUTPUT.PUT_LINE (dados(i).valor);
  END LOOP;
END;
/

-- Array associativo com Exist

SET SERVEROUTPUT ON
DECLARE
    TYPE lista_reg IS RECORD (
        nome  VARCHAR2(20),
        valor NUMBER(7,2));
    TYPE compras_arr IS TABLE OF lista_reg
     INDEX BY BINARY_INTEGER;
    dados compras_arr;
BEGIN
  dados(1).nome := 'Caneta';
  dados(1).valor := 3.00;
  dados(2).nome := 'Borracha';
  dados(2).valor := 1.50;
  dados(4).nome := 'Estojo';
  dados(4).valor := 17.00;
  dados(5).nome := 'Apontador';
  dados(5).valor := 9.00;
  FOR i IN dados.FIRST .. dados.LAST
  LOOP
      IF dados.EXISTS(i) THEN
         DBMS_OUTPUT.PUT_LINE (dados(i).nome);
         DBMS_OUTPUT.PUT_LINE (dados(i).valor);
      ELSE
         DBMS_OUTPUT.PUT_LINE ('Item ' || i || ' ausente');
      END IF;
  END LOOP;
END;
/