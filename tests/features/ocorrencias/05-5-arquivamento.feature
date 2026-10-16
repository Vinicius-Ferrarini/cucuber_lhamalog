# language: pt
@LLT84
Funcionalidade: 5 Arquivamento

  @USID_004 @pagina @front
  @LLT84_C25 @planejado
  Esquema do Cenário: 25 Confirmar arquivamento individual - <exemplo>
    Dado que uma Ocorrência autorizada está acessível em <origem>
    Quando aciono Arquivar
    Então devo visualizar uma confirmação que identifica a Ocorrência antes de enviar a mudança
    Quando confirmo e o Core confirma o arquivamento
    Então a Ocorrência não deve permanecer na lista ativa
    E devo perceber a conclusão sem excluir definitivamente o registro nem criar um estado de ciclo de vida ARQUIVADA

    Exemplos:
      | exemplo | origem |
      | pela lista | listagem |
      | pelo detalhe | detalhe |


  @USID_004 @pagina @front
  @LLT84_C26 @planejado
  Esquema do Cenário: 26 Cancelar arquivamento individual ou em lote - <exemplo>
    Dado que a confirmação de arquivamento está aberta para <alvo>
    Quando aciono Cancelar
    Então a confirmação deve fechar sem enviar a alteração
    E os registros devem permanecer inalterados na lista ativa

    Exemplos:
      | exemplo | alvo |
      | individual | Ocorrência Exemplo 01 |
      | lote | Ocorrências Exemplo 01 e 02 selecionadas |


  @USID_004 @pagina @front
  @LLT84_C27 @planejado
  Cenário: 27 Arquivar somente os registros selecionados
    Dado que selecionei Ocorrências Exemplo 01 e 02 e deixei Exemplo 03 sem seleção
    Quando aciono Arquivar Selecionadas
    Então devo visualizar confirmação para os dois registros selecionados
    Quando confirmo e o Core confirma os dois resultados
    Então somente Exemplo 01 e 02 devem sair da lista ativa
    E Exemplo 03 deve permanecer sem alteração
    E o total e a página devem ser reconciliados com uma nova consulta válida


  @USID_004 @pagina @front @contrato @criterio_front
  @LLT84_C28 @planejado
  Esquema do Cenário: 28 Tratar falha de arquivamento sem ocultar sucesso inexistente - <exemplo>
    Dado que confirmei o arquivamento de <alvo>
    Quando o Core recusa a operação ou não confirma sua conclusão
    Então não devo anunciar arquivamento concluído nem remover definitivamente os registros da interface
    E devo poder atualizar a consulta para conhecer o estado efetivo
    E resultados por item só devem ser usados se forem fornecidos pelo contrato real

    Exemplos:
      | exemplo | alvo |
      | individual | um registro |
      | lote | dois registros selecionados |


  @USID_003 @USID_004 @pagina @front @criterio_front
  @LLT84_C29 @planejado
  Esquema do Cenário: 29 Evitar confirmação duplicada de mutação - <exemplo>
    Dado que uma solicitação de <operacao> aguarda resposta
    Quando aciono novamente a confirmação na interface
    Então o Front não deve disparar outra solicitação simultânea idêntica pelo mesmo controle
    E devo perceber o processamento e conseguir recuperar a interface após a resposta

    Exemplos:
      | exemplo | operacao |
      | marcação | mudança de estado |
      | arquivamento | arquivamento |
