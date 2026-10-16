# language: pt
@LLT84
Funcionalidade: 8 Integração real do Front

  @USID_001 @USID_002 @USID_005 @integracao @ADR_101 @ADR_141
  @LLT84_C36 @planejado
  Esquema do Cenário: 36 Consultar o Core com contexto e filtros reais - <exemplo>
    Dado que o ambiente real de teste contém Ocorrências fictícias no Produto Alfa autorizado
    Quando consulto <recorte> pela interface Web
    Então as chamadas de negócio devem ir ao Core com a sessão e o contexto corretos
    E a lista e o detalhe devem corresponder aos registros reais de teste e aos filtros aplicados
    E nenhum serviço interno nem banco deve ser acessado diretamente pelo navegador

    Exemplos:
      | exemplo | recorte |
      | Produto | Ocorrências do Produto |
      | lote | Ocorrências de um lote quando a navegação oferece esse recorte |
      | arquivo | Ocorrências de um arquivo quando a navegação oferece esse recorte |


  @USID_003 @integracao @ADR_082 @ADR_089
  @LLT84_C37 @planejado
  Cenário: 37 Persistir e reler uma mudança de estado válida
    Dado que o ambiente autoriza a mudança manual e a Ocorrência ABERTA não tem Sugestões que impeçam fechamento
    Quando altero para FECHADA pela interface e o Core confirma
    E recarrego o detalhe por uma nova consulta
    Então devo visualizar FECHADA persistida no mesmo registro
    E a evidência deve comprovar a gravação real sem usar a resposta simulada do teste de página


  @USID_004 @integracao
  @LLT84_C38 @planejado
  Cenário: 38 Arquivar e reler a lista ativa real
    Dado que a operação real de arquivamento está disponibilizada pelo contrato do Core no ambiente de teste
    E existem registros fictícios autorizados que podem ser arquivados
    Quando confirmo o arquivamento pela tela e consulto novamente a lista ativa
    Então os registros confirmados como arquivados não devem integrar essa lista
    E registros não selecionados devem permanecer conforme a consulta
    E o teste não deve deduzir a representação interna do arquivamento
