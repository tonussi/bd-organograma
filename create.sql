create table orcamento  ( id integer primary key
                        , valor numeric(10, 2) not null
                        , datahoraorcamento timestamp without time zone not null default agora()
                        );

create table material ( id integer primary key
                      , brevedescricao varchar(60) not null check (brevedescricao <> '')
                      );

create table orcamentosmateriais ( id integer primary key
                                 , quantidade integer not null check (quantidade > 0)
                                 , preco numeric(10, 2) not null check (preco > 0)
                                 , codorc integer
                                 , codmat integer
                                 );

  -- codorc references orcamento (id)
-- alter table orcamentosmateriais add constraint codorc_fkey foreign key (codorc) references orcamento (id);
  -- codmat references material (id)
-- alter table orcamentosmateriais add constraint codmat_fkey foreign key (codmat) references material (id);

create table homologado ( id integer primary key
                        , codass integer
                        , codaloc integer
                        , codmat integer
                        , codcoord integer
                        );

  -- codass references assinatura (id)
-- alter table homologado add constraint codass_fkey foreign key (codass) references assinatura (id);
  -- codaloc references alocacao (id)
-- alter table homologado add constraint codaloc_fkey foreign key (codaloc) references alocacao (id);
  -- codmat references material (id)
-- alter table homologado add constraint codmat_fkey foreign key (codmat) references material (id);
  -- codcoord references coordenador (id)
-- alter table homologado add constraint codcoord_fkey foreign key (codcoord) references coordenador (id);

create table local ( id integer primary key
                   , andar integer not null
                   , setor varchar(2) not null check (setor <> '')
                   , sala integer not null
                   );

-- alter table local add constraint localizacaounica unique(andar)
-- alter table local add constraint localizacaounica unique(setor)
-- alter table local add constraint localizacaounica unique(sala)

create table alocacao ( id integer primary key
                      , datahoraalocacao timestamp without time zone not null default agora()
                      , codlocal integer
                      );

  -- codlocal references local (id)
-- alter table alocacao add constraint codlocal_fkey foreign key (codlocal) references local (id);
  -- codhom references homologado (id)
-- alter table alocacao add constraint codhom_fkey foreign key (codhom) references homologado (id);

create table assinatura ( id integer primary key
                        , datahoraassinatura timestamp without time zone not null default agora()
                        , codfun integer
                        );

  -- codfun references funcionario (id)
-- alter table assinatura add constraint codfun_fkey foreign key (codfun) references funcionario (id);
  -- codhomo references homologado (id)
-- alter table assinatura add constraint codfun_fkey foreign key (codhomo) references homologado (id);

create table funcionario ( id integer primary key
                         , nome varchar(60) not null check (nome <> '')
                         , idade integer not null
                         , salario numeric(10,2) not null
                         , datahoraingresso timestamp without time zone not null default agora()
                         , datahoraegresso timestamp without time zone
                         );

-- create table alteracoes_funcionario ( id integer primary key
--                                     , ultima_vez_data timestamp
--                                     , ultima_vez_usuario varchar(60)
--                                     );

-- alter table alteracoes_funcionario add constraint logfun_fkey foreign key (logfunfk) references funcionario (id);

create table funcionariolocal ( id integer primary key
                              , codfun integer
                              , codlocal integer
                              );

  -- codfun references funcionario (id)
-- alter table funcionariolocal add constraint codfun_fkey foreign key (codfun) references funcionario (id);
  -- codlocal references local (id)
-- alter table funcionariolocal add constraint codlocal_fkey foreign key (codlocal) references local (id);

create table projeto ( id integer primary key
                     , brevedescricao varchar(60) not null
                     , datahorainicio timestamp without time zone not null default agora()
                     , datahorafim timestamp without time zone not null
                     );

create table participacaoprojeto  ( id integer primary key
                                  , datahorainicio timestamp without time zone not null default agora()
                                  , datahorafim timestamp without time zone not null
                                  , codfun integer
                                  , codproj integer
                                  );

  -- codfun references funcionario (id)
-- alter table participacaoprojeto add constraint codfun_fkey foreign key (codfun) references funcionario (id);
  -- codproj references projeto (id)
