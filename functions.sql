create function agora() returns timestamp as $$
  select now()::timestamp without time zone;
$$ language pgsql;
