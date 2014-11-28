create or replace function agora() returns timestamp as $$
  begin
    return now()::timestamp(0) without time zone;
  end;
$$ language plpgsql;
