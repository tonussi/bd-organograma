Windows        | Mac/Linux
-------------- | ------------
               |

# Atelopus Varius

![Atelopus Varius](http://upload.wikimedia.org/wikipedia/commons/0/0a/Atelopus_varius_1.jpg)

The Costa Rican Variable Harlequin Toad (Atelopus varius), also known as the clown frog, is a neo-tropical true toad from the family Bufonidae (Crump 1986). Once ranging from Costa Rica to Panama, A. varius is now listed as critically endangered and has been reduced to a single remnant population near Quepos, Costa Rica (rediscovered in 2003) and is presumed to be extinct in Panama (IUCN).

# Autores

[Lucas Tonuss](https://github.com/tonussi/)

[Thiago Rose](https://github.com/thisenrose/)

# Esquema conceitual

```sql
orcamento             (_id, valor, data)
material              (_id, descricao)
orcamentos_materiais  (_id, quantidade, preco, #codOrc, #codMat)
  codOrc references orcamento (id)
  codMat references material (id)
homologado            (_id, #codAss, #codAloc, #codMat)
  codAss references assinatura (id)
  codAloc references alocacao (id)
  codMat references material (id)
local                 (_id, andar, setor, numero)
alocacao              (_id, data_alocacao, #codLocal, #codHom)
  codLocal references local (id)
  codHom references homologado (id)
assinatura            (_id, data_assinatura, #codFun, #codHomo)
  codFun references funcionario (id)
  codHomo refenrences homologado (id)
funcionario           (_id, nome, idade, salario, data_egresso, data_ingresso)
projeto               (_id, breve_descricao, data_inicio)
participacao_projeto  (_id, data_inicio, data_fim, #codFun, #codProj)
  codFun references funcionario (id)
  codProj references projeto (id)
tarefa                (_id, _#codProj, breve_descricao, estado, prioridade, tempo_gasto)
  codProj references projeto (id)
  codSubtar references subtarefas (id)
subtarefas (_id, breve_descricao, estado, prioridade, tempo_gasto)
  codTar references tarefa (id, codProj)
coordenador           (_id, designacao, _#codFun)
  references funcionario (id)
coordenador_projeto (_#codCoord, _#codProj)
  codCoord references coordenador (id)
  codProj references projeto (id)
programador           (_id, _#codFun)
  codFun references funcionario (id)
linguagem             (_id, nome)
programador_linguagem (_id, dominio, #codProg, #codLing)
  codProg references programador (id, codFun)
  codLing references linguagem (id)
```

# Entregas

INE5423-05208 (20142) - Banco de Dados I
