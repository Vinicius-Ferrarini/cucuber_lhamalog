# language: pt
@LLT86
Funcionalidade: 9 Integração real do login Web

  @USID_049 @integracao @perfil_atual @ADR_023 @ADR_024 @ADR_123
  @LLT86_C41 @planejado
  Esquema do Cenário: 41 Interpretar a autenticação real com MFA obrigatório - <exemplo>
    Dado que a Clerk real de teste usa o perfil atual com MFA obrigatório
    Quando realizo <tentativa>
    Então devo visualizar <destino>
    E o estado real da sessão deve corresponder a <sessao>
    E a evidência deve identificar a integração sem incluir segredos

    Exemplos:
      | exemplo | tentativa | destino | sessao |
      | conta sem fator | primeira etapa por senha em conta sem fator | setup-mfa | sessão ainda não ativa |
      | conta com fator | primeira etapa por senha em conta com TOTP | desafio de MFA | autenticação ainda incompleta |
      | MFA concluído | senha e TOTP aceitos | área inicial | sessão ativa |
      | Google e MFA | Google habilitado e TOTP aceitos | área inicial | sessão ativa |
      | senha rejeitada | senha rejeitada pela Clerk | falha no SignIn | nenhuma autenticação concluída |


  @USID_049 @integracao @ADR_022 @ADR_025 @ADR_028 @ADR_032
  @LLT86_C42 @planejado
  Esquema do Cenário: 42 Renovar sessão sem criar token de usuário próprio - <exemplo>
    Dado que a conta possui sessão Clerk ativa
    Quando a renovação do session token <resultado>
    Então devo observar <efeito>
    E o Core não deve emitir um session token próprio para substituir o da Clerk
    E JWTs internos de serviço não devem ser entregues ao navegador

    Exemplos:
      | exemplo | resultado | efeito |
      | aceita | é aceita e o Core valida o token renovado | continuidade da sessão sem novo login |
      | recusada | falha por revogação da sessão | encerramento do acesso e retorno ao SignIn |


  @USID_049 @integracao @ADR_022 @ADR_023 @ADR_141
  @LLT86_C43 @planejado
  Esquema do Cenário: 43 Enviar sessão ao Core pelo transporte correto - <exemplo>
    Dado que o Front chama uma API de negócio do Core em <origem>
    Quando a conta autenticada faz a requisição
    Então a sessão Clerk deve chegar por <transporte>
    E o Core deve validar a sessão antes de devolver dados protegidos
    E a requisição não deve conter senha nem JWT interno de serviço

    Exemplos:
      | exemplo | origem | transporte |
      | mesma origem | mesma origem | cookie de sessão |
      | outra origem | origem diferente | Authorization Bearer com token obtido pelo SDK |
