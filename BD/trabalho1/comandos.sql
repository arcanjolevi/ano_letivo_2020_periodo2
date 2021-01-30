CREATE TABLE Enderecos (
  idEndereco INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  rua VARCHAR(255) NOT NULL,
  cidade VARCHAR(255) NOT NULL,
  estado VARCHAR(255) NOT NULL,
  cep VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Alunos(
  idAluno INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,                                    
  idEndereco INT UNSIGNED,
  nomeAluno VARCHAR(255) NOT NULL,
  cpfAluno VARCHAR(12) NOT NULL,
  foneAluno VARCHAR(255) NOT NULL,
  anoLetivo INT,
  emailAluno VARCHAR(255) NOT NULL,
  nascimentoAluno DATE NOT NULL,
  sexoAluno CHAR NOT NULL,
  FOREIGN KEY (idEndereco) REFERENCES Enderecos(idEndereco)
);

CREATE TABLE IF NOT EXISTS Cursos(
  idCurso INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
  nomeCurso VARCHAR(255) NOT NULL,
  duracaoCurso VARCHAR(255) NOT NULL,
  campusCurso VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS MatriculasCursos(
  numeroMatriculaCurso INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  idAluno INT UNSIGNED,                                    
  idCurso INT UNSIGNED,
  dataMatriculaCurso DATE NOT NULL,
  situacaoCurso VARCHAR(255) NOT NULL,
  FOREIGN KEY (idAluno) REFERENCES Alunos(idAluno),
  FOREIGN KEY (idCurso) REFERENCES Cursos(idCurso)
);

CREATE TABLE IF NOT EXISTS Disciplinas(
  idDisciplina INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
  nomeDisciplina VARCHAR(255) NOT NULL,
  cargaHoraria INT UNSIGNED NOT NULL,
  serie INT UNSIGNED NOT NULL,
  periodo VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Professores(
  idProfessor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
  idEndereco INT UNSIGNED,
  nomeProfessor VARCHAR(255) NOT NULL,
  cpfProfessor VARCHAR(12) NOT NULL,
  foneProfessor VARCHAR(255) NOT NULL,
  emailProfessor VARCHAR(255) NOT NULL,
  nascimentoProfessor DATE NOT NULL,
  sexoProfessor CHAR NOT NULL,
  FOREIGN KEY (idEndereco) REFERENCES Enderecos(idEndereco)
);

CREATE TABLE IF NOT EXISTS MatriculasDisciplinas(
  nrmMatriculaDisciplina INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  idDisciplina INT UNSIGNED,
  idAluno INT UNSIGNED,
  dataMatriculaDisciplina DATE NOT NULL,
  FOREIGN KEY (idDisciplina) REFERENCES Disciplinas(idDisciplina),
  FOREIGN KEY (idAluno) REFERENCES Alunos(idAluno)
);

CREATE TABLE IF NOT EXISTS DisciplinasCursos(
  idDisciplina INT UNSIGNED NOT NULL,
  idCurso INT UNSIGNED NOT NULL,
  FOREIGN KEY (idCurso) REFERENCES Cursos(idCurso),
  FOREIGN KEY (idDisciplina) REFERENCES Disciplinas(idDisciplina)
);

CREATE TABLE IF NOT EXISTS ProfessoresDisciplinas(
  idDisciplina INT UNSIGNED NOT NULL,
  idProfessor INT UNSIGNED NOT NULL,
  dataInicio DATE NOT NULL,
  dataFim DATE NOT NULL,
  FOREIGN KEY (idDisciplina) REFERENCES Disciplinas(idDisciplina),
  FOREIGN KEY (idProfessor) REFERENCES Professores(idProfessor)
);



-- Endereco Alunos
INSERT INTO Enderecos (rua, cidade, estado, cep) VALUES ('Av. Tancrevo Neves', 'Cascavel', 'Sao Paulo', '858585-458'), ('Av. Brasil', 'Foz do Iguacu', 'Parana', '85855-500'), ('Rua Caio Nevando das Cachueiras', 'Foz do Iguacu', 'Parana', '77777-777'), ('Av. Pablo Vitar', 'Foz do Iguacu', 'Parana', '11111-111'), ('Av. Padre Fabio de Melo', 'Foz do Iguacu', 'Parana', '66666-666');

--Alunos 
INSERT INTO Alunos ( idEndereco, nomeAluno, cpfAluno, foneAluno, anoLetivo, emailAluno, nascimentoAluno, sexoAluno) VALUES ((SELECT idEndereco FROM Enderecos WHERE cep='858585-458'), 'Levi Arcanjo', '15090188999', '45985641547',  2020, 'arcanjolevi@gmail.com', '1990-12-12', 'M'), ((SELECT idEndereco FROM Enderecos WHERE cep='85855-500'), 'Caio Cezar Nevando', '1245524185', '45999999999', 2020, 'caioslppuo@gmail.com', '1999-12-03', 'M'), ((SELECT idEndereco FROM Enderecos WHERE cep='77777-777'), "Lucas Gravata", "18771669756", "45888157584",  2020, "lucasgrafimar@gmail.com","2000-02-28", "M");

--Cursos
INSERT INTO Cursos (nomeCurso, duracaoCurso, campusCurso) VALUES ('Ciencia da computacao', '4 Anos', 'Foz do Iguacu'), ('Engenharia Mecanica', '5 Anos', 'Foz do Iguacu'), ('Engenharia Eletrica', '5 Anos', 'Foz do Iguacu');

--Disciplinas
INSERT INTO Disciplinas (nomeDisciplina, cargaHoraria, serie , periodo) VALUES ('Banco de dados', 102, 3, 'Semestral'), ('Formacao Empreendedora', 136, 3, 'Anual'), ('Organizacao e Arquitetura de Computadores', 102, 3, 'Semestral'), ('Redes de Computadores', 68, 3, 'Semestral'), ('Compiladores', 68, 3, 'Semestral'), ('Engenharia de Software I', 136, 3, 'Semestral'), ('Projeto e Analise de Algoritmos', 102, 3, 'Semestral');


--Disciplinas Cursos
INSERT INTO DisciplinasCursos (idDisciplina, idCurso) VALUE ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=1), (SELECT idCurso FROM Cursos WHERE idCurso=1)), ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=2), (SELECT idCurso FROM Cursos WHERE idCurso=1)), ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=3), (SELECT idCurso FROM Cursos WHERE idCurso=1)), ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=4), (SELECT idCurso FROM Cursos WHERE idCurso=1)), ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=5), (SELECT idCurso FROM Cursos WHERE idCurso=1)), ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=6), (SELECT idCurso FROM Cursos WHERE idCurso=1)), ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=7), (SELECT idCurso FROM Cursos WHERE idCurso=1));


