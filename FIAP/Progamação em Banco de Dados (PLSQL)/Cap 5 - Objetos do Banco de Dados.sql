/* ----------------- Programação em Banco de Dados - FIAP ON -------------------

-- Cap 5. - Objetos do Banco de Dados                                         */

-- Introdução aos objetos compilados do banco de dados
-- Dicionário de dados

SELECT DISTINCT object_type 
  FROM user_objects;
  
SELECT DISTINCT object_type 
  FROM all_objects;
  
-- Objetos PL/SQL armazenados
-- Exibindo informações sobre os objetos armazenados

SELECT object_name
  FROM user_objects
 WHERE object_type = 'TABLE'
 ORDER BY object_name
/
SELECT object_name
  FROM all_objects
 WHERE object_type = 'TABLE'
 ORDER BY object_name
/
------------------------------------

SELECT object_type, object_name
  FROM user_objects
 WHERE status = 'INVALID'
 ORDER BY object_type, object_name
/

SELECT object_type, object_name, 
       last_ddl_time
  FROM usr_objects
 WHERE last_ddl_time >= TRUNC (SYSDATE)
 ORDER BY object_type, object_name
/

-- Exibindo infos sobre os o código-fonte

SELECT name, line, text
  FROM user_source
 WHERE UPPER(text) 
  LIKE '%DEPT%'
 ORDER BY name, line
/

-- Exibindo infos sobre procedimentos e funções

SELECT  object_name, procedure_name 
    FROM user_procedures
   WHERE authid = 'CURRENT_USER'
ORDER BY object_name, procedure_name
/

-- Exibindo infos sobre TRIGGERS

SELECT *
  FROM user_triggers 
 WHERE status = 'DISABLED'
/

SELECT *
  FROM user_triggers 
 WHERE table_name = 'EMP'
   AND trigger_type LIKE '%EACH ROW'
/

SELECT *
  FROM user_triggers 
 WHERE triggering_event LIKE '%UPDATE%'
/

