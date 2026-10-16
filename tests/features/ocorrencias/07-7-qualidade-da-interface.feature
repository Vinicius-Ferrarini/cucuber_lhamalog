# language: pt
@LLT84
Funcionalidade: 7 Qualidade da interface

  @USID_001 @USID_002 @USID_004 @USID_005 @pagina @front @criterio_front
  @LLT84_C33 @planejado
  Esquema do Cenário: 33 Operar ações essenciais pelo teclado - <exemplo>
    Dado que utilizo a tela somente pelo teclado
    Quando percorro os controles e realizo <acao>
    Então devo conseguir executar a ação sem mouse com foco visível e ordem compreensível
    E uma confirmação modal deve manter foco útil e devolvê-lo ao controle de origem ao cancelar
    E nenhum foco deve permanecer preso em elemento oculto ou removido

    Exemplos:
      | exemplo | acao |
      | consulta | pesquisar e abrir o detalhe |
      | filtros | aplicar filtros e navegar entre páginas |
      | confirmação | abrir e cancelar o arquivamento |


  @USID_002 @USID_004 @USID_005 @componente @front @criterio_front
  @LLT84_C34 @planejado
  Esquema do Cenário: 34 Identificar campos e ações por tecnologia assistiva - <exemplo>
    Dado que verifico <controle> no componente do LhamaLog
    Quando consulto os nomes acessíveis e a associação de estado ou erro
    Então devo entender <informacao> sem depender somente de cor ícone ou placeholder
    E a verificação deve ser confirmada na página real com tecnologia assistiva

    Exemplos:
      | exemplo | controle | informacao |
      | pesquisa | campo de busca | sua finalidade |
      | data inválida | campo de data com erro | a causa e o campo a corrigir |
      | seleção | checkbox de uma Ocorrência | qual registro está selecionado |


  @USID_001 @USID_002 @USID_004 @pagina @front @criterio_front
  @LLT84_C35 @planejado
  Esquema do Cenário: 35 Manter a tela operável com largura reduzida e zoom - <exemplo>
    Dado que abro <tela> nas condições <condicoes>
    Quando consulto os dados ou navego pelos controles
    Então textos campos botões e foco devem permanecer legíveis e alcançáveis
    E detalhes técnicos extensos podem rolar em sua própria área sem encobrir as ações
    E nenhuma ação necessária deve ficar cortada ou coberta

    Exemplos:
      | exemplo | tela | condicoes |
      | lista estreita | listagem | viewport 360 por 800 e zoom 100 por cento |
      | detalhe ampliado | detalhe | viewport 1280 por 800 e zoom 200 por cento |
      | confirmação ampliada | modal de arquivamento | viewport 1280 por 800 e zoom 200 por cento |
