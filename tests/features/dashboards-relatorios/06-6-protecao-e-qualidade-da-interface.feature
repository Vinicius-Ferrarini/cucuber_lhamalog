# language: pt
@LLT85
Funcionalidade: 6 Proteção e qualidade da interface

  @USID_031 @USID_034 @pagina @front @contrato @ADR_032
  @LLT85_C32 @planejado
  Esquema do Cenário: 32 Tratar sessão inválida e revogação conforme a operação - <exemplo>
    Dado que uma consulta ou exportação está em andamento
    Quando a operação retorna <retorno>
    Então devo visualizar Você foi deslogado e retornar ao SignIn sem manter conteúdo protegido
    E o tratamento não deve depender de uma mensagem no corpo
    E esse caso não deve ser confundido com a negação simples da ADR_126

    Exemplos:
      | exemplo | retorno |
      | sessão inválida | 401 do Core |
      | revogação aplicável | 403 classificado pelo contrato como revogação da ADR_032 |


  @USID_031 @USID_034 @USID_036 @pagina @front @contrato @criterio_front
  @LLT85_C33 @planejado
  Esquema do Cenário: 33 Tratar resposta inesperada sem fabricar indicadores - <exemplo>
    Dado que uma consulta de dashboard aguarda resposta
    Quando a fronteira consumida retorna <resposta> fora do contrato
    Então devo visualizar orientação geral de falha sem travar nem mostrar null ou undefined
    E não devo apresentar indicadores antigos como atuais nem fabricar zero para preencher dados ausentes
    E devo poder recuperar a consulta sem perder a identificação do contexto autorizado

    Exemplos:
      | exemplo | resposta |
      | nulo | null |
      | vazio | corpo vazio quando é exigido conteúdo |
      | estrutura inválida | JSON inválido ou HTML inesperado |
      | sucesso incompleto | HTTP 200 sem os campos exigidos do dashboard |
      | erro desconhecido | erro sem causa reconhecida pelo contrato |


  @USID_031 @USID_032 @USID_033 @USID_036 @USID_037 @pagina @front @criterio_front
  @LLT85_C34 @planejado
  Esquema do Cenário: 34 Operar ações essenciais somente pelo teclado - <exemplo>
    Dado que utilizo a interface somente pelo teclado
    Quando realizo <acao>
    Então os controles necessários devem ser alcançáveis com foco visível e ordem compreensível
    E uma janela de exportação deve manter foco útil e devolvê-lo ao controle de origem ao fechar
    E a ação não deve depender do mouse

    Exemplos:
      | exemplo | acao |
      | filtros | selecionar Produto e aplicar critérios |
      | exportação | escolher formato e confirmar ou desistir |
      | consulta empresarial | alterar seleção de Produtos e consultar resultados |


  @USID_031 @USID_032 @USID_033 @componente @front @criterio_front
  @LLT85_C35 @planejado
  Esquema do Cenário: 35 Identificar indicadores controles e erros de forma acessível - <exemplo>
    Dado que verifico <elemento> no componente do LhamaLog
    Quando consulto o nome acessível e a leitura assistiva
    Então devo compreender <informacao> sem depender somente de cor ícone ou placeholder
    E os resultados devem ser confirmados na página real com tecnologia assistiva

    Exemplos:
      | exemplo | elemento | informacao |
      | indicador | card ou representação do gráfico | nome unidade e valor ou alternativa textual equivalente |
      | filtro | campo de data com erro | qual campo corrigir e por quê |
      | exportação | controle de geração | ação disponível e estado de processamento |


  @USID_031 @USID_033 @USID_034 @pagina @front @criterio_front
  @LLT85_C36 @planejado
  Esquema do Cenário: 36 Manter dashboard e exportação operáveis com zoom - <exemplo>
    Dado que abro <tela> nas condições <condicoes>
    Quando consulto dados e percorro os controles
    Então rótulos valores filtros botões e foco devem permanecer legíveis e alcançáveis
    E nenhum controle necessário deve ficar cortado ou sobreposto
    E gráficos devem ter acesso aos seus dados sem exigir somente precisão de ponteiro

    Exemplos:
      | exemplo | tela | condicoes |
      | estreita | dashboard por Produto | viewport 360 por 800 e zoom 100 por cento |
      | ampliada | dashboard empresarial | viewport 1280 por 800 e zoom 200 por cento |
      | modal | configuração de exportação | viewport 1280 por 800 e zoom 200 por cento |
