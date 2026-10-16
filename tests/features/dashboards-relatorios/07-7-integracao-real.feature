# language: pt
@LLT85
Funcionalidade: 7 Integração real

  @USID_031 @USID_032 @USID_034 @USID_036 @integracao @ADR_141
  @LLT85_C37 @planejado
  Esquema do Cenário: 37 Consultar dados reais de teste pelo Core - <exemplo>
    Dado que o Core real de teste contém dados fictícios do recorte <escopo>
    Quando aplico critérios válidos pela interface Web
    Então as chamadas de negócio devem ir ao Core com sessão Empresa e Produtos corretos
    E indicadores e gráficos devem corresponder aos valores e unidades devolvidos para essa consulta
    E a evidência deve identificar o contrato usado sem declarar validada uma fórmula de agregação não especificada

    Exemplos:
      | exemplo | escopo |
      | Produto | Produto Alfa |
      | Empresa | Empresa Exemplo A com Alfa e Gama autorizados |


  @USID_033 @USID_035 @integracao @ADR_121 @ADR_122
  @LLT85_C38 @planejado
  Esquema do Cenário: 38 Conferir o conteúdo do relatório gerado - <exemplo>
    Dado que a operação real oferece um formato de exportação documentado para <escopo>
    E registrei os filtros confirmados e os dados fictícios de referência desse recorte
    Quando confirmo e obtenho o arquivo real gerado
    Então o arquivo deve corresponder ao formato e aos filtros da solicitação
    E seus dados devem pertencer apenas à Empresa e aos Produtos autorizados no recorte
    E devo conferir o conteúdo do arquivo e não somente sua extensão ou presença de um link
    E a geração deve ter o registro de exportação previsto na fonte comprovado em evidência do serviço

    Exemplos:
      | exemplo | escopo |
      | Produto | Produto Alfa |
      | Empresa | Empresa Exemplo A com Alfa e Gama |


  @USID_033 @USID_035 @integracao
  @LLT85_C39 @planejado
  Esquema do Cenário: 39 Comprovar o cancelamento real da geração - <exemplo>
    Dado que a operação de <escopo> oferece cancelamento documentado no ambiente de teste
    E uma tarefa de geração fictícia está em andamento
    Quando solicito o cancelamento pela interface
    Então o serviço deve confirmar a interrupção conforme seu contrato e a tela deve retornar ao dashboard
    E a evidência deve demonstrar o resultado da tarefa sem usar apenas o fechamento da janela como prova

    Exemplos:
      | exemplo | escopo |
      | Produto | relatório do Produto Alfa |
      | Empresa quando suportado | relatório empresarial |
