# language: pt
@LLT84
Funcionalidade: 4 Marcação do estado

  @USID_003 @pagina @front @ADR_082
  @LLT84_C20 @planejado
  Esquema do Cenário: 20 Confirmar transição manual permitida - <exemplo>
    Dado que o contexto de teste não possui recurso de IA e autoriza a mudança manual
    E a Ocorrência está em <origem>
    Quando seleciono <destino> e confirmo a alteração
    Então devo enviar a mudança do registro selecionado ao Core
    E após confirmação de sucesso devo visualizar <destino> e uma indicação de conclusão
    E a interface não deve mudar a recorrência como consequência da marcação

    Exemplos:
      | exemplo | origem | destino |
      | iniciar análise | ABERTA | EM_ANALISE |
      | fechar aberta | ABERTA | FECHADA |
      | concluir análise | EM_ANALISE | FECHADA |
      | reabrir | FECHADA | ABERTA |


  @USID_003 @pagina @front
  @LLT84_C21 @planejado
  Cenário: 21 Cancelar mudança sem alterar a Ocorrência
    Dado que abri a seleção de estado para uma Ocorrência
    Quando desisto da alteração antes de confirmar
    Então o estado original deve permanecer na interface
    E nenhuma requisição de mudança deve ser enviada
    E devo continuar podendo consultar a Ocorrência


  @USID_003 @pagina @front @contrato @ADR_089
  @LLT84_C22 @planejado
  Cenário: 22 Tratar recusa de fechamento com Sugestão não finalizada
    Dado que a Ocorrência está EM_ANALISE com uma Sugestão válida não FECHADA
    Quando o Core recusa a tentativa de fechamento por essa regra
    Então devo visualizar que a alteração não foi concluída
    E o estado EM_ANALISE deve permanecer sem confirmação falsa de fechamento
    E devo poder continuar consultando a Ocorrência e suas Sugestões


  @USID_001 @USID_002 @pagina @front @ADR_089 @ADR_090
  @LLT84_C23 @planejado
  Esquema do Cenário: 23 Refletir o estado recebido no fluxo de Sugestão - <exemplo>
    Dado que consultei uma Ocorrência ABERTA no fluxo <fluxo>
    Quando o Core devolve <situacao> e o estado <estado>
    Então devo visualizar <estado> sem antecipar transição por conta própria
    E uma Sugestão manual em FALHA não deve ser exibida como item de Sugestão nem bloquear fechamento

    Exemplos:
      | exemplo | fluxo | situacao | estado |
      | solicitação | manual | Sugestão somente solicitada ou enfileirada | ABERTA |
      | disponível | manual ou automático | Sugestão concluída e visível como DISPONIVEL | EM_ANALISE |
      | falha manual | manual | Sugestão com falha | ABERTA |


  @USID_003 @pagina @front @contrato
  @LLT84_C24 @planejado
  Esquema do Cenário: 24 Não confirmar gravação após falha ou timeout - <exemplo>
    Dado que confirmei uma mudança de estado
    Quando ocorre <falha> sem confirmação de gravação
    Então não devo visualizar sucesso nem assumir o novo estado como confirmado
    E devo receber orientação para recuperar a consulta ou tentar novamente
    E uma nova leitura deve reconciliar o estado com o Core antes de tratá-lo como definitivo

    Exemplos:
      | exemplo | falha |
      | rede | falha de conexão |
      | timeout | tempo de espera excedido |
