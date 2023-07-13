# Universidade DB

Este projeto descreve a construção de um Banco de Dados de uma Universidade utilizando Oracle Database 21c. O projeto foi proposto e realizado durante a disciplina de Fundamentos de Banco de Dados do curso de Ciência da Computação da Universidade Federal do Ceará. Deixo aqui registrado o meu agradecimento ao Renan que realizou o projeto comigo. 

## Instalação e configuração do Oracle Database 21c no Red Hat Enterprise Linux 8

Você pode seguir visualizar o processo de instalação e configuração do SGBD e do Sistema Operacional [aqui](https://medium.com/@elvinmatheus/instalando-o-oracle-database-21c-no-red-hat-enterprise-linux-8-ac90ab202601).

## Configurando um Banco de Dados no Oracle Database 21c

1. Crie um novo database com dbca
    - No terminal, digite dbca
    - Marque Advanced configuration
    - Selecione Oracle Single Instance database como o Database Type
    - Marque o template General Purpose or Transaction Processing
    - Em Global database name escolha o mesmo nome definido anteriormente para o SID
    - Marque a opção Create a Container database with one or more PDBs
        - Recomendo usar o nome pdborcl (mais fácil de lembrar)
    - Avance a seção Storage Option
    - Você pode desmarcar a opção Specify Fast Recovery Area em Fast Recovery Option
    - Em Network Configuration é necessário ter um Listener configurado
    - Avance as seções Data Vault Option, Configuration Options, Management Options
    - Em User Credentials, marque a opção Use the same administrative password for all acounts e forneça uma senha
    - Avance a seção Creation Option
    - Veja o resumo da instalação e depois inicie o processo de criação do database

2. Crie uma entrada TNS no arquivo tnsnames.ora usando o netca
    - No terminal, digite netca
    - Escolha a opção Local Net Service Name configuration
    - Marque Add 
    - Em service name, informe o nome do PDB criado anteriormente (pdborcl)
    - Escolha o hostname como localhost, caso o Oracle esteja instalado na mesma máquina
    - Se você desejar fazer um teste, marque a opção Yes, perform a test
    - Escolha o Net Service Name
    - Em seguida, marque No, Next e Finish
    - Teste a entrada TNS usando o comando tnsping
        - tnsping pdborcl

3. Inicie o PDB
    - No terminal, use "sqlplus / as sysdba"
    - Execute:
        ALTER PLUGGABLE DATABASE pdborcl OPEN;
        ALTER PLUGGABLE DATABASE pdborcl SAVE STATE;

4. Abra o SQL Developer
    - Conecte-se ao CDB ao clicar no símbolo de mais verde
    - Preencha o nome da conexão, username, password e SID
    - Execute os comandos:
        CREATE TABLESPACE universidade_tb
            DATAFILE '/u01/app/oracle/oradata/ORCL21/pdborcl/universidade_tb01.tbf' SIZE 20M
	        ONLINE;
        CREATE USER universidade IDENTIFIED BY universidade001 DEFAULT TABLESPACE universidade_tb;
        ALTER USER universidade ACCOUNT UNLOCK;
        GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO universidade;

5. Conecte-se ao PDB
    - Conecte-se ao PDB ao clicar no símbolo de mais verde
    - Preencha o nome da conexão, username (universidade), password (universidade001) e Service name (pdborcl)

## Diagrama Entidade-Relacionamento

![Imagem do diagrama ER](https://github.com/elvinmatheus/UniversidadeDB/blob/main/image/ERD.png)

## Criação do Banco de Dados

Execute os comandos SQL presentes no arquivo `init.sql` para criar as tabelas e relacionamentos.

## Carregamento dos dados

Execute os comandos SQL presentes no arquivo `dados.sql` para carregar os dados nas tabelas do banco de dados.