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
SELECT tarefa.brevedescricao, tarefa.estado FROM tarefa WHERE tarefa.prioridade = 'Alta' AND EXTRACT(hour FROM tarefa.datahorainicial) BETWEEN 8 AND 12;