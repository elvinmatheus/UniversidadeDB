CREATE TABLE unidade_academica (
    codigo_seq  NUMBER              PRIMARY KEY,
    nome        VARCHAR2(100 CHAR)  NOT NULL UNIQUE,
    endereco    VARCHAR2(200 CHAR)  NOT NULL
);

CREATE TABLE telefone (
    codigo_seq  NUMBER              PRIMARY KEY,
    numero      VARCHAR2(20 CHAR)   NOT NULL UNIQUE,
    tipo        VARCHAR2(20 CHAR)   NOT NULL
);

CREATE TABLE telefone_unidade_academica (
    codigo_UA       NUMBER    NOT NULL,
    codigo_telefone NUMBER    NOT NULL UNIQUE,    
    FOREIGN KEY (codigo_UA)         REFERENCES unidade_academica (codigo_seq),
    FOREIGN KEY (codigo_telefone)   REFERENCES telefone (codigo_seq)
);

CREATE TABLE departamento (
    codigo_seq              NUMBER              PRIMARY KEY,
    nome                    VARCHAR2(100 CHAR)  NOT NULL UNIQUE,
    codigo_UA               NUMBER              NOT NULL,
    FOREIGN KEY (codigo_UA) REFERENCES unidade_academica (codigo_seq)
);

CREATE TABLE telefone_departamento (
    codigo_departamento     NUMBER      NOT NULL,
    codigo_telefone         NUMBER      NOT NULL UNIQUE,
    FOREIGN KEY (codigo_departamento)   REFERENCES departamento (codigo_seq),
    FOREIGN KEY (codigo_telefone)       REFERENCES telefone (codigo_seq)
);

CREATE TABLE curso (
    codigo_seq  NUMBER          PRIMARY KEY,
    nome        VARCHAR2(200)   NOT NULL UNIQUE
);

CREATE TABLE tefefone_curso(
    codigo_curso    NUMBER      NOT NULL,
    codigo_telefone NUMBER      NOT NULL UNIQUE,
    FOREIGN KEY (codigo_curso)      REFERENCES curso (codigo_seq),
    FOREIGN KEY (codigo_telefone)   REFERENCES telefone (codigo_seq)
);

CREATE TABLE departamento_curso(
    codigo_departamento NUMBER      NOT NULL,
    codigo_curso        NUMBER      NOT NULL,
    FOREIGN KEY (codigo_departamento)   REFERENCES departamento (codigo_seq),
    FOREIGN KEY (codigo_curso)          REFERENCES curso (codigo_seq)
);

CREATE TABLE professor (
    matricula               NUMBER              PRIMARY KEY,
    nome                    VARCHAR2(200 CHAR)  NOT NULL,
    lotacao                 NUMBER              NOT NULL,
    cpf                     VARCHAR2(11 CHAR)   NOT NULL UNIQUE,
    rg                      VARCHAR2(11 CHAR)   NOT NULL UNIQUE,
    salario                 NUMBER(*, 2)        NOT NULL,
    endereco                VARCHAR2(200 CHAR)  DEFAULT '',
    coordenador_curso_cod   NUMBER,
    chefe_departamento_cod  NUMBER,
    diretor_UA_cod          NUMBER,
    FOREIGN KEY (lotacao)                   REFERENCES departamento (codigo_seq),
    FOREIGN KEY (diretor_UA_cod)            REFERENCES unidade_academica (codigo_seq),
    FOREIGN KEY (chefe_departamento_cod)    REFERENCES departamento (codigo_seq),
    FOREIGN KEY (coordenador_curso_cod)     REFERENCES curso (codigo_seq)
);

CREATE TABLE disciplina (
    codigo_disciplina   VARCHAR2(10 CHAR)   PRIMARY KEY,
    nome                VARCHAR2(100 CHAR)  NOT NULL,
    creditos            NUMBER              NOT NULL,
    FOREIGN KEY (codigo_departamento) REFERENCES departamento (codigo_seq)
);

CREATE TABLE prerequisito (
    codigo_disciplina       VARCHAR2(10 CHAR)      NOT NULL,
    codigo_prerequisito     VARCHAR2(10 CHAR)      NOT NULL,
    FOREIGN KEY (codigo_disciplina)     REFERENCES disciplina (codigo_disciplina),
    FOREIGN KEY (codigo_prerequisito)   REFERENCES disciplina (codigo_disciplina)
);

CREATE TABLE professor_disciplina (
    codigo_disciplina   VARCHAR2(10 CHAR)   NOT NULL,
    matricula_professor NUMBER              NOT NULL,
    semestre            CHAR(6 CHAR)             NOT NULL,
    FOREIGN KEY (codigo_disciplina)     REFERENCES disciplina (codigo_disciplina),
    FOREIGN KEY (matricula_professor)   REFERENCES professor (matricula)
);

CREATE TABLE curso_disciplina (
    codigo_curso        NUMBER              NOT NULL,
    codigo_disciplina   VARCHAR2(10 CHAR)   NOT NULL,
    FOREIGN KEY (codigo_curso)      REFERENCES curso (codigo_seq),
    FOREIGN KEY (codigo_disciplina) REFERENCES disciplina (codigo_disciplina)
);

CREATE TABLE aluno (
    matricula       NUMBER              PRIMARY KEY,
    nome            VARCHAR2(120 CHAR)  NOT NULL,
    endereco        VARCHAR2(200 CHAR)  DEFAULT '',
    cpf             NUMBER              NOT NULL UNIQUE,
    rg              NUMBER              NOT NULL UNIQUE,
    codigo_curso    NUMBER              NOT NULL,
    FOREIGN KEY (codigo_curso) REFERENCES curso (codigo_seq)
);

CREATE TABLE aluno_disciplina (
    matricula_aluno     NUMBER              NOT NULL,
    codigo_disciplina   VARCHAR2(10 CHAR)   NOT NULL,
    semestre            CHAR(6)             NOT NULL,
    af                  NUMBER(5, 3),
    ap1                 NUMBER(5, 3),
    ap2                 NUMBER(5, 3),
    FOREIGN KEY (matricula_aluno)   REFERENCES aluno (matricula),
    FOREIGN KEY (codigo_disciplina) REFERENCES disciplina (codigo_disciplina),
    CHECK (af >= 0  AND af <= 10),
    CHECK (ap1 >= 0 AND ap1 <= 10),
    CHECK (ap2 >= 0 AND ap2 <= 10)
);