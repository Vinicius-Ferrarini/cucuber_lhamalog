# language: pt
@LLT84
Funcionalidade: 2 Busca e detalhe

  @USID_002 @pagina @front
  @LLT84_C06 @planejado
  Esquema do Cenário: 06 Buscar Ocorrência por parâmetro suportado - <exemplo>
    Dado que a lista do Produto Alfa está carregada
    E a fixture de consulta associa <entrada> à Ocorrência Exemplo 01
    Quando informo <entrada> na pesquisa e aciono a busca
    Então devo visualizar o resultado correspondente retornado pelo Core
    E a pesquisa deve permanecer limitada ao Produto e à Empresa autorizados

    Exemplos:
      | exemplo | entrada |
      | identificador | identificador fictício OC-EX-01 |
      | texto | termo fictício FalhaExemplo |


  @USID_002 @pagina @front
  @LLT84_C07 @planejado
  Cenário: 07 Informar consulta sem correspondência
    Dado que pesquiso um termo fictício inexistente no contexto autorizado
    Quando o Core retorna sucesso sem correspondência
    Então devo entender que nenhuma Ocorrência foi encontrada para a consulta
    E devo poder alterar ou limpar o termo para pesquisar novamente
    E a interface não deve mostrar esse resultado como erro de comunicação


  @USID_002 @pagina @front @ADR_035
  @LLT84_C08 @planejado
  Esquema do Cenário: 08 Abrir o detalhe do registro selecionado - <exemplo>
    Dado que a listagem contém <ocorrencia> do Produto Alfa
    E a resposta controlada do detalhe pertence a esse mesmo registro
    Quando seleciono <ocorrencia>
    Então devo visualizar o detalhe correspondente ao identificador selecionado
    E não devo receber o detalhe de outra Ocorrência nem um resumo de Arquivo como substituto

    Exemplos:
      | exemplo | ocorrencia |
      | primeiro registro | Ocorrência Exemplo 01 |
      | segundo registro | Ocorrência Exemplo 02 |


  @USID_002 @pagina @front
  @LLT84_C09 @planejado
  Esquema do Cenário: 09 Consultar as abas de dados técnicos - <exemplo>
    Dado que o detalhe da Ocorrência Exemplo 01 foi carregado com dados fictícios
    Quando abro a aba <aba>
    Então devo visualizar <conteudo> do registro selecionado conforme o contrato
    E a troca de aba não deve misturar dados de outra Ocorrência
    E o texto técnico deve ser apresentado como dado sem executar HTML ou script contido na fixture

    Exemplos:
      | exemplo | aba | conteudo |
      | resumo | Visão geral | data e hora e endpoint retornados |
      | pilha | Stack trace | stack trace fictício |
      | corpo | Payload | payload fictício |


  @USID_002 @USID_005 @pagina @front
  @LLT84_C10 @planejado
  Cenário: 10 Voltar ao estado anterior da consulta
    Dado que abri um detalhe a partir de uma pesquisa com filtros e página definidos
    Quando encerro a visualização do detalhe
    Então devo retornar à consulta com o termo os filtros e a página anteriores
    E os registros devem continuar pertencendo ao mesmo contexto autorizado


  @USID_002 @pagina @front @contrato @criterio_front
  @LLT84_C11 @planejado
  Esquema do Cenário: 11 Tratar detalhe indisponível sem mostrar outro registro - <exemplo>
    Dado que solicitei um detalhe autorizado
    Quando o Core informa <resposta>
    Então devo visualizar uma orientação compatível com essa resposta sem dados de outro registro
    E devo poder retornar à consulta
    E não devo reutilizar um detalhe anterior como se fosse o solicitado

    Exemplos:
      | exemplo | resposta |
      | não localizado | registro não encontrado conforme contrato |
      | falha | falha de carregamento do detalhe |
