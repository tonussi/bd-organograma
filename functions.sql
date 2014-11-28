create or replace function agora() returns timestamp as $$
  begin
    return now()::timestamp without time zone;
  end;
$$ language plpgsql;
