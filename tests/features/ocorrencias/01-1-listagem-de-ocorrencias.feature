# language: pt
@LLT84
Funcionalidade: 1 Listagem de Ocorrências

  @USID_001 @pagina @front @criterio_front
  @LLT84_C01 @planejado
  Cenário: 01 Mostrar carregamento sem antecipar resultado
    Dado que Ana Exemplo abriu as Ocorrências do Produto Alfa autorizado
    Quando a consulta ao Core ainda não terminou
    Então devo perceber que a lista está carregando
    E não devo visualizar um estado vazio ou uma confirmação de sucesso antes da resposta
    E dados do Produto anteriormente selecionado não devem aparecer como dados do Produto Alfa


  @USID_001 @pagina @front @ADR_035 @ADR_062 @ADR_063
  @LLT84_C02 @planejado
  Esquema do Cenário: 02 Apresentar os registros e atributos retornados - <exemplo>
    Dado que o Core retorna uma Ocorrência fictícia do Produto Alfa com <tipo> e recorrente <recorrente>
    E a resposta inclui a gravidade já calculada pelo serviço de Ocorrência
    Quando a listagem termina de carregar
    Então devo visualizar o registro com seu tipo e os atributos disponibilizados pelo contrato
    E recorrência deve permanecer um atributo independente do tipo e do estado
    E o Front não deve recalcular a gravidade nem criar Ocorrência para SPAM

    Exemplos:
      | exemplo | tipo | recorrente |
      | erro novo | ERRO | false |
      | erro recorrente | ERRO | true |
      | warning novo | WARNING | false |
      | warning recorrente | WARNING | true |


  @USID_001 @pagina @front @criterio_front
  @LLT84_C03 @planejado
  Cenário: 03 Mostrar lista vazia do Produto autorizado
    Dado que Ana Exemplo pode acessar o Produto Alfa
    Quando o Core retorna uma consulta bem-sucedida sem Ocorrências
    Então devo visualizar uma indicação compreensível de ausência de registros
    E não devo visualizar registros fictícios de preenchimento como se fossem reais
    E não devo poder avançar para uma página de resultados inexistente


  @USID_001 @pagina @front @contrato @criterio_front
  @LLT84_C04 @planejado
  Esquema do Cenário: 04 Recuperar a listagem após falha - <exemplo>
    Dado que a consulta da listagem está em andamento
    Quando ocorre <falha>
    Então devo visualizar que não foi possível carregar os dados e ter uma forma de tentar novamente
    E a interface não deve confundir a falha com ausência de registros
    E o carregamento não deve permanecer indefinido

    Exemplos:
      | exemplo | falha |
      | rede | falha de conexão |
      | serviço | erro do Core sem resposta útil |


  @USID_001 @pagina @front @criterio_front
  @LLT84_C05 @planejado
  Cenário: 05 Ignorar resposta atrasada de outro Produto
    Dado que a consulta ao Produto Alfa ainda está em andamento
    E Ana Exemplo possui acesso também ao Produto Gama da mesma Empresa
    Quando seleciono o Produto Gama e a resposta do Alfa chega por último
    Então devo continuar vendo somente o contexto e os dados do Produto Gama
    E a resposta atrasada não deve repor dados ou contadores do Produto Alfa
