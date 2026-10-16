# language: pt
@LLT84
Funcionalidade: 6 Acesso e tratamento de respostas

  @USID_001 @USID_002 @pagina @front @contrato @ADR_121 @ADR_122 @ADR_126
  @LLT84_C30 @planejado
  Esquema do Cenário: 30 Voltar à área inicial em negação simples - <exemplo>
    Dado que Ana Exemplo possui sessão válida
    Quando o Core informa negação simples porque <motivo>
    Então devo voltar à tela inicial e continuar logada
    E nenhum dado ou contador do contexto recusado deve permanecer visível
    E não devo aplicar o logout global da ADR_032 por essa negação

    Exemplos:
      | exemplo | motivo |
      | outra Empresa | não é membro da Empresa solicitada |
      | Produto trocado | o Produto da URL pertence a outro tenant |
      | sem acesso | MEMBRO não tem AcessoProduto |


  @USID_001 @USID_002 @pagina @front @contrato @ADR_032
  @LLT84_C31 @planejado
  Cenário: 31 Encerrar acesso local diante de 401 do Core
    Dado que a tela de Ocorrências está aberta
    Quando uma consulta ou mutação recebe HTTP 401 do Core
    Então devo visualizar Você foi deslogado e retornar ao SignIn
    E o conteúdo protegido da tela deve deixar de ficar acessível
    E o tratamento não deve depender de uma mensagem no corpo da resposta


  @USID_001 @USID_002 @USID_003 @USID_004 @USID_005 @pagina @front @contrato @criterio_front
  @LLT84_C32 @planejado
  Esquema do Cenário: 32 Continuar utilizável diante de retorno inesperado - <exemplo>
    Dado que uma operação da tela aguarda resposta do Core
    Quando a fronteira consumida devolve <resposta> fora do contrato
    Então devo visualizar orientação geral sem travar nem mostrar null ou undefined
    E não devo mostrar dados ou confirmar alterações sem comprovação válida
    E devo poder recuperar a consulta ou corrigir a tentativa

    Exemplos:
      | exemplo | resposta |
      | nulo | null |
      | vazio | corpo vazio quando o contrato exige conteúdo |
      | inválido | JSON inválido ou HTML inesperado |
      | erro sem causa | erro sem código ou causa reconhecida |
      | sucesso incompleto | HTTP 200 sem dados obrigatórios de confirmação |
