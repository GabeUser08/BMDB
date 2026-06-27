-- ============================================================
-- SCRIPT SQL - Sistema de Gestão Escolar
-- Gerado com base na modelagem lógica (brModelo)
-- ============================================================

-- ============================================================
-- CRIAÇÃO DAS TABELAS
-- ============================================================

CREATE TABLE estado (
    id_estado   INTEGER PRIMARY KEY,
    nome_estado VARCHAR(50) NOT NULL
);

CREATE TABLE cidade (
    id_cidade   INTEGER PRIMARY KEY,
    Nome_cidade VARCHAR(100) NOT NULL,
    id_estado   INTEGER NOT NULL,
    FOREIGN KEY (id_estado) REFERENCES estado(id_estado)
);

CREATE TABLE bairro (
    id_bairro   INTEGER PRIMARY KEY,
    nome_bairro VARCHAR(100) NOT NULL,
    id_cidade   INTEGER NOT NULL,
    FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade)
);

CREATE TABLE logradouro (
    id_logradouro INTEGER PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    id_bairro     INTEGER NOT NULL,
    FOREIGN KEY (id_bairro) REFERENCES bairro(id_bairro)
);

CREATE TABLE endereco (
    id_endereco   INTEGER PRIMARY KEY,
    numero        VARCHAR(10)  NOT NULL,
    complemento   VARCHAR(50),
    id_logradouro INTEGER NOT NULL,
    FOREIGN KEY (id_logradouro) REFERENCES logradouro(id_logradouro)
);

CREATE TABLE responsavel (
    id_responsavel INTEGER PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    id_endereco    INTEGER NOT NULL,
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
);

CREATE TABLE aluno (
    id_aluno        INTEGER PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    cpf             CHAR(11)     NOT NULL UNIQUE,
    data_nascimento DATE         NOT NULL,
    email           VARCHAR(100),
    id_endereco     INTEGER NOT NULL,
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
);

CREATE TABLE aluno_responsavel (
    id_aluno       INTEGER NOT NULL,
    id_responsavel INTEGER NOT NULL,
    parentesco     VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_aluno, id_responsavel),
    FOREIGN KEY (id_aluno)       REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_responsavel) REFERENCES responsavel(id_responsavel)
);

CREATE TABLE coordenador (
    id_coordenador INTEGER PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    id_endereco    INTEGER NOT NULL,
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
);

CREATE TABLE professor (
    id_professor INTEGER PRIMARY KEY,
    nome         VARCHAR(100) NOT NULL,
    formacao     VARCHAR(100) NOT NULL,
    email        VARCHAR(100),
    id_endereco  INTEGER NOT NULL,
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
);

CREATE TABLE curso (
    id_curso       INTEGER PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    duracao        INTEGER      NOT NULL,
    id_coordenador INTEGER NOT NULL,
    FOREIGN KEY (id_coordenador) REFERENCES coordenador(id_coordenador)
);

CREATE TABLE disciplina (
    id_disciplina INTEGER PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    Carga_horaria INTEGER      NOT NULL,
    id_curso      INTEGER NOT NULL,
    id_professor  INTEGER NOT NULL,
    FOREIGN KEY (id_curso)    REFERENCES curso(id_curso),
    FOREIGN KEY (id_professor) REFERENCES professor(id_professor)
);

CREATE TABLE turma (
    id_turma   INTEGER PRIMARY KEY,
    nome       VARCHAR(50)  NOT NULL,
    ano_letivo CHAR(4)      NOT NULL,
    id_curso   INTEGER NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);

CREATE TABLE disciplina_turma (
    id_disciplina INTEGER NOT NULL,
    id_turma      INTEGER NOT NULL,
    PRIMARY KEY (id_disciplina, id_turma),
    FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina),
    FOREIGN KEY (id_turma)      REFERENCES turma(id_turma)
);

CREATE TABLE matricula (
    id_matricula   INTEGER PRIMARY KEY,
    data_matricula DATE    NOT NULL,
    id_aluno       INTEGER NOT NULL,
    id_turma       INTEGER NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
);

CREATE TABLE avaliacao (
    id_avaliacao  INTEGER PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    id_disciplina INTEGER NOT NULL,
    FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)
);

CREATE TABLE nota (
    id_nota      INTEGER PRIMARY KEY,
    nota         DECIMAL(4,2) NOT NULL,
    media_final  DECIMAL(4,2),
    id_matricula INTEGER NOT NULL,
    id_avaliacao INTEGER NOT NULL,
    FOREIGN KEY (id_matricula) REFERENCES matricula(id_matricula),
    FOREIGN KEY (id_avaliacao) REFERENCES avaliacao(id_avaliacao)
);

