# language: pt
@LLT86
Funcionalidade: 3 Processamento e proteção da sessão

  @USID_049 @front @perfil_atual @ADR_024 @pagina
  @LLT86_C08 @planejado
  Cenário: 08 Cancelar a verificação obrigatória
    Dado que aguardo a verificação de MFA ou a tarefa setup-mfa
    Quando cancelo o fluxo do componente
    Então não devo obter acesso protegido
    E devo poder retomar a autenticação pelo SignIn


  @USID_049 @front @perfil_atual @criterio_do_plano @pagina
  @LLT86_C09 @planejado
  Esquema do Cenário: 09 Evitar envio repetido na interface - <exemplo>
    Dado que uma solicitação de <etapa> está em andamento
    Quando repito a ação de confirmação antes da resposta
    Então a interface deve manter uma única tentativa em andamento para essa ação
    E não deve repetir navegação ou confirmação de sucesso

    Exemplos:
      | exemplo | etapa |
      | login | primeira etapa |
      | MFA | verificação TOTP |


  @USID_049 @front @perfil_atual @criterio_do_plano @pagina
  @LLT86_C10 @planejado
  Esquema do Cenário: 10 Recuperar a interface após falha de conexão - <exemplo>
    Dado que aguardo resposta de <etapa>
    Quando a comunicação falha
    Então devo visualizar uma indicação de falha sem carregamento indefinido
    E devo poder tentar novamente
    E a falha não deve concluir a autenticação

    Exemplos:
      | exemplo | etapa |
      | sem rede | primeira etapa |
      | falha no fator | MFA |


  @USID_049 @front @perfil_atual @ADR_023 @ADR_024 @pagina
  @LLT86_C11 @planejado
  Esquema do Cenário: 11 Bloquear navegação antes de concluir autenticação - <exemplo>
    Dado que estou <estado>
    Quando tento abrir um recurso protegido por <navegacao>
    Então não devo visualizar seu conteúdo
    E devo ser encaminhado ao fluxo Clerk adequado ao estado da conta

    Exemplos:
      | exemplo | estado | navegacao |
      | sem sessão | sem sessão | endereço direto |
      | reload antes de MFA | com primeira etapa aceita e MFA não concluído | atualização da página |
      | voltar antes de MFA | com primeira etapa aceita e MFA não concluído | voltar do navegador |
      | setup incompleto | com tarefa setup-mfa não concluída | endereço direto |


  @USID_049 @front @perfil_atual @ADR_023 @ADR_032 @pagina
  @LLT86_C12 @planejado
  Cenário: 12 Recarregar com sessão ativa
    Dado que minha sessão Clerk está ativa e as tarefas estão concluídas
    Quando atualizo a área inicial
    Então devo permanecer na conta correta após o carregamento do provedor
    E a atualização não deve exigir um novo login enquanto a sessão continuar válida


  @USID_049 @front @perfil_atual @ADR_032 @pagina
  @LLT86_C13 @planejado
  Esquema do Cenário: 13 Interromper navegação após sessão inválida - <exemplo>
    Dado que a sessão da conta se torna <estado>
    Quando a interface detecta a perda da sessão
    Então o conteúdo protegido deve deixar de ser apresentado
    E devo ser encaminhado ao SignIn sem restaurar acesso pelo histórico

    Exemplos:
      | exemplo | estado |
      | expirada | expirada |
      | revogada | revogada |


  @USID_049 @front @perfil_atual @ADR_023 @pagina
  @LLT86_C14 @planejado
  Esquema do Cenário: 14 Não restaurar sessão depois de sair - <exemplo>
    Dado que encerrei a sessão pelo componente Clerk
    Quando tento retornar usando <navegacao>
    Então não devo recuperar a sessão encerrada
    E o conteúdo protegido deve continuar indisponível

    Exemplos:
      | exemplo | navegacao |
      | histórico | voltar do navegador |
      | rota direta | endereço protegido direto |
