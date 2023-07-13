-- No sql developer
ALTER SESSION SET CONTAINER = PDBORCL21;

-- Local onde será armazenado o banco de dados
CREATE TABLESPACE universidade_tb
	DATAFILE '/u01/app/oracle/oradata/ORCL21/pdborcl21/universidade_tb01.tbf' SIZE 20M
	ONLINE;

-- Ainda não é um Schema, pois não temos nenhum objeto criado sob o usuário universidade
CREATE USER universidade IDENTIFIED BY universidade001 DEFAULT TABLESPACE universidade_tb;

ALTER USER universidade ACCOUNT UNLOCK;

-- Concessão de privilégios ao user universidade
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO universidade;

-- Para verificar a pasta e o padrão nominal para criação de tablespaces.
SELECT * FROM DBA_DATA_FILES;