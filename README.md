(ง •̀_•́)ง Ordem de execução dos arquivos `.sql`.

```sh
psql -U uname -d dbname -a -f   functions.sql
psql -U uname -d dbname -a -f      create.sql
psql -U uname -d dbname -a -f       index.sql
psql -U uname -d dbname -a -f constraints.sql
psql -U uname -d dbname -a -f     trigger.sql
psql -U uname -d dbname -a -f      insert.sql
psql -U uname -d dbname -a -f       query.sql # test
```

# Autores

- [Lucas Tonussi](https://github.com/tonussi/) :octocat:

- [Thiago Rose](https://github.com/thisenrose/) :bicyclist:

# Esquema conceitual

* Entidades: `16`
* Referências: `21`

```sql
orcamento (id, valor, datahoraorcamento)
material (id, descricao)
orcamentosmateriais (id, quantidade, preco, #codorc, #codmat)
  codorc references orcamento (id)
  codmat references material (id)
homologado (id, #codass, #codaloc, #codmat, #codcoord)
  codass references assinatura (id)
  codaloc references alocacao (id)
  codmat references material (id)
  codcoord references coordenador (id)
local (id, andar, setor, sala)
alocacao (id, datahoraalocacao, #codlocal)
  codlocal references local (id)
assinatura (id, datahoraassinatura, #codfun)
  codfun references funcionario (id)
funcionario (id, nome, idade, salario, dataegresso, dataingresso)
projeto (id, brevedescricao, datahorainicio)
participacaoprojeto (id, datahorainicio, datahorafim, #codfun, #codproj)
  codfun references funcionario (id)
  codproj references projeto (id)
tarefa (id, brevedescricao, estado, prioridade, datahorainicial,
datahorafinal, #codproj, #codsubtar, #codfun)
  codfun references funcionario (id)
  codproj references projeto (id)
  codsubtar references tarefas (id)
coordenador (id, designacao, #codfun)
  codfun references funcionario (id)
coordenadorprojeto (id, #codcoord, #codproj)
  codcoord references coordenador (id)
  codproj references projeto (id)
programador (id, #codfun)
  codfun references funcionario (id)
linguagem (id, nome)
programadorlinguagem (id, dominio, #codprog, #codling)
  codprog references programador (id)
  codling references linguagem (id)
```

# Disciplina

INE5423-05208 (20142) - Banco de Dados I

# Instruções

Crie consultas em SQL, seguindo as seguites instruções (não esqueça de fornecer
o enunciado de sua consulta):

1. [ ] Crie uma consulta que teste duas colunas no WHERE, mas que selecione
outras duas. A cláusula WHERE deve possuir o operador BETWEEN.

* [ ] Crie uma consulta que acesse duas tabelas. A cláusula SELECT deve possuir
mais de dois atributos. A cláusula WHERE deve possuir AND e OR. A consulta deve
possuir três variantes:

  * [ ] Com operador de JOIN
  * [ ] Com operador de Produto Cartesiano
  * [ ] Com operador de IN

* [ ] Escreva e crie uma consulta que use <> ALL, e que envolva mais de uma tabela e mais de dois atributos na clásula SELECT.

* [ ] Crie uma consulta que acesse três tabelas sendo que uma delas deve ter
sido criada por causa de um relacionamento nn do modelo conceitual. A cláusula
SELECT deve possuir pelo menos um atributo de cada uma das tabelas relacionadas.
A cláusula where deve possuir pelo menos três filtros. A consulta deve ser feita
com operador de JOIN e possuir alguma função de agregação.

* [ ] Crie uma consutla, aninhada, com duas tabelas.

  * [ ] Usando o NOT IN
  * [ ] Usando o NOT EXISTS

A consulta mais interna deve possuir a cláusula WHERE, que por sua vez deve
possuir o operador IN. A consula deve possuir alguma função de agregação.

* [ ] Crie uma consulta, que acesse três tabelas, selecionando dois atributos
quaisquer e usando a função COUNT(). Utilize o ORDER BY e GROUP BY. A cláusula
WHERE deve possuir pelo menos dois filtros.

* [ ] Crie uma consulta, que acesse três tabelas que utilize o HAVING. A
cláusula WHERE deve possuir pelo menos dois filtros. O HAVING deve testar o
valor de retorno de uma função de agregação escrita em uma cláusula SELECT.
