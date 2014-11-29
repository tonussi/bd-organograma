-- trigger 1

-- for table tarefa ( id integer primary key
--                  , brevedescricao varchar(60)
--                  , estado varchar(60)
--                  , prioridade varchar(60)
--                  , datahorainicial timestamp without time zone default agora()
--                  , datahorafinal timestamp without time zone default agora()
--                  , codsubtar integer
--                  );

create or replace function apenas_tarefa_futuras() returns trigger as $apenas_tarefa_futuras$
  begin

    if new.id is null then
      raise exception 'Campo id nao pode ser nulo';
    end if;

    if new.brevedescricao is null then
      raise exception 'Campo brevedescricao nao pode ser nulo';
    end if;

    if new.estado is null then
      raise exception 'Campo estado nao pode ser nulo';
    end if;

    if new.prioridade is null then
      raise exception 'Campo prioridade nao pode ser nulo';
    end if;

    if new.datahorainicial is null then
      raise exception 'Campo datahorainicial nao pode ser nulo';
    end if;

    if new.datahorafinal is null then
      raise exception 'Campo datahorafinal nao pode ser nulo';
    end if;

    if new.codsubtar is null then
      raise exception 'Campo codsubtar nao pode ser nulo';
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

    if new.id is null then
      raise exception 'Campo id nao pode ser nulo';
    end if;

    if new.nome is null then
      raise exception 'Campo nome nao pode ser nulo';
    end if;

    if new.idade is null then
      raise exception 'Campo idade nao pode ser nulo';
    end if;

    if new.salario is null then
      raise exception 'Campo salario nao pode ser nulo';
    end if;

    if new.datahoraingresso is null then
      raise exception 'Campo datahoraingresso nao pode ser nulo';
    end if;

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

    if new.id is null then
      raise exception 'Campo codsubtar nao pode ser nulo';
    end if;

    if new.brevedescricao is null then
      raise exception 'Campo datahorafinal nao pode ser nulo';
    end if;

    if new.estado is null then
      raise exception 'Campo datahorainicial nao pode ser nulo';
    end if;

    if new.prioridade is null then
      raise exception 'Campo prioridade nao pode ser nulo';
    end if;

    if new.datahorainicial is null then
      raise exception 'Campo estado nao pode ser nulo';
    end if;

    if new.datahorafinal is null then
      raise exception 'Campo brevedescricao nao pode ser nulo';
    end if;

    if new.codsubtar is null then
      raise exception 'Campo id nao pode ser nulo';
    end if;

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
