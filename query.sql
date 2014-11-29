-- test

select * from orcamento; -- (id, valor, data)
select * from material; -- (id, descricao)
select * from orcamentosmateriais; -- (id, quantidade, preco, #codOrc, #codMat)
select * from homologado; -- (id, #codAss, #codAloc, #codMat)
select * from local; -- (id, andar, setor, numero)
select * from alocacao; -- (id, dataalocacao, #codLocal, #codHom)
select * from assinatura; -- (id, dataassinatura, #codFun, #codHomo)
select * from funcionario; -- (id, nome, idade, salario, dataegresso, dataingresso)
select * from projeto; -- (id, brevedescricao, datainicio)
select * from participacaoprojeto; -- (id, datainicio, datafim, #codFun, #codProj)
select * from tarefa; -- (id, #codProj, brevedescricao, estado, prioridade,
tempogasto)
select * from coordenador; -- (id, designacao, #codFun)
select * from coordenadorprojeto; -- (#codCoord, #codProj)
select * from programador; -- (id, #codFun)
select * from linguagem; -- (id, nome)
select * from programadorlinguagem; -- (id, dominio, #codProg, #codLing)


-- Primeira. Retorna a descrição e o estado das tarefas de prioridade alta que foram iniciadas no período matutino, ou seja, das 8h às 12h.
SELECT tarefa.brevedescricao, tarefa.estado FROM tarefa WHERE tarefa.prioridade = 'ALTA' AND EXTRACT(hour FROM tarefa.datahorainicial) BETWEEN 8 AND 12;

--Segunda. Retorna o nome do funcionario e a descrições das suas tarefas que estejam no estado 'Aguardando Desenvolvimento' e tenham prioridade 'ALTA' ou 'NORMAL'
    -- join
SELECT funcionario.nome, tarefa.brevedescricao FROM funcionario JOIN tarefa ON funcionario.id = tarefa.codfun WHERE tarefa.estado = 'AGUARDANDO DESENVOLVIMENTO' AND (tarefa.prioridade = 'ALTA' OR tarefa.prioridade = 'NORMAL') GROUP BY funcionario.nome, tarefa.brevedescricao;
    -- produto cartesiano
SELECT funcionario.nome, tarefa.brevedescricao FROM funcionario, tarefa WHERE  funcionario.id = tarefa.codfun AND tarefa.estado = 'AGUARDANDO DESENVOLVIMENTO' AND (tarefa.prioridade = 'ALTA' OR tarefa.prioridade = 'NORMAL') GROUP BY funcionario.nome, tarefa.brevedescricao;

-- Terceira. Retorna o nome e a idade do funcionario que apesar de ter tarefas nenhuma delas está no estado 'EM DESENVOLVIMENTO'
SELECT funcionario.nome, funcionario.idade FROM funcionario JOIN tarefa ON funcionario.id = tarefa.codfun WHERE funcionario.id <> ALL (SELECT codfun FROM tarefa WHERE estado = 'EM DESENVOLVIMENTO' GROUP BY codfun);

-- Quarta. Para o funcionario que tiver participação após '2000-01-01 00:00:00' em um projeto inciado após '1990-01-01 00:00:00' e seu selario for maior que 10000 retornar o seu nome, descrição do projeto e número de participações nesse projeto.
SELECT funcionario.nome  AS nome_do_funcionario, projeto.brevedescricao AS descricao_do_projeto, COUNT(participacaoprojeto.id) as numero_de_participacoes
    FROM participacaoprojeto JOIN funcionario ON participacaoprojeto.codfun = funcionario.id JOIN projeto ON participacaoprojeto.codproj = projeto.id
        WHERE participacaoprojeto.datahorainicio > '2000-01-01 00:00:00' AND funcionario.salario > 10000 AND projeto.datahorainicio > '1990-01-01 00:00:00' GROUP BY projeto.id, funcionario.id;