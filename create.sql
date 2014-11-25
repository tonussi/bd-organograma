create table orcamento  ( id integer primary key
                        , valor numeric(10, 2)
                        , data date
                        );

create table material ( id integer
                      , brevedescricao varchar(60) not null check (descricao <> '')
                      );

create table orcamentosmateriais ( id integer primary key
                                 , quantidade integer
                                 , preco numeric(10, 2)
                                 );

  -- codorc references orcamento (id)
alter table orcamentosmateriais add constraint codorcfk foreign key (codorc) references orcamento (id);
  -- codmat references material (id)
alter table orcamentosmateriais add constraint codmatfk foreign key (codmat) references material (id);

create table homologado ( id integer primary key
                        );

  -- codass references assinatura (id)
alter table orcamentosmateriais add constraint codassfk foreign key (codass) references assinatura (id);
  -- codaloc references alocacao (id)
alter table orcamentosmateriais add constraint codalocfk foreign key (codaloc) references alocacao (id);
  -- codmat references material (id)
alter table orcamentosmateriais add constraint codmatfk foreign key (codmat) references material (id);

create table local ( id integer primary key
                   , andar integer not null
                   , setor integer not null
                   , numero integer not null
                   , constraint localizacao unique(andar, setor, numero)
                   );

create table alocacao ( id integer primary key
                      , dataalocacao date
                      );


  -- codlocal references local (id)
alter table alocacao add constraint codlocalfk foreign key (codlocal) references local (id);
  -- codhom references homologado (id)
alter table alocacao add constraint codhomfk foreign key (codhom) references homologado (id);

create table assinatura ( id integer primary key
                        , data_assinatura date not null
                        );


  -- codfun references funcionario (id)
alter table assinatura add constraint codfun foreign key (codfunfk) references funcionario (id);
  -- codhomo refenrences homologado (id)
alter table assinatura add constraint codfun foreign key (codhomofk) references homologado (id);

create table funcionario ( id integer primary key
                         , nome varchar(60) not null check (nome <> '')
                         , idade integer not null
                         , salario numeric(10,2) not null
                         , dataegresso date
                         , dataingresso date not null
                         );

-- create table alteracoes_funcionario ( id integer primary key
--                                     , ultima_vez_data timestamp
--                                     , ultima_vez_usuario varchar(60)
--                                     );

-- alter table alteracoes_funcionario add constraint logfun foreign key (logfunfk) references funcionario (id);

create table projeto ( id integer primary key
                     , brevedescricaov varchar(60) not null
                     , datainicio data not null
                     );

create table participacaoprojeto  ( id integer primary key
                                  , datainicio date not null
                                  , datafim date null
                                  );

  -- codfun references funcionario (id)
alter table participacaoprojeto add constraint codfunfk foreign key (codmatfk) references funcionario (id);
  -- codproj references projeto (id)
alter table participacaoprojeto add codprojfk codmatfk foreign key (codmatfk) references projeto (id);

create table tarefa ( id integer primary key
                    , brevedescricao varchar(60)
                    , estado varchar(60)
                    , prioridade varchar(60)
                    , tempogasto integer
                    );

  -- tarefa weak entity, must have the id of project identifying tarefa

  -- codproj references projeto (id)
alter table tarefa add constraint codproj foreign key (codprojfk) references projeto (id);
alter table tarefa add constraint codsubtar foreign key (codsubtarfk) references projeto (id);
  -- codsubtar references subtarefas (id)
alter table tarefa add constraint codsubtar foreign key (codsubtarfk) references tarefas (id);
alter table tarefa add constraint codsubtar foreign key (codsubtarfk) references projeto (id);

-- create table subtarefas ( id integer primary key
--                         , brevedescricao varchar(60) not null check (designacao <> '')
--                         , estado varchar(60) not null check (designacao <> '')
--                         , prioridade varchar(60) not null check (designacao <> '')
--                         , tempogasto integer not null
--                         );

  -- codtar references tarefa (id, codproj)
-- alter table tarefa add constraint codtar foreign key (codtarfk) references tarefa (id, codproj);

create table coordenador ( id integer primary key
                         , designacao varchar(60) not null check (designacao <> '')
                         );

  -- codfun references funcionario (id)

  -- create table coordenadorprojeto ( codcoord
  --                                 , codproj
  --                                 );

  -- codcoord references coordenador (id)
alter table tarefa add constraint codcoord foreign key (codcoordfk) references coordenador (id);
  -- codproj references projeto (id)
alter table tarefa add constraint codproj foreign key (codprojfk) references projeto (id);

create table programador ( id integer primary key
                         );

  -- codfun references funcionario (id)

create table linguagem ( id
                       , nome varchar(60) not null check (nome <> '')
                       );

create table programadorlinguagem ( id integer primary key
                                  , dominio varchar(60) not null check (dominio <> '')
                                  );

  -- codprog references programador (id codfun)
alter table tarefa add constraint codprog foreign key (codprogfk) references programador (id codfun);
  -- codling references linguagem (id)
alter table tarefa add constraint codling foreign key (codlingfk) references linguagem (id);
