-- quando alguma tarefa expira o tempo dela ser executada.

create or replace function tarefa_expirou()
returns trigger as $tarefa_expirou$
  begin
    if new.expirationdate > current_timestamp then
      return new;
    end if;
    return null;
  end;
$tarefa_expirou$ language plpgsql;

create or replace trigger verificar_data_expiracao before insert or update on product
  for each row execute procedure tarefa_expirou();

create or replace function funcionario_salario() returns trigger as $funcionario_salario$
  begin

   if new.nome is null then
        raise exception 'nome não pode ser nulo';
    end if;

    if new.salario is null then
        raise exception 'funcionário % não pode ser nulo', new.nome;
    end if;

    -- who works for us when she must pay for it?
    if new.salario < 0 then
        raise exception 'funcionário % não pode ter salário negativo', new.nome;
    end if;

    return new;

  end;
$funcionario_salario$ language plpgsql;

create or replace trigger funcionario_salario before insert or update on funcionario
  for each row execute procedure funcionario_salario();

create or replace function tarefas8_80() returns trigger as $funcionario_salario$
  declare diferenca8_80 integer;

  begin

    set diferenca8_80 select age(new.datahorafinal::timestamp, new.datahorainicial::timestamp);

    -- who works for us when she must pay for it?
    if diferenca8_80 > 80 then
        raise exception 'A diferença está maior que 80, o que não pode ocorrer';
    end if;

    return new;

  end;
$funcionario_salario$ language plpgsql;

create or replace trigger tarefas8_80 before insert or update on funcionario
  for each row execute procedure tarefas8_80();
