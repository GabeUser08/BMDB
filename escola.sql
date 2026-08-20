
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


INSERT INTO estado VALUES (1, 'São Paulo');
INSERT INTO estado VALUES (2, 'Rio de Janeiro');
INSERT INTO estado VALUES (3, 'Minas Gerais');
INSERT INTO estado VALUES (4, 'Paraná');
INSERT INTO estado VALUES (5, 'Bahia');
INSERT INTO estado VALUES (6, 'Santa Catarina');
INSERT INTO estado VALUES (7, 'Rio Grande do Sul');
INSERT INTO estado VALUES (8, 'Pernambuco');
INSERT INTO estado VALUES (9, 'Ceará');
INSERT INTO estado VALUES (10, 'Goiás');
INSERT INTO estado VALUES (11, 'Espírito Santo');
INSERT INTO estado VALUES (12, 'Pará');
INSERT INTO estado VALUES (13, 'Maranhão');
INSERT INTO estado VALUES (14, 'Amazonas');
INSERT INTO estado VALUES (15, 'Mato Grosso');

-- cidade
INSERT INTO cidade VALUES (1, 'São José dos Campos', 1);
INSERT INTO cidade VALUES (2, 'Campinas', 1);
INSERT INTO cidade VALUES (3, 'Rio de Janeiro', 2);
INSERT INTO cidade VALUES (4, 'Belo Horizonte', 3);
INSERT INTO cidade VALUES (5, 'Curitiba', 4);
INSERT INTO cidade VALUES (6, 'Salvador', 5);
INSERT INTO cidade VALUES (7, 'Florianópolis', 6);
INSERT INTO cidade VALUES (8, 'Porto Alegre', 7);
INSERT INTO cidade VALUES (9, 'Recife', 8);
INSERT INTO cidade VALUES (10, 'Fortaleza', 9);
INSERT INTO cidade VALUES (11, 'Goiânia', 10);
INSERT INTO cidade VALUES (12, 'Vitória', 11);
INSERT INTO cidade VALUES (13, 'Belém', 12);
INSERT INTO cidade VALUES (14, 'São Luís', 13);
INSERT INTO cidade VALUES (15, 'Manaus', 14);

-- bairro
INSERT INTO bairro VALUES (1, 'Centro', 1);
INSERT INTO bairro VALUES (2, 'Vila Industrial', 2);
INSERT INTO bairro VALUES (3, 'Jardim América', 3);
INSERT INTO bairro VALUES (4, 'Copacabana', 4);
INSERT INTO bairro VALUES (5, 'Savassi', 5);
INSERT INTO bairro VALUES (6, 'Batel', 6);
INSERT INTO bairro VALUES (7, 'Pituba', 7);
INSERT INTO bairro VALUES (8, 'Trindade', 8);
INSERT INTO bairro VALUES (9, 'Moinhos de Vento', 9);
INSERT INTO bairro VALUES (10, 'Boa Viagem', 10);
INSERT INTO bairro VALUES (11, 'Aldeota', 11);
INSERT INTO bairro VALUES (12, 'Setor Bueno', 12);
INSERT INTO bairro VALUES (13, 'Praia do Canto', 13);
INSERT INTO bairro VALUES (14, 'Nazaré', 14);
INSERT INTO bairro VALUES (15, 'Adrianópolis', 15);

-- logradouro
INSERT INTO logradouro VALUES (1, 'Rua das Flores', 1);
INSERT INTO logradouro VALUES (2, 'Av. Brasil', 2);
INSERT INTO logradouro VALUES (3, 'Rua Humberto de Campos', 3);
INSERT INTO logradouro VALUES (4, 'Av. Atlântica', 4);
INSERT INTO logradouro VALUES (5, 'Rua da Bahia', 5);
INSERT INTO logradouro VALUES (6, 'Rua XV de Novembro', 6);
INSERT INTO logradouro VALUES (7, 'Av. Beira-Mar', 7);
INSERT INTO logradouro VALUES (8, 'Rua Padre Chagas', 8);
INSERT INTO logradouro VALUES (9, 'Av. Boa Viagem', 9);
INSERT INTO logradouro VALUES (10, 'Av. Santos Dumont', 10);
INSERT INTO logradouro VALUES (11, 'Av. T-63', 11);
INSERT INTO logradouro VALUES (12, 'Av. Nossa Senhora da Penha', 12);
INSERT INTO logradouro VALUES (13, 'Av. Nazaré', 13);
INSERT INTO logradouro VALUES (14, 'Av. dos Holandeses', 14);
INSERT INTO logradouro VALUES (15, 'Av. Djalma Batista', 15);

