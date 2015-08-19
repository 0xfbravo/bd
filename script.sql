/*
  Script de Importação e Normalização - AA Banco de Dados
  UFRRJ - 2016.2
  Professor: Luiz Fernando Orleans
  Alunos: Bianca Albuquerque e Fellipe Pimentel
*/

-- Criação da Tabela Não Normalizada
CREATE SCHEMA diarias_nao_normalizadas AUTHORIZATION postgres;
CREATE TABLE IF NOT EXISTS diarias_nao_normalizadas.Diarias (
		Codigo_Orgao_Superior VARCHAR NOT NULL,
    Nome_Orgao_Superior VARCHAR NOT NULL,
    Codigo_Orgao_Subordinado VARCHAR NOT NULL,
    Nome_Orgao_Subordinado VARCHAR NOT NULL,
    Codigo_Unidade_Gestora VARCHAR NOT NULL,
    Nome_Unidade_Gestora VARCHAR NOT NULL,
    Codigo_Funcao VARCHAR NOT NULL,
    Nome_Funcao VARCHAR NOT NULL,
    Codigo_Subfuncao VARCHAR NOT NULL,
    Nome_Subfuncao VARCHAR NOT NULL,
    Codigo_Programa VARCHAR NOT NULL,
    Nome_Programa VARCHAR NOT NULL,
    Codigo_Acao VARCHAR NOT NULL,
    Nome_Acao VARCHAR NOT NULL,
    Linguagem_Cidada VARCHAR NOT NULL,
    CPF_Favorecido VARCHAR NOT NULL,
    Nome_Favorecido VARCHAR NOT NULL,
    Documento_Pagamento VARCHAR NOT NULL,
    Gestao_Pagamento VARCHAR NOT NULL,
    Data_Pagamento VARCHAR NOT NULL,
    Valor_Pagamento DOUBLE PRECISION NOT NULL
);
-- Importar dados do .CSV
SET client_encoding = LATIN1;
COPY diarias_nao_normalizadas.Diarias FROM '/Users/insidemybrain/bd/201403_Diarias.csv' delimiter ',' CSV HEADER;
-- Consulta para Verificar Import [DEBUG]
SELECT * FROM diarias_nao_normalizadas.Diarias LIMIT 50;
-- Verificação de Cardinalidade no arquivo: cardinalidade.sql

-- Criação da Normalização
CREATE SCHEMA diarias_normalizadas AUTHORIZATION postgres;
CREATE TABLE IF NOT EXISTS diarias_normalizadas.Orgao_Superior (
		Codigo_Orgao_Superior VARCHAR NOT NULL PRIMARY KEY,
		Nome_Orgao_Superior VARCHAR NOT NULL
);
CREATE TABLE IF NOT EXISTS diarias_normalizadas.Orgao_Subordinado (
		Codigo_Orgao_Subordinado VARCHAR NOT NULL PRIMARY KEY,
		Nome_Orgao_Subordinado VARCHAR NOT NULL,
		Orgao_Superior VARCHAR NOT NULL REFERENCES diarias_normalizadas.Orgao_Superior (Codigo_Orgao_Superior)
);
CREATE TABLE IF NOT EXISTS diarias_normalizadas.Unidade_Gestora (
		Codigo_Unidade_Gestora VARCHAR NOT NULL PRIMARY KEY,
		Nome_Unidade_Gestora VARCHAR NOT NULL,
		Gestao_Pagamento VARCHAR NOT NULL
);
CREATE TABLE IF NOT EXISTS diarias_normalizadas.Funcao (
		Codigo_Funcao VARCHAR NOT NULL PRIMARY KEY,
		Nome_Funcao VARCHAR NOT NULL
);
CREATE TABLE IF NOT EXISTS diarias_normalizadas.Subfuncao (
		Codigo_Subfuncao VARCHAR NOT NULL PRIMARY KEY,
		Nome_Subfuncao VARCHAR NOT NULL
);
CREATE TABLE IF NOT EXISTS diarias_normalizadas.Programa (
		Codigo_Programa VARCHAR NOT NULL PRIMARY KEY,
		Nome_Programa VARCHAR NOT NULL
);
CREATE TABLE IF NOT EXISTS diarias_normalizadas.Acao (
		Codigo_Acao VARCHAR NOT NULL PRIMARY KEY,
		Nome_Acao VARCHAR NOT NULL,
		Linguagem_Cidada VARCHAR NOT NULL
);
CREATE TABLE IF NOT EXISTS diarias_normalizadas.Favorecido (
		ID_Favorecido SERIAL PRIMARY KEY,
		CPF_Favorecido VARCHAR NOT NULL,
		Nome_Favorecido VARCHAR NOT NULL
);
CREATE TABLE IF NOT EXISTS diarias_normalizadas.Pagamentos (
		Orgao VARCHAR NOT NULL REFERENCES diarias_normalizadas.Orgao_Subordinado (Codigo_Orgao_Subordinado),
		Subfuncao VARCHAR NOT NULL REFERENCES diarias_normalizadas.Subfuncao (Codigo_Subfuncao),
		Funcao VARCHAR NOT NULL REFERENCES diarias_normalizadas.Funcao (Codigo_Funcao),
		Acao VARCHAR NOT NULL REFERENCES diarias_normalizadas.Acao (Codigo_Acao),
		Programa VARCHAR NOT NULL REFERENCES diarias_normalizadas.Programa (Codigo_Programa),
		Favorecido BIGINT REFERENCES diarias_normalizadas.Favorecido (ID_Favorecido),
		Unidade_Gestora VARCHAR NOT NULL REFERENCES diarias_normalizadas.Unidade_Gestora (Codigo_Unidade_Gestora),
		Data_Pagamento VARCHAR NOT NULL,
		Documento_Pagamento VARCHAR NOT NULL,
		Valor_Pagamento DOUBLE PRECISION NOT NULL,
		PRIMARY KEY(Favorecido, Documento_Pagamento, Valor_Pagamento)
);

