# language: pt
@LLT85
Funcionalidade: 3 Dashboard empresarial

  @USID_034 @pagina @front @ADR_121 @ADR_122
  @LLT85_C12 @planejado
  Esquema do Cenário: 12 Mostrar consolidação autorizada da Empresa - <exemplo>
    Dado que a conta possui papel <papel> na Empresa Exemplo A e acesso empresarial confirmado pelo Core
    Quando abro o dashboard empresarial
    Então devo visualizar a consolidação e os detalhamentos por Produto que o Core devolveu para essa Empresa
    E nenhum dado ou contribuição da Empresa Exemplo B deve ser exibido
    E o Front não deve criar uma fórmula de agregação própria

    Exemplos:
      | exemplo | papel |
      | dono | DONO |
      | admin | ADMIN |


  @USID_034 @USID_036 @pagina @front @ADR_122
  @LLT85_C13 @planejado
  Cenário: 13 Restringir a consolidação aos Produtos permitidos
    Dado que Ana Exemplo é MEMBRO e tem AcessoProduto somente ao Alfa
    E o contrato autoriza sua visualização empresarial limitada ao Alfa
    Quando o Core devolve o dashboard desse recorte
    Então devo visualizar somente dados e opções de Produto permitidos na resposta
    E totais gráficos e exportação não devem incluir Gama nem Produto de outra Empresa
    E o teste não deve conceder permissão empresarial apenas por ser MEMBRO


  @USID_034 @USID_035 @pagina @front @contrato @ADR_126
  @LLT85_C14 @planejado
  Esquema do Cenário: 14 Tratar negação simples de acesso empresarial - <exemplo>
    Dado que a sessão é válida mas o Core não autoriza o contexto solicitado
    Quando a operação retorna negação simples por <motivo>
    Então devo voltar à área inicial e continuar logada
    E nenhum indicador detalhe ou arquivo do contexto recusado deve ficar disponível
    E não devo aplicar o logout global da ADR_032 por essa negação

    Exemplos:
      | exemplo | motivo |
      | Empresa | ausência de vínculo com a Empresa |
      | Produto | Produto de outro tenant ou sem AcessoProduto |


  @USID_034 @pagina @front
  @LLT85_C15 @planejado
  Cenário: 15 Abrir detalhamento do Produto selecionado
    Dado que o dashboard empresarial mostra Alfa e Gama autorizados
    Quando seleciono o detalhamento do Gama
    Então devo visualizar os dados do Gama retornados pelo Core
    E o contexto de Empresa deve permanecer Exemplo A
    E voltar à visão consolidada deve manter os filtros aplicados


  @USID_036 @pagina @front @ADR_121 @ADR_122
  @LLT85_C16 @planejado
  Esquema do Cenário: 16 Selecionar vários Produtos sem ampliar a autorização - <exemplo>
    Dado que o contrato disponibiliza seleção de Produtos permitidos na Empresa Exemplo A
    Quando aplico a seleção <selecao> com o período fictício
    Então a consulta deve usar somente os identificadores selecionados e autorizados
    E indicadores e legenda devem corresponder à resposta desse conjunto
    E selecionar todos significa somente os Produtos permitidos desse contexto

    Exemplos:
      | exemplo | selecao |
      | um Produto | Alfa |
      | dois Produtos | Alfa e Gama |
      | todos permitidos | todos os Produtos autorizados da Empresa Exemplo A |


  @USID_036 @pagina @front
  @LLT85_C17 @planejado
  Cenário: 17 Preservar filtros empresariais até alteração ou remoção
    Dado que apliquei período e seleção de Produtos no dashboard empresarial
    Quando consulto seus indicadores e detalhamentos sem alterar os filtros
    Então os critérios devem continuar identificáveis e ativos nessa navegação
    E uma consulta seguinte do mesmo estado deve usar esses critérios
    E o teste não deve exigir persistência entre dispositivos ou após logout
