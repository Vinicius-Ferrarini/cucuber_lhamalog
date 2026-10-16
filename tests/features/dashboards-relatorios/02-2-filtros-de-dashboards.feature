# language: pt
@LLT85
Funcionalidade: 2 Filtros de dashboards

  @USID_032 @USID_036 @pagina @front
  @LLT85_C07 @planejado
  Esquema do Cenário: 07 Aplicar critérios suportados pelo contrato - <exemplo>
    Dado que estou no dashboard <escopo> com dados fictícios e autorização
    Quando aplico <criterios>
    Então a consulta deve transmitir os critérios juntos ao Core
    E indicadores e gráficos devem refletir a resposta desse mesmo recorte
    E os critérios aplicados devem permanecer visíveis

    Exemplos:
      | exemplo | escopo | criterios |
      | período do Produto | do Produto Alfa | período fictício suportado |
      | tipo no Produto | do Produto Alfa | tipo de alerta aceito pela operação |
      | combinação empresarial | empresarial | período e Produtos Alfa e Gama autorizados |


  @USID_032 @USID_036 @componente @front
  @LLT85_C08 @planejado
  Esquema do Cenário: 08 Impedir aplicação normal de filtro inválido - <exemplo>
    Dado que o filtro recebe <entrada> inválida conforme o contrato
    Quando tento aplicá-lo
    Então devo visualizar orientação associada ao campo
    E o Front não deve enviar a consulta inválida pelo fluxo normal
    E os últimos critérios aplicados com sucesso não devem ser substituídos por valores inválidos

    Exemplos:
      | exemplo | entrada |
      | datas invertidas | data inicial posterior à final |
      | data inválida | texto que não representa data válida |


  @USID_032 @USID_036 @pagina @front
  @LLT85_C09 @planejado
  Esquema do Cenário: 09 Alterar ou remover filtros e atualizar os dados - <exemplo>
    Dado que o dashboard possui filtros aplicados
    Quando realizo <alteracao>
    Então a consulta deve refletir os critérios restantes e o contexto autorizado
    E a tela deve substituir os indicadores pelos da nova resposta
    E o comando de exportar deve usar o recorte aplicado com sucesso

    Exemplos:
      | exemplo | alteracao |
      | alterar | troca de período |
      | remover um | remoção de um filtro |
      | limpar | limpeza dos filtros opcionais |


  @USID_032 @USID_036 @pagina @front
  @LLT85_C10 @planejado
  Cenário: 10 Distinguir resultado filtrado vazio de erro
    Dado que apliquei uma combinação válida de filtros
    Quando o Core informa ausência de resultados para essa combinação
    Então devo visualizar uma indicação de ausência de dados filtrados
    E devo poder alterar ou remover os filtros
    E nenhuma métrica anterior deve aparecer como resultado do novo recorte


  @USID_032 @USID_036 @pagina @front @criterio_front
  @LLT85_C11 @planejado
  Cenário: 11 Manter somente a última consulta aplicada
    Dado que solicitei dois recortes de filtros em sequência
    Quando a resposta do primeiro chega depois da resposta do segundo
    Então os filtros indicadores e gráficos devem continuar correspondendo ao segundo recorte
    E a exportação não deve usar critérios de uma resposta atrasada