-- Populando Tabelas Normalizadas
INSERT INTO diarias_normalizadas.Orgao_Superior SELECT DISTINCT diarias_nao_normalizadas.Diarias.Codigo_Orgao_Superior, diarias_nao_normalizadas.Diarias.Nome_Orgao_Superior FROM diarias_nao_normalizadas.Diarias;
INSERT INTO diarias_normalizadas.Orgao_Subordinado SELECT DISTINCT diarias_nao_normalizadas.Diarias.Codigo_Orgao_Subordinado, diarias_nao_normalizadas.Diarias.Nome_Orgao_Subordinado , diarias_nao_normalizadas.Diarias.Codigo_Orgao_Superior FROM diarias_nao_normalizadas.Diarias;
INSERT INTO diarias_normalizadas.Unidade_Gestora SELECT DISTINCT diarias_nao_normalizadas.Diarias.Codigo_Unidade_Gestora, diarias_nao_normalizadas.Diarias.Nome_Unidade_Gestora , diarias_nao_normalizadas.Diarias.Gestao_Pagamento FROM diarias_nao_normalizadas.Diarias;
INSERT INTO diarias_normalizadas.Funcao SELECT DISTINCT diarias_nao_normalizadas.Diarias.Codigo_Funcao, diarias_nao_normalizadas.Diarias.Nome_Funcao  FROM diarias_nao_normalizadas.Diarias;
INSERT INTO diarias_normalizadas.Subfuncao SELECT DISTINCT diarias_nao_normalizadas.Diarias.Codigo_Subfuncao, diarias_nao_normalizadas.Diarias.Nome_Subfuncao  FROM diarias_nao_normalizadas.Diarias;
INSERT INTO diarias_normalizadas.Programa SELECT DISTINCT diarias_nao_normalizadas.Diarias.Codigo_Programa, diarias_nao_normalizadas.Diarias.nome_Programa FROM diarias_nao_normalizadas.Diarias;
INSERT INTO diarias_normalizadas.Acao SELECT DISTINCT diarias_nao_normalizadas.Diarias.Codigo_Acao, diarias_nao_normalizadas.Diarias.Nome_Acao, diarias_nao_normalizadas.Diarias.Linguagem_Cidada FROM diarias_nao_normalizadas.Diarias;
INSERT INTO diarias_normalizadas.Favorecido (CPF_Favorecido,Nome_Favorecido) SELECT DISTINCT diarias_nao_normalizadas.Diarias.CPF_Favorecido,diarias_nao_normalizadas.Diarias.Nome_Favorecido FROM diarias_nao_normalizadas.Diarias;
INSERT INTO diarias_normalizadas.Pagamentos
	(Orgao, Subfuncao, Funcao, Acao, Programa, Favorecido, Unidade_Gestora, Data_Pagamento, Documento_Pagamento, Valor_Pagamento)
    SELECT DISTINCT
    	diarias_nao_normalizadas.Diarias.Codigo_Orgao_Subordinado,
        diarias_nao_normalizadas.Diarias.Codigo_Subfuncao,
        diarias_nao_normalizadas.Diarias.Codigo_Funcao,
        diarias_nao_normalizadas.Diarias.Codigo_Acao,
        diarias_nao_normalizadas.Diarias.Codigo_Programa,
        diarias_normalizadas.Favorecido.ID_Favorecido,
        diarias_nao_normalizadas.Diarias.Codigo_Unidade_Gestora,
        diarias_nao_normalizadas.Diarias.Data_Pagamento,
        diarias_nao_normalizadas.Diarias.Documento_Pagamento,
        diarias_nao_normalizadas.Diarias.Valor_Pagamento
    FROM diarias_nao_normalizadas.Diarias, diarias_normalizadas.Favorecido
    WHERE
			diarias_normalizadas.Favorecido.CPF_Favorecido = diarias_nao_normalizadas.Diarias.CPF_Favorecido
			AND
			diarias_normalizadas.Favorecido.Nome_Favorecido = diarias_nao_normalizadas.Diarias.Nome_Favorecido;

