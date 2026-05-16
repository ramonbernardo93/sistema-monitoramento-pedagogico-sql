-- Criando o banco de dados. 
CREATE DATABASE IF NOT EXISTS sistema_escolar;
USE sistema_escolar;

-- Criando as tabelas.
CREATE TABLE IF NOT EXISTS professores (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    materia VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS turmas (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    nome_turma VARCHAR(50) NOT NULL,
    id_professor INT,
    FOREIGN KEY (id_professor) REFERENCES professores(id_professor)
);

CREATE TABLE IF NOT EXISTS alunos (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_turma INT,
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma)
);

-- Alimentando as tabelas - dados fictícios.

-- 1. Inserindo Professores
INSERT INTO professores (nome, materia) VALUES 
('Regina Souza', 'Inglês'),
('Carlos Andrade', 'Matemática');

-- 2. Inserindo Turmas 
-- (Aqui assumimos que a Regina terá o id_professor = 1 e o Carlos o id = 2)
INSERT INTO turmas (nome_turma, id_professor) VALUES 
('1º Ano Bilingual', 1),
('2º Ano Regular', 2);

-- 3. Inserindo Alunos
-- (Vinculando os alunos às turmas pelos IDs 1 e 2)
INSERT INTO alunos (nome, id_turma) VALUES 
('Enzo Silva', 1),
('Yane Costa', 1),
('Lucas Almeida', 2);

-- Consultas (Select and Join)

SELECT * FROM professores;
SELECT * FROM turmas;
SELECT * FROM alunos;

SELECT 
    alunos.nome AS 'Nome do Aluno', 
    turmas.nome_turma AS 'Turma'
FROM alunos
INNER JOIN turmas ON alunos.id_turma = turmas.id_turma;

SELECT 
    alunos.nome AS 'Aluno',
    turmas.nome_turma AS 'Turma',
    professores.nome AS 'Professor(a)',
    professores.materia AS 'Matéria'
FROM alunos
INNER JOIN turmas ON alunos.id_turma = turmas.id_turma
INNER JOIN professores ON turmas.id_professor = professores.id_professor;

/*******************************************************************************
 PROJETO: Sistema de Acompanhamento Pedagógico Individual (Bilingual Education)
 AUTOR: Coordenação Pedagógica / Data Science
 DATA: Maio de 2026
 
 OBJETIVO DO SCRIPT:
 --------------------
 Evoluir o modelo inicial de banco de dados escolar simples para uma estrutura
 avançada de gestão pedagógica. O foco desta alteração é implementar o rastreio,
 histórico e documentação dos atendimentos individuais dos alunos.
 
 ARQUITETURA E REGRAS DE NEGÓCIO:
 ---------------------------------
 1. Relacionamento N:M Indireto: Um aluno pode passar por múltiplos atendimentos 
    ao longo do ano letivo, e um professor/coordenador pode realizar múltiplos 
    atendimentos. A tabela 'atendimentos' atua como a centralizadora dessa relação.
 
 2. Chaves Estrangeiras (Foreign Keys):
    - id_aluno: Garante a integridade referencial, impedindo o registro de um 
      atendimento para um estudante não matriculado.
    - id_professor: Vincula formalmente o docente ou membro da equipe bilíngue 
      responsável pelo parecer e pela condução do caso.
 
 3. Tipos de Dados Escolhidos:
    - data_atendimento (DATE): Armazena o registro cronológico no formato YYYY-MM-DD.
    - motivo (VARCHAR): Categorização do foco (ex: Phonics, Adaptação, Intervenção).
    - observacoes (TEXT): Campo de texto longo para preservar o parecer qualitativo,
      detalhes da evolução pedagógica e direcionamentos de suporte.
*******************************************************************************/

CREATE TABLE IF NOT EXISTS atendimentos (
    id_atendimento INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT,
    id_professor INT,
    data_atendimento DATE NOT NULL,
    motivo VARCHAR(100) NOT NULL, -- Ex: Dificuldade de fala, Adaptação, Avanço Pedagógico
    observacoes TEXT,              -- Detalhes do que foi conversado/encaminhado
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_professor) REFERENCES professores(id_professor)
);

-- Simulando um atendimento para teste. 

INSERT INTO atendimentos (id_aluno, id_professor, data_atendimento, motivo, observacoes) 
VALUES 
(
    (SELECT id_aluno FROM alunos WHERE nome = 'Enzo Silva' LIMIT 1),
    (SELECT id_professor FROM professores WHERE nome = 'Regina Souza' LIMIT 1),
    '2026-05-16', 
    'Acompanhamento de Phonics/Blending', 
    'O aluno demonstrou excelente evolução na junção de fonemas consonantais, mas ainda precisa de suporte com short vowels. Recomendado reforço com flashcards gamificados.'
);

SELECT 
    atendimentos.data_atendimento AS 'Data',
    alunos.nome AS 'Aluno',
    professores.nome AS 'Professor(a) Bilíngue',
    atendimentos.motivo AS 'Motivo/Foco',
    atendimentos.observacoes AS 'Parecer Pedagógico'
FROM atendimentos
INNER JOIN alunos ON atendimentos.id_aluno = alunos.id_aluno
INNER JOIN professores ON atendimentos.id_professor = professores.id_professor
ORDER BY atendimentos.data_atendimento DESC;