-- endereco
INSERT INTO endereco VALUES (1, '137', 'Apto 1', 1);
INSERT INTO endereco VALUES (2, '174', 'Apto 2', 2);
INSERT INTO endereco VALUES (3, '211', NULL, 3);
INSERT INTO endereco VALUES (4, '248', 'Apto 4', 4);
INSERT INTO endereco VALUES (5, '285', 'Apto 5', 5);
INSERT INTO endereco VALUES (6, '322', NULL, 6);
INSERT INTO endereco VALUES (7, '359', 'Apto 7', 7);
INSERT INTO endereco VALUES (8, '396', 'Apto 8', 8);
INSERT INTO endereco VALUES (9, '433', NULL, 9);
INSERT INTO endereco VALUES (10, '470', 'Apto 10', 10);
INSERT INTO endereco VALUES (11, '507', 'Apto 11', 11);
INSERT INTO endereco VALUES (12, '544', NULL, 12);
INSERT INTO endereco VALUES (13, '581', 'Apto 13', 13);
INSERT INTO endereco VALUES (14, '618', 'Apto 14', 14);
INSERT INTO endereco VALUES (15, '655', NULL, 15);

-- responsavel
INSERT INTO responsavel VALUES (1, 'Maria Oliveira', 1);
INSERT INTO responsavel VALUES (2, 'João Santos', 2);
INSERT INTO responsavel VALUES (3, 'Ana Lima', 3);
INSERT INTO responsavel VALUES (4, 'Carlos Ferreira', 4);
INSERT INTO responsavel VALUES (5, 'Fernanda Costa', 5);
INSERT INTO responsavel VALUES (6, 'Patrícia Mendes', 6);
INSERT INTO responsavel VALUES (7, 'Henrique Alves', 7);
INSERT INTO responsavel VALUES (8, 'Camila Torres', 8);
INSERT INTO responsavel VALUES (9, 'Ricardo Gomes', 9);
INSERT INTO responsavel VALUES (10, 'Simone Barbosa', 10);
INSERT INTO responsavel VALUES (11, 'André Vieira', 11);
INSERT INTO responsavel VALUES (12, 'Juliana Pinto', 12);
INSERT INTO responsavel VALUES (13, 'Marcos Corrêa', 13);
INSERT INTO responsavel VALUES (14, 'Larissa Nunes', 14);
INSERT INTO responsavel VALUES (15, 'Bruno Cardoso', 15);

-- aluno
INSERT INTO aluno VALUES (1, 'Lucas Souza', '11122233001', '2007-01-02', 'aluno01@email.com', 1);
INSERT INTO aluno VALUES (2, 'Beatriz Martins', '11122233002', '2006-02-04', 'aluno02@email.com', 2);
INSERT INTO aluno VALUES (3, 'Rafael Andrade', '11122233003', '2007-03-06', 'aluno03@email.com', 3);
INSERT INTO aluno VALUES (4, 'Isabela Rocha', '11122233004', '2006-04-08', 'aluno04@email.com', 4);
INSERT INTO aluno VALUES (5, 'Gabriel Nascimento', '11122233005', '2007-05-10', 'aluno05@email.com', 5);
INSERT INTO aluno VALUES (6, 'Mariana Oliveira', '11122233006', '2006-06-12', 'aluno06@email.com', 6);
INSERT INTO aluno VALUES (7, 'Pedro Santos', '11122233007', '2007-07-14', 'aluno07@email.com', 7);
INSERT INTO aluno VALUES (8, 'Ana Clara Lima', '11122233008', '2006-08-16', 'aluno08@email.com', 8);
INSERT INTO aluno VALUES (9, 'João Ferreira', '11122233009', '2007-09-18', 'aluno09@email.com', 9);
INSERT INTO aluno VALUES (10, 'Larissa Costa', '11122233010', '2006-10-20', 'aluno10@email.com', 10);
INSERT INTO aluno VALUES (11, 'Matheus Mendes', '11122233011', '2007-11-22', 'aluno11@email.com', 11);
INSERT INTO aluno VALUES (12, 'Bianca Alves', '11122233012', '2006-12-24', 'aluno12@email.com', 12);
INSERT INTO aluno VALUES (13, 'Felipe Torres', '11122233013', '2007-01-26', 'aluno13@email.com', 13);
INSERT INTO aluno VALUES (14, 'Amanda Gomes', '11122233014', '2006-02-01', 'aluno14@email.com', 14);
INSERT INTO aluno VALUES (15, 'Gustavo Barbosa', '11122233015', '2007-03-03', 'aluno15@email.com', 15);

