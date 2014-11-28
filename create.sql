create table orcamento  ( id integer
                        , valor numeric(10, 2)
                        , data timestamp without time zone default agora()
                        , primary key (id)
                        );

create table material ( id integer
                      , brevedescricao varchar(60) not null check (brevedescricao <> '')
                      );

create table orcamentosmateriais ( id integer primary key
                                 , quantidade integer not null check (quantidade > 0)
                                 , preco numeric(10, 2) not null check (preco > 0)
                                 , codorc integer
                                 , codmat integer
                                 );

  -- codorc references orcamento (id)
alter table orcamentosmateriais add constraint codorc_fkey foreign key (codorc) references orcamento (id);
  -- codmat references material (id)
alter table orcamentosmateriais add constraint codmat_fkey foreign key (codmat) references material (id);

create table homologado ( id integer primary key
                        , codass integer
                        , codaloc integer
                        , codmat integer
                        );

  -- codass references assinatura (id)
alter table orcamentosmateriais add constraint codass_fkey foreign key (codass) references assinatura (id);
  -- codaloc references alocacao (id)
alter table orcamentosmateriais add constraint codaloc_fkey foreign key (codaloc) references alocacao (id);
  -- codmat references material (id)
alter table orcamentosmateriais add constraint codmat_fkey foreign key (codmat) references material (id);

create table local ( id integer primary key
                   , andar integer not null
                   , setor integer not null
                   , sala integer not null
                   );

-- alter table local add constraint localizacaounica unique(andar)
-- alter table local add constraint localizacaounica unique(setor)
-- alter table local add constraint localizacaounica unique(sala)

create table alocacao ( id integer primary key
                      , dataalocacao timestamp without time zone default agora()
                      , codlocal integer
                      , codhom integer
                      );

  -- codlocal references local (id)
alter table alocacao add constraint codlocal_fkey foreign key (codlocal) references local (id);
  -- codhom references homologado (id)
alter table alocacao add constraint codhom_fkey foreign key (codhom) references homologado (id);

create table assinatura ( id integer primary key
                        , data_assinatura timestamp without time zone default agora()
                        , codfun integer
                        , codhomo integer
                        );


  -- codfun references funcionario (id)
alter table assinatura add constraint codfun_fkey foreign key (codfun) references funcionario (id);
  -- codhomo references homologado (id)
alter table assinatura add constraint codfun_fkey foreign key (codhomo) references homologado (id);

create table funcionario ( id integer primary key
                         , nome varchar(60) not null check (nome <> '')
                         , idade integer not null
                         , salario numeric(10,2) not null
                         , dataegresso timestamp without time zone default agora()
                         , dataingresso timestamp without time zone default agora()
                         );

-- create table alteracoes_funcionario ( id integer primary key
--                                     , ultima_vez_data timestamp
--                                     , ultima_vez_usuario varchar(60)
--                                     );

-- alter table alteracoes_funcionario add constraint logfun_fkey foreign key (logfunfk) references funcionario (id);

create table projeto ( id integer primary key
                     , brevedescricaov varchar(60) not null
                     , datainicio timestamp without time zone default agora()
                     );

create table participacaoprojeto  ( id integer primary key
                                  , datainicio timestamp without time zone default agora()
                                  , datafim timestamp without time zone default agora()
                                  , codfun integer
                                  , codproj integer
                                  );

  -- codfun references funcionario (id)
alter table participacaoprojeto add constraint codfun_fkey foreign key (codfun) references funcionario (id);
  -- codproj references projeto (id)
alter table participacaoprojeto add constraint codproj_fkey foreign key (codproj) references projeto (id);

create table tarefa ( id integer primary key
                    , brevedescricao varchar(60)
                    , estado varchar(60)
                    , prioridade varchar(60)
                    , datahorainicial timestamp without time zone default agora()
                    , datahorafinal timestamp without time zone default agora()
                    , codsubtar integer
                    );

  -- tarefa weak entity, must have the id of project identifying tarefa

  -- codproj references projeto (id)
alter table tarefa add constraint codproj_fkey foreign key (codproj) references projeto (id);
  -- codsubtar references subtarefas (id)
alter table tarefa add constraint codsubtar_fkey foreign key (codsubtar) references tarefas (id);

-- create table subtarefas ( id integer primary key
--                         , brevedescricao varchar(60) not null check (designacao <> '')
--                         , estado varchar(60) not null check (designacao <> '')
--                         , prioridade varchar(60) not null check (designacao <> '')
--                         , tempogasto integer not null
--                         );

  -- codtar references tarefa (id, codproj)
-- alter table tarefa add constraint codtar_fkey foreign key (codtarfk) references tarefa (id, codproj);

create table coordenador ( id integer primary key
                         , designacao varchar(60) not null check (designacao <> '')
                         , codcoord integer
                         , codproj integer
                         );

  -- codfun references funcionario (id)
alter table coordenador add constraint codfun_fkey foreign key (codfun) references funcionario (id);

  -- create table coordenadorprojeto ( codcoord
  --                                 , codproj
  --                                 );

  -- codcoord references coordenador (id)
alter table tarefa add constraint codcoord_fkey foreign key (codcoord) references coordenador (id);
  -- codproj references projeto (id)
alter table tarefa add constraint codproj_fkey foreign key (codproj) references projeto (id);

create table programador ( id integer primary key
                         , rank varchar(60) not null check (rank <> '')
                         , codfun integer
                         );

  -- codfun references funcionario (id)
alter table programador add constraint codfun_fkey foreign key (codfun) references funcionario (id);

create table linguagem ( id integer primary key
                       , nome varchar(60) not null check (nome <> '')
                       );

create table programadorlinguagem ( id integer primary key
                                  , dominio varchar(60) not null check (dominio <> '')
                                  , codprog integer
                                  , codling integer
                                  );

  -- codprog references programador (id)
alter table programadorlinguagem add constraint codprog_fkey foreign key (codprog) references programador (id, codfun);
  -- codling references linguagem (id)
alter table programadorlinguagem add constraint codling_fkey foreign key (codling) references linguagem (id);
