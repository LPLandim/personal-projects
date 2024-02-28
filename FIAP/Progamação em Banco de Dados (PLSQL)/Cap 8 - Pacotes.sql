/* ----------------- Programação em Banco de Dados - FIAP ON -------------------

-- Cap 8. - Pacotes                                                           */
    
-- Sintaxe do Package Specification

CREATE [ OR REPLACE ] PACKAGE nome_pacote
{IS ou AS}
    [ variáveis ]
    [ especificação dos cursores ]
    [ especificação dos módulos ]
END [nome_pacote ];
/

-- Package Specification

CREATE OR REPLACE PACKAGE pkg_faculdade AS
    CNOME CONSTANT VARCHAR2(4) := 'FIAP';
    CFONE CONSTANT VARCHAR2(13) := '(11)3385-8010';
    CNOTA CONSTANT NUMBER(2) := 10;
END pkg_faculdade;
/

SET SERVEROUTPUT ON
DECLARE
    melhor VARCHAR2(30);
BEGIN
    melhor := pkg_faculdade.cnome || ', a melhor faculdade';
    dbms_output.put_line(melhor);
END;
/

SET SERVEROUTPUT ON
DECLARE
    conta NUMBER(6);
BEGIN
    conta := pkg_faculdade.cnota ** 2;
    dbms_output.put_line(conta);
END;
/

CREATE OR REPLACE PACKAGE pkg_rh as
    FUNCTION f_descobrir_salario 
      (p_id IN emp.empno%TYPE) 
      RETURN NUMBER;
    PROCEDURE sp_reajuste
      (v_codigo_emp IN emp.empno%type,
       v_porcentagem IN number DEFAULT 25);
END pkg_rh;
/

DESCRIBE pkg_rh;
--------------------------------------------------------------------------------

-- Sintaxe do Body Specification

CREATE [ OR REPLACE ] PACKAGE BODY nome_pacote
{IS ou AS}
    [ variáveis ]
    [ especificação dos cursores ]
    [ especificação dos módulos ]
[BEGIN
     sequencia_de_comandos 
[EXCEPTION
     exceções ] ]
END [nome_pacote ];
 
-- Package Body

CREATE OR REPLACE PACKAGE BODY pkg_rh
AS
  FUNCTION f_descobrir_salario
     (p_id IN emp.empno%TYPE)
  RETURN NUMBER
  IS
     v_salario emp.sal%TYPE := 0;
  BEGIN
     SELECT sal INTO v_salario
       FROM emp
      WHERE empno = p_id;
     RETURN v_salario;
  END f_descobrir_salario;
  PROCEDURE sp_reajuste
      (v_codigo_emp IN emp.empno%type,
       v_porcentagem IN number DEFAULT 25)
  IS
  BEGIN
      UPDATE emp
         SET sal = sal + (sal *( v_porcentagem / 100 ) )
       where empno = v_codigo_emp;
      COMMIT;
      END sp_reajuste;
END pkg_rh;
/

SET SERVEROUTPUT ON
DECLARE
   v_sal NUMBER(8,2);
BEGIN
   v_sal := pkg_rh.f_descobrir_salario(7900);
   DBMS_OUTPUT.PUT_LINE(v_sal);
END;
/

SELECT pkg_rh.f_descobrir_salario(7900)
  FROM dual;
/

SET SERVEROUTPUT ON
DECLARE
   v_sal NUMBER(8,2);
BEGIN
   v_sal := pkg_rh.f_descobrir_salario(7900);
        DBMS_OUTPUT.PUT_LINE ('Salario atual - ' || v_sal);
   pkg_rh.sp_reajuste (7900, faculdade.cnota);
   v_sal := pkg_rh.f_descobrir_salario(7900);
        DBMS_OUTPUT.PUT_LINE ('Salario atualizado - ' || v_sal);
END;
/

EXECUTE pkg_rh.sp_reajuste (7900, faculdade.cnota);