-- aluno_responsavel
INSERT INTO aluno_responsavel VALUES (1, 1, 'Mãe');
INSERT INTO aluno_responsavel VALUES (2, 2, 'Pai');
INSERT INTO aluno_responsavel VALUES (3, 3, 'Responsável Legal');
INSERT INTO aluno_responsavel VALUES (4, 4, 'Mãe');
INSERT INTO aluno_responsavel VALUES (5, 5, 'Pai');
INSERT INTO aluno_responsavel VALUES (6, 6, 'Mãe');
INSERT INTO aluno_responsavel VALUES (7, 7, 'Pai');
INSERT INTO aluno_responsavel VALUES (8, 8, 'Responsável Legal');
INSERT INTO aluno_responsavel VALUES (9, 9, 'Mãe');
INSERT INTO aluno_responsavel VALUES (10, 10, 'Pai');
INSERT INTO aluno_responsavel VALUES (11, 11, 'Mãe');
INSERT INTO aluno_responsavel VALUES (12, 12, 'Pai');
INSERT INTO aluno_responsavel VALUES (13, 13, 'Responsável Legal');
INSERT INTO aluno_responsavel VALUES (14, 14, 'Mãe');
INSERT INTO aluno_responsavel VALUES (15, 15, 'Pai');

-- coordenador
INSERT INTO coordenador VALUES (1, 'Patrícia Mendes', 1);
INSERT INTO coordenador VALUES (2, 'Henrique Alves', 2);
INSERT INTO coordenador VALUES (3, 'Camila Torres', 3);
INSERT INTO coordenador VALUES (4, 'Ricardo Gomes', 4);
INSERT INTO coordenador VALUES (5, 'Simone Barbosa', 5);
INSERT INTO coordenador VALUES (6, 'André Vieira', 6);
INSERT INTO coordenador VALUES (7, 'Juliana Pinto', 7);
INSERT INTO coordenador VALUES (8, 'Marcos Corrêa', 8);
INSERT INTO coordenador VALUES (9, 'Larissa Nunes', 9);
INSERT INTO coordenador VALUES (10, 'Bruno Cardoso', 10);
INSERT INTO coordenador VALUES (11, 'Renata Freitas', 11);
INSERT INTO coordenador VALUES (12, 'Paulo Ribeiro', 12);
INSERT INTO coordenador VALUES (13, 'Carla Moreira', 13);
INSERT INTO coordenador VALUES (14, 'Eduardo Teixeira', 14);
INSERT INTO coordenador VALUES (15, 'Débora Machado', 15);

-- professor
INSERT INTO professor VALUES (1, 'André Vieira', 'Licenciatura em Matemática', 'prof01@escola.com', 1);
INSERT INTO professor VALUES (2, 'Juliana Pinto', 'Licenciatura em Português', 'prof02@escola.com', 2);
INSERT INTO professor VALUES (3, 'Marcos Corrêa', 'Licenciatura em História', 'prof03@escola.com', 3);
INSERT INTO professor VALUES (4, 'Larissa Nunes', 'Licenciatura em Ciências', 'prof04@escola.com', 4);
INSERT INTO professor VALUES (5, 'Bruno Cardoso', 'Licenciatura em Ed. Física', 'prof05@escola.com', 5);
INSERT INTO professor VALUES (6, 'Renata Freitas', 'Ciência da Computação', 'prof06@escola.com', 6);
INSERT INTO professor VALUES (7, 'Paulo Ribeiro', 'Administração', 'prof07@escola.com', 7);
INSERT INTO professor VALUES (8, 'Carla Moreira', 'Enfermagem', 'prof08@escola.com', 8);
INSERT INTO professor VALUES (9, 'Eduardo Teixeira', 'Design Gráfico', 'prof09@escola.com', 9);
INSERT INTO professor VALUES (10, 'Débora Machado', 'Licenciatura em Física', 'prof10@escola.com', 10);
INSERT INTO professor VALUES (11, 'Fábio Martins', 'Licenciatura em Química', 'prof11@escola.com', 11);
INSERT INTO professor VALUES (12, 'Aline Souza', 'Licenciatura em Geografia', 'prof12@escola.com', 12);
INSERT INTO professor VALUES (13, 'Roberto Lima', 'Licenciatura em Sociologia', 'prof13@escola.com', 13);
INSERT INTO professor VALUES (14, 'Vanessa Costa', 'Licenciatura em Artes', 'prof14@escola.com', 14);
INSERT INTO professor VALUES (15, 'Diego Alves', 'Engenharia de Software', 'prof15@escola.com', 15);

