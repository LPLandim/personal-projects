-- Aula 2.1 - Primeiro programa PL/SQL

SET SERVEROUTPUT ON;
DECLARE
    v_id NUMBER(5) := 1;
BEGIN
    dbms_output.put_line(v_id);
    v_id := 2;
    dbms_output.put_line(v_id);
END;
/

-- Aula 2.2 - Erros de compilação

SET SERVEROUTPUT ON;
DECLARE
    v_id NUMBER(5) := 1;
BEGIN
    dbms_output.put_line(v_id);
    v_id := 2 dbms_output.put_line(v_id);
END;
/