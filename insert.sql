insert into orcamento values (id, valor, data) values (1, 1000, '2014-10-10');
insert into orcamento values (id, valor, data) values (2, 2000, '2014-10-11');
insert into orcamento values (id, valor, data) values (3, 3000, '2014-10-12');
insert into orcamento values (id, valor, data) values (4, 4000, '2014-10-13');

insert into material (id, brevedescricao) values (1, 'Breve descricao material 1');
insert into material (id, brevedescricao) values (2, 'Breve descricao material 2');
insert into material (id, brevedescricao) values (3, 'Breve descricao material 3');
insert into material (id, brevedescricao) values (4, 'Breve descricao material 4');

-- codOrc references orcamento (id)
-- codMat references material (id)

insert into homologado (id) values (1);
insert into homologado (id) values (2);
insert into homologado (id) values (3);
insert into homologado (id) values (4);

-- codAss references assinatura (id)
-- codAloc references alocacao (id)
-- codMat references material (id)

insert into local (id, andar, setor, numero) values (1, 1, 'S1', 108);
insert into local (id, andar, setor, numero) values (2, 2, 'S2', 208);
insert into local (id, andar, setor, numero) values (3, 3, 'S3', 308);
insert into local (id, andar, setor, numero) values (4, 4, 'S4', 408);

insert into alocacao (id, dataalocacao) values (1, '2014-10-11');
insert into alocacao (id, dataalocacao) values (2, '2014-10-12');
insert into alocacao (id, dataalocacao) values (3, '2014-10-13');
insert into alocacao (id, dataalocacao) values (4, '2014-10-14');

-- codLocal references local (id)
-- codHom references homologado (id)

insert into assinatura (id, dataassinatura) values (1, '2014-11-22');
insert into assinatura (id, dataassinatura) values (2, '2014-11-23');
insert into assinatura (id, dataassinatura) values (3, '2014-11-24');
insert into assinatura (id, dataassinatura) values (4, '2014-11-25');

-- codFun references funcionario (id)
-- codHomo refenrences homologado (id)

insert into funcionario (id, nome, idade, salario, dataegresso, dataingresso) values (1, 'Marco', 31, 13500, null, '2001-2-20');
insert into funcionario (id, nome, idade, salario, dataegresso, dataingresso) values (2, 'Joana', 33, 13500, null, '2001-2-20');
insert into funcionario (id, nome, idade, salario, dataegresso, dataingresso) values (3, 'Paula', 34, 13500, null, '2001-2-20');
insert into funcionario (id, nome, idade, salario, dataegresso, dataingresso) values (4, 'Paulo', 32, 13500, null, '2001-2-20');

insert into projeto (id, brevedescricao, datainicio) values (1, 'Breve descricao projeto 1', '2014-5-20');
insert into projeto (id, brevedescricao, datainicio) values (2, 'Breve descricao projeto 2', '2014-3-20');
insert into projeto (id, brevedescricao, datainicio) values (3, 'Breve descricao projeto 3', '2014-1-20');
insert into projeto (id, brevedescricao, datainicio) values (4, 'Breve descricao projeto 4', '2014-2-20');

insert into participacaoprojeto (id, datainicio, datafim) values (1, '2014-5-20', null);
insert into participacaoprojeto (id, datainicio, datafim) values (2, '2014-3-20', null);
insert into participacaoprojeto (id, datainicio, datafim) values (3, '2014-1-20', null);
insert into participacaoprojeto (id, datainicio, datafim) values (4, '2014-2-20', null);

-- codFun references funcionario (id)
-- codProj references projeto (id)

insert into tarefa (id, brevedescricao, estado, prioridade, tempogasto) values (1, 'Breve descricao tarefa 1', 'E1', 'ALTA', 12);
insert into tarefa (id, brevedescricao, estado, prioridade, tempogasto) values (2, 'Breve descricao tarefa 2', 'E1', 'ALTA', 12);
insert into tarefa (id, brevedescricao, estado, prioridade, tempogasto) values (3, 'Breve descricao tarefa 3', 'A1', 'ALTA', 12);
insert into tarefa (id, brevedescricao, estado, prioridade, tempogasto) values (4, 'Breve descricao tarefa 4', 'A1', 'ALTA', 12);

-- codProj references projeto (id)
-- codSubtar references subtarefas (id)

insert into subtarefas (id, brevedescricao, estado, prioridade, tempogasto) values (1, 'Breve descricao subtarefa 1', 'C1', 'BAIXA', 9);
insert into subtarefas (id, brevedescricao, estado, prioridade, tempogasto) values (2, 'Breve descricao subtarefa 2', 'C1', 'BAIXA', 5);
insert into subtarefas (id, brevedescricao, estado, prioridade, tempogasto) values (3, 'Breve descricao subtarefa 3', 'C1', 'BAIXA', 2);
insert into subtarefas (id, brevedescricao, estado, prioridade, tempogasto) values (4, 'Breve descricao subtarefa 4', 'C1', 'BAIXA', 8);

-- codTar references tarefa (id, codProj)

insert into coordenador (id, designacao) values (1, 'DESIG_CO1');
insert into coordenador (id, designacao) values (2, 'DESIG_CO2');
insert into coordenador (id, designacao) values (3, 'DESIG_CO3');
insert into coordenador (id, designacao) values (4, 'DESIG_CO4');

-- references funcionario (id)
-- coordenadorprojeto (_#codCoord, _#codProj)
-- codCoord references coordenador (id)
-- codProj references projeto (id)

insert into programador (id) values (1);
insert into programador (id) values (2);
insert into programador (id) values (3);
insert into programador (id) values (4);

-- codFun references funcionario (id)

insert into linguagem (id, nome) values (1, 'CPP');
insert into linguagem (id, nome) values (2, 'RUBY');
insert into linguagem (id, nome) values (3, 'PYTHON');
insert into linguagem (id, nome) values (4, 'JAVASCRIPT');

insert into programadorlinguagem (id, dominio) values (1, 'Algum dominio 1');
insert into programadorlinguagem (id, dominio) values (2, 'Algum dominio 2');
insert into programadorlinguagem (id, dominio) values (3, 'Algum dominio 3');
insert into programadorlinguagem (id, dominio) values (4, 'Algum dominio 4');

-- codProg references programador (id, codFun)
-- codLing references linguagem (id)