--Matricula Alunos no curso

INSERT INTO MatriculasCursos (idAluno, idCurso, dataMatriculaCurso, situacaoCurso) VALUES ((SELECT idAluno FROM Alunos WHERE idAluno=1), (SELECT idCurso FROM Cursos WHERE idCurso=1), '2018-11-27', 'Cursando'),((SELECT idAluno FROM Alunos WHERE idAluno=2), (SELECT idCurso FROM Cursos WHERE idCurso=1), '2013-01-01', 'Cursando'),((SELECT idAluno FROM Alunos WHERE idAluno=3), (SELECT idCurso FROM Cursos WHERE idCurso=1), '2020-01-23', 'Cursando');


-- Matricula de materia


INSERT INTO MatriculasDisciplinas (idDisciplina, dataMatriculaDisciplina, idAluno) VALUES ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=1 ), '2021-02-12', (SELECT idAluno FROM Alunos WHERE idAluno=1)), ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=2 ), '2020-02-12', (SELECT idAluno FROM Alunos WHERE idAluno=3)), ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=3 ), '2020-02-12', (SELECT idAluno FROM Alunos WHERE idAluno=2)), ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=4 ), '2021-02-12', (SELECT idAluno FROM Alunos WHERE idAluno=2)), ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=5 ), '2019-02-12', (SELECT idAluno FROM Alunos WHERE idAluno=3)), ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=6 ), '2020-02-12', (SELECT idAluno FROM Alunos WHERE idAluno=1)), ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=7 ), '2021-02-12', (SELECT idAluno FROM Alunos WHERE idAluno=3)), ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=1 ), '2019-02-12', (SELECT idAluno FROM Alunos WHERE idAluno=2)), ((SELECT idDisciplina FROM Disciplinas WHERE idDisciplina=5 ), '2019-02-12', (SELECT idAluno FROM Alunos WHERE idAluno=1)); 


-- Professores

INSERT INTO Professores (idEndereco, nomeProfessor, cpfProfessor, foneProfessor, emailProfessor, nascimentoProfessor, sexoProfessor) VALUES ((SELECT idEndereco FROM Enderecos WHERE cep='66666-666'), 'Roberto Gil Brasil', '16492598759', '45986578432', 'robertogbrasil@gmail.com', '1975-01-01', 'M'), ((SELECT idEndereco FROM Enderecos WHERE cep='11111-111'), 'Marcos Antonis Hashicuca', '16457598759', '45986574587', 'shiro@gmail.com', '1959-01-01', 'M');

-- Professores Disciplinas

INSERT INTO ProfessoresDisciplinas ( idDisciplina, idProfessor, dataInicio, dataFim) VALUES 
((SELECT idDisciplina FROM Disciplinas WHERE nomeDisciplina='Banco de Dados'), (SELECT idProfessor FROM Professores WHERE nomeProfessor='Roberto Gil Brasil'), '2021-01-01', '2021-06-30')((SELECT idDisciplina FROM Disciplinas WHERE nomeDisciplina='Formacao Empreendedora'), (SELECT idProfessor FROM Professores WHERE nomeProfessor='Marcos Antonis Hashicuca'), '2021-01-01', '2021-06-30');


-- Queries

-- Quais cursos ofertados?
```
SELECT nomeCurso FROM Cursos;
```

-- Quais alunos do ano letivo 2021 estao em Banco de Dados
```
SELECT nomeAluno FROM Alunos WHERE idAluno IN (SELECT idAluno FROM MatriculasDisciplinas WHERE idDisciplina IN (SELECT idDisciplina FROM Disciplinas WHERE nomeDisciplina LIKE '%Banco de Dados%'));
```
-- Quais alunos nao moram em foz do iguacu
```
SELECT nomeAluno FROM Alunos WHERE idEndereco IN (SELECT idEndereco FROM Enderecos WHERE cidade NOT LIKE '%Foz do Iguacu%');
```

