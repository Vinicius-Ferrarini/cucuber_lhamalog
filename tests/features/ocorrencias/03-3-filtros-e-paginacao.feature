# language: pt
@LLT84
Funcionalidade: 3 Filtros e paginação

  @USID_005 @pagina @front
  @LLT84_C12 @planejado
  Esquema do Cenário: 12 Aplicar um filtro suportado - <exemplo>
    Dado que estou na listagem do Produto Alfa
    E a fixture contém registros que atendem e que não atendem ao filtro <filtro>
    Quando aplico <filtro>
    Então devo visualizar somente os resultados devolvidos para esse critério
    E a consulta deve começar na primeira página com total e navegação coerentes com a resposta

    Exemplos:
      | exemplo | filtro |
      | período | intervalo fictício de datas suportado |
      | tipo | tipo ERRO |
      | estado | estado ABERTA |
      | aplicação | nome ou aplicação admitido no contrato |


  @USID_005 @pagina @front
  @LLT84_C13 @planejado
  Esquema do Cenário: 13 Combinar filtros na mesma consulta - <exemplo>
    Dado que a fixture contém registros que atendem apenas parte dos critérios
    Quando aplico a combinação <combinacao>
    Então a consulta deve transmitir conjuntamente os critérios ao Core
    E devo visualizar apenas os resultados que a resposta identifica para essa combinação
    E o contexto autorizado de Empresa e Produto deve ser preservado

    Exemplos:
      | exemplo | combinacao |
      | data e tipo | período fictício e ERRO |
      | tipo e estado | WARNING e ABERTA |
      | três critérios | período fictício ERRO e EM_ANALISE |


  @USID_005 @pagina @front
  @LLT84_C14 @planejado
  Cenário: 14 Mostrar ausência de resultados filtrados
    Dado que apliquei filtros válidos no Produto Alfa
    Quando o Core informa total zero
    Então devo visualizar que não há Ocorrências para os filtros aplicados
    E os filtros devem continuar disponíveis para correção ou limpeza
    E os controles para avançar em resultados inexistentes devem estar ocultos ou indisponíveis


  @USID_005 @pagina @front
  @LLT84_C15 @planejado
  Cenário: 15 Limpar filtros e retornar à primeira página
    Dado que estou em outra página com uma pesquisa e filtros ativos
    Quando aciono a limpeza dos filtros
    Então os critérios devem ser removidos e a lista sem filtros deve ser consultada na primeira página
    E a Empresa e o Produto autorizados devem permanecer selecionados
    E totais e navegação devem corresponder à nova resposta


  @USID_005 @pagina @front
  @LLT84_C16 @planejado
  Esquema do Cenário: 16 Navegar mantendo os filtros ativos - <exemplo>
    Dado que há várias páginas de resultados com filtros ativos
    Quando aciono <controle>
    Então a requisição da página solicitada deve manter os mesmos critérios e contexto autorizado
    E devo visualizar os itens e a indicação de página retornados sem misturar páginas

    Exemplos:
      | exemplo | controle |
      | avançar | próxima página |
      | voltar | página anterior |
      | escolher | número de página disponível |


  @USID_005 @pagina @front
  @LLT84_C17 @planejado
  Esquema do Cenário: 17 Alterar a quantidade por página sem perder filtros - <exemplo>
    Dado que a fixture do contrato disponibiliza as opções de quantidade 10 e 50
    E estou em uma página posterior com filtros ativos
    Quando escolho a quantidade <quantidade>
    Então a consulta deve retornar à primeira página usando essa quantidade e os filtros ativos
    E o total de páginas e o intervalo exibido devem refletir a resposta

    Exemplos:
      | exemplo | quantidade |
      | menor quantidade | 10 |
      | maior quantidade | 50 |


  @USID_005 @componente @front @criterio_front
  @LLT84_C18 @planejado
  Esquema do Cenário: 18 Impedir envio normal de filtro inválido - <exemplo>
    Dado que o formulário recebe <entrada> inválida segundo o contrato da operação
    Quando tento aplicar os filtros
    Então devo visualizar uma orientação associada ao campo
    E a consulta inválida não deve ser enviada pelo caminho normal da interface
    E devo poder corrigir o valor sem perder o contexto autorizado

    Exemplos:
      | exemplo | entrada |
      | intervalo invertido | data inicial posterior à final |
      | formato inválido | valor que não representa uma data válida |


  @USID_002 @USID_005 @pagina @front @criterio_front
  @LLT84_C19 @planejado
  Cenário: 19 Manter o resultado da última consulta solicitada
    Dado que solicitei uma busca e depois alterei o termo ou os filtros
    Quando a resposta da consulta mais antiga chega após a resposta mais recente
    Então devo continuar vendo os critérios e resultados da última consulta solicitada
    E totais e paginação antigos não devem sobrescrever o estado atual
