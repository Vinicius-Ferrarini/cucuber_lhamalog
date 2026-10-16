# language: pt
@LLT85
Funcionalidade: 5 Exportação de relatórios

  @USID_033 @USID_035 @pagina @front
  @LLT85_C22 @planejado
  Esquema do Cenário: 22 Oferecer somente formatos disponibilizados para a operação - <exemplo>
    Dado que abro a exportação do dashboard <escopo>
    E o contrato ou configuração validada do ambiente informa os formatos disponíveis
    Quando visualizo as opções
    Então devo poder selecionar os formatos efetivamente oferecidos por essa operação
    E não devo visualizar um formato inventado apenas porque é exemplo na planilha
    E escolher um formato não deve iniciar geração antes da confirmação

    Exemplos:
      | exemplo | escopo |
      | Produto | do Produto Alfa |
      | Empresa | empresarial |


  @USID_033 @USID_035 @pagina @front
  @LLT85_C23 @planejado
  Esquema do Cenário: 23 Capturar o recorte aplicado ao confirmar a exportação - <exemplo>
    Dado que o dashboard <escopo> tem período tipo e Produtos autorizados aplicados com sucesso
    Quando escolho um formato disponível e confirmo a exportação
    Então a solicitação deve identificar o mesmo recorte aplicado no dashboard
    E alterações ainda não aplicadas no formulário não devem ser enviadas como filtros confirmados
    E a interface deve indicar que a exportação foi iniciada sem anunciar arquivo pronto

    Exemplos:
      | exemplo | escopo |
      | Produto | do Produto Alfa |
      | Empresa | empresarial de Alfa e Gama |


  @USID_033 @USID_035 @pagina @front
  @LLT85_C24 @planejado
  Esquema do Cenário: 24 Disponibilizar o arquivo concluído para download - <exemplo>
    Dado que confirmei uma exportação <escopo> em um formato disponível
    Quando o Core confirma conclusão e disponibiliza o arquivo conforme o contrato
    Então devo conseguir iniciar o download do arquivo correspondente à solicitação
    E devo distinguir geração em andamento de arquivo pronto
    E o arquivo deve manter formato e recorte associados àquela solicitação

    Exemplos:
      | exemplo | escopo |
      | Produto | do Produto Alfa |
      | Empresa | empresarial de Alfa e Gama |


  @USID_033 @USID_035 @pagina @front @criterio_front
  @LLT85_C25 @planejado
  Esquema do Cenário: 25 Desistir antes de iniciar a geração - <exemplo>
    Dado que abri a configuração de exportação <escopo> sem confirmar
    Quando cancelo essa configuração
    Então devo retornar ao dashboard com seus filtros preservados
    E nenhuma solicitação de geração deve ser enviada
    E a interface não deve registrar essa desistência como exportação concluída

    Exemplos:
      | exemplo | escopo |
      | Produto | por Produto |
      | Empresa | empresarial |


  @USID_033 @pagina @front @contrato
  @LLT85_C26 @planejado
  Cenário: 26 Cancelar geração em andamento do Produto
    Dado que a geração do relatório do Produto Alfa está em andamento
    Quando aciono o cancelamento e o serviço confirma a interrupção conforme o contrato
    Então devo voltar ao dashboard com o recorte preservado e indicação de cancelamento
    E a resposta posterior da tarefa cancelada não deve iniciar download automático
    E fechar uma janela sem confirmação do serviço não deve ser tratado como cancelamento efetivo


  @USID_035 @pagina @front @contrato @criterio_front
  @LLT85_C27 @planejado
  Esquema do Cenário: 27 Usar cancelamento empresarial somente quando suportado - <exemplo>
    Dado que a operação empresarial <suporte>
    Quando consulto a possibilidade de cancelar a geração em andamento
    Então devo observar <resultado>
    E uma recusa de permissão não deve ser interpretada como confirmação de cancelamento

    Exemplos:
      | exemplo | suporte | resultado |
      | suportado | oferece cancelamento documentado e o confirma quando solicitado | ação de cancelamento com retorno ao dashboard após confirmação |
      | sem operação | não oferece cancelamento documentado | ausência de promessa de interrupção do serviço ao fechar a interface |


  @USID_033 @USID_035 @pagina @front @contrato @criterio_front
  @LLT85_C28 @planejado
  Esquema do Cenário: 28 Recuperar a interface após falha de exportação - <exemplo>
    Dado que uma exportação autorizada está em <etapa>
    Quando ocorre <falha>
    Então devo visualizar que essa etapa não foi concluída e poder recuperar a operação
    E não devo mostrar confirmação de arquivo baixado sem comprovação
    E Produto Empresa e filtros do dashboard devem permanecer recuperáveis

    Exemplos:
      | exemplo | etapa | falha |
      | início | solicitação de geração | erro de comunicação sem confirmação de criação |
      | geração | geração confirmada | erro de processamento informado pelo Core |
      | download | arquivo disponibilizado | falha de obtenção do arquivo |


  @USID_033 @USID_035 @pagina @front @criterio_front
  @LLT85_C29 @planejado
  Cenário: 29 Evitar solicitações repetidas pelo mesmo controle
    Dado que confirmei uma exportação e o controle aguarda a resposta
    Quando aciono novamente a confirmação
    Então o Front não deve enviar duas solicitações simultâneas idênticas pelo mesmo controle
    E devo perceber o andamento e conseguir recuperar o controle após a resposta
    E o teste não deve inventar uma garantia de idempotência do serviço


  @USID_033 @USID_035 @pagina @front @contrato @criterio_front
  @LLT85_C30 @planejado
  Esquema do Cenário: 30 Rejeitar retorno de arquivo incompatível com o contrato - <exemplo>
    Dado que uma exportação aguarda um arquivo válido
    Quando a fronteira de download retorna <resposta>
    Então a interface não deve anunciar download concluído de um relatório válido
    E devo visualizar orientação de falha sem executar conteúdo inesperado
    E o tratamento deve usar os campos e sinais realmente disponíveis no contrato de download

    Exemplos:
      | exemplo | resposta |
      | erro HTML | página HTML de erro no lugar do arquivo solicitado |
      | referência ausente | retorno sem arquivo ou referência obrigatória |
      | formato divergente | arquivo identificado com formato diferente do confirmado |
      | conteúdo inválido | resposta inválida segundo as verificações previstas no contrato |


  @USID_033 @USID_035 @pagina @front @contrato @ADR_126
  @LLT85_C31 @planejado
  Cenário: 31 Interromper entrega quando o acesso for recusado
    Dado que uma exportação foi solicitada com autorização
    Quando a obtenção do arquivo retorna negação simples por perda de acesso ao Produto ou à Empresa
    Então nenhum arquivo ou conteúdo recusado deve ser entregue pela interface
    E devo retornar à área inicial mantendo a sessão conforme a ADR_126
    E a autorização obtida no início não deve ser tratada como permissão permanente de download
