# language: pt
@LLT86
Funcionalidade: 5 Recuperação de senha e de MFA

  @USID_049 @front @perfil_atual @ADR_021 @ADR_023 @pagina
  @LLT86_C18 @planejado
  Cenário: 18 Usar a recuperação disponível no componente
    Dado que a conta possui um fluxo de recuperação de senha habilitado pela Clerk
    Quando abro a recuperação no SignIn
    Então devo visualizar as opções suportadas e configuradas pelo provedor
    E não deve ser exigida uma lista própria de todos os contatos ou confirmação pelo Mobile LhamaLog


  @USID_049 @front @perfil_atual @ADR_021 @ADR_024 @criterio_do_plano @pagina
  @LLT86_C19 @planejado
  Cenário: 19 Recuperar senha sem remover o MFA
    Dado que iniciei a recuperação de senha da conta fictícia com MFA obrigatório
    Quando concluo a comprovação aceita pela Clerk e defino uma nova senha fictícia no ambiente de teste
    Então a senha antiga deve ser rejeitada na tentativa seguinte
    E a nova senha deve ser aceita como primeira etapa
    E o MFA ou a tarefa setup-mfa exigida deve continuar sendo respeitado antes do acesso protegido


  @USID_049 @front @perfil_atual @criterio_do_plano @pagina
  @LLT86_C20 @planejado
  Cenário: 20 Não enviar recuperação a um destino arbitrário
    Dado que a recuperação da Clerk usa o e-mail verificado da conta fictícia
    Quando tento indicar um destino diferente sem comprovar o vínculo com essa conta
    Então a interface não deve permitir recuperar a conta por esse destino arbitrário
    E o teste não deve exigir disparo para telefone ou Mobile não suportados pelo fluxo configurado


  @USID_049 @front @perfil_atual @ADR_023 @criterio_do_plano @pagina
  @LLT86_C21 @planejado
  Esquema do Cenário: 21 Recusar comprovação inválida na recuperação - <exemplo>
    Dado que iniciei a recuperação de senha no componente Clerk
    Quando envio <comprovacao>
    Então devo visualizar a rejeição ou a orientação de recuperação fornecida pelo componente
    E a senha não deve ser alterada por essa tentativa

    Exemplos:
      | exemplo | comprovacao |
      | rejeitada | comprovação fictícia rejeitada |
      | expirada | comprovação fictícia expirada no serviço |


  @USID_049 @front @perfil_atual @USID_051 @ADR_024 @ADR_034 @pagina
  @LLT86_C22 @planejado
  Cenário: 22 Exigir novo cadastro de MFA após reset autorizado
    Dado que a fixture registra um reset de MFA já autorizado e concluído pelo suporte
    E a exigência de MFA está ligada na Clerk
    Quando a conta inicia o próximo login
    Então devo visualizar a tarefa setup-mfa
    E nenhum recurso protegido deve ser liberado antes de concluir o novo cadastro


  @USID_049 @front @perfil_atual @USID_051 @ADR_024 @ADR_034 @pagina
  @LLT86_C23 @planejado
  Cenário: 23 Não oferecer reset autônomo de MFA sem fator
    Dado que a conta perdeu seus fatores e códigos de backup
    Quando tenta prosseguir no login sem concluir a verificação
    Então o acesso protegido deve permanecer bloqueado
    E o Front não deve remover o MFA nem inventar recuperação automática por e-mail SMS ou Mobile
    E o reset deve permanecer restrito ao processo de suporte autorizado