-- alter table participacaoprojeto add constraint codproj_fkey foreign key (codproj) references projeto (id);

create table tarefa ( id integer primary key
                    , brevedescricao varchar(60)
                    , estado varchar(60) check (estado in ( 'AGUARDANDO DESENVOLVIMENTO'
                                                          , 'EM DESENVOLVIMENTO'
                                                          , 'AGUARDANDO ANALISE'
                                                          , 'EM ANALISE'
                                                          ))
                    , prioridade varchar(60) check (prioridade in ( 'BAIXA'
                                                                  , 'MEDIA'
                                                                  , 'ALTA'
                                                                  ))
                    , datahorainicial timestamp without time zone not null default agora()
                    , datahorafinal timestamp without time zone not null
                    , codsubtar integer
                    , codproj integer
                    , codfundono integer
                    );

  -- tarefa weak entity, must have the id of project identifying tarefa

  -- codfun references funcionario (id)
-- alter table tarefa add constraint codfun_fkey foreign key (codfun) references projeto (id);
  -- codproj references projeto (id)
-- alter table tarefa add constraint codproj_fkey foreign key (codproj) references projeto (id);
  -- codsubtar references tarefa (id)
-- alter table tarefa add constraint codsubtar_fkey foreign key (codsubtar) references tarefa (id);
  -- codfundono references funcionario (id)
-- alter table tarefa add constraint codfundono_fkey foreign key (codfundono) references funcionario (id);


create table participacaotarefa  ( id integer primary key
                                 , codfun integer
                                 , codtar integer
                                 , codsubtar integer
                                 );

  -- codsubtar references tarefa (id)
-- alter table participacaotarefa add constraint codsubtar_fkey foreign key (codsubtar) references tarefa (id);
  -- codfund references funcionario (id)
-- alter table participacaotarefa add constraint codfun_fkey foreign key (codfun) references funcionario (id);
  -- codtar references tarefa (id)
-- alter table participacaotarefa add constraint codsubtar_fkey foreign key (codsubtar) references tarefa (id);


create table coordenador ( id integer primary key
                         , designacao varchar(60) not null check (designacao in ( 'D1'
                                                                                , 'D2'
                                                                                , 'D3'
                                                                                , 'D4'
                                                                                , 'D5'
                                                                                ))
                         , codfun integer
                         );

  -- codfun references funcionario (id)
-- alter table coordenador add constraint codfun_fkey foreign key (codfun) references funcionario (id);

create table coordenadorprojeto ( id integer primary key
                                , codcoord integer
                                , codproj integer
                                );

  -- codcoord references coordenador (id)
-- alter table coordenadorprojeto add constraint codcoord_fkey foreign key (codcoord) references coordenador (id);
  -- codproj references projeto (id)
-- alter table coordenadorprojeto add constraint codproj_fkey foreign key (codproj) references projeto (id);

create table programador ( id integer primary key
                         , rank varchar(60) not null check (rank in ( 'R1'
                                                                    , 'R2'
                                                                    , 'R3'
                                                                    ))
                         , codfun integer
                         );


  -- codfun references funcionario (id)
-- alter table programador add constraint codfun_fkey foreign key (codfun) references funcionario (id);

create table linguagem ( id integer primary key
                       , nome varchar(60) not null check (nome in ( 'C'
                                                                  , 'CPP'
                                                                  , 'PERL'
                                                                  , 'RUBY'
                                                                  , 'JAVA'
                                                                  , 'SHELL'
                                                                  , 'PYTHON'
                                                                  , 'GROOVY'
                                                                  , 'CLOJURE'
                                                                  , 'JAVASCRIPT'
                                                                  ))
                       );

create table programadorlinguagem ( id integer primary key
                                  , dominio varchar(60) not null check (dominio <> '')
                                  , codprog integer
                                  , codling integer
                                  );

  -- codprog references programador (id)
-- alter table programadorlinguagem add constraint codprog_fkey foreign key (codprog) references programador (id);
  -- codling references linguagem (id)
-- alter table programadorlinguagem add constraint codling_fkey foreign key (codling) references linguagem (id);
