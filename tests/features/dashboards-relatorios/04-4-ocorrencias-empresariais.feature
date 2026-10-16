# language: pt
@LLT85
Funcionalidade: 4 Ocorrências empresariais

  @USID_037 @pagina @front @ADR_121 @ADR_122
  @LLT85_C18 @planejado
  Esquema do Cenário: 18 Filtrar Ocorrências de múltiplos Produtos - <exemplo>
    Dado que a conta possui acesso ao módulo empresarial e aos Produtos <produtos>
    Quando aplico os filtros de Ocorrências para <produtos>
    Então devo visualizar somente as Ocorrências correspondentes retornadas pelo Core
    E cada registro deve manter a identificação do Produto correto
    E o termo empresarial não deve misturar Empresas diferentes

    Exemplos:
      | exemplo | produtos |
      | único | Alfa |
      | múltiplos | Alfa e Gama |


  @USID_037 @pagina @front
  @LLT85_C19 @planejado
  Cenário: 19 Mostrar consulta de Ocorrências sem correspondência
    Dado que apliquei filtros válidos nas Ocorrências empresariais
    Quando o Core retorna sucesso sem correspondência
    Então devo visualizar que não há Ocorrências para os critérios aplicados
    E os filtros devem permanecer disponíveis para alteração ou remoção
    E a interface não deve reapresentar registros anteriores como resultado atual


  @USID_037 @pagina @front
  @LLT85_C20 @planejado
  Esquema do Cenário: 20 Alterar e remover critérios da consulta empresarial - <exemplo>
    Dado que a consulta de Ocorrências empresariais possui filtros ativos
    Quando realizo <acao>
    Então devo observar uma nova consulta com os critérios atualizados
    E os registros e as identificações de Produto devem corresponder à nova resposta
    E o contexto autorizado de Empresa deve ser mantido

    Exemplos:
      | exemplo | acao |
      | alterar | alteração de um critério |
      | remover | remoção de um filtro |
      | limpar | limpeza dos filtros opcionais |


  @USID_037 @pagina @front @criterio_front
  @LLT85_C21 @planejado
  Cenário: 21 Abrir detalhe preservando Empresa e Produto da Ocorrência
    Dado que a lista empresarial contém uma Ocorrência do Gama autorizada
    E a interface oferece navegação ao detalhe
    Quando abro esse registro
    Então a consulta deve usar o identificador da Ocorrência e o Produto Gama na Empresa Exemplo A
    E não deve reutilizar o Produto anteriormente consultado por engano
    E o comportamento interno do detalhe segue o plano LLT-84
