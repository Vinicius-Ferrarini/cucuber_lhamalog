# language: pt
@LLT85
Funcionalidade: 1 Dashboard por Produto

  @USID_031 @pagina @front @criterio_front
  @LLT85_C01 @planejado
  Cenário: 01 Aguardar carregamento sem antecipar indicadores
    Dado que abri o dashboard do Produto Alfa autorizado
    Quando a consulta ao Core está em andamento
    Então devo perceber que os indicadores estão carregando
    E a interface não deve apresentar ausência de dados ou zero como resultado confirmado
    E métricas do Produto anterior não devem ser identificadas como métricas do Alfa


  @USID_031 @pagina @front @ADR_121 @ADR_122
  @LLT85_C02 @planejado
  Esquema do Cenário: 02 Selecionar somente um Produto autorizado - <exemplo>
    Dado que a conta de teste possui papel <papel> na Empresa Exemplo A
    E o Core retorna os Produtos permitidos para essa conta
    Quando seleciono o Produto Alfa na interface
    Então a consulta e os indicadores devem usar a Empresa Exemplo A e o Produto Alfa
    E o seletor não deve oferecer como permitido o Produto Beta de outra Empresa

    Exemplos:
      | exemplo | papel |
      | proprietário | DONO |
      | administrador | ADMIN |
      | membro com acesso | MEMBRO com AcessoProduto para Alfa |


  @USID_031 @componente @front @criterio_front
  @LLT85_C03 @planejado
  Esquema do Cenário: 03 Representar valores recebidos sem inventar métricas - <exemplo>
    Dado que o contrato identifica um indicador e sua unidade
    Quando a resposta controlada contém <valor>
    Então devo visualizar <resultado> associado ao indicador correto
    E o componente não deve recalcular fórmula nem confundir dado ausente com zero
    E o nome e a unidade devem permanecer coerentes com o contrato

    Exemplos:
      | exemplo | valor | resultado |
      | positivo | quantidade válida 12 | a quantidade 12 |
      | zero real | quantidade válida 0 | zero como valor válido |
      | não disponível | ausência permitida pelo contrato | indicação de indisponibilidade sem fabricar zero |


  @USID_031 @pagina @front @criterio_front
  @LLT85_C04 @planejado
  Cenário: 04 Apresentar ausência de dados coletados
    Dado que o Produto Alfa está autorizado mas não possui dados no recorte consultado
    Quando o Core retorna sucesso indicando ausência de dados
    Então devo visualizar que não há dados para esse recorte
    E o Produto e o período devem permanecer identificáveis
    E a interface não deve mostrar dados de demonstração nem erro de rede para essa condição


  @USID_031 @pagina @front @criterio_front
  @LLT85_C05 @planejado
  Cenário: 05 Ignorar métricas atrasadas de outro Produto
    Dado que solicitei o dashboard do Alfa e depois selecionei o Produto Gama autorizado
    Quando a resposta do Alfa chega após a resposta do Gama
    Então devo continuar vendo apenas o contexto e os indicadores do Gama
    E títulos gráficos totais e opções de exportação não devem ser repostos para Alfa


  @USID_031 @pagina @front @contrato @criterio_front
  @LLT85_C06 @planejado
  Esquema do Cenário: 06 Recuperar o dashboard após falha de carregamento - <exemplo>
    Dado que uma consulta de indicadores está em andamento
    Quando ocorre <falha>
    Então devo visualizar uma orientação de falha e poder tentar novamente
    E o carregamento não deve continuar indefinido
    E a falha não deve ser apresentada como ausência de dados

    Exemplos:
      | exemplo | falha |
      | conexão | interrupção de rede |
      | serviço | erro do Core sem dados úteis |
