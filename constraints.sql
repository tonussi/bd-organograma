-- codorc references orcamento (id)
alter table orcamentosmateriais add constraint codorc_fkey foreign key (codorc) references orcamento (id);
-- codmat references material (id)
alter table orcamentosmateriais add constraint codmat_fkey foreign key (codmat) references material (id);

-- codass references assinatura (id)
alter table homologado add constraint codass_fkey foreign key (codass) references assinatura (id);
-- codaloc references alocacao (id)
alter table homologado add constraint codaloc_fkey foreign key (codaloc) references alocacao (id);
-- codmat references material (id)
alter table homologado add constraint codmat_fkey foreign key (codmat) references material (id);
-- codcoord references coordenador (id)
alter table homologado add constraint codcoord_fkey foreign key (codcoord) references coordenador (id);

-- codlocal references local (id)
alter table alocacao add constraint codlocal_fkey foreign key (codlocal) references local (id);
-- codhom references homologado (id)
-- alter table alocacao add constraint codhom_fkey foreign key (codhom) references homologado (id);

-- codfun references funcionario (id)
alter table assinatura add constraint codfun_fkey foreign key (codfun) references funcionario (id);
-- codhomo references homologado (id)
-- alter table assinatura add constraint codhomo_fkey foreign key (codhomo) references homologado (id);

-- codfun references funcionario (id)
alter table funcionariolocal add constraint codfun_fkey foreign key (codfun) references funcionario (id);
-- codlocal references local (id)
alter table funcionariolocal add constraint codlocal_fkey foreign key (codlocal) references local (id);

-- codfun references funcionario (id)
alter table participacaoprojeto add constraint codfun_fkey foreign key (codfun) references funcionario (id);
-- codproj references projeto (id)
alter table participacaoprojeto add constraint codproj_fkey foreign key (codproj) references projeto (id);

-- codfun references funcionario (id)
alter table tarefa add constraint codfun_fkey foreign key (codfun) references projeto (id);
-- codproj references projeto (id)
alter table tarefa add constraint codproj_fkey foreign key (codproj) references projeto (id);
-- codsubtar references tarefa (id)
alter table tarefa add constraint codsubtar_fkey foreign key (codsubtar) references tarefa (id);

-- codfun references funcionario (id)
alter table coordenador add constraint codfun_fkey foreign key (codfun) references funcionario (id);

-- codcoord references coordenador (id)
alter table coordenadorprojeto add constraint codcoord_fkey foreign key (codcoord) references coordenador (id);
-- codproj references projeto (id)
alter table coordenadorprojeto add constraint codproj_fkey foreign key (codproj) references projeto (id);

-- codfun references funcionario (id)
alter table programador add constraint codfun_fkey foreign key (codfun) references funcionario (id);

-- codprog references programador (id)
alter table programadorlinguagem add constraint codprog_fkey foreign key (codprog) references programador (id);
-- codling references linguagem (id)
alter table programadorlinguagem add constraint codling_fkey foreign key (codling) references linguagem (id);
