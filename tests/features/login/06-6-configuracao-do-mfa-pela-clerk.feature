# language: pt
@LLT86
Funcionalidade: 6 Configuração do MFA pela Clerk

  @USID_051 @front @perfil_atual @ADR_023 @ADR_024 @ADR_123 @pagina
  @LLT86_C24 @planejado
  Cenário: 24 Cadastrar fator exigido e disponibilizar backup
    Dado que a conta está na tarefa setup-mfa sem acesso protegido
    Quando concluo o cadastro de TOTP aceito pela Clerk
    Então a tarefa deve ser concluída conforme o provedor
    E os códigos de backup devem estar disponíveis pelo fluxo de segurança da Clerk
    E o próximo login deve respeitar a exigência de MFA


  @USID_051 @front @perfil_atual @ADR_024 @pagina
  @LLT86_C25 @planejado
  Cenário: 25 Cancelar setup sem liberar acesso
    Dado que preciso cadastrar MFA e a sessão está pending
    Quando cancelo o cadastro antes da confirmação
    Então a sessão não deve ser tratada como ativa pelo LhamaLog
    E o próximo acesso deve continuar exigindo a tarefa setup-mfa


  @USID_051 @front @perfil_atual @ADR_023 @ADR_024 @pagina
  @LLT86_C26 @planejado
  Cenário: 26 Manter fatores usando UserProfile
    Dado que a conta está autenticada e usa o UserProfile da Clerk
    Quando conclui uma alteração de fator aceita pelo provedor
    Então o estado exibido deve corresponder aos fatores confirmados pela Clerk
    E o Front não deve manter cadastro paralelo de MFA próprio


  @USID_051 @front @perfil_atual @ADR_023 @criterio_do_plano @pagina
  @LLT86_C27 @planejado
  Esquema do Cenário: 27 Não anunciar alteração de fator não concluída - <exemplo>
    Dado que iniciei uma alteração de fator no UserProfile
    Quando a operação é <resultado>
    Então não devo visualizar confirmação de alteração concluída
    E o estado apresentado deve corresponder ao que foi efetivamente confirmado pela Clerk

    Exemplos:
      | exemplo | resultado |
      | cancelada | cancelada antes de confirmar |
      | rejeitada | rejeitada pelo provedor |
