-- test
SELECT *
FROM   orcamento; -- (id, valor, data)

SELECT *
FROM   material; -- (id, descricao)

SELECT *
FROM   orcamentosmateriais; -- (id, quantidade, preco, #codOrc, #codMat)

SELECT *
FROM   homologado; -- (id, #codAss, #codAloc, #codMat)

SELECT *
FROM   local; -- (id, andar, setor, numero)

SELECT *
FROM   alocacao; -- (id, dataalocacao, #codLocal, #codHom)

SELECT *
FROM   assinatura; -- (id, dataassinatura, #codFun, #codHomo)

SELECT *
FROM   funcionario; -- (id, nome, idade, salario, dataegresso, dataingresso)

SELECT *
FROM   funcionariolocal; -- (id, #codfun, #codlocal)

SELECT *
FROM   projeto; -- (id, brevedescricao, datainicio)

SELECT *
FROM   participacaoprojeto; -- (id, datainicio, datafim, #codFun, #codProj)

SELECT *
FROM   tarefa; -- (id, brevedescricao, estado, prioridade, tempogasto, #codProj)

SELECT *
FROM   participacaotarefa; -- (id, codfun, #codtar, #codsubtar)

SELECT *
FROM   coordenador; -- (id, designacao, #codFun)

SELECT *
FROM   coordenadorprojeto; -- (#codCoord, #codProj)

SELECT *
FROM   programador; -- (id, #codFun)

SELECT *
FROM   linguagem; -- (id, nome)

SELECT *
FROM   programadorlinguagem; -- (id, dominio, #codProg, #codLing)

-- Primeira. Retorna a descrição e o estado das tarefas de prioridade alta que
-- foram iniciadas no período matutino, ou seja, das 8h às 12h.

SELECT tarefa.brevedescricao,
       tarefa.estado
FROM   tarefa
WHERE  tarefa.prioridade = 'ALTA'
       AND Extract(hour FROM tarefa.datahorainicial) BETWEEN 8 AND 12;

--Segunda. Retorna o nome do funcionario e a descrições das suas tarefas que
-- estejam no estado 'Aguardando Desenvolvimento' e tenham prioridade 'ALTA'
-- ou 'NORMAL'

-- join
SELECT funcionario.nome,
       tarefa.brevedescricao
FROM   funcionario
       JOIN participacaotarefa
         ON funcionario.id = participacaotarefa.codfun
       JOIN tarefa
         ON tarefa.estado = 'AGUARDANDO DESENVOLVIMENTO'
            AND ( tarefa.prioridade = 'ALTA'
                   OR tarefa.prioridade = 'NORMAL' )
GROUP  BY funcionario.nome,
          tarefa.brevedescricao;

-- produto cartesiano
SELECT funcionario.nome,
       tarefa.brevedescricao
FROM   funcionario,
       participacaotarefa,
       tarefa
WHERE  funcionario.id = participacaotarefa.codfun
       AND tarefa.estado = 'AGUARDANDO DESENVOLVIMENTO'
       AND ( tarefa.prioridade = 'ALTA'
              OR tarefa.prioridade = 'NORMAL' )
GROUP  BY funcionario.nome,
          tarefa.brevedescricao;

-- Terceira. Retorna o nome e a idade do funcionario que apesar de ter tarefas
-- nenhuma delas está no estado 'EM DESENVOLVIMENTO'

SELECT funcionario.nome,
       funcionario.idade
FROM   funcionario
       JOIN participacaotarefa
         ON funcionario.id = participacaotarefa.codfun
WHERE  funcionario.id <> ALL (SELECT codfundono
                              FROM   tarefa
                              WHERE  estado = 'EM DESENVOLVIMENTO'
                              GROUP  BY codfundono);

-- Quarta. Para o funcionario que tiver participação após '2000-01-01 00:00:00'
-- em um projeto inciado após '1990-01-01 00:00:00' e seu selario for maior que
-- 10000 retornar o seu nome, descrição do projeto e número de participações
-- nesse projeto.

SELECT funcionario.nome              AS nome_do_funcionario,
       projeto.brevedescricao        AS descricao_do_projeto,
       Count(participacaoprojeto.id) AS numero_de_participacoes
FROM   participacaoprojeto
       JOIN funcionario
         ON participacaoprojeto.codfun = funcionario.id
       JOIN projeto
         ON participacaoprojeto.codproj = projeto.id
WHERE  participacaoprojeto.datahorainicio > '2000-01-01 00:00:00'
       AND funcionario.salario > 10000
       AND projeto.datahorainicio > '1990-01-01 00:00:00'
GROUP  BY projeto.id,
          funcionario.id;

-- Quinta. Retorna o id e o nome dos funcionários que não são donos de tarefas.
-- not in
SELECT id,
       nome
FROM   funcionario
WHERE  true NOT IN (SELECT Count(*) > 0
                    FROM   tarefa
                    WHERE  tarefa.codfundono IN ( funcionario.id )
                    GROUP  BY tarefa.codfundono);

-- not exists
SELECT id,
       nome
FROM   funcionario
WHERE  NOT EXISTS (SELECT Count(*)
                   FROM   tarefa
                   WHERE  tarefa.codfundono IN ( funcionario.id )
                   GROUP  BY tarefa.codfundono);

-- Setima. Recupera contagem de funcionarios e contagem de projetos dos quais
-- funcionarios participaram e sao projetos apos 2002 para funcionario que
-- entreram depois de 2001 e estao ate 2005.

SELECT Count(funcionario.id),
       Count(participacaoprojeto.id)
FROM   funcionario,
       participacaoprojeto,
       projeto
WHERE  funcionario.datahoraingresso > '2001-10-10'
       AND funcionario.datahoraingresso < '2005-10-10'
       AND participacaoprojeto.codfun = funcionario.id
       AND projeto.datahorainicio > '2002-1-1'
GROUP  BY funcionario.id
ORDER  BY funcionario.id;