-- curso
INSERT INTO curso VALUES (1, 'Técnico em Desenvolvimento de Sistemas', 3, 1);
INSERT INTO curso VALUES (2, 'Técnico em Administração', 2, 2);
INSERT INTO curso VALUES (3, 'Técnico em Enfermagem', 2, 3);
INSERT INTO curso VALUES (4, 'Técnico em Design Gráfico', 2, 4);
INSERT INTO curso VALUES (5, 'Ensino Médio Regular', 3, 5);
INSERT INTO curso VALUES (6, 'Técnico em Informática', 2, 6);
INSERT INTO curso VALUES (7, 'Técnico em Logística', 2, 7);
INSERT INTO curso VALUES (8, 'Técnico em Recursos Humanos', 2, 8);
INSERT INTO curso VALUES (9, 'Técnico em Eletrônica', 2, 9);
INSERT INTO curso VALUES (10, 'Técnico em Mecânica', 2, 10);
INSERT INTO curso VALUES (11, 'Técnico em Redes', 2, 11);
INSERT INTO curso VALUES (12, 'Técnico em Contabilidade', 2, 12);
INSERT INTO curso VALUES (13, 'Técnico em Marketing', 2, 13);
INSERT INTO curso VALUES (14, 'Técnico em Segurança do Trabalho', 2, 14);
INSERT INTO curso VALUES (15, 'Técnico em Multimídia', 2, 15);

-- disciplina
INSERT INTO disciplina VALUES (1, 'Algoritmos e Lógica de Programação', 80, 1, 1);
INSERT INTO disciplina VALUES (2, 'Língua Portuguesa', 60, 2, 2);
INSERT INTO disciplina VALUES (3, 'História Geral', 60, 3, 3);
INSERT INTO disciplina VALUES (4, 'Biologia', 60, 4, 4);
INSERT INTO disciplina VALUES (5, 'Educação Física', 40, 5, 5);
INSERT INTO disciplina VALUES (6, 'Banco de Dados', 80, 6, 6);
INSERT INTO disciplina VALUES (7, 'Matemática', 80, 7, 7);
INSERT INTO disciplina VALUES (8, 'Inglês', 60, 8, 8);
INSERT INTO disciplina VALUES (9, 'Física', 60, 9, 9);
INSERT INTO disciplina VALUES (10, 'Química', 60, 10, 10);
INSERT INTO disciplina VALUES (11, 'Programação Web', 80, 11, 11);
INSERT INTO disciplina VALUES (12, 'Redes de Computadores', 60, 12, 12);
INSERT INTO disciplina VALUES (13, 'Geografia', 60, 13, 13);
INSERT INTO disciplina VALUES (14, 'Sociologia', 40, 14, 14);
INSERT INTO disciplina VALUES (15, 'Artes', 40, 15, 15);

-- turma
INSERT INTO turma VALUES (1, 'TURMA-01', '2026', 1);
INSERT INTO turma VALUES (2, 'TURMA-02', '2026', 2);
INSERT INTO turma VALUES (3, 'TURMA-03', '2026', 3);
INSERT INTO turma VALUES (4, 'TURMA-04', '2026', 4);
INSERT INTO turma VALUES (5, 'TURMA-05', '2026', 5);
INSERT INTO turma VALUES (6, 'TURMA-06', '2026', 6);
INSERT INTO turma VALUES (7, 'TURMA-07', '2026', 7);
INSERT INTO turma VALUES (8, 'TURMA-08', '2026', 8);
INSERT INTO turma VALUES (9, 'TURMA-09', '2026', 9);
INSERT INTO turma VALUES (10, 'TURMA-10', '2026', 10);
INSERT INTO turma VALUES (11, 'TURMA-11', '2026', 11);
INSERT INTO turma VALUES (12, 'TURMA-12', '2026', 12);
INSERT INTO turma VALUES (13, 'TURMA-13', '2026', 13);
INSERT INTO turma VALUES (14, 'TURMA-14', '2026', 14);
INSERT INTO turma VALUES (15, 'TURMA-15', '2026', 15);