CREATE OR REPLACE PACKAGE pkg_rh AS
   TYPE RegEmp IS RECORD (v_empno emp.empno%TYPE,
                          v_sal emp.sal%TYPE);
   TYPE RegDept IS RECORD (v_deptno dept.deptno%TYPE, 
                           v_loc dept.deptno%TYPE);
   CURSOR c_sal 
   RETURN RegEmp;
   salario_invalido EXCEPTION;
   FUNCTION f_contrata_func 
       (v_ename  emp.ename%TYPE, 
        v_job    emp.job%TYPE,
        v_mgr    emp.mgr%TYPE,
        v_sal    emp.sal%TYPE,
        v_comm   emp.comm%TYPE,
        v_deptno emp.deptno%TYPE)
   RETURN INT;
   PROCEDURE sp_demite_func
        (v_empno emp.empno%TYPE);
   PROCEDURE sp_reajuste
        (v_codigo_emp IN emp.empno%type,
         v_porcentagem IN number DEFAULT 25);
   FUNCTION f_maiores_salarios (n INT)
   RETURN RegEmp;
END pkg_rh;
/

CREATE OR REPLACE PACKAGE BODY pkg_rh AS
   CURSOR c_sal RETURN RegEmp IS
      SELECT empno, sal FROM emp ORDER BY sal DESC;
 
   FUNCTION f_contrata_func (
        v_ename  emp.ename%TYPE,
        v_job    emp.job%TYPE,
        v_mgr    emp.mgr%TYPE,
        v_sal    emp.sal%TYPE,
        v_comm   emp.comm%TYPE,
        v_deptno emp.deptno%TYPE) 
        RETURN INT IS cod_novo_emp INT;
   BEGIN
      SELECT max(empno) + 1 INTO cod_novo_emp FROM emp;
      INSERT INTO emp (empno, ename, job, mgr, 
                       hiredate, sal, comm, deptno) 
               VALUES (cod_novo_emp, v_ename, v_job, 
                       v_mgr, SYSDATE, v_sal,
                       v_comm, v_deptno);
      RETURN cod_novo_emp;
   END f_contrata_func;
 
   PROCEDURE sp_demite_func (v_empno emp.empno%TYPE) IS
   BEGIN
      DELETE FROM emp WHERE empno = v_empno;
   END sp_demite_func;
   
   FUNCTION f_sal_ok
      (v_sal emp.sal%TYPE) 
       RETURN BOOLEAN IS
      min_sal emp.sal%TYPE;
      max_sal emp.sal%TYPE;
   BEGIN
      SELECT min(sal), max(sal) INTO 
             min_sal, max_sal
        FROM emp;
      RETURN (v_sal >= min_sal) AND (v_sal <= max_sal);
   END f_sal_ok;
   
  PROCEDURE sp_reajuste
      (v_codigo_emp IN emp.empno%type,
       v_porcentagem IN number DEFAULT 25) IS
       v_sal emp.sal%TYPE;
  BEGIN
      SELECT sal INTO v_sal 
        FROM emp 
       WHERE empno = v_codigo_emp;
      IF f_sal_ok(v_sal + (v_sal*(v_porcentagem/100))) THEN
         UPDATE emp
            SET sal = 
                   v_sal + (v_sal*(v_porcentagem/100))
          WHERE empno = v_codigo_emp;
      ELSE
         RAISE salario_invalido;
      END IF;
  END sp_reajuste;
 
   FUNCTION f_maiores_salarios (n INT) RETURN RegEmp IS
      emp_rec RegEmp;
   BEGIN
      OPEN c_sal;
      FOR i IN 1..n LOOP
         FETCH c_sal INTO emp_rec;
      END LOOP;
      CLOSE c_sal;
      RETURN emp_rec;
   END f_maiores_salarios;
END pkg_rh;
/

SET SERVEROUTPUT ON
DECLARE   
    novo_cod emp.empno%TYPE;
BEGIN   
    novo_cod := rh.f_contrata_func('Rita', 'Gerente', 7839, 9000, NULL, 10);
        DBMS_OUTPUT.PUT_LINE ('Funcionario ' || novo_cod || ' cadastrado');
END;
/
Select * from emp where empno = '7935';

BEGIN
  pkg_rh.sp_demite_func (7935);
END;
/