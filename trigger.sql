-- trigger 1

-- create table tarefa ( id integer primary key
--                     , brevedescricao varchar(60)
--                     , estado varchar(60) CHECK (estado IN ('AGUARDANDO DESENVOLVIMENTO', 'EM DESENVOLVIMENTO', 'AGUARDANDO ANALISE', 'EM ANALISE'))
--                     , prioridade varchar(60) CHECK (prioridade IN ('BAIXA', 'MEDIA', 'ALTA'))
--                     , datahorainicial timestamp without time zone default agora()
--                     , datahorafinal timestamp without time zone
--                     , codsubtar integer
--                     , codproj integer
--                     , codfundono integer
--                     );

-- TODO: tarefas precisam ter datas entre a data do projeto

create or replace function apenas_tarefa_futuras() returns trigger as $apenas_tarefa_futuras$
  begin

    if new.datahorainicial > new.datahorafinal then
      raise exception 'Campo datahorainicial tem que ser menor que datahorafinal';
    end if;

    if new.datahorainicial < agora() then
      raise exception 'Campo datahorainicial nao pode ser nulo';
    end if;

    if new.datahorafinal < agora() then
      raise exception 'Campo datahorafinal nao pode ser nulo';
    end if;

    return new;

  end;
$apenas_tarefa_futuras$ language plpgsql;

create trigger apenas_tarefa_futuras before insert or update on tarefa
  for each row execute procedure apenas_tarefa_futuras();

-- trigger 2

-- for table funcionario ( id integer primary key
--                       , nome varchar(60) not null check (nome <> '')
--                       , idade integer not null
--                       , salario numeric(10,2) not null
--                       , datahoraegresso timestamp without time zone default agora()
--                       , datahoraingresso timestamp without time zone default agora()
--                       );

create or replace function funcionario_salario() returns trigger as $funcionario_salario$
  begin

    if new.salario < 0 then
      raise exception 'Campo salario nao pode ser negativo';
    end if;

    return new;

  end;
$funcionario_salario$ language plpgsql;

create trigger funcionario_salario before insert or update on funcionario
  for each row execute procedure funcionario_salario();

-- trigger 3

-- for table tarefa

create or replace function tarefas8_80() returns trigger as $tarefas8_80$
  declare diferenca8_80 integer;

  begin

    diferenca8_80 = extract(hour from age(new.datahorafinal, new.datahorainicial))
                    * 60 + extract(minute from age(new.datahorafinal, new.datahorainicial))
                    + extract(second from age(new.datahorafinal, new.datahorainicial))/ 60;

    if new.datahorafinal < new.datahorainicial then
      raise exception 'Datahorafinal nao pode ser menor que datahorainicial';
    end if;

    if diferenca8_80 > 4800 and diferenca8_80 < 480 then
      raise exception 'Diferenca tem que ser entre 8 horas e 80 horas, inicio: %s, fim: %s', new.datahorafinal, new.datahorainicial;
    end if;

    return new;

  end;
$tarefas8_80$ language plpgsql;

create trigger tarefas8_80 before insert or update on tarefa
  for each row execute procedure tarefas8_80();

-- trigger 4

-- create table projeto ( id integer primary key
--                      , brevedescricao varchar(60) not null
--                      , datahorainicio timestamp without time zone default agora()
--                      , datahorafim timestamp without time zone
--                      );
--
-- create table participacaoprojeto  ( id integer primary key
--                                   , datahorainicio timestamp without time zone default agora()
--                                   , datahorafim timestamp without time zone
--                                   , codfun integer
--                                   , codproj integer
--                                   );

create or replace function datahora_participacao_projeto() returns trigger as $datahora_participacao_projeto$
  declare tmpdatahorainicio timestamp;
  declare tmpdatahorafim timestamp;

  begin
    tmpdatahorainicio = datahorainicio from projeto p where p.id = new.codproj;
    tmpdatahorafim = datahorafim from projeto p where p.id = new.codproj;

    if new.datahorainicio < tmpdatahorainicio then
      raise exception 'Datahorainicio de participacaoprojeto tem que ser maior que datahorainicio do projeto. Obtive: %s < %s', new.datahorainicio, tmpdatahorainicio;
    end if;

    if new.datahorafim < tmpdatahorainicio then
      raise exception 'Datahorafim de participacaoprojeto tem que ser maior que datahorainicio do projeto. Obtive: %s < %s', new.datahorafim, tmpdatahorainicio;
    end if;

    if new.datahorainicio > tmpdatahorafim then
      raise exception 'Datahorainicio de participacaoprojeto tem que ser menor que datahorafim do projeto. Obtive: %s > %s', new.datahorainicio, tmpdatahorafim;
    end if;

    if new.datahorafim > tmpdatahorafim then
      raise exception 'Datahorafim de participacaoprojeto tem que ser menor que datahorafim do projeto. Obtive: %s > %s', new.datahorafim, tmpdatahorafim;
    end if;

    if new.datahorainicio > new.datahorafim then
      raise exception 'Datahorainicio de participacaoprojeto tem que ser menor que datahorafim de participacaoprojeto. Obtive: %s < %s', new.datahorainicio, new.datahorafim;
    end if;

    return new;

  end;

$datahora_participacao_projeto$ language plpgsql;

create trigger datahora_participacao_projeto after insert or update or delete on participacaoprojeto
  for each row execute procedure datahora_participacao_projeto();