-- disciplina_turma
INSERT INTO disciplina_turma VALUES (1, 1);
INSERT INTO disciplina_turma VALUES (2, 2);
INSERT INTO disciplina_turma VALUES (3, 3);
INSERT INTO disciplina_turma VALUES (4, 4);
INSERT INTO disciplina_turma VALUES (5, 5);
INSERT INTO disciplina_turma VALUES (6, 6);
INSERT INTO disciplina_turma VALUES (7, 7);
INSERT INTO disciplina_turma VALUES (8, 8);
INSERT INTO disciplina_turma VALUES (9, 9);
INSERT INTO disciplina_turma VALUES (10, 10);
INSERT INTO disciplina_turma VALUES (11, 11);
INSERT INTO disciplina_turma VALUES (12, 12);
INSERT INTO disciplina_turma VALUES (13, 13);
INSERT INTO disciplina_turma VALUES (14, 14);
INSERT INTO disciplina_turma VALUES (15, 15);

-- matricula
INSERT INTO matricula VALUES (1, '2026-02-01', 1, 1);
INSERT INTO matricula VALUES (2, '2026-02-02', 2, 2);
INSERT INTO matricula VALUES (3, '2026-02-03', 3, 3);
INSERT INTO matricula VALUES (4, '2026-02-04', 4, 4);
INSERT INTO matricula VALUES (5, '2026-02-05', 5, 5);
INSERT INTO matricula VALUES (6, '2026-02-06', 6, 6);
INSERT INTO matricula VALUES (7, '2026-02-07', 7, 7);
INSERT INTO matricula VALUES (8, '2026-02-08', 8, 8);
INSERT INTO matricula VALUES (9, '2026-02-09', 9, 9);
INSERT INTO matricula VALUES (10, '2026-02-10', 10, 10);
INSERT INTO matricula VALUES (11, '2026-02-11', 11, 11);
INSERT INTO matricula VALUES (12, '2026-02-12', 12, 12);
INSERT INTO matricula VALUES (13, '2026-02-13', 13, 13);
INSERT INTO matricula VALUES (14, '2026-02-14', 14, 14);
INSERT INTO matricula VALUES (15, '2026-02-15', 15, 15);

-- avaliacao
INSERT INTO avaliacao VALUES (1, 'Prova Bimestral 1', 1);
INSERT INTO avaliacao VALUES (2, 'Trabalho em Grupo 1', 2);
INSERT INTO avaliacao VALUES (3, 'Seminário 1', 3);
INSERT INTO avaliacao VALUES (4, 'Projeto Prático 1', 4);
INSERT INTO avaliacao VALUES (5, 'Lista de Exercícios 1', 5);
INSERT INTO avaliacao VALUES (6, 'Prova Bimestral 2', 6);
INSERT INTO avaliacao VALUES (7, 'Trabalho em Grupo 2', 7);
INSERT INTO avaliacao VALUES (8, 'Seminário 2', 8);
INSERT INTO avaliacao VALUES (9, 'Projeto Prático 2', 9);
INSERT INTO avaliacao VALUES (10, 'Lista de Exercícios 2', 10);
INSERT INTO avaliacao VALUES (11, 'Prova Bimestral 3', 11);
INSERT INTO avaliacao VALUES (12, 'Trabalho em Grupo 3', 12);
INSERT INTO avaliacao VALUES (13, 'Seminário 3', 13);
INSERT INTO avaliacao VALUES (14, 'Projeto Prático 3', 14);
INSERT INTO avaliacao VALUES (15, 'Lista de Exercícios 3', 15);

