-- trigger 1

-- for table tarefa ( id integer primary key
--                  , brevedescricao varchar(60)
--                  , estado varchar(60)
--                  , prioridade varchar(60)
--                  , datahorainicial timestamp without time zone default agora()
--                  , datahorafinal timestamp without time zone default agora()
--                  , codsubtar integer
--                  );

create or replace function apenas_tarefa_futuras() returns trigger as $$
  begin

    if new.id is null then
      raise exception 'Campo id não pode ser nulo';
    end if;

    if new.brevedescricao is null then
      raise exception 'Campo brevedescricao não pode ser nulo';
    end if;

    if new.estado is null then
      raise exception 'Campo estado não pode ser nulo';
    end if;

    if new.prioridade is null then
      raise exception 'Campo prioridade não pode ser nulo';
    end if;

    if new.datahorainicial is null then
      raise exception 'Campo datahorainicial não pode ser nulo';
    end if;

    if new.datahorafinal is null then
      raise exception 'Campo datahorafinal não pode ser nulo';
    end if;

    if new.codsubtar is null then
      raise exception 'Campo codsubtar não pode ser nulo';
    end if;

    if new.datahorainicial < agora() then
      raise exception 'Campo datahorainicial não pode ser nulo';
    end if;

    if new.datahorafinal < agora() then
      raise exception 'Campo datahorafinal não pode ser nulo';
    end if;

    return new;

  end;
$$ language plpgsql;

-- create or replace trigger apenas_tarefa_futuras before insert or update on tarefa
--   for each row execute procedure apenas_tarefa_futuras();

-- trigger 2

-- for table funcionario ( id integer primary key
--                       , nome varchar(60) not null check (nome <> '')
--                       , idade integer not null
--                       , salario numeric(10,2) not null
--                       , dataegresso timestamp without time zone default agora()
--                       , dataingresso timestamp without time zone default agora()
--                       );

create or replace function funcionario_salario() returns trigger as $$
  begin

    if new.id is null then
      raise exception 'Campo dataingresso não pode ser nulo';
    end if;

    if new.nome is null then
      raise exception 'Campo dataegresso não pode ser nulo';
    end if;

    if new.idade is null then
      raise exception 'Campo salario não pode ser nulo';
    end if;

    if new.salario is null then
      raise exception 'Campo idade não pode ser nulo';
    end if;

    if new.dataegresso is null then
      raise exception 'Campo nome não pode ser nulo';
    end if;

    if new.dataingresso is null then
      raise exception 'Campo id não pode ser nulo';
    end if;

    if new.salario < 0 then
      raise exception 'funcionário % não pode ter salário negativo', new.nome;
    end if;

    return new;

  end;
$$ language plpgsql;

-- create or replace trigger funcionario_salario before insert or update on funcionario
--   for each row execute procedure funcionario_salario();

-- trigger 3

-- for table tarefa

create or replace function tarefas8_80() returns trigger as $$
  declare diferenca8_80 integer;

  begin

    set diferenca8_80 select age(new.datahorafinal::timestamp, new.datahorainicial::timestamp);

    if new.id is null then
      raise exception 'Campo codsubtar não pode ser nulo';
    end if;

    if new.brevedescricao is null then
      raise exception 'Campo datahorafinal não pode ser nulo';
    end if;

    if new.estado is null then
      raise exception 'Campo datahorainicial não pode ser nulo';
    end if;

    if new.prioridade is null then
      raise exception 'Campo prioridade não pode ser nulo';
    end if;

    if new.datahorainicial is null then
      raise exception 'Campo estado não pode ser nulo';
    end if;

    if new.datahorafinal is null then
      raise exception 'Campo brevedescricao não pode ser nulo';
    end if;

    if new.codsubtar is null then
      raise exception 'Campo id não pode ser nulo';
    end if;


    if diferenca8_80 > 80 then
      raise exception 'A diferença está maior que 80, o que não pode ocorrer';
    end if;

    return new;

  end;
$$ language plpgsql;

-- create or replace trigger tarefas8_80 before insert or update on tarefa
--   for each row execute procedure tarefas8_80();