CREATE TABLE frequencia (
    id_frequencia         INTEGER PRIMARY KEY,
    percentual_frequencia DECIMAL(5,2) NOT NULL,
    id_matricula          INTEGER NOT NULL,
    FOREIGN KEY (id_matricula) REFERENCES matricula(id_matricula)
);

CREATE TABLE boletim (
    id_boletim    INTEGER PRIMARY KEY,
    id_frequencia INTEGER NOT NULL,
    id_matricula  INTEGER NOT NULL,
    FOREIGN KEY (id_frequencia) REFERENCES frequencia(id_frequencia),
    FOREIGN KEY (id_matricula)  REFERENCES matricula(id_matricula)
);


-- ============================================================
-- INSERÇÃO DE DADOS FICTÍCIOS (5 por tabela)
-- ============================================================

-- estado
INSERT INTO estado VALUES (1, 'São Paulo');
INSERT INTO estado VALUES (2, 'Rio de Janeiro');
INSERT INTO estado VALUES (3, 'Minas Gerais');
INSERT INTO estado VALUES (4, 'Paraná');
INSERT INTO estado VALUES (5, 'Bahia');

-- cidade
INSERT INTO cidade VALUES (1, 'São José dos Campos', 1);
INSERT INTO cidade VALUES (2, 'Campinas',            1);
INSERT INTO cidade VALUES (3, 'Rio de Janeiro',      2);
INSERT INTO cidade VALUES (4, 'Belo Horizonte',      3);
INSERT INTO cidade VALUES (5, 'Curitiba',            4);

-- bairro
INSERT INTO bairro VALUES (1, 'Centro',          1);
INSERT INTO bairro VALUES (2, 'Vila Industrial', 1);
INSERT INTO bairro VALUES (3, 'Jardim América',  2);
INSERT INTO bairro VALUES (4, 'Copacabana',      3);
INSERT INTO bairro VALUES (5, 'Savassi',         4);

-- logradouro
INSERT INTO logradouro VALUES (1, 'Rua das Flores',        1);
INSERT INTO logradouro VALUES (2, 'Av. Brasil',             2);
INSERT INTO logradouro VALUES (3, 'Rua Humberto de Campos', 3);
INSERT INTO logradouro VALUES (4, 'Av. Atlântica',          4);
INSERT INTO logradouro VALUES (5, 'Rua da Bahia',           5);

-- endereco
INSERT INTO endereco VALUES (1, '100',  NULL,       1);
INSERT INTO endereco VALUES (2, '250',  'Apto 12',  2);
INSERT INTO endereco VALUES (3, '33',   'Casa B',   3);
INSERT INTO endereco VALUES (4, '1500', NULL,       4);
INSERT INTO endereco VALUES (5, '78',   'Bloco C',  5);

-- responsavel
INSERT INTO responsavel VALUES (1, 'Maria Oliveira',   1);
INSERT INTO responsavel VALUES (2, 'João Santos',      2);
INSERT INTO responsavel VALUES (3, 'Ana Lima',         3);
INSERT INTO responsavel VALUES (4, 'Carlos Ferreira',  4);
INSERT INTO responsavel VALUES (5, 'Fernanda Costa',   5);

-- aluno
INSERT INTO aluno VALUES (1, 'Lucas Souza',        '11122233344', '2006-03-15', 'lucas@email.com',    1);
INSERT INTO aluno VALUES (2, 'Beatriz Martins',    '22233344455', '2007-08-22', 'bea@email.com',      2);
INSERT INTO aluno VALUES (3, 'Rafael Andrade',     '33344455566', '2006-11-01', 'rafael@email.com',   3);
INSERT INTO aluno VALUES (4, 'Isabela Rocha',      '44455566677', '2007-05-30', 'isa@email.com',      4);
INSERT INTO aluno VALUES (5, 'Gabriel Nascimento', '55566677788', '2006-07-18', 'gabriel@email.com',  5);

-- aluno_responsavel
INSERT INTO aluno_responsavel VALUES (1, 1, 'Mãe');
INSERT INTO aluno_responsavel VALUES (2, 2, 'Pai');
INSERT INTO aluno_responsavel VALUES (3, 3, 'Mãe');
INSERT INTO aluno_responsavel VALUES (4, 4, 'Pai');
INSERT INTO aluno_responsavel VALUES (5, 5, 'Responsável Legal');

-- coordenador
INSERT INTO coordenador VALUES (1, 'Dra. Patrícia Mendes',  1);
INSERT INTO coordenador VALUES (2, 'Dr. Henrique Alves',    2);
INSERT INTO coordenador VALUES (3, 'Dra. Camila Torres',    3);
INSERT INTO coordenador VALUES (4, 'Dr. Ricardo Gomes',     4);
INSERT INTO coordenador VALUES (5, 'Dra. Simone Barbosa',   5);