-- nota
INSERT INTO nota VALUES (1, 6.70, 6.70, 1, 1);
INSERT INTO nota VALUES (2, 7.40, 7.40, 2, 2);
INSERT INTO nota VALUES (3, 8.10, 8.10, 3, 3);
INSERT INTO nota VALUES (4, 8.80, 8.80, 4, 4);
INSERT INTO nota VALUES (5, 9.50, 9.50, 5, 5);
INSERT INTO nota VALUES (6, 6.10, 6.10, 6, 6);
INSERT INTO nota VALUES (7, 6.80, 6.80, 7, 7);
INSERT INTO nota VALUES (8, 7.50, 7.50, 8, 8);
INSERT INTO nota VALUES (9, 8.20, 8.20, 9, 9);
INSERT INTO nota VALUES (10, 8.90, 8.90, 10, 10);
INSERT INTO nota VALUES (11, 9.60, 9.60, 11, 11);
INSERT INTO nota VALUES (12, 6.20, 6.20, 12, 12);
INSERT INTO nota VALUES (13, 6.90, 6.90, 13, 13);
INSERT INTO nota VALUES (14, 7.60, 7.60, 14, 14);
INSERT INTO nota VALUES (15, 8.30, 8.30, 15, 15);

-- frequencia
INSERT INTO frequencia VALUES (1, 79.10, 1);
INSERT INTO frequencia VALUES (2, 80.20, 2);
INSERT INTO frequencia VALUES (3, 81.30, 3);
INSERT INTO frequencia VALUES (4, 82.40, 4);
INSERT INTO frequencia VALUES (5, 83.50, 5);
INSERT INTO frequencia VALUES (6, 84.60, 6);
INSERT INTO frequencia VALUES (7, 85.70, 7);
INSERT INTO frequencia VALUES (8, 86.80, 8);
INSERT INTO frequencia VALUES (9, 87.90, 9);
INSERT INTO frequencia VALUES (10, 89.00, 10);
INSERT INTO frequencia VALUES (11, 90.10, 11);
INSERT INTO frequencia VALUES (12, 91.20, 12);
INSERT INTO frequencia VALUES (13, 92.30, 13);
INSERT INTO frequencia VALUES (14, 93.40, 14);
INSERT INTO frequencia VALUES (15, 94.50, 15);

-- boletim
INSERT INTO boletim VALUES (1, 1, 1);
INSERT INTO boletim VALUES (2, 2, 2);
INSERT INTO boletim VALUES (3, 3, 3);
INSERT INTO boletim VALUES (4, 4, 4);
INSERT INTO boletim VALUES (5, 5, 5);
INSERT INTO boletim VALUES (6, 6, 6);
INSERT INTO boletim VALUES (7, 7, 7);
INSERT INTO boletim VALUES (8, 8, 8);
INSERT INTO boletim VALUES (9, 9, 9);
INSERT INTO boletim VALUES (10, 10, 10);
INSERT INTO boletim VALUES (11, 11, 11);
INSERT INTO boletim VALUES (12, 12, 12);
INSERT INTO boletim VALUES (13, 13, 13);
INSERT INTO boletim VALUES (14, 14, 14);
INSERT INTO boletim VALUES (15, 15, 15);


CREATE VIEW vw_01_alunos_cursos AS
SELECT
    a.id_aluno AS codigo_aluno,
    a.nome AS nome_aluno,
    m.id_matricula AS codigo_matricula,
    c.id_curso AS codigo_curso,
    c.nome AS nome_curso
FROM aluno a
INNER JOIN matricula m ON a.id_aluno = m.id_aluno
INNER JOIN turma t ON m.id_turma = t.id_turma
INNER JOIN curso c ON t.id_curso = c.id_curso;


CREATE VIEW vw_02_alunos_turmas_cursos AS
SELECT
    a.nome AS aluno,
    t.nome AS turma,
    c.nome AS curso,
    t.ano_letivo AS ano_letivo
FROM aluno a
INNER JOIN matricula m ON a.id_aluno = m.id_aluno
INNER JOIN turma t ON m.id_turma = t.id_turma
INNER JOIN curso c ON t.id_curso = c.id_curso;


CREATE VIEW vw_03_disciplinas_professores AS
SELECT
    d.id_disciplina AS codigo_disciplina,
    d.nome AS disciplina,
    d.Carga_horaria AS carga_horaria,
    p.id_professor AS codigo_professor,
    p.nome AS professor,
    p.formacao AS formacao
