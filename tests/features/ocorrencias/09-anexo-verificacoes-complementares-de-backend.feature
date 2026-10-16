# language: pt
@LLT84
Funcionalidade: Anexo Verificações complementares de backend

  @USID_001 @USID_002 @USID_003 @USID_004 @api @core @ADR_121 @ADR_122 @ADR_126
  @LLT84_C39 @planejado
  Esquema do Cenário: 39 Recusar consulta ou mutação fora do contexto autorizado - <exemplo>
    Dado que uso uma sessão real de teste sem autorização para o alvo
    Quando envio diretamente uma operação de <operacao> com identificador de outra Empresa ou Produto sem acesso
    Então o Core deve recusar sem devolver dados nem modificar registros
    E a recusa deve seguir o contrato de negação simples sem revogar a sessão por esse motivo

    Exemplos:
      | exemplo | operacao |
      | consulta | consulta de lista ou detalhe |
      | marcação | mudança de estado |
      | arquivo | arquivamento |


  @USID_003 @api @core @ADR_082 @ADR_089 @ADR_090
  @LLT84_C40 @planejado
  Esquema do Cenário: 40 Validar restrições de transição sem depender do formulário - <exemplo>
    Dado que a fixture real prepara <situacao>
    Quando envio diretamente a mudança <transicao> ao Core
    Então devo observar <resultado> ao consultar novamente o registro
    E o formulário não deve ser a única proteção da regra

    Exemplos:
      | exemplo | situacao | transicao | resultado |
      | transição não permitida | Ocorrência FECHADA | FECHADA para EM_ANALISE | recusa sem alterar o estado |
      | Sugestão aberta | Ocorrência EM_ANALISE com Sugestão válida não FECHADA | EM_ANALISE para FECHADA | recusa sem alterar o estado |
      | falha manual excluída | Ocorrência ABERTA com somente Sugestão manual em FALHA | ABERTA para FECHADA | fechamento permitido sem tratar a falha como dependência |


  @USID_005 @api @core @criterio_front
  @LLT84_C41 @planejado
  Esquema do Cenário: 41 Validar parâmetros de consulta diretamente na API - <exemplo>
    Dado que identifiquei a operação real de consulta e seus parâmetros documentados
    Quando envio diretamente <entrada> fora desse contrato sem passar pelo formulário
    Então o Core deve recusar conforme o contrato sem produzir consulta irrestrita ou dados de outro contexto
    E o resultado deve ser verificado na resposta real do serviço

    Exemplos:
      | exemplo | entrada |
      | período | intervalo inicial posterior ao final |
      | paginação | tipo inválido no parâmetro de paginação exigido |
      | tipo | valor de filtro fora do conjunto aceito pela operação |
