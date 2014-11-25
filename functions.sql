create function tonussi_now() returns timestamp as $$
  select now()::timestamp without time zone;
$$ language pgsql;