FROM disciplina d
INNER JOIN professor p ON d.id_professor = p.id_professor;


CREATE VIEW vw_04_disciplinas_professores_cursos AS
SELECT
    c.nome AS curso,
    d.nome AS disciplina,
    d.Carga_horaria AS carga_horaria,
    p.nome AS professor
FROM disciplina d
INNER JOIN curso c ON d.id_curso = c.id_curso
INNER JOIN professor p ON d.id_professor = p.id_professor;


CREATE VIEW vw_05_alunos_responsaveis AS
SELECT
    a.nome AS aluno,
    a.cpf AS cpf_aluno,
    r.nome AS responsavel,
    ar.parentesco AS parentesco
FROM aluno a
INNER JOIN aluno_responsavel ar ON a.id_aluno = ar.id_aluno
INNER JOIN responsavel r ON ar.id_responsavel = r.id_responsavel;

CREATE VIEW vw_06_alunos_disciplinas_notas AS
SELECT
    a.nome AS aluno,
    d.nome AS disciplina,
    n.nota AS nota,
    n.media_final AS media_final
FROM aluno a
INNER JOIN matricula m ON a.id_aluno = m.id_aluno
INNER JOIN nota n ON m.id_matricula = n.id_matricula
INNER JOIN avaliacao av ON n.id_avaliacao = av.id_avaliacao
INNER JOIN disciplina d ON av.id_disciplina = d.id_disciplina;


CREATE VIEW vw_07_alunos_turmas_disciplinas_professores AS
SELECT
    a.nome AS aluno,
    t.nome AS turma,
    c.nome AS curso,
    d.nome AS disciplina,
    p.nome AS professor,
    t.ano_letivo AS ano_letivo
FROM aluno a
INNER JOIN matricula m ON a.id_aluno = m.id_aluno
INNER JOIN turma t ON m.id_turma = t.id_turma
INNER JOIN curso c ON t.id_curso = c.id_curso
INNER JOIN disciplina_turma dt ON t.id_turma = dt.id_turma
INNER JOIN disciplina d ON dt.id_disciplina = d.id_disciplina
INNER JOIN professor p ON d.id_professor = p.id_professor;


CREATE VIEW vw_08_desempenho_academico AS
SELECT
    a.nome AS aluno,
    c.nome AS curso,
    d.nome AS disciplina,
    n.nota AS nota,
    n.media_final AS media_final,
    f.percentual_frequencia AS frequencia
FROM aluno a
INNER JOIN matricula m ON a.id_aluno = m.id_aluno
INNER JOIN turma t ON m.id_turma = t.id_turma
INNER JOIN curso c ON t.id_curso = c.id_curso
INNER JOIN nota n ON m.id_matricula = n.id_matricula
INNER JOIN avaliacao av ON n.id_avaliacao = av.id_avaliacao
INNER JOIN disciplina d ON av.id_disciplina = d.id_disciplina
INNER JOIN frequencia f ON m.id_matricula = f.id_matricula;


CREATE VIEW vw_09_matriculas AS
SELECT
    a.nome AS aluno,
    c.nome AS curso,
    t.nome AS turma,
    m.data_matricula AS data_matricula,
    t.ano_letivo AS ano_letivo
FROM aluno a
INNER JOIN matricula m ON a.id_aluno = m.id_aluno
INNER JOIN turma t ON m.id_turma = t.id_turma
INNER JOIN curso c ON t.id_curso = c.id_curso;


CREATE VIEW vw_10_relatorio_academico AS
SELECT
    a.nome AS aluno,
    c.nome AS curso,
    t.nome AS turma,
    d.nome AS disciplina,
    p.nome AS professor,
    n.nota AS nota,
    n.media_final AS media_final,
    f.percentual_frequencia AS frequencia
FROM aluno a
INNER JOIN matricula m ON a.id_aluno = m.id_aluno
INNER JOIN turma t ON m.id_turma = t.id_turma
INNER JOIN curso c ON t.id_curso = c.id_curso
INNER JOIN nota n ON m.id_matricula = n.id_matricula
INNER JOIN avaliacao av ON n.id_avaliacao = av.id_avaliacao
INNER JOIN disciplina d ON av.id_disciplina = d.id_disciplina
INNER JOIN professor p ON d.id_professor = p.id_professor
INNER JOIN frequencia f ON m.id_matricula = f.id_matricula;




