(ง •̀_•́)ง

# Autores

- [Lucas Tonussi](https://github.com/tonussi/) :rocket:

- [Thiago Rose](https://github.com/thisenrose/) :black_joker:

# Esquema conceitual

```sql
orcamento (_id, valor, data)
material (_id, descricao)
orcamentos_materiais (_id, quantidade, preco, #codOrc, #codMat)
  codOrc references orcamento (id)
  codMat references material (id)
homologado (_id, #codAss, #codAloc, #codMat)
  codAss references assinatura (id)
  codAloc references alocacao (id)
  codMat references material (id)
local (_id, andar, setor, numero)
alocacao (_id, data_alocacao, #codLocal, #codHom)
  codLocal references local (id)
  codHom references homologado (id)
assinatura (_id, data_assinatura, #codFun, #codHomo)
  codFun references funcionario (id)
  codHomo references homologado (id)
funcionario (_id, nome, idade, salario, data_egresso, data_ingresso)
projeto (_id, breve_descricao, data_inicio)
participacao_projeto (_id, data_inicio, data_fim, #codFun, #codProj)
  codFun references funcionario (id)
  codProj references projeto (id)
tarefa (_id, _#codProj, breve_descricao, estado, prioridade, datahorainicial, datahorafinal, #codSubtar)
  codProj references projeto (id)
  codSubtar references tarefas (id, codProj)
coordenador (_id, designacao, _#codFun)
  codFun references funcionario (id)
coordenador_projeto (_#codCoord, _#codProj)
  codCoord references coordenador (id)
  codProj references projeto (id)
programador (_id, _#codFun)
  codFun references funcionario (id)
linguagem (_id, nome)
programador_linguagem (_id, dominio, #codProg, #codLing)
  codProg references programador (id, codFun)
  codLing references linguagem (id)
```

# Disciplina

INE5423-05208 (20142) - Banco de Dados I

# Instruções

Crie consultas em SQL, seguindo as seguites instruções (não esqueça de fornecer
o enunciado de sua consulta):

1. Crie uma consulta que teste duas colunas no WHERE, mas que selecione outras
duas. A cláusula WHERE deve possuir o operador BETWEEN.

2. Crie uma consulta que acesse duas tabelas. A cláusula SELECT deve possuir
mais de dois atributos. A cláusula WHERE deve possuir AND e OR. A consulta deve
possuir três variantes:

- Com operador de JOIN
- Com operador de Produto Cartesiano
- Com operador de IN

3. Escreva e crie uma consulta que use <> ALL, e que envolva mais de uma tabela
e mais de dois atributos na clásula SELECT.

4. Crie uma consulta que acesse três tabelas sendo que uma delas deve ter sido
criada por causa de um relacionamento n_n do modelo conceitual. A cláusula
SELECT deve possuir pelo menos um atributo de cada uma das tabelas relacionadas.
A cláusula where deve possuir pelo menos três filtros. A consulta deve ser feita
com operador de JOIN e possuir alguma função de agregação.

5. Crie uma consutla, aninhada, com duas tabelas.

- Usando o NOT IN - Usando o NOT EXISTS

A consulta mais interna deve possuir a cláusula WHERE, que por sua vez deve
possuir o operador IN. A consula deve possuir alguma função de agregação.

6. Crie uma consulta, que acesse três tabelas, selecionando dois atributos
quaisquer e usando a função COUNT(). Utilize o ORDER BY e GROUP BY. A cláusula
WHERE deve possuir pelo menos dois filtros.

7. Crie uma consulta, que acesse três tabelas que utilize o HAVING. A cláusula
WHERE deve possuir pelo menos dois filtros. O HAVING deve testar o valor de
retorno de uma função de agregação escrita em uma cláusula SELECT.
