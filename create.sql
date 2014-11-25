create table orcamento  ( id integer primary key
                        , valor numeric(10, 2)
                        , data date
                        );

create table material ( id integer
                      , descricao varchar(60) not null check (descricao <> '')
                      );

create table orcamentosmateriais ( id integer primary key
                                 , quantidade integer
                                 , preco numeric(10, 2)
                                 );

  -- codOrc references orcamento (id)
  -- codMat references material (id)

create table homologado ( id integer primary key
                        );

  -- codAss references assinatura (id)
  -- codAloc references alocacao (id)
  -- codMat references material (id)

create table local ( id integer primary key
                   , andar integer not null
                   , setor integer not null
                   , numero integer not null
                   , constraint localizacao unique(andar, setor, numero)
                   );

create table alocacao ( id integer primary key
                      , dataalocacao date
                      );


  -- codLocal references local (id)
  -- codHom references homologado (id)

create table assinatura ( id integer primary key
                        , data_assinatura date not null
                        )


  -- codFun references funcionario (id)
  -- codHomo refenrences homologado (id)


create table funcionario ( id integer primary key
                         , nome varchar(60) not null check (nome <> '')
                         , idade integer not null
                         , salario numeric(10,2) not null
                         , dataegresso date
                         , dataingresso date not null
                         );

create table projeto ( id integer primary key
                     , brevedescricaov varchar(60) not null
                     , datainicio data not null
                     );

create table participacaoprojeto  ( id integer primary key
                                  , datainicio date not null
                                  , datafim date null
                                  );

  -- codFun references funcionario (id)
  -- codProj references projeto (id)

create table tarefa ( id integer primary key
                    , brevedescricao varchar(60)
                    , estado varchar(60)
                    , prioridade varchar(60)
                    , tempogasto integer
                    );


  -- tarefa weak entity, must have the id of project identifying tarefa
  -- codProj references projeto (id)
  -- codSubtar references subtarefas (id)

create table subtarefas (id brevedescricao estado prioridade tempogasto)

  -- codTar references tarefa (id codProj)

create table coordenador ( id integer primary key
                         , designacao varchar(60) not null check (designacao <> '')
                         );

  -- codFun references funcionario (id)

  -- create table coordenadorprojeto ( codCoord
  --                                 , codProj
  --                                 );

  -- codCoord references coordenador (id)
  -- codProj references projeto (id)

create table programador ( id integer primary key
                         );

  -- codFun references funcionario (id)

create table linguagem ( id
                       , nome varchar(60) not null check (nome <> '')
                       );

create table programadorlinguagem ( id integer primary key
                                  , dominio varchar(60) not null check (dominio <> '')
                                  );
  -- codProg references programador (id codFun)
  -- codLing references linguagem (id)
