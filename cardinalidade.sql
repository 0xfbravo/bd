/*
  Verificação de Cardinalidade - AA Banco de Dados
  UFRRJ - 2016.2
  Professor: Luiz Fernando Orleans
  Alunos: Bianca Albuquerque e Fellipe Pimentel

	Teste de cardinalidade entre colunas da Tabela diarias_nao_normalizadas.diarias.
	Todos os testes que retornaram uma relação 1 x n estão listados a seguir.
	Alguns testes com resultado n x n foram listados devido a aparente relação entre as colunas,
	que não se confirmaram. Logo, não gerando dependências de nenhum tipo entre essas colunas.
*/

-- Cardinalidade de Órgãos Superior na relação Órgão Superior x Órgão Subordinado
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_orgao_superior)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.codigo_orgao_subordinado
	HAVING
    	COUNT(distinct diarias_nao_normalizadas.diarias.codigo_orgao_superior) > 1
      OR
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_orgao_superior) < 1;
-- Cardinalidade de Órgãos Subordinado na relação Órgão Superior x Órgão Subordinado
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_orgao_subordinado)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.codigo_orgao_superior
	HAVING
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_orgao_subordinado) > 1
      OR
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_orgao_subordinado) < 1;
-- Foram realizados testes de Cardinalidade entre Orgao_Superior e Orgao_Subordinado com diversas outras colunas da tabela diarias_nao_normalizadas.diarias. Todas as outras relações retornaram um resultado n x n.
-- Cardinalidade de Unidade Gestora na relação Unidade Gestora x Gestão Pagamento
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_unidade_gestora)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.gestao_pagamento
	HAVING
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_unidade_gestora) > 1
      OR
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_unidade_gestora) < 1;
-- Cardinalidade de Gestão Pagamento na relação Unidade Gestora x Gestão Pagamento
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.gestao_pagamento)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.codigo_unidade_gestora
  HAVING
      COUNT(distinct diarias_nao_normalizadas.diarias.gestao_pagamento) > 1
      OR
      COUNT(distinct diarias_nao_normalizadas.diarias.gestao_pagamento) < 1;
-- Cardinalidade de Unidade Gestora na relação Unidade Gestora x Orgao_Subordinado
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_unidade_gestora)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.Codigo_Orgao_Subordinado
		HAVING
			 COUNT(distinct diarias_nao_normalizadas.diarias.codigo_unidade_gestora) > 1
			 OR
			 COUNT(distinct diarias_nao_normalizadas.diarias.codigo_unidade_gestora) < 1;
-- TODO: Cardinalidade de Orgão Subordinado na relação Unidade Gestora x Orgao Subordinado
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_orgao_subordinado)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.codigo_unidade_gestora
		HAVING
			 COUNT(distinct diarias_nao_normalizadas.diarias.codigo_orgao_subordinado) > 1
			 OR
			 COUNT(distinct diarias_nao_normalizadas.diarias.codigo_orgao_subordinado) < 1;
-- Cardinalidade de Unidade Gestora na relação Unidade Gestora x Orgao_Superior
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_unidade_gestora)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.Codigo_Orgao_Superior
 		HAVING
 				COUNT(distinct diarias_nao_normalizadas.diarias.codigo_unidade_gestora) > 1
 				OR
 				COUNT(distinct diarias_nao_normalizadas.diarias.codigo_unidade_gestora) < 1;
-- Foram realizados testes de cardinalidade entre Unidade_Gestora com Ação, Programa, Documento_Pagamento, Subfuncao, Função, todos os testes retornaram uma relação n x n, não gerando dependencias entre uma Unidade_Gestora e nenhuma outra coluna. Um conjunto pagamento possui apenas uma Unidade_Gestora
-- Cardinalidade de Função na relação Função x Subfunção
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_funcao)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.codigo_subfuncao
  HAVING
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_funcao) > 1
      OR
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_funcao) < 1;
-- Cardinalidade de Subfunção na relação Função x Subfunção
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_subfuncao)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.codigo_funcao
  HAVING
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_subfuncao) > 1
      OR
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_subfuncao) < 1;
-- Cardinalidade de Função na relação Função x Ação
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_funcao)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.codigo_acao
  HAVING
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_funcao) > 1
      OR
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_funcao) < 1;
-- Cardinalidade de Ação na relação Função x Ação
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_acao)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.codigo_funcao
  HAVING
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_acao) > 1
      OR
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_acao) < 1;
-- Cardinalidade de Ação na relação Ação x Programa
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_acao)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.codigo_programa
  HAVING
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_acao) > 1
      OR
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_acao) < 1;
-- Cardinalidade de Programa na relação Ação x Programa
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_programa)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.codigo_acao
  HAVING
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_programa) > 1
      OR
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_programa) < 1;
-- Cardinalidade de Programa na relação Favorecido x Programa
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_programa)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.nome_favorecido, diarias_nao_normalizadas.diarias.cpf_favorecido
  HAVING
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_programa) > 1
      OR
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_programa) < 1;
-- Cardinalidade de Subfuncao na relação Favorecido x Subfuncao
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_subfuncao)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.nome_favorecido, diarias_nao_normalizadas.diarias.cpf_favorecido
  HAVING
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_subfuncao) > 1
      OR
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_subfuncao) < 1;
-- Cardinalidade de Funcao na relação Favorecido x Funcao
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_funcao)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.nome_favorecido, diarias_nao_normalizadas.diarias.cpf_favorecido
  HAVING
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_funcao) > 1
      OR
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_funcao) < 1;
-- Cardinalidade de Ação na relação Favorecido x Ação
SELECT COUNT(distinct diarias_nao_normalizadas.diarias.codigo_acao)
FROM diarias_nao_normalizadas.diarias
GROUP BY diarias_nao_normalizadas.diarias.nome_favorecido, diarias_nao_normalizadas.diarias.cpf_favorecido
  HAVING
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_acao) > 1
      OR
      COUNT(distinct diarias_nao_normalizadas.diarias.codigo_acao) < 1;
-- Todos os outros testes entre colunas da tabela diarias_nao_normalizadas.diarias foram realizados e todos retornaram relações n x n, que não geram dependencias de nenhum tipo entre colunas, logo não são importantes nas tomadas de decisões para normalização.
-- Verificando combinação para PRIMARY KEY( criando um conjunto minimo relacionado a Pagamentos que retorne apenas um resultado)
SELECT COUNT( diarias_normalizadas.pagamentos.documento_pagamento)
FROM diarias_normalizadas.pagamentos
GROUP BY diarias_normalizadas.pagamentos.documento_pagamento, diarias_normalizadas.pagamentos.valor_pagamento, diarias_normalizadas.pagamentos.favorecido
  HAVING
      COUNT( diarias_normalizadas.pagamentos.documento_pagamento) > 1
      OR
      COUNT( diarias_normalizadas.pagamentos.documento_pagamento) < 1;
