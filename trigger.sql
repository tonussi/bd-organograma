-- quando alguma tarefa expira o tempo dela ser executada.

create function tarefa_expirou()
returns trigger as $body$
  begin
    if new.expirationdate > current_timestamp then
      return new;
    else
      return null;
  end;
$body$
language 'plpgsql';

create trigger verificar_data_expiracao before insert or update on product
  for each row execute procedure tarefa_expirou();

create function funcionario_salario() returns trigger as $funcionario_salario$
  begin

    if new.nome is null then
        raise exception 'Nome não pode ser nulo';
    end if;

    if new.salario is null then
        raise exception 'Funcionário % não pode ser nulo', new.nome;
    end if;

    -- who works for us when she must pay for it?
    if new.salario < 0 then
        raise exception 'Funcionário % não pode ter salário negativo', new.nome;
    end if;

    new.last_date := current_timestamp;
    new.last_user := current_user;

    return new;

  end;
$funcionario_salario$ language plpgsql;

create trigger funcionario_salario before insert or update on funcionario
  for each row execute procedure funcionario_salario();

create function funcionario_salario() returns trigger as $funcionario_salario$
  begin

    if new.nome is null then
        raise exception 'Nome não pode ser nulo';
    end if;

    if new.salario is null then
        raise exception 'Funcionário % não pode ser nulo', new.nome;
    end if;

    -- who works for us when she must pay for it?
    if new.salario < 0 then
        raise exception 'Funcionário % não pode ter salário negativo', new.nome;
    end if;

    new.last_date := current_timestamp;
    new.last_user := current_user;

    return new;

  end;
$funcionario_salario$ language plpgsql;

create trigger funcionario_salario before insert or update on funcionario
  for each row execute procedure funcionario_salario();