-- Consulta a tabela Normalizada
SELECT * FROM diarias_normalizadas.Pagamentos LIMIT 100;

-- Querys de Consulta
-- Query 1: Nome do Favorecido que recebeu o maior valor de diária
SELECT Nome_Favorecido
	FROM diarias_normalizadas.Pagamentos pags, diarias_normalizadas.Favorecido fav
	WHERE
		fav.ID_Favorecido = pags.Favorecido
		AND
		pags.Valor_Pagamento = (SELECT MAX(pags.Valor_Pagamento) FROM diarias_normalizadas.Pagamentos pags);
-- Query 2: O valor total gasto pelo Ministério do Planejamento com diárias
SELECT sum(pags.Valor_Pagamento)
	FROM diarias_normalizadas.Pagamentos pags, diarias_normalizadas.Orgao_Subordinado orgaoSub, diarias_normalizadas.Orgao_Superior orgaoSup
	WHERE
		orgaoSup.Nome_Orgao_Superior LIKE '%MINISTERIO DO PLANEJAMENTO%'
		AND
		pags.Orgao = orgaoSub.Codigo_Orgao_Subordinado
		AND
		orgaoSub.Orgao_Superior = orgaoSup.Codigo_Orgao_Superior;
-- Query 3: As pessoas que tiveram mais do que 5 pagamentos
SELECT favs.nome_Favorecido, favs.cpf_Favorecido
	FROM diarias_normalizadas.Favorecido favs, diarias_normalizadas.Pagamentos pags
	WHERE favs.ID_Favorecido = pags.Favorecido
    GROUP BY favs.ID_Favorecido
   	 HAVING COUNT(pags.Valor_Pagamento) > 5
-- Query 4: O nome do Programa que menos gastou com diárias
CREATE VIEW diarias_normalizadas.ValoresDiariasPrograma AS
SELECT prog.nome_Programa,
sum(pags.Valor_Pagamento) as soma
FROM diarias_normalizadas.Programa prog, diarias_normalizadas.Pagamentos pags
WHERE prog.Codigo_Programa = pags.Programa
GROUP BY prog.Codigo_Programa;

SELECT Nome_Programa FROM diarias_normalizadas.ValoresDiariasPrograma vp WHERE vp.soma = (SELECT MIN(vp.soma) from diarias_normalizadas.ValoresDiariasPrograma vp);
-- Query 5: Uma relação contendo o nome do órgão superior, do órgão subordinado, da Unidade_Gestora, da Função, da Subfuncao, do Programa, da Ação e valor médio das suas diárias.

CREATE VIEW diarias_normalizadas.Media AS
SELECT sum(pags.Valor_pagamento)/count(pags.Valor_Pagamento) as media, a.Codigo_Acao
FROM diarias_normalizadas.Acao a, diarias_normalizadas.Pagamentos pags
WHERE a.Codigo_Acao = pags.Acao
GROUP BY a.Codigo_Acao;

CREATE VIEW diarias_normalizadas.Relacao AS
SELECT distinct OSup.Nome_Orgao_Superior,
OSub.Nome_Orgao_Subordinado,
UG.Nome_Unidade_Gestora,
f.Nome_Funcao,
s.Nome_Subfuncao,
prog.Nome_Programa,
a.Nome_Acao,
m.Media
FROM diarias_normalizadas.Orgao_Superior OSup,
diarias_normalizadas.Orgao_Subordinado OSub,
diarias_normalizadas.Unidade_Gestora UG,
diarias_normalizadas.Funcao f,
diarias_normalizadas.Subfuncao s,
diarias_normalizadas.Programa prog,
diarias_normalizadas.Acao a,
diarias_normalizadas.Media m,
diarias_normalizadas.Pagamentos pags
WHERE OSup.Codigo_Orgao_Superior = OSub.Orgao_Superior
AND OSub.Codigo_Orgao_Subordinado = pags.Orgao
AND pags.Unidade_Gestora = UG.Codigo_Unidade_Gestora
AND pags.Funcao = f.Codigo_Funcao
AND pags.Subfuncao = s.Codigo_Subfuncao
AND pags.Programa = prog.Codigo_Programa
AND pags.Acao = a.Codigo_Acao
AND a.Codigo_Acao = m.Codigo_Acao;

SELECT * FROM diarias_normalizadas.Relacao LIMIT 100;