-- professor
INSERT INTO professor VALUES (1, 'Prof. André Vieira',   'Licenciatura em Matemática',   'andre@escola.com',   1);
INSERT INTO professor VALUES (2, 'Profa. Juliana Pinto', 'Licenciatura em Português',    'juliana@escola.com', 2);
INSERT INTO professor VALUES (3, 'Prof. Marcos Corrêa',  'Licenciatura em História',     'marcos@escola.com',  3);
INSERT INTO professor VALUES (4, 'Profa. Larissa Nunes', 'Licenciatura em Ciências',     'larissa@escola.com', 4);
INSERT INTO professor VALUES (5, 'Prof. Bruno Cardoso',  'Licenciatura em Ed. Física',   'bruno@escola.com',   5);

-- curso
INSERT INTO curso VALUES (1, 'Técnico em Desenvolvimento de Sistemas', 3, 1);
INSERT INTO curso VALUES (2, 'Técnico em Administração',                2, 2);
INSERT INTO curso VALUES (3, 'Técnico em Enfermagem',                   2, 3);
INSERT INTO curso VALUES (4, 'Técnico em Design Gráfico',               2, 4);
INSERT INTO curso VALUES (5, 'Ensino Médio Regular',                    3, 5);

-- disciplina
INSERT INTO disciplina VALUES (1, 'Algoritmos e Lógica de Programação', 80, 1, 1);
INSERT INTO disciplina VALUES (2, 'Língua Portuguesa',                  60, 5, 2);
INSERT INTO disciplina VALUES (3, 'História Geral',                     60, 5, 3);
INSERT INTO disciplina VALUES (4, 'Biologia',                           60, 5, 4);
INSERT INTO disciplina VALUES (5, 'Educação Física',                    40, 5, 5);

-- turma
INSERT INTO turma VALUES (1, '1DS-A', '2024', 1);
INSERT INTO turma VALUES (2, '1DS-B', '2024', 1);
INSERT INTO turma VALUES (3, '1ADM',  '2024', 2);
INSERT INTO turma VALUES (4, '1MED',  '2024', 3);
INSERT INTO turma VALUES (5, '1EM-A', '2024', 5);

-- disciplina_turma
INSERT INTO disciplina_turma VALUES (1, 1);
INSERT INTO disciplina_turma VALUES (2, 5);
INSERT INTO disciplina_turma VALUES (3, 5);
INSERT INTO disciplina_turma VALUES (4, 5);
INSERT INTO disciplina_turma VALUES (5, 5);

-- matricula
INSERT INTO matricula VALUES (1, '2024-02-05', 1, 1);
INSERT INTO matricula VALUES (2, '2024-02-05', 2, 1);
INSERT INTO matricula VALUES (3, '2024-02-05', 3, 3);
INSERT INTO matricula VALUES (4, '2024-02-05', 4, 4);
INSERT INTO matricula VALUES (5, '2024-02-05', 5, 5);

-- avaliacao
INSERT INTO avaliacao VALUES (1, 'Prova Bimestral 1', 1);
INSERT INTO avaliacao VALUES (2, 'Prova Bimestral 2', 1);
INSERT INTO avaliacao VALUES (3, 'Trabalho em Grupo', 2);
INSERT INTO avaliacao VALUES (4, 'Prova Bimestral 1', 3);
INSERT INTO avaliacao VALUES (5, 'Apresentação Oral',  4);

-- nota
INSERT INTO nota VALUES (1, 8.5,  8.5,  1, 1);
INSERT INTO nota VALUES (2, 7.0,  7.0,  2, 1);
INSERT INTO nota VALUES (3, 9.0,  9.0,  1, 2);
INSERT INTO nota VALUES (4, 6.5,  6.5,  3, 3);
INSERT INTO nota VALUES (5, 10.0, 10.0, 4, 4);

-- frequencia
INSERT INTO frequencia VALUES (1, 92.50, 1);
INSERT INTO frequencia VALUES (2, 87.30, 2);
INSERT INTO frequencia VALUES (3, 95.00, 3);
INSERT INTO frequencia VALUES (4, 78.60, 4);
INSERT INTO frequencia VALUES (5, 100.0, 5);

-- boletim
INSERT INTO boletim VALUES (1, 1, 1);
INSERT INTO boletim VALUES (2, 2, 2);
INSERT INTO boletim VALUES (3, 3, 3);
INSERT INTO boletim VALUES (4, 4, 4);
INSERT INTO boletim VALUES (5, 5, 5);
